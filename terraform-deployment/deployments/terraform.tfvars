region            = "us-east-1"                              # region for kdb environment
kms-key-id        = "1d74c759-80e3-4780-a721-c27f376bf7c9"      # key id for kms key (create kms key first)

# file paths
zip_file_path     = "../../../code.zip"                               # path to zipped code, containing finTorq-App and TorQ with updated database name in env.q
hdb-path          = "../../hdb"                        # path to hdb to migrate 


# unique names for aws/finspace resources
code-bucket-name  = "finspace-code-bucket-virginia"                  
data-bucket-name  = "finspace-data-bucket-virginia"                 
environment-name  = "virginia-env-test3"                                
policy-name       = "finspace-policy-virginia"
role-name         = "finspace-role-virginia"
kx-user           = "finspace-user-virginia"

# lambda configs
lambda-name       = "boto3-rdb-scaling-test"
sfn-machine-name  = "finspace-scaler-state-machine"
rdbCntr_modulo    = 3
send-sns-alert    = true                                      # true=create email subscription. false=no email subscription
alert-smpt-target = "eugene.temlock@dataintellect.com"            # email address to send sns alerts to if send-alert flag is set to 'true'

# metricfilter configs
wdb_log_groups = ["wdb","wdb2"]                                # configure EXISTING log groups with names like "wdb*" here 

# database name
database-name     = "finspace-database"                        # database name should match name specified in env.q 
init-script       = "TorQ-Amazon-FinSpace-Starter-Pack/env.q"  # path to init script inside zipped folder

# cluster count
create-clusters   = 0                                        # 1=create no. of clusters specified below, 0=no clusters

rdb-count         = 0
hdb-count         = 0
gateway-count     = 0
feed-count        = 0
discovery-count   = 0