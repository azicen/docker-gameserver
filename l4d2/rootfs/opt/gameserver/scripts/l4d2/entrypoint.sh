#!/bin/bash

# Load environment variables
. /opt/gameserver/scripts/l4d2/env.sh

flags=( "-game" "left4dead2" "-secure" "-ip" "$L4D2_IP" "-port" "$L4D2_PORT" )

if [[ -n "${L4D2_EXTRA_FLAGS:-}" ]]; then
    read -r -a extra_flags <<< "$L4D2_EXTRA_FLAGS"
    flags+=("${extra_flags[@]}")
fi

flags+=("$@")

cmd="/app/l4d2/srcds_run"

exec s6-setuidgid abc "$cmd" "${flags[@]}"
