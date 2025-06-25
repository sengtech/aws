#!/bin/bash
# AWS Glacier Vault Inventory Retrieval Script
# Region: eu-north-1
# Vault: vlt01-nas-bak

# 1. Configure AWS CLI (if not already done)
aws configure set output table
aws configure

# 2. Initiate an inventory retrieval job for the vault
aws glacier initiate-job --account-id - --vault-name vlt01-nas-bak --job-parameters '{"Type": "inventory-retrieval"}'
aws glacier initiate-job --account-id - --vault-name ENG-NAS_0011323F1B92_1 --job-parameters '{"Type": "inventory-retrieval"}'

# 3. Wait several hours for the job to complete, then check job status
aws glacier list-jobs --account-id - --vault-name vlt01-nas-bak
aws glacier list-jobs --account-id - --vault-name ENG-NAS_0011323F1B92_1

# 4. When the job status is 'Succeeded', download the inventory (replace <JobId> with the actual JobId)
# Create a subfolder (e.g., glacier-inventory) if it doesn't exist
mkdir -p glacier-inventory
aws glacier get-job-output --account-id - --vault-name vlt01-nas-bak --job-id <JobId> glacier-inventory/output.json
aws glacier get-job-output --account-id - --vault-name vlt01-nas-bak --job-id ZKMayee3wAiA7kya94ER8SozHbTvImdgGpAd0IeiwZkeeZUPuBM-bT0B09xlNGbyeikgFhcAvo68JCWTBRZYY4qHgJXa glacier-inventory/output.json
aws glacier get-job-output --account-id - --vault-name ENG-NAS_0011323F1B92_1 --job-id xP3owQnkt0DPi0zIsK_qwb990d2vTLuZtNeUFspUhufjyNn7ftUfoyNiFrHbCE-zGKJ02Q3ikQqujVDQm7AP4G1-JElj glacier-inventory/output_2.json

# 5. Browse the inventory file (output.json) using jq or a text editor
# a) See a summary of all archives (ArchiveId, Description, Size) in a table-like format:
cat glacier-inventory/output.json | jq -r '.ArchiveList[] | [.ArchiveId, .ArchiveDescription, .Size] | @tsv'
cat glacier-inventory/output_2.json | jq -r '.ArchiveList[] | [.ArchiveId, .ArchiveDescription, .Size] | @tsv'

# b) See just the archive descriptions:
cat glacier-inventory/output.json | jq -r '.ArchiveList[].ArchiveDescription'

# c) See the full details of the first archive:
cat glacier-inventory/output.json | jq '.ArchiveList[0]'

# d) You can also open glacier-inventory/output.json in any text editor to browse the full inventory.

# Notes:
# - Inventory retrieval jobs are free. You are only charged if you retrieve/download actual data from Glacier.
# - For more details, see: https://aws.amazon.com/s3/pricing/
# - The --output table option is set as the default for your CLI profile via aws configure.
