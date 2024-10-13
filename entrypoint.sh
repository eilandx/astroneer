#!/bin/sh
if [ ! -f /astroneer-dedicated-server/Astro/Saved/Config/WindowsServer/Engine.ini ]; then
  mkdir -p /astroneer-dedicated-server/Astro/Saved/Config/WindowsServer
  mv /tmp/WindowsServer/* /astroneer-dedicated-server/Astro/Saved/Config/WindowsServer/
  mkdir -p /astroneer-dedicated-server/Astro/Saved/SavedGames
  /var/lib/flatpak/runtime/com.valvesoftware.Steam.CompatibilityTool.Proton/x86_64/stable/active/files/proton run /astroneer-dedicated-server/AstroServer.exe
fi

/var/lib/flatpak/runtime/com.valvesoftware.Steam.CompatibilityTool.Proton/x86_64/stable/active/files/proton run /astroneer-dedicated-server/AstroServer.exe