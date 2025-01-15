FROM --platform=$BUILDPLATFORM library/alpine:3.20.3 AS download

RUN apk add --no-cache curl wget

RUN mkdir -p /archive
RUN mkdir -p /app/addons/sourcemod/gamedata
RUN mkdir -p /app/addons/sourcemod/plugins
RUN mkdir -p /app/addons/sourcemod/translations
RUN mkdir -p /app/cfg/sourcemod

# 下载

# L4DToolZ
RUN curl -LJo /archive/l4dtoolz.zip "https://github.com/lakwsh/l4dtoolz/releases/download/2.4.0/l4dtoolz-11977260267.zip"

# Actions
COPY archive/actions.ext.zip /archive/actions.ext.zip

# Left 4 DHooks Direct
COPY archive/left4dhooks.zip /archive/left4dhooks.zip

# SMExt-SourceScramble
RUN curl -LJo /archive/sourcescramble_manager.tar.gz "https://github.com/nosoop/SMExt-SourceScramble/releases/download/0.7.1.4/package.tar.gz"

# autoIS
RUN curl -LJo /app/addons/sourcemod/plugins/autois.smx "https://www.sourcemod.net/vbcompiler.php?file_id=137935"

# Charger Collision patch
RUN curl -LJo /app/addons/sourcemod/plugins/charger_collision_patch.smx "https://github.com/LuxLuma/Left-4-fix/raw/refs/heads/master/left%204%20fix/charger/Charger_Collision_patch/plugins/Charger_Collision_patch.smx"
RUN curl -LJo /app/addons/sourcemod/gamedata/charger_collision_patch.txt "https://github.com/LuxLuma/Left-4-fix/raw/refs/heads/master/left%204%20fix/charger/Charger_Collision_patch/gamedata/charger_collision_patch.txt"

# Clear Dead Body Entity
RUN curl -LJo /app/addons/sourcemod/plugins/clear_dead_body.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/clear_dead_body/plugins/clear_dead_body.smx"

# Command and ConVar - Buffer Overflow Fixer
RUN curl -LJo /app/addons/sourcemod/plugins/command_buffer.smx "https://www.sourcemod.net/vbcompiler.php?file_id=170776"
RUN curl -LJo /app/addons/sourcemod/gamedata/command_buffer.games.txt "https://github.com/SilvDev/Command_Buffer/raw/refs/heads/main/gamedata/command_buffer.games.txt"

# Coop Markers - Flow Distance
RUN curl -LJo /app/addons/sourcemod/plugins/coop_markers.smx "https://www.sourcemod.net/vbcompiler.php?file_id=180562"
RUN curl -LJo /app/addons/sourcemod/gamedata/l4d_coop_markers.txt "https://github.com/SilvDev/Coop_Markers-Flow_Distance/raw/refs/heads/main/gamedata/l4d_coop_markers.txt"
RUN curl -LJo /app/addons/sourcemod/translations/coop_markers.phrases.txt "https://github.com/SilvDev/Coop_Markers-Flow_Distance/raw/refs/heads/main/translations/coop_markers.phrases.txt"

# Drop Secondary
RUN curl -LJo /app/addons/sourcemod/plugins/drop_secondary.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/drop_secondary/plugins/drop_secondary.smx"

# Heartbeat (Revive Fix - Post Revive Options)
RUN curl -LJo /app/addons/sourcemod/plugins/heartbeat.smx "https://github.com/fbef0102/L4D1_2-Plugins/raw/refs/heads/master/l4d_heartbeat/plugins/l4d_heartbeat.smx"

# Item Give
RUN curl -LJo /app/addons/sourcemod/plugins/item_give.smx "https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/item_give/addons/sourcemod/plugins/item_give.smx"

# Item Hint
RUN curl -LJo /app/addons/sourcemod/plugins/item_hint.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_item_hint/plugins/l4d2_item_hint.smx"
RUN curl -LJo /app/addons/sourcemod/gamedata/l4d2_item_hint.txt "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_item_hint/gamedata/l4d2_item_hint.txt"
RUN curl -LJo /app/addons/sourcemod/translations/l4d2_item_hint.phrases.txt "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_item_hint/translations/l4d2_item_hint.phrases.txt"

# Incapped Magnum
RUN curl -LJo /app/addons/sourcemod/plugins/incap_magnum.smx "https://www.sourcemod.net/vbcompiler.php?file_id=62363"

# Infinite Ammo
RUN curl -LJo /app/addons/sourcemod/plugins/iiammo.smx "https://www.sourcemod.net/vbcompiler.php?file_id=172742"

