Creating and Connect to an EC2 Instance
===============

## Create a Windows EC2 Instance

Navigate to the EC2 service.

<p style="text-align: center">
    <img src="../workshop/graphics/navigate_ec2.png" alt="Navigate to the EC2 service" width="90%"/>
</p>

Select `Launch instance` to create a new EC2 instance.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_launch.png" alt="Select launch instance" width="90%"/>
</p>

Most options here can be left as their defaults. Here are the ones that need selected/changing:

1. Select "Windows" from the `Quick Start` options.

    <p style="text-align: center">
        <img src="../workshop/graphics/ec2_application.png" alt="Select windows quick start" width="90%"/>
    </p>

2. We need to create a new key pair: Select `Create new key pair`.

    <p style="text-align: center">
        <img src="../workshop/graphics/ec2_keypair_button.png" alt="Select create new key pair" width="90%"/>
    </p>

3. Enter a name for your key pair, leave the key pair type as `RSA` and the file format as `.pem`. This will download a key file to you PC which you will use to connect to the instance.

    <p style="text-align: center">
        <img src="../workshop/graphics/create_key_pair.png" alt="Create new key pair" width="90%"/>
    </p>

The network should be in the same VPC as your cluster. Select `Create security group` that allows Remote Desktop Protocol (RDP) connections from anywhere.
    - This is only for the purposes of the MVP. For customising see [this page](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/working-with-security-groups.html) on security groups.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_network.png" alt="EC2 network" width="90%"/>
</p>

## Adding your new security group to you EC2

Now we need to add the security group of your cluster to your EC2.

Navigate to EC2 service.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_navigate.png" alt="Navigate to EC2" width="90%"/>
</p>

Select `Instances (running)`.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_navigate2.png" alt="Select Instance running" width="90%"/>
</p>

Open your EC2 Instance.

<p style="text-align: center">
    <img src="../workshop/graphics/EC2_connect1.png" alt="Open EC2 instance" width="90%"/>
</p>

Select `Actions` -> `Security` -> `Change security groups`.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_add_security.png" alt="Select change security groups" width="90%"/>
</p>

Search and select the security group that is on your clusters, select `Add security group` then `Save`.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_add_security2.png" alt="Add security group" width="90%"/>
</p>

You should now have two security groups, one from the launch wizard, and the one you added manually that is also attached to your clusters.

<p style="text-align: center">
    <img src="../workshop/graphics/ec2_security.png" alt="Security group example" width="90%"/>
</p>

## Connecting to your EC2 Instance

Open your EC2 Instance.

<p style="text-align: center">
    <img src="../workshop/graphics/EC2_connect1.png" alt="Open EC2 instance" width="90%"/>
</p>

Select `Connect`.

<p style="text-align: center">
    <img src="../workshop/graphics/EC2_connect2.png" alt="Select connect" width="90%"/>
</p>

### Get your password

This only needs to be done once. Once you have this password you can skip this step.

Select `Get password`.

<p style="text-align: center">
    <img src="../workshop/graphics/EC2_connect3.png" alt="Get password" width="90%"/>
</p>

Upload the `.pem` that was saved to you PC earlier (alternativly you can just paste the contents of this file in the text box).

<p style="text-align: center">
    <img src="../workshop/graphics/EC2_connect4.png" alt="Upload .pem file" width="90%"/>
</p>

This will return the value of your password. Keep a note of this password as you will need it to connect your EC2.

### Connect

Download the remote desktop file.

<p style="text-align: center">
    <img src="../workshop/graphics/EC2_connect5.png" alt="Dowload remote desktop file" width="90%"/>
</p>

Run this file and enter the password you recieved above when promted. You should now be connected to the Windows remote desktop.