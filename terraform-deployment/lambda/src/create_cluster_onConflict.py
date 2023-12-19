import json
import boto3
#import botocore
import re
import logging
import time
import sys
from env import *

logger = logging.getLogger()
logger.setLevel(logging.INFO)

defaultSession = boto3.Session()
client = defaultSession.client('finspace')

def lambda_handler(event, context):
    logging.info(event)
    
    #gaurd 1
    if 'responsePayload' not in event.keys():
        logging.error("event payload is not correct. Excpected \'responsePayload\' within event keys")
        raise ValueError("event payload is not correct. Excpected \'responsePayload\' within event keys")
    
    #gaurd 2
    if 'errorType' not in event['responsePayload']:
        logging.error("responsePayload is not of expected content. Expected \'errorType\' inside payload")
        raise ValueError("responsePayload is not of expected content. Expected \'errorType\' inside payload")
        
    #gaurd 3
    if event['responsePayload']['errorType'] != "ConflictException":
        logging.error(f"expected errorType : ConflictException. Found : {event['responsePayload']['errorType']}")
        raise ValueError(f"expected errorType : ConflictException. Found :  {event['responsePayload']['errorType']}")

    logging.warn("Function will only handle cases where cluster_name has format [a-zA-Z]+[0-9]*")
    
    parseMessage = event['responsePayload']['errorMessage']
    match = re.findall(r'Cluster already exists with alias: [a-zA-Z]+[0-9]*',parseMessage)
    if not match:
        logging.error("Expected message not in payload. Aborting")
        raise ValueError("Expected message not in payload")
    cluster_name = match[0].split(":")[-1].strip()
    logging.info(cluster_name)
    
    clusterInfo = client.get_kx_cluster(environmentId=envId, clusterName=cluster_name)
    
    match = re.findall(r'[0-9]+',cluster_name)
    newClusterId = cluster_name
    if not match:
        newClusterId = f'{cluster_name}2'
    else:
        repl = str((int(match[0])%rdbCntr_modulo)+1)
        newClusterId = re.sub(match[0],repl,cluster_name)
        
    databaseInfo = [{
        'databaseName':clusterInfo['databases'][0]['databaseName'],
        'changesetId':clusterInfo['databases'][0]['changesetId']
    }]
    
    commandLineArgs = []
    for k in clusterInfo['commandLineArguments']:
        if k['key'] == 'procname':
            commandLineArgs.append({'key':'procname','value':newClusterId})
            commandLineArgs.append({'key':'replaceProc','value':k['value']})
            commandLineArgs.append({'key':'replaceCluster','value':cluster_name})
        elif k['key'] == 'replaceCluster' or k['key'] == 'replaceProc':
            pass
        else:
            commandLineArgs.append(k)
    logger.info("new command line args: %s" % commandLineArgs)
    
    clusterArgs = {
        'environmentId': envId,
        'clusterName': newClusterId,
        'clusterType': "RDB",
        'databases': databaseInfo,
        'clusterDescription': "new rdb cluster",
        'capacityConfiguration': clusterInfo['capacityConfiguration'],
        'releaseLabel': clusterInfo['releaseLabel'],
        'vpcConfiguration': clusterInfo['vpcConfiguration'],
        'initializationScript' : clusterInfo['initializationScript'],
        'commandLineArguments' : commandLineArgs,
        'code': clusterInfo['code'],
        'executionRole': clusterInfo['executionRole'],
        'savedownStorageConfiguration': clusterInfo['savedownStorageConfiguration'],
        'azMode' : clusterInfo['azMode'],
        'availabilityZoneId' :clusterInfo['availabilityZoneId']
    }
    
    logger.info(clusterArgs)
    
    logging.info("BEGINNING CREATION")
    
    client.create_kx_cluster(**clusterArgs)
    
    logging.info("CREATION COMPLETE")
    
    return {
        'statusCode':200
    }