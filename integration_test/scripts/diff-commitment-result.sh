#!/bin/bash

set -e
set -o pipefail

export PATH=/opt/dcm4che/bin:$PATH

dcm2xml /workspace/integration_test/commitment_result/$(ls /workspace/integration_test/commitment_result/) \
        > /workspace/integration_test/tmp.xml
cd /workspace/integration_test
perl -pe 's|<DicomAttribute keyword="TransactionUID".*?<\/DicomAttribute>||' tmp.xml >commitment-clean.xml
diff --strip-trailing-cr commitment-clean.xml data/commitment-expected.xml