# Fixes upgrade packs pickup bug
RUN curl -LJo /app/addons/sourcemod/plugins/lfd_both_fixUpgradePack.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/lfd_both_fixUpgradePack/plugins/lfd_both_fixUpgradePack.smx"
RUN curl -LJo /app/addons/sourcemod/gamedata/lfd_both_fixUpgradePack.txt "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/lfd_both_fixUpgradePack/gamedata/lfd_both_fixUpgradePack.txt"

# Rescue glow
RUN curl -LJo /app/addons/sourcemod/plugins/rescue_glow.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/rescue_glow/plugins/rescue_glow.smx"

# Show Mic
RUN curl -LJo /app/addons/sourcemod/plugins/show_mic.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/show_mic/plugins/show_mic.smx"

# Survivor Legs
RUN curl -LJo /app/addons/sourcemod/plugins/survivor_legs.smx "https://www.sourcemod.net/vbcompiler.php?file_id=201116"

# Use Priority Patch
RUN curl -LJo /app/addons/sourcemod/plugins/use_priority.smx "https://www.sourcemod.net/vbcompiler.php?file_id=188692"
RUN curl -LJo /app/addons/sourcemod/gamedata/l4d_use_priority.txt "https://github.com/SilvDev/Use_Priority_Patch/raw/refs/heads/main/gamedata/l4d_use_priority.txt"

# Melee In The Saferoom
RUN curl -LJo /app/addons/sourcemod/plugins/melee_in_the_saferoom.smx "https://www.sourcemod.net/vbcompiler.php?file_id=184014"

# More item
RUN curl -LJo /app/addons/sourcemod/plugins/more_item.smx "https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/l4d2_more_item/addons/sourcemod/plugins/l4d2_more_item.smx"
RUN curl -LJo /app/cfg/sourcemod/l4d2_more_item.cfg "https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/l4d2_more_item/cfg/sourcemod/l4d2_more_item.cfg"

# Coop save weapon when map transition
RUN curl -LJo /app/addons/sourcemod/plugins/ty_saveweapons.smx "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_ty_saveweapons/plugins/l4d2_ty_saveweapons.smx"
RUN curl -LJo /app/addons/sourcemod/gamedata/l4d2_ty_saveweapons.txt "https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_ty_saveweapons/gamedata/l4d2_ty_saveweapons.txt"

# ---

FROM --platform=$BUILDPLATFORM library/alpine:3.20.3 AS aggregation

RUN apk add --no-cache tree unzip

COPY --from=download /app /app
COPY --from=download /archive /archive

RUN mkdir -p /app/addons/sourcemod


RUN mkdir -p /archive/l4dtoolz/addons
RUN unzip /archive/l4dtoolz.zip -d /archive/l4dtoolz/addons
RUN cp -r /archive/l4dtoolz/addons/* /app/addons/

RUN unzip /archive/actions.ext.zip -d /archive
RUN cp -r /archive/actions.ext/* /app/addons/sourcemod/

# Left 4 DHooks Direct
RUN mkdir -p /archive/left4dhooks/addons
RUN unzip /archive/left4dhooks.zip -d /archive/left4dhooks/addons
RUN cp -r /archive/left4dhooks/addons/* /app/addons/

RUN mkdir -p /archive/sourcescramble_manager
RUN tar -xzvf /archive/sourcescramble_manager.tar.gz -C /archive/sourcescramble_manager
RUN cp -r /archive/sourcescramble_manager/addons/* /app/addons/


COPY plugins/damage_control/ /app/addons/sourcemod/
COPY plugins/kill/ /app/addons/sourcemod/
COPY plugins/nextmap/ /app/addons/sourcemod/
COPY plugins/teleport/ /app/addons/sourcemod/

RUN cd /app && tree

# ---

FROM ghcr.io/azicen/l4d2server:latest AS release

ENV HOME=/app \
    STEAMCMDDIR=/app/steamcmd

COPY rootfs/ /
COPY --from=aggregation /app/ /app/l4d2/left4dead2/

RUN set -ex; \
    # 编译插件
    cd /app/l4d2/left4dead2/addons/sourcemod/scripting; \
    chmod 755 -R ./; \
    ls -la ./; \
    ./compile.sh damage_control.sp; \
    ./compile.sh kill.sp; \
    ./compile.sh nextmap.sp; \
    ./compile.sh teleport.sp; \
    cp -r ./compiled/* /app/l4d2/left4dead2/addons/sourcemod/plugins/; \
    # 设置权限
    chown -R abc:abc /app; \
    chmod +x -R /etc/s6-overlay/s6-rc.d; \
    chmod +x -R /opt/gameserver/scripts
