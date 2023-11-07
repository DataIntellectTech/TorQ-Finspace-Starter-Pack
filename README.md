
# FinTorQ

This repo will contain

* Useful scripts for interacting with AWS finspace
* initial code for a finTorq application



# Terraform Deployment for FinTorq Stack and FinSpace Environment

This Terraform setup is designed to deploy and manage a FinSpace environment running a FinTorq stack.

## Prerequisites

1. Ensure that you have the latest version of the AWS CLI installed (already done on homer).
2. Have the latest version of Terraform installed (also done on homer).
3. Configure the AWS CLI to your AWS account.
4. Create a KMS key in the region where you intend to set up your environment. You will also need to edit the key policy to grant FinSpace permissions.
5. Note that FinSpace environments are limited to one per region. Make sure you don't already have an environment set up in the same region.

## How to Use - Initial Deployment

1. Download this repository along with the latest version of TorQ.
2. Move TorQ into the `FinTorQ` directory, alongside `finTorq-App`.
3. Zip `TorQ` and `finTorq-App` together using the command: `zip -r code.zip TorQ/ finTorq-App/`. This will form the base code for each cluster.
4. (Optional) If you have an HDB you want to migrate to FinSpace, replace the dummy HDB in `/finTorq-App/hdb`.
5. Move into the `terraform-deployment/deployments` directory; this will be the Terraform working directory from which you should run all `terraform` commands.
6. Modify variables inside the `terraform.tfvars` file.
7. (Optional) Use the `cluster.tf` files in the `cluster` directory to configure settings for each cluster individually.
8. Run `aws configure` in the terminal to set up your access key and secret key from your AWS account. This is needed to connect to your account and use the Terraform deployment. Check our resource link for more instructions on how to find your access key and secret key.
9. From your Terraform working directory, run `terraform init`.
10. If initialized successfully, run `terraform plan`. This will show all resources set to be created or destroyed by Terraform.
11. Run `terraform apply` to execute this plan. The initial deployment can take approximately 45 minutes, and connection losses can cause errors with deployment, so it's a good idea to run this in `nohup`.

## Resource Link

