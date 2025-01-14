#include <sourcemod>

#define PLUGIN_VERSION "1.0"
#define CONFIG_FILE "configs/servername.cfg"

#define DEFAULT_SERVER_NAME "L4D2 Server"


ConVar cHostname;
char gServerName[256];

public Plugin myinfo = {
    name = "Server Name",
    author = "azicen",
    description = "更改服务器名",
    version = PLUGIN_VERSION,
    url = "https://github.com/azicen/docker-gameserver"
}

public void OnPluginStart() {
    cHostname = FindConVar("hostname");

    ReadConfig();

    HookEvent("round_start", EventRoundStart);
}

public void ReadConfig() {
    char confPath[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, confPath, sizeof(confPath), CONFIG_FILE);

    File file = OpenFile(confPath, "r");
    if (file == INVALID_HANDLE) {
        return;
    }
    int count = ReadFileString(file, gServerName, sizeof(gServerName), -1);
    if (count <= 0) {
        gServerName = DEFAULT_SERVER_NAME;
    }
    TrimString(gServerName);
    file.Close();
}

public void EventRoundStart(Event event, const char[] name, bool dontBroadcast) {
    SetConVarString(cHostname, gServerName, false, false);
}
