#!/usr/bin/with-contenv bash

. /opt/gameserver/scripts/l4d2/libl4d2.sh
. /opt/gameserver/scripts/l4d2_campaign/libl4d2.sh

. /opt/gameserver/scripts/l4d2/env.sh
. /opt/gameserver/scripts/l4d2_campaign/env.sh


flags=( "-game" "left4dead2" "-console" "-ip" "$L4D2_IP" "-port" "$L4D2_PORT" "+sv_setmax" "31" )

read -r -a additional_flags <<< "$(l4d2_generate_flags)"
flags+=("${additional_flags[@]}")

read -r -a additional_flags <<< "$(l4d2_campaign_generate_flags)"
flags+=("${additional_flags[@]}")

flags+=("$@")

cmd="/app/l4d2/srcds_run"

exec s6-setuidgid abc "$cmd" "${flags[@]}"
