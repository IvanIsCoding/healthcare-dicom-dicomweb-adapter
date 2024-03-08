#!/bin/bash

set -e
set -o pipefail

export PATH=/opt/dcm4che/bin:$PATH
tmp_dir=$(mktemp -d)

echo Starting commitment expected

ls /workspace/integration_test/commitment_result/

dcm2xml /workspace/integration_test/commitment_result/$(ls /workspace/integration_test/commitment_result/) \
        > $tmp_dir/got.xml

echo DEBUG Got
cat $tmp_dir/got.xml
echo DEBUG Want
cat /workspace/integration_test/data/commitment-expected.xml

IGNORE_TRANSACTION_AND_IMPLEMENTATION='.NativeDicomModel.DicomAttribute[] | select(."+@keyword" != "ImplementationVersionName" and ."+@keyword" != "TransactionUID")'

diff \
	<(yq -oj "$IGNORE_TRANSACTION_AND_IMPLEMENTATION"  $tmp_dir/got.xml) \
	<(yq -oj "$IGNORE_TRANSACTION_AND_IMPLEMENTATION"  /workspace/integration_test/data/commitment-expected.xml)

rm -rf $tmp_dir
