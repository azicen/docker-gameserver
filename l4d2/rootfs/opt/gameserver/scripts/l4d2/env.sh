#!/usr/bin/with-contenv bash

export HOME=${HOME:-"/app"}
export STEAMCMDDIR=${STEAMCMDDIR:-"/app/steamcmd"}

export L4D2_IP=${L4D2_IP:-"0.0.0.0"}
export L4D2_PORT=${L4D2_PORT:-27015}
export L4D2_ENABLE_DEBUG=${L4D2_ENABLE_DEBUG:-false}

# 服务器名称
export L4D2_SERVER_NAME=${L4D2_SERVER_NAME:-"Left 4 Dead 2 Server"}

# 启用VAC
export L4D2_ENABLE_SECURE=${L4D2_ENABLE_SECURE:-false}

# 默认地图
export L4D2_MAP=${L4D2_MAP:-"c1m1_hotel"}

# 仅允许通过大厅连接
export L4D2_ALLOW_LOBBY_CONNECT_ONLY=${L4D2_ALLOW_LOBBY_CONNECT_ONLY:-false}

# 拥有所有权限的管理员
# 多个用户用 `,` 分隔
export L4D2_ADMIN_ALL_PERMISSIONS_USERS=${L4D2_ADMIN_ALL_PERMISSIONS_USERS:-""}

# 启用一致性检查
export L4D2_ENABLE_CONSISTENCY=${L4D2_ENABLE_CONSISTENCY:-false}

# 启用作弊
export L4D2_ENABLE_CHEATS=${L4D2_ENABLE_CHEATS:-false}

# 启用游戏内语音
export L4D2_ENABLE_ALLTALK=${L4D2_ENABLE_ALLTALK:-true}

# 默认游戏难度
# 选项:
#   Easy: 简单, Normal: 普通, Hard: 困难, Impossible: 专家
export L4D2_DIFFICULTY=${L4D2_DIFFICULTY:-"Normal"}
