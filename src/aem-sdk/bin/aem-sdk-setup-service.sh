#!/usr/bin/env bash

source "$(dirname $0)/_globals.sh"

# script args
runmode_primary="${1}"
runmode_secondary="${2}"

sdkzip=$(get_aem_sdk_zip) || aem_sdk_not_found

# extract and rename the quickstart jar
runmode_dir=$(get_runmode_dir ${runmode_primary} ${runmode_secondary})
runmode_jar=$(get_runmode_jar ${runmode_primary} ${runmode_secondary})

sudo unzip -d ${runmode_dir} ${sdkzip} 'aem-sdk-quickstart-*.jar'
sudo find ${runmode_dir} -maxdepth 1 -iname 'aem-sdk-quickstart-*.jar' -type f -execdir mv {} ${runmode_jar} \;

# make user owner of crx-quickstart (it is a volume mount)
sudo chown ${USER} "${runmode_dir}/crx-quickstart"
