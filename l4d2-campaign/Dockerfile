FROM --platform=$BUILDPLATFORM alpine/curl:8.9.1 AS download

RUN mkdir -p /archive
RUN mkdir -p /app/addons/sourcemod/gamedata
RUN mkdir -p /app/addons/sourcemod/plugins
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
# Survivor Legs
RUN curl -LJo /app/addons/sourcemod/plugins/survivor_legs.smx https://www.sourcemod.net/vbcompiler.php?file_id=201116
# More item
RUN curl -LJo /app/addons/sourcemod/plugins/more_item.smx https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/l4d2_more_item/addons/sourcemod/plugins/l4d2_more_item.smx
RUN curl -LJo /app/cfg/sourcemod/l4d2_more_item.cfg https://github.com/wyxls/SourceModPlugins-L4D2/raw/refs/heads/master/l4d2_more_item/cfg/sourcemod/l4d2_more_item.cfg

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

COPY plugins/damage_control/configs /app/addons/sourcemod/configs
COPY plugins/damage_control/scripting /app/addons/sourcemod/scripting
COPY plugins/kill/scripting /app/addons/sourcemod/scripting
COPY plugins/nextmap/configs /app/addons/sourcemod/configs
COPY plugins/nextmap/scripting /app/addons/sourcemod/scripting
COPY plugins/servername/configs /app/addons/sourcemod/configs
COPY plugins/servername/scripting /app/addons/sourcemod/scripting
COPY plugins/teleport/scripting /app/addons/sourcemod/scripting

RUN cd /app && tree

# ---

FROM ghcr.io/azicen/l4d2server:latest AS release

ENV HOME=/app \
    STEAMCMDDIR=/app/steamcmd

COPY rootfs/ /
COPY --from=aggregation /app/* /app/l4d2/left4dead2/

RUN set -ex; \
    cd /app/l4d2/left4dead2/addons/sourcemod/scripting; \
    chmod 755 -R ./; \
    ls -la ./; \
    ./compile.sh damage_control.sp; \
    ./compile.sh kill.sp; \
    ./compile.sh nextmap.sp; \
    ./compile.sh servername.sp; \
    ./compile.sh teleport.sp; \
    cp -r ./compiled/* /app/l4d2/left4dead2/addons/sourcemod/plugins/

CMD [ "/opt/gameserver/scripts/l4d2_campaign/run.sh" ]
