FROM --platform=$BUILDPLATFORM library/alpine:3.20.3 AS aggregation

RUN mkdir -p /app/addons/sourcemod/

COPY plugins/servername/ /app/addons/sourcemod/


# ---

FROM ghcr.io/linuxserver/baseimage-debian:bookworm AS release

ENV HOME=/app \
    STEAMCMDDIR=/app/steamcmd

COPY rootfs/ /
COPY --from=aggregation /app/ /app/l4d2/left4dead2/

RUN set -ex; \
    apt update; \
    apt install -y --no-install-recommends \
        ca-certificates \
        curl \
        iproute2 \
        iputils-ping \
        less \
        procps \
        software-properties-common; \
    apt-add-repository non-free -y; \
    dpkg --add-architecture i386; \
    apt update; \
    apt install -y --no-install-recommends \
        gdb \
        lib32gcc-s1 \
        lib32stdc++6; \
    # Download
    curl -o /tmp/steamcmd.tar.gz \
        https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz; \
    curl -o /tmp/mmsource.tar.gz \
        https://mms.alliedmods.net/mmsdrop/1.11/$(curl -s https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux); \
    curl -o /tmp/sourcemod.tar.gz \
        https://sm.alliedmods.net/smdrop/1.12/$(curl -s https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux); \
    # Install steamcmd
    mkdir -p /app/steamcmd; \
    tar -xzf /tmp/steamcmd.tar.gz -C /app/steamcmd; \
    # Install
    ## 直接设置linux平台将会导致找不到平台
    ## 一个临时的解决方案是先设置为windows平台，然后再设置为linux平台
    /app/steamcmd/steamcmd.sh +force_install_dir /app/l4d2 +login anonymous +@sSteamCmdForcePlatformType windows +app_update 222860 validate +quit; \
    /app/steamcmd/steamcmd.sh +force_install_dir /app/l4d2 +login anonymous +@sSteamCmdForcePlatformType linux +app_update 222860 validate +quit; \
    # 链接库, 一些服务器需要从这里找到 steamclient.so
    # 来自 https://hub.docker.com/r/cm2network/steamcmd/dockerfile
    mkdir -p "${HOME}/.steam/sdk32"; \
    mkdir -p "${HOME}/.steam/sdk64"; \
    ln -s "${STEAMCMDDIR}/linux32/steamclient.so" "${HOME}/.steam/sdk32/steamclient.so"; \
    ln -s "${STEAMCMDDIR}/linux32/steamcmd" "${STEAMCMDDIR}/linux32/steam"; \
    ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "${HOME}/.steam/sdk64/steamclient.so"; \
    ln -s "${STEAMCMDDIR}/steamcmd.sh" "${STEAMCMDDIR}/steam.sh"; \
    ln -s "${STEAMCMDDIR}/linux64/steamclient.so" "/usr/lib/x86_64-linux-gnu/steamclient.so"; \
    # 安装 Metamod:Source 和 Sourcemod
    mkdir -p /tmp/gamemod; \
    tar -xzf /tmp/mmsource.tar.gz -C /tmp/gamemod; \
    tar -xzf /tmp/sourcemod.tar.gz -C /tmp/gamemod; \
    cp -r /tmp/gamemod/* /app/l4d2/left4dead2/; \
    # 编译插件
    cd /app/l4d2/left4dead2/addons/sourcemod/scripting; \
    chmod 755 -R ./; \
    ls -la ./; \
    ./compile.sh servername.sp; \
    cp -r ./compiled/* /app/l4d2/left4dead2/addons/sourcemod/plugins/; \
    # 设置权限
    chown -R abc:abc /app; \
    chmod +x -R /etc/cont-init.d; \
    chmod +x -R /etc/s6-overlay/s6-rc.d; \
    chmod +x -R /opt/gameserver/scripts; \
    # 清理
    apt autoremove -y; \
    apt autoclean -y; \
    apt clean; \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*
