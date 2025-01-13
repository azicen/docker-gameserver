#!/usr/bin/with-contenv bash

export HOME=${HOME:-"/app"}
export STEAMCMDDIR=${STEAMCMDDIR:-"/app/steamcmd"}

export L4D2_IP=${L4D2_IP:-"0.0.0.0"}
export L4D2_PORT=${L4D2_PORT:-27015}
export L4D2_DEBUG=${L4D2_DEBUG:-false}

# 启用VAC
export L4D2_ENABLE_SECURE=${L4D2_ENABLE_SECURE:-false}

# game server settings
export L4D2_MAP=${L4D2_MAP:-"c1m1_hotel"}
export L4D2_ALLOW_LOBBY_CONNECT_ONLY=${L4D2_ALLOW_LOBBY_CONNECT_ONLY:-false}

# 拥有所有权限的管理员
# 多个用户用 `,` 分隔
export L4D2_ADMIN_ALL_PERMISSIONS_USERS=${L4D2_ADMIN_ALL_PERMISSIONS_USERS:-""}
