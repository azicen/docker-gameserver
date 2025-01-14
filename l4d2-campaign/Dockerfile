FROM --platform=$BUILDPLATFORM alpine/curl:8.9.1 AS download

RUN mkdir -p /archive
RUN mkdir -p /app/addons/sourcemod/gamedata
RUN mkdir -p /app/addons/sourcemod/plugins
RUN mkdir -p /app/addons/sourcemod/translations
RUN mkdir -p /app/cfg/sourcemod

# 下载

# L4DToolZ
RUN curl -LJo /archive/l4dtoolz.zip https://github.com/lakwsh/l4dtoolz/releases/download/2.4.0/l4dtoolz-11977260267.zip

# SMExt-SourceScramble
RUN curl -LJo /archive/sourcescramble_manager.tar.gz https://github.com/nosoop/SMExt-SourceScramble/releases/download/0.7.1.4/package.tar.gz

# autoIS
RUN curl -LJo /app/addons/sourcemod/plugins/autois.smx https://www.sourcemod.net/vbcompiler.php?file_id=137935

# Charger Collision patch
RUN curl -LJo /app/addons/sourcemod/plugins/charger_collision_patch.smx https://github.com/LuxLuma/Left-4-fix/raw/refs/heads/master/left%204%20fix/charger/Charger_Collision_patch/plugins/Charger_Collision_patch.smx
RUN curl -LJo /app/addons/sourcemod/gamedata/charger_collision_patch.txt https://github.com/LuxLuma/Left-4-fix/raw/refs/heads/master/left%204%20fix/charger/Charger_Collision_patch/gamedata/charger_collision_patch.txt

# Clear Dead Body Entity
RUN curl -LJo /app/addons/sourcemod/plugins/clear_dead_body.smx https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/clear_dead_body/plugins/clear_dead_body.smx

# Command and ConVar - Buffer Overflow Fixer
RUN curl -LJo /app/addons/sourcemod/plugins/command_buffer.smx https://www.sourcemod.net/vbcompiler.php?file_id=170776
RUN curl -LJo /app/addons/sourcemod/gamedata/command_buffer.games.txt https://forums.alliedmods.net/attachment.php?attachmentid=170774&d=1722845109

# Drop Secondary
RUN curl -LJo /app/addons/sourcemod/plugins/drop_secondary.smx https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/drop_secondary/plugins/drop_secondary.smx

# Item Hint
RUN curl -LJo /app/addons/sourcemod/plugins/item_hint.smx https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_item_hint/plugins/l4d2_item_hint.smx
RUN curl -LJo /app/addons/sourcemod/gamedata/l4d2_item_hint.txt https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_item_hint/gamedata/l4d2_item_hint.txt
RUN curl -LJo /app/addons/sourcemod/translations/l4d2_item_hint.phrases.txt https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_item_hint/translations/l4d2_item_hint.phrases.txt

# Fixes upgrade packs pickup bug
RUN curl -LJo /app/addons/sourcemod/plugins/lfd_both_fixUpgradePack.smx https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/lfd_both_fixUpgradePack/plugins/lfd_both_fixUpgradePack.smx
RUN curl -LJo /app/addons/sourcemod/gamedata/lfd_both_fixUpgradePack.txt https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/lfd_both_fixUpgradePack/gamedata/lfd_both_fixUpgradePack.txt

# Rescue glow
RUN curl -LJo /app/addons/sourcemod/plugins/rescue_glow.smx https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/rescue_glow/plugins/rescue_glow.smx

# Survivor Legs
RUN curl -LJo /app/addons/sourcemod/plugins/survivor_legs.smx https://www.sourcemod.net/vbcompiler.php?file_id=201116

# Melee In The Saferoom
RUN curl -LJo /app/addons/sourcemod/plugins/melee_in_the_saferoom.smx https://www.sourcemod.net/vbcompiler.php?file_id=184014

# More item
RUN curl -LJo /app/addons/sourcemod/plugins/more_item.smx https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/l4d2_more_item/addons/sourcemod/plugins/l4d2_more_item.smx
RUN curl -LJo /app/cfg/sourcemod/l4d2_more_item.cfg https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/l4d2_more_item/cfg/sourcemod/l4d2_more_item.cfg

# Coop save weapon when map transition
RUN curl -LJo /app/addons/sourcemod/plugins/ty_saveweapons.smx https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_ty_saveweapons/plugins/l4d2_ty_saveweapons.smx
RUN curl -LJo /app/addons/sourcemod/gamedata/l4d2_ty_saveweapons.txt https://github.com/fbef0102/L4D2-Plugins/raw/refs/heads/master/l4d2_ty_saveweapons/gamedata/l4d2_ty_saveweapons.txt

# ---

FROM --platform=$BUILDPLATFORM library/alpine:3.20.3 AS aggregation

RUN apk add --no-cache tree unzip

COPY --from=download /app /app
COPY --from=download /archive /archive
COPY addons /app/addons
COPY ems /app/ems

RUN mkdir -p /archive/l4dtoolz/addons
RUN unzip /archive/l4dtoolz.zip -d /archive/l4dtoolz/addons
RUN mkdir -p /archive/sourcescramble_manager
RUN tar -xzvf /archive/sourcescramble_manager.tar.gz -C /archive/sourcescramble_manager

RUN cp -r /archive/l4dtoolz/addons/* /app/addons/
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
