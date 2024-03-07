#!/bin/bash

set -e
set -o pipefail

export PATH=/opt/dcm4che/bin:$PATH
tmp_dir=$(mktemp -d)

echo DEBUG Before Maven First Run $PWD looking for $1
ls

echo Second LS just for the sake of it
ls $PWD/integration_test

echo DEBUG First dcm2json Run

dcm2json --with-bulkdata $PWD/$1 > $tmp_dir/got.json

echo DEBUG Second Maven Run

dcm2json --with-bulkdata $PWD/$2 > $tmp_dir/want.json

diff <(jq --sort-keys 'del(.["00020013"])' $tmp_dir/want.json) <(jq --sort-keys 'del(.["00020013"])' $tmp_dir/got.json)

rm -rf $tmp_dir
