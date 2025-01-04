#include <sourcemod>
#include <sdktools>
#include <string>

#define PLUGIN_VERSION "1.0"


// 可用的实体, 可以是在线的玩家或者人机
#define isAvailableEntity(%1) (%1 > 0 && IsClientInGame(%1))
// 是否为服务器终端
#define isTerminal(%1) (%1 == 0)
// 是否有管理权限
#define isPermission(%1) (%1 == 0 || GetAdminFlag(GetUserAdmin(%1), Admin_Generic))

#define PLAYER_NAME_MAX_LENGTH 64


public Plugin myinfo = {
    name = "Teleport",
    author = "azicen",
    description = "简单的Teleport命令",
    version = PLUGIN_VERSION,
    url = "https://github.com/azicen/docker-gameserver"
}

public void OnPluginStart() {
    // 注册命令
    RegConsoleCmd("sm_teleport", CMDTeleport, "传送; !teleport [<targets>] <destination>");
    RegConsoleCmd("sm_tp", CMDTeleport, "传送; !tp [<targets>] <destination>");
}

// 通过名称获取实体ID
// 成功匹配, 将返回第一个匹配到的EntityID
// 失败返回 `-1`
public int GetPlayerEntityIDByName(char[] targetPlayerName) {
    if (strlen(targetPlayerName) == 0) {
        return -1;
    }
    TrimString(targetPlayerName);
    int clientCount = GetClientCount(true);
    // id=0是终端
    for (int i = 1; i <= clientCount; i++) {
        if (!IsClientConnected(i)) {
            continue;
        }
        if (!IsClientInGame(i)) {
            continue;
        }
        char name[PLAYER_NAME_MAX_LENGTH];
        GetClientName(i, name, sizeof(name));
        TrimString(name);
        if (StrEqual(name, targetPlayerName)) {
            return i;
        }
    }
    return -1;
}

public void TeleportToEntity(int targets, int destination) {
    // 检查是否为可用实体
    if (!isAvailableEntity(targets) || !isAvailableEntity(destination)) {
        return;
    }
    // 获取目的地坐标
    float dest[3];
	GetClientAbsOrigin(destination, Origin);

    // 传送
    TeleportEntity(targets, dest, NULL_VECTOR, NULL_VECTOR);
}

public Action CMDTeleport(int client, int args) {
    // 检查权限
    if (!isPermission(client)) {
        ReplyToCommand(client, "\x05[权限不足] 你没有权限执行此命令");
        return Plugin_Continue;
    }

    // 检查参数
    if(args <= 0 || args > 2) {
        ReplyToCommand(client, "\x05[命令错误] 参数错误");
        ReplyToCommand(client, "\x05[提示] 使用方式: \x04!tp [<targets>] <destination>");
        return Plugin_Continue;
    }

    int targets, destination;
    // 获取第一个参数
    char targetPlayerName[PLAYER_NAME_MAX_LENGTH];
    GetCmdArg(1, targetPlayerName, sizeof(targetPlayerName));
    targets = GetPlayerEntityIDByName(targetPlayerName);
    if (targets == -1) {
        ReplyToCommand(client, "\x05[提示] 没有找到实体 \x04%s", targetPlayerName);
        return Plugin_Continue;
    }
    if (args == 1) {
        // 如果只有一个参数则执行 `!tp <destination>`
        // 此时将目标设置为命令发送者, 目的地为输入的实体
        destination = targets;
        targets = client;
    } else {
        // 获取第二个参数
        char destPlayerName[PLAYER_NAME_MAX_LENGTH];
        GetCmdArg(2, destPlayerName, sizeof(destPlayerName));
        destination = GetPlayerEntityIDByName(destPlayerName);
        if (destination == -1) {
            ReplyToCommand(client, "\x05[提示] 没有找到实体 \x04%s", destPlayerName);
            return Plugin_Continue;
        }
    }

    // 检查是否为终端
    if (isTerminal(targets) || isTerminal(destination)) {
        ReplyToCommand(client, "\x05[提示] 终端无法传送");
        return Plugin_Continue;
    }

	TeleportToEntity(targets, destination);

	return Plugin_Handled;
}
