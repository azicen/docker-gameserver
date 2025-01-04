#!/bin/bash

# Load environment variables
. /opt/gameserver/scripts/l4d2_campaign/env.sh

# 定义函数，返回需要增加的 flags
l4d2_campaign_generate_flags() {
    local flags=()

    flags+=("+sv_maxplayers" "$L4D2_MAX_PLAYERS")

    echo "${flags[@]}"
}
