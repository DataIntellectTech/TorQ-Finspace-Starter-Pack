Cluster Connection String
===============

## Create a user

In your kdb environment, go to the Users tab and select Add user.

![Create user button](workshop/graphics/create_user_button.png)

Give it a name and select the IAM role you created above.

![Add user](workshop/graphics/create_user.png)

## Generate Connection String

On the users tab, copy the links for IAM role and User ARN for the user.

![User details](workshop/graphics/user_details.png)

Navigate to CloudShell.

![Navigate to CloudShell](workshop/graphics/cloudshell.png)

Replace ``<ARN_COPIED_FROM_ABOVE>`` with the IAM Role copied above and run the following (this will not return anything):

    export $(printf "AWS_ACCESS_KEY_ID=%s AWS_SECRET_ACCESS_KEY=%s AWS_SESSION_TOKEN=%s" \
    $(aws sts assume-role \
    --role-arn <ARN_COPIED_FROM_ABOVE> \
    --role-session-name "connect-to-finTorq" \
    --query "Credentials.[AccessKeyId,SecretAccessKey,SessionToken]" \
    --output text))

This lets you assume the role that you have just created by taking the values returned from the aws sts assume-role command and setting them in your AWS_ACCESS_KEY_ID... etc environment variables. NOTE - if you need to switch back to your own user within the CloudShell, you will need to run unset AWS_ACCESS_KEY_ID AWS_SECRET_ACCESS_KEY AWS_SESSION_TOKEN to unset these environment variables.

Copy your kdb Environment Id:

![Get you kdb env ID](workshop/graphics/kdbenv_id.png)

Replace ``<YOUR_KDB_ENVIRONMENT_ID>`` with your kdb environment ID, ``<USER_ARN_COPIED_ABOVE>`` with the User ARN, and ``<NAME_OF_CLUSTER>`` with the name of the cluster you want to connect to. Run the following:

    aws finspace get-kx-connection-string --environment-id <YOUR_KDB_ENVIRONMENT_ID> --user-arn <USER_ARN_COPIED_ABOVE> --cluster-name <NAME_OF_CLUSTER>

This will return a large connection string which can be used to connect to your cluster.

![Connection string example](workshop/graphics/connection_string.png)