#!/bin/bash

set -e
set -o pipefail

export PATH=/opt/dcm4che/bin:$PATH
tmp_dir=$(mktemp -d)

echo DEBUG Before Maven First Run $PWD looking for $1
ls

echo DEBUG First Maven Run

dcm2json $1 --with-bulkdata > $tmp_dir/got.json

echo DEBUG Second Maven Run

dcm2json $2 --with-bulkdata > $tmp_dir/want.json

gcloud storage cp $tmp_dir/got.json  gs://ivan-debug-integration-test/got.json
gcloud storage cp $tmp_dir/want.json gs://ivan-debug-integration-test/want.json
