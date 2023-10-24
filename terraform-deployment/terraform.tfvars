region            = "us-east-1"                              # region for kdb environment
kms-key-id        = "1d74c759-80e3-4780-a721-c27f376bf7c9"      # key id for kms key (create kms key first)

# file paths
#zip_file_path     = "../code.zip"                               # path to zipped code
zip_file_path     = "../zancodemydb-dep.zip"                     # path to zipped code
#hdb-path          = "../finTorq-App/hdb"                        # path to hdb to migrate
hdb-path           = "../zancodemydb-edit/finTorq-App/hdb2"      # path to hdb to migrate 

# network details
# availability_zone = "use1-az6"
# vpc-id            = "vpc-0a5b1db302525d776"
# subnets           = ["subnet-b70c92dc"]
# security-groups   = ["sg-c370258f","sg-0ae04fc92abb499ca"]


# unique names for aws/finspace resources
code-bucket-name  = "finspace-code-bucket-virginia"               
data-bucket-name  = "finspace-data-bucket-virginia"                 
environment-name  = "virginia-env-test2"                                
policy-name       = "finspace-policy-virginia"
role-name         = "finspace-role-virginia"
kx-user           = "finspace-user-virginia"
lambda-name       = "boto3-rdb-scaling-test"

# database name
database-name     = "finspace-database3"                        # database name should match name specified in env.q 
init-script       = "finTorq-App/env.q"                        # path to init script inside zipped folder

# cluster count
create-clusters   = 1                                        # 1=create no. of clusters specified below, 0=no clusters

rdb-count         = 0
hdb-count         = 0
gateway-count     = 0
feed-count        = 0
discovery-count   = 0
