FROM --platform=$BUILDPLATFORM library/debian:12-slim AS download

ADD https://steamcdn-a.akamaihd.net/client/installer/steamcmd_linux.tar.gz /tmp/steamcmd.tar.gz

RUN curl -o /tmp/mmsource.tar.gz https://mms.alliedmods.net/mmsdrop/1.11/$(curl -s https://mms.alliedmods.net/mmsdrop/1.11/mmsource-latest-linux)

RUN curl -o /tmp/sourcemod.tar.gz https://sm.alliedmods.net/smdrop/1.12/$(curl -s https://sm.alliedmods.net/smdrop/1.12/sourcemod-latest-linux)

RUN set -ex; \
    mkdir -p /tmp/steamcmd; \
    mkdir -p /tmp/gameserver; \
    tar -xzf /tmp/steamcmd.tar.gz -C /tmp/steamcmd; \
    tar -xzf /tmp/mmsource.tar.gz -C /tmp/gameserver; \
    tar -xzf /tmp/sourcemod.tar.gz -C /tmp/gameserver

# ---

FROM ghcr.io/linuxserver/baseimage-debian:bookworm AS release

ENV HOME=/app \
    STEAMCMDDIR=/app/steamcmd

COPY --from=download /tmp/steamcmd /app/steamcmd

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
        lib32gcc-s1; \
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
    # Cleanup
    apt autoremove -y; \
    apt autoclean -y; \
    apt clean; \
    rm -rf \
        /var/lib/apt/lists/* \
        /var/tmp/* \
        /tmp/*

# 安装 Metamod:Source 和 Sourcemod
COPY --from=download /tmp/gameserver/* /app/l4d2/left4dead2/

COPY rootfs/ /

ENTRYPOINT [ "/opt/gameserver/scripts/l4d2/entrypoint.sh" ]
