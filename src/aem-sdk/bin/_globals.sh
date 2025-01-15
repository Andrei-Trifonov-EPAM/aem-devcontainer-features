#!/usr/bin/env bash

source "${AEM_SDK_FEATURE_DIR}/options.sh"

function get_runmode_port()
{
    local runmode_primary="${1}"
    local runmode_secondary="${2}"

    if [ "${runmode_primary}" = "publish" ]; then
        echo "${AEM_SDK_PUBLISH_PORT}"
    else
        echo "${AEM_SDK_AUTHOR_PORT}"
    fi
}

function get_runmode_dir()
{
    local runmode_primary="${1}"
    local runmode_secondary="${2}"

    echo "${AEM_SDK_FEATURE_DIR}/${runmode_primary}"
}

function get_runmode_jar()
{
    local runmode_primary="${1}"
    local runmode_secondary="${2}"
    local port=$(get_runmode_port ${runmode_primary})
    
    echo "aem-${runmode_primary}${runmode_secondary:+_$runmode_secondary}-p${port}.jar"
}

function get_aem_sdk_zip()
{
    local searchdir="${AEM_SDK_SDKS_DIRECTORY}"
    [ ! -d ${searchdir} ] && return 1

    local sdk="${searchdir}/aem-sdk-${AEM_SDK_VERSION}.zip"
    if [ "${AEM_SDK_VERSION}" = "automatic" ]; then
        sdk="$(find ${searchdir} -maxdepth 1 -iname 'aem-sdk-*.zip' -type f | sort -V | tail -n1)"
    fi

    [ ! -f "${sdk}" ] && return 1 || echo "${sdk}"
}

function aem_sdk_not_found()
{
    cat <<EOM
AEM SDK not found.
  sdksDirectory: '${AEM_SDK_SDKS_DIRECTORY:-empty}'
  sdkVersion: '${AEM_SDK_VERSION}'
EOM
exit 42
}
