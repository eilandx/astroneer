# Set the base image
FROM ubuntu:24.04

ENV STEAM_COMPAT_CLIENT_INSTALL_PATH=/steam/
ENV STEAM_COMPAT_DATA_PATH=/steam/compatdata/728470

RUN mkdir -p /astroneer-dedicated-server

RUN dpkg --add-architecture i386

RUN apt-get update -y \
 && apt-get install -y --no-install-recommends ca-certificates steamcmd software-properties-common

RUN add-apt-repository -y multiverse && \
 apt install -y flatpak lib32gcc-s1

RUN ln -s /usr/games/steamcmd /usr/bin/steamcmd

RUN steamcmd +quit

RUN steamcmd +@sSteamCmdForcePlatformType windows +force_install_dir /astroneer-dedicated-server +login anonymous +app_update 728470 validate +quit

RUN flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo \
 && flatpak install -y com.valvesoftware.Steam.CompatibilityTool.Proton

RUN mkdir -p $STEAM_COMPAT_DATA_PATH

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

COPY healthcheck.sh /usr/local/bin/healthcheck.sh
RUN chmod +x /usr/local/bin/healthcheck.sh

# Should exit after 30 seconds
RUN /var/lib/flatpak/runtime/com.valvesoftware.Steam.CompatibilityTool.Proton-GE/x86_64/stable/active/files/proton run /astroneer/AstroServer.exe

EXPOSE 12123/udp

COPY ./Serverfiles /astroneer/Astro/Saved/Config/WindowsServer

HEALTHCHECK --interval=30s --timeout=10s --start-period=30s --retries=3 CMD /usr/local/bin/healthcheck.sh || exit 1

# Set default command
ENTRYPOINT ["/entrypoint.sh"]