#!/usr/bin/with-contenv bash

# Load environment variables
. /opt/gameserver/scripts/l4d2/env.sh

# 定义函数，返回需要增加的 flags
l4d2_generate_flags() {
    local flags=()

    # 启用VAC
    [[ "$L4D2_ENABLE_SECURE" = true ]] && flags+=("-secure")
    [[ "$L4D2_ENABLE_SECURE" = false ]] && flags+=("-insecure")

    # 启用DEBUG
    [[ "$L4D2_ENABLE_DEBUG" = true ]] && flags+=("-debug")

    # 默认地图
    flags+=("+map" "$L4D2_MAP")

    # 仅允许通过大厅连接
    flags+=("+sv_allow_lobby_connect_only" "$L4D2_ALLOW_LOBBY_CONNECT_ONLY")

    # 启用一致性检查
    flags+=("+sv_consistency")
    [[ "$L4D2_ENABLE_CONSISTENCY" = true ]] && flags+=("1")
    [[ "$L4D2_ENABLE_CONSISTENCY" = false ]] && flags+=("0")

    # 启用作弊
    flags+=("+sv_cheats")
    [[ "$L4D2_ENABLE_CHEATS" = true ]] && flags+=("1")
    [[ "$L4D2_ENABLE_CHEATS" = false ]] && flags+=("0")

    # 启用游戏内语音
    flags+=("+sv_alltalk")
    [[ "$L4D2_ENABLE_ALLTALK" = true ]] && flags+=("1")
    [[ "$L4D2_ENABLE_ALLTALK" = false ]] && flags+=("0")

    # 额外参数
    if [[ -n "${L4D2_EXTRA_FLAGS:-}" ]]; then
        read -r -a extra_flags <<<"$L4D2_EXTRA_FLAGS"
        flags+=("${extra_flags[@]}")
    fi

    echo "${flags[@]}"
}
