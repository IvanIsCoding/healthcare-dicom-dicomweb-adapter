#!/bin/bash
# url, output_file

curl -X GET \
     -H "Authorization: Bearer "$(gcloud auth print-access-token) \
     -H "Accept: application/dicom; transfer-syntax=*" \
     $1 --output $2

gcloud storage cp $2 gs://ivan-debug-integration-test/$2
echo DEBUG found dir $PWD at $PWD/$2
