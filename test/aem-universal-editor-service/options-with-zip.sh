#!/bin/bash

set -e

source dev-container-features-test-lib

# Check options file created with defaults
source ${AEM_UES_FEATURE_DIR}/options.sh
check "downloads directory set" \
    echo "${AEM_UES_DOWNLOADS_DIR}" | grep -E "^/workspaces/[0-9]+/.devcontainer$"
check "ues node version default" \
    [ "${AEM_UES_NODE_VERSION}" = "16" ]
check "ues version default" \
    [ "${AEM_UES_VERSION}" = "mock-2024.02.01" ]
check "ues http port default" \
    [ "${AEM_UES_HTTP_PORT}" = "9091" ]
check "ues https port default" \
    [ "${AEM_UES_HTTPS_PORT}" = "9090" ]
check "author http port default" \
    [ "${AEM_UES_AUTHOR_HTTP_PORT}" = "4510" ]
check "author https port default" \
    [ "${AEM_UES_AUTHOR_HTTPS_PORT}" = "44310" ]

# Check that ues installs and exec the node script
check "can install & run ues" \
    bash -c "start-ues || true" | grep "hello, world"

reportResults
