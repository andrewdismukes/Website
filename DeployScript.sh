#!/bin/sh

# Build site files.
hugo

# Upload site files to Google.
gsutil -m rsync -R public gs://www.dismukes.io

echo Deployment completed!
