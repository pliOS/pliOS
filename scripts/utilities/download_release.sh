#!/bin/bash

# Copyright (c) 2017 The pliOS Authors. All rights reserved.
#
# Use of this source code is governed by a MIT-style license that can be found
# in the LICENSE file.

API_URL="https://api.github.com/repos/$1/releases/latest"
JQ_QUERY=".assets[] | select(.name | test(\"$2\")) | .browser_download_url"

DOWNLOAD_URL=$(jq "$JQ_QUERY" < <( curl -s "$API_URL" ))

DOWNLOAD_URL="${DOWNLOAD_URL%\"}"
DOWNLOAD_URL="${DOWNLOAD_URL#\"}"

curl -LO# $DOWNLOAD_URL
