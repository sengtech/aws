# Install AWS CLI on macOS using Homebrew

# Install Homebrew if you don't have it (uncomment the next line if needed)
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Update Homebrew
brew update

# Install AWS CLI
brew install awscli

# Set default output format to table for AWS CLI
aws configure set output table

# Verify installation
aws --version

# ---
# Browsing Glacier inventory output (output.json):
# a) See a summary of all archives (ArchiveId, Description, Size) in a table-like format:
cat output.json | jq -r '.ArchiveList[] | [.ArchiveId, .ArchiveDescription, .Size] | @tsv'
# b) See just the archive descriptions:
cat output.json | jq -r '.ArchiveList[].ArchiveDescription'
# c) See the full details of the first archive:
cat output.json | jq '.ArchiveList[0]'
# d) You can also open output.json in any text editor to browse the full inventory.
