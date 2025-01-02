#!/bin/bash

# Load environment variables
. /opt/gameserver/scripts/l4d2/env.sh

l4d2_init_permissions() {
    chown abc:abc -R $HOME
    chown abc:abc -R /opt/gameserver
    chmod +x -R /opt/gameserver
}

# 定义函数，返回需要增加的 flags
l4d2_generate_flags() {
    local flags=()

    [[ "$L4D2_ENABLE_SECURE" = true ]] && flags+=("-secure")
    [[ "$L4D2_ENABLE_SECURE" = false ]] && flags+=("-insecure")
    [[ "$L4D2_DEBUG" = true ]] && flags+=("-debug")

    flags+=("+map" "$L4D2_MAP")
    flags+=("+sv_allow_lobby_connect_only" "$L4D2_ALLOW_LOBBY_CONNECT_ONLY")

    if [[ -n "${L4D2_EXTRA_FLAGS:-}" ]]; then
        read -r -a extra_flags <<<"$L4D2_EXTRA_FLAGS"
        flags+=("${extra_flags[@]}")
    fi

    echo "${flags[@]}"
}
