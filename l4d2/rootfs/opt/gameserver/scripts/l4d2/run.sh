#!/bin/bash

. /opt/gameserver/scripts/l4d2/libl4d2.sh

# Load environment variables
. /opt/gameserver/scripts/l4d2/env.sh

l4d2_init_permissions

flags=( "-game" "left4dead2" "-console" "-secure" "-ip" "$L4D2_IP" "-port" "$L4D2_PORT" )

read -r -a additional_flags <<< "$(l4d2_generate_flags)"
flags+=("${additional_flags[@]}")

flags+=("$@")

cmd="/app/l4d2/srcds_run"

exec s6-setuidgid abc "$cmd" "${flags[@]}"