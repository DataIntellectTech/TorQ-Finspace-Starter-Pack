import boto3

from env import *


userName = "finTorq_user"
clusterName = "finTorq_hdb"

defaultSession = boto3.Session()
finspace = defaultSession.client('finspace')

userDetails = finspace.get_kx_user(userName=userName, environmentId=environmentId)
iamRole = userDetails['iamRole']
userArn = userDetails['userArn']

sts = defaultSession.client('sts')
creds = sts.assume_role(RoleArn=iamRole, RoleSessionName="connect_kdb_session")
creds = creds['Credentials']

connectSession = boto3.Session(aws_access_key_id=creds['AccessKeyId'],
                             aws_secret_access_key=creds['SecretAccessKey'],
                             aws_session_token=creds['SessionToken']
                             )

connect = connectSession.client('finspace') 
connString = connect.get_kx_connection_string(environmentId=environmentId, 
                                              userArn=userArn, 
                                              clusterName=clusterName
                                              )


print(connString['signedConnectionString'])