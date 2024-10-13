# Astroneer-docker
## Configuration
Edit the following in 'Serverfiles\AstroServerSettings.ini' file
- ServerName, the name of the server
- ServerPassword, the password to join the server
- PublicIP, the **public IP** of the server
- OwnerName, steam name of the owner, you can get it from steam launcher: click on your name (top right side) -> Account details: <your_name>
- ActiveSaveFileDescriptiveName, the name of the save file (if you have already a save file), use the text before the $ symbol in the save file name, for example: SaveGame$2021.01.01-00.00.00.savegame, the ActiveSaveFileDescriptiveName is SaveGame

It is also possible to edit the other settings, but the above are the most important.

## How to use
After cloning the repository, run the following command:
```
docker build -t astroneer-server .
```
Then you can use the following

docker compose:
```
services:
  astroneer:
    image: astroneer-server
    container_name: astroneer-server
    ulimits:
      nice: 40
    volumes:
      - ./astroneer/Config:/astroneer/Astro/Saved/Config/WindowsServer
      - ./astroneer/Savegame:/astroneer/Astro/Saved/SavedGames
    network_mode: "host"
```