#!/usr/bin/env bash

#
# Copyright © 2023 Nico170420
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# A Function to Send Posts to Telegram
telegram_message() {
	curl -s -X POST "https://api.telegram.org/bot${TG_TOKEN}/sendMessage" \
	-d chat_id="${TG_CHAT_ID}" \
	-d parse_mode="HTML" \
	-d text="$1"
}

# Variables
REPO="https://github.com/minimal-manifest-twrp/platform_manifest_twrp_aosp.git"                                         #<--- Change the wanted Repo here (Link to SHRP, RP or TWRP Manifest Link)
Branch="twrp-12.1"                                                                                  #<--- Set Source Branch here (SHRP-12.1, android-12.1 for RP or twrp-12.1)
Device="p3s"                                                                                         #<--- Set Device Codename here
OEM="samsung"                                                                                        #<--- Set Device Manufactor here
DeviceTree="https://github.com/Nico17042020/android_device_samsung_p3s-test.git"                            #<--- Put Device Tree Link here
DTBranch="android-11"                                                                                     #<--- Set the DT Branch Name here

# Initialize Repo Manifest (SHRP/TWRP/RP)
repo init -u ${REPO} -b ${Branch}

# Sync Repo
repo sync -j$(nproc) --force-sync --no-clone-bundle --no-tags
repo sync --force-sync

# Cloning the Device Tree
git clone ${DeviceTree} -b ${DTBranch} device/${OEM}/${Device}

# Exit
exit 0
