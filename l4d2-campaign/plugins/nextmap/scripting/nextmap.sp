#include <sourcemod>
#include <string>

// 是否有管理权限
#define isPermission(%1) (%1 == 0 || GetAdminFlag(GetUserAdmin(%1), Admin_Generic))

#define PLUGIN_VERSION "1.0"
#define CONFIG_FILE "configs/nextmap.cfg"

#define MAP_NAME_MAX_LENGTH 64
#define DEFAULT_MAP_NAME "c1m1_hotel"
#define DELAY 5.0


StringMap gNextMap;

public Plugin myinfo = {
    name = "Next Map",
    author = "azicen",
    description = "自动切换下一张地图",
    version = PLUGIN_VERSION,
    url = "https://github.com/azicen/docker-gameserver"
}

public void OnPluginStart() {
    gNextMap = new StringMap();

    ReadConfig();

    // 注册命令
    RegConsoleCmd("sm_next_map", CMDNextMap, "立刻开始下一张地图");

    HookEvent("finale_win", EventFinaleWin);
}

public void ReadConfig() {
    char confPath[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, confPath, sizeof(confPath), CONFIG_FILE);

    File file = OpenFile(confPath, "r");
    if (file == INVALID_HANDLE) {
        return;
    }

    char line[MAP_NAME_MAX_LENGTH * 2 + 1];
    while(!IsEndOfFile(file) && ReadFileLine(file, line, sizeof(line))) {
        if (strlen(line) == 0) {
            continue;
        }
        char map[MAP_NAME_MAX_LENGTH];
        char nextMap[MAP_NAME_MAX_LENGTH];
        int indexMap = BreakString(line, map, sizeof(map));
        if (indexMap == -1) {
            continue;
        }
        BreakString(line[indexMap], nextMap, sizeof(nextMap));
        TrimString(map);
        TrimString(nextMap);
        gNextMap.SetString(map, nextMap, true);
    }

    file.Close();
}

// 立刻切换下一张地图
public void NextMap() {
    char map[MAP_NAME_MAX_LENGTH];
    GetCurrentMap(map, sizeof(map));
    char nextMap[MAP_NAME_MAX_LENGTH];
    bool success = gNextMap.GetString(map, nextMap, sizeof(nextMap));
    if (!success) {
        nextMap = DEFAULT_MAP_NAME;
    }
    ServerCommand("changelevel %s", nextMap);
}

public void CreateNextMapTimer() {
    PrintToChatAll("\x05[提示] 即将切换下一张地图");
    CreateTimer(DELAY, HandleTimerNextMap, 0);
}

public void EventFinaleWin(Event event, const char[] name, bool dontBroadcast) {
    CreateNextMapTimer();
}

public Action HandleTimerNextMap(Handle timer, any data) {
    NextMap();
    return Plugin_Handled;
}

public Action CMDNextMap(int client, int args) {
    // 检查权限
    if (!isPermission(client)) {
        ReplyToCommand(client, "\x05[权限不足] 你没有权限执行此命令");
        return Plugin_Handled;
	}

    CreateNextMapTimer();
    return Plugin_Handled;
}
