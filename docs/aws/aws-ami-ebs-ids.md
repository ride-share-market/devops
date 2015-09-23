### Step 1

First up we need to get the AMI ID for the Ubuntu server image from the selected AWS Region.

*Note: The AMI ID is different from Region to Region.*

The simplest way to do this is via the AWS console in the browser.

1. Click `EC2` in the AWS console. 
1. Select the AWS Region from the top right dropdown.
2. Click `Launch Instance`
3. The Quick Start tab offers several default instance types - copy the AMI id for `Ubuntu Server 14.04 LTS (HVM), SSD Volume Type`
4. `export VPC_AMI_ID=ami-xxxxxx`

### Step 2

We want to boot up the new instance with a disk size larger than the default 8GB.

To do this we need the `SnapshotId` for the `EBS` volume that the Ubuntu AMI is using.

1. `aws ec2 describe-images --image-ids $VPC_AMI_ID | jq '.Images[0].BlockDeviceMappings[0].Ebs.SnapshotId'`
2. `export VPC_AMI_EBS_SNAPSHOT_ID=snap-xxxxxx`

### Step 3

Update the block_device_mapping files with the `SnapshotId`.

Example: `"SnapshotId": "snap-d00ac9e4",`

1. [app/kitchen/aws/block_device_mapping_db.json](./../../app/kitchen/aws/block_device_mapping_db.json)



