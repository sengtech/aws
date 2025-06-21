# Configure AWS CLI with your credentials

# Region eu-north-1

# Set default output format to table
aws configure set output table
# This will prompt you for your AWS Access Key ID, Secret Access Key, region, and output format
aws configure

# To verify your configuration, you can list your S3 buckets (if you have any):
aws s3 ls

# You can use your AWS Access Key ID and Secret Access Key for any AWS service, including Amazon S3 and Amazon Glacier.
# If your credentials have permissions for Glacier, you can use the AWS CLI to interact with Glacier as well.

# Example: List Glacier vaults (if you have permissions)
aws glacier list-vaults --account-id -

# ---
# Browsing Glacier inventory output (output.json):
# a) See a summary of all archives (ArchiveId, Description, Size) in a table-like format:
cat output.json | jq -r '.ArchiveList[] | [.ArchiveId, .ArchiveDescription, .Size] | @tsv'
# b) See just the archive descriptions:
cat output.json | jq -r '.ArchiveList[].ArchiveDescription'
# c) See the full details of the first archive:
cat output.json | jq '.ArchiveList[0]'
# d) You can also open output.json in any text editor to browse the full inventory.