For detailed Terraform deployment instructions, refer to [FinTorq Deployment / Terraform](https://data-intellect.atlassian.net/wiki/spaces/TK/pages/238944400/FinTorq+Deployment+Terraform).



## Managing Your Infrastructure

Once your environment is up and running, you can use this configuration to manage it:

1. Code Updates: If you make any code changes in `TorQ` or `finTorq-App` and want to apply these to your clusters, rezip these directories and run the Terraform deployment again. This will recreate clusters with the updated code.
2. Cluster Config: If you want to make changes to a cluster's config settings (e.g., node size of the RDB), update this in `clusters/rdb.tf` and run Terraform again. The RDB will be recreated with the new node size.
3. Delete/Create Clusters: Clusters can be deleted or created individually or all at once from the `terraform.tfvars` file. To delete a cluster, set its count to 0. To delete all clusters, set `create-clusters` to 0.

## Terraform State Management

Terraform maintains a state file that tracks the state of the deployed infrastructure. This state file is crucial for Terraform to understand what resources have been created and to make changes to them. To ensure proper state management:

- Always store your state files securely, as they may contain sensitive information.
- Consider using remote state storage, such as Amazon S3, to keep your state files safe and accessible from multiple locations.
- Avoid manual changes to resources managed by Terraform, as this can lead to inconsistencies between the actual infrastructure and Terraform's state.


## Deploying With Terraform But With Existing Infrastructure

For users with existing infrastructure in their AWS account who would like to reuse the same resources for their FinTorq stack, you can use import blocks in Terraform. This functionality allows you to import existing infrastructure resources into Terraform, bringing them under Terraform's management. The import block records that Terraform imported the resource and did not create it. After importing, you can optionally remove import blocks from your configuration or leave them as a record of the resource's origin.

Once imported, Terraform tracks the resource in your state file. You can then manage the imported resource like any other, updating its attributes and destroying it as part of a standard resource lifecycle.

Move into the `deployments` directory, and you'll see an `imports.tf` file (currently empty). This `imports.tf` file is automatically run before Terraform applies any changes to the structure, importing existing structures from your AWS to the deployment system.

## Terraform Import Block Syntax

```
 import {
  to = aws_instance.example
  id = "i-abcd1234"
}

resource "aws_instance" "example" {
  name = "hashi"
  # (other resource arguments...)
}
```
The above `import` block defines an import of the AWS instance with the ID "i-abcd1234" into the `aws_instance.example` resource in the root module.

The import block has the following arguments:

`to` - The instance address this resource will have in your state file.
`id` - A string with the import ID of the resource.
`provider`` (optional) - An optional custom resource provider, see [The Resource provider Meta-Argument](https://developer.hashicorp.com/terraform/language/meta-arguments/resource-provider) for details.
If you do not set the provider argument, Terraform attempts to import from the default provider.

The import block's `id` argument can be a literal string of your resource's import ID, or an expression that evaluates to a string. Terraform needs this import ID to locate the resource you want to import.

The import ID must be known at plan time for planning to succeed. If the value of `id` is only known after apply, `terraform plan` will fail with an error.

The identifier you use for a resource's import ID is resource-specific. You can find the required ID in the [provider documentation](https://registry.terraform.io/providers/hashicorp/aws/latest) for the resource you wish to import.

## Terraform import block Template
We have created a Terraform import block template in `terraform-deployment/importtemplate.md`. In this template, you can select the needed import block and paste it into the `imports.tf` file within the `terraform-deployment/deployments/imports.tf` directory. Remember to change the ID to the referring ID of your existing infrastructure.

### List of AWS Structures that will be created with our Terraform deployment
* module.environment.data.aws_iam_policy_document.iam-policy
* module.environment.data.aws_iam_policy_document.s3-code-policy
* module.environment.data.aws_iam_policy_document.s3-data-policy
* module.environment.aws_ec2_transit_gateway.test
* module.environment.aws_finspace_kx_database.database
* module.environment.aws_finspace_kx_environment.environment
* module.environment.aws_finspace_kx_user.finspace-user
* module.environment.aws_iam_policy.finspace-policy
* module.environment.aws_iam_role.finspace-test-role
* module.environment.aws_iam_role_policy_attachment.policy_attachment
* module.environment.aws_s3_bucket.finspace-code-bucket
* module.environment.aws_s3_bucket.finspace-data-bucket
* module.environment.aws_s3_bucket_policy.code-policy
* module.environment.aws_s3_bucket_policy.data-policy
* module.environment.aws_s3_bucket_public_access_block.code_bucket
* module.environment.aws_s3_bucket_public_access_block.data_bucket
* module.environment.aws_s3_bucket_versioning.versioning
* module.environment.null_resource.create_changeset
* module.environment.null_resource.upload_hdb
* module.lambda.data.aws_iam_policy_document.finspace-extra
* module.lambda.aws_cloudwatch_event_rule.trigger_finSpace-rdb-lambda
* module.lambda.aws_cloudwatch_event_target.target_finSpace-rdb-lambda
* module.lambda.aws_cloudwatch_metric_alarm.RDBOverCPUUtilization
* module.lambda.aws_iam_policy.lambda_basic_policy
* module.lambda.aws_iam_policy.lambda_ec2_policy
* module.lambda.aws_iam_policy.lambda_finspace_policy
* module.lambda.aws_iam_role.lambda_execution_role
* module.lambda.aws_iam_role_policy_attachment.attach1
* module.lambda.aws_iam_role_policy_attachment.attach2
* module.lambda.aws_iam_role_policy_attachment.attach3
* module.lambda.aws_lambda_function.finSpace-rdb-lambda
* module.lambda.aws_lambda_permission.lambda_from_cw_permission
* module.network.aws_internet_gateway.finspace-igw
* module.network.aws_route.finspace-route
* module.network.aws_route_table.finspace-route-table
* module.network.aws_security_group.finspace-security-group
* module.network.aws_subnet.finspace-subnets[0]
* module.network.aws_subnet.finspace-subnets[1] 
* module.network.aws_subnet.finspace-subnets[2]
* module.network.aws_subnet.finspace-subnets[3] 
* module.network.aws_vpc.finspace-vpc

## References and Documentation

For more in-depth information and documentation, explore the following resources:

- [Terraform Documentation](https://learn.hashicorp.com/tutorials/terraform/)
- [AWS Documentation](https://docs.aws.amazon.com/)

These resources provide detailed information about Terraform and AWS services, best practices, and advanced configurations.










