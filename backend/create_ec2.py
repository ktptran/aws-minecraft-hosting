#!/usr/bin/env python
import boto3
import os, stat

# Creating session
session = boto3.Session(profile_name='KevinPortfolioAdmin')
ec2 = session.resource('ec2')

# 1. Make a security group with the configurations for users to connect to it
# 1a. Create the security group
sg = ec2.create_security_group(
    GroupName='Minecraft-Security-Group',
    Description='Security group for minecraft server'
)
security_group_id = sg.group_id
print('Security Group created %s.' % (security_group_id))

# 1b. Authorize access to the security group
data = sg.authorize_ingress(
    GroupId=security_group_id,
    IpPermissions=[
        {'IpProtocol': 'tcp',
         'FromPort': 22,
         'ToPort': 22,
         'IpRanges': [{'CidrIp': '24.18.232.184/32'}]},
        {'IpProtocol': 'tcp',
         'FromPort': 25565,
         'ToPort': 25565,
         'IpRanges': [{'CidrIp': '0.0.0.0/0'}]},
        {'IpProtocol': 'udp',
         'FromPort': 25565,
         'ToPort': 25565,
         'IpRanges': [{'CidrIp': '0.0.0.0/0'}]},
    ]
)
print('Ingress successfully set %s' % data)

# 2. Find an associated key pair to SSH into the instance
key_pair = ec2.KeyPair('python_automation_key')
key_name = key_pair.key_name

# 3. Create the EC2 instance and find the DNS address
# 3a. Create the EC2 instance
instance = ec2.create_instances(
    ImageId='ami-0b1e2eeb33ce3d66f',
    MinCount=1,
    MaxCount=1,
    InstanceType='t2.small',
    KeyName=key_name,
    SecurityGroupIds = [security_group_id]
)
# 3b. Find the DNS name.
inst = instance[0]
inst.wait_until_running()
inst.reload()
inst.public_dns_name # to SSH into
inst.public_ip_address # to login to minecraft server


# 4. Terminate the security group and the EC2 instance created.
inst.terminate()
inst.wait_until_terminated()
sg.delete()
