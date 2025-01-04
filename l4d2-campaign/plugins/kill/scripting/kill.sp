#include <sourcemod>
#include <sdktools>
#include <string>

// 可用的实体, 可以是在线的玩家或者人机
#define isAvailableEntity(%1) (%1 > 0 && IsClientInGame(%1))
// 是否为服务器终端
#define isTerminal(%1) (%1 == 0)
// 是否有管理权限
#define isPermission(%1) (%1 == 0 || GetAdminFlag(GetUserAdmin(%1), Admin_Generic))

#define PLUGIN_VERSION "1.0"
#define CON_VAR_ENABLE_SUICIDE "enable_suicide"

#define PLAYER_NAME_MAX_LENGTH 64


// 是否启用自杀功能
ConVar cEnableSuicide;

public Plugin myinfo = {
    name = "Kill",
    author = "azicen",
    description = "简单的kill命令",
    version = PLUGIN_VERSION,
    url = "https://github.com/azicen/docker-gameserver"
}

public void OnPluginStart() {
    // 创建控制台变量
    cEnableSuicide = CreateConVar(CON_VAR_ENABLE_SUICIDE, "1", "0: 禁止自杀; 1: 允许自杀", FCVAR_PLUGIN);
    // 注册命令
    RegConsoleCmd("sm_kill", CMDKill, "自杀; !kill [<player_name>]");
    RegConsoleCmd("sm_zs", CMDKill, "自杀; !zs [<player_name>]");
    RegConsoleCmd("sm_enable_suicide", CMDSetEnableKill, "允许玩家自杀");
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

// 杀死玩家
public Action CMDKill(int client, int args) {
    // 检查命令是否可以执行
    if (!isPermission(client)) {
        // 检查是否可以自杀
        if (GetConVarInt(cEnableSuicide) == 0) {
            ReplyToCommand(client, "\x05[提示] 自杀功能已被禁用");
            return Plugin_Continue;
        }
        // 检查参数
        if(args != 0) {
            // 非管理员不能杀死其他实体
            ReplyToCommand(client, "\x05[命令错误] 参数错误");
            ReplyToCommand(client, "\x05[提示] 使用方式: \x04!kill");
            return Plugin_Continue;
        }
    }

    // 检查参数(管理员输入检查)
    if(args > 1) {
        ReplyToCommand(client, "\x05[命令错误] 参数错误");
		ReplyToCommand(client, "\x05[提示] 使用方式: \x04!kill [<player_name>]");
		return Plugin_Continue;
	}

    int targets;
    // 检查参数
    if(args == 0) {
        // 自杀
		targets = client;
	} else {
        // 杀死其他玩家
        char targetPlayerName[PLAYER_NAME_MAX_LENGTH];
        GetCmdArg(1, targetPlayerName, sizeof(targetPlayerName));
        targets = GetPlayerEntityIDByName(targetPlayerName);
        if (targets == -1) {
            ReplyToCommand(client, "\x05[提示] 没有找到实体 \x04%s", targetPlayerName);
            return Plugin_Continue;
        }
    }

    // 检查目标是否为终端
    if (isTerminal(targets)) {
        ReplyToCommand(client, "\x05[提示] 终端无法杀死");
        return Plugin_Continue;
    }
    // 检查目标是否为可用
    if (!isAvailableEntity(targets)) {
        ReplyToCommand(client, "\x05[提示] 无法杀死");
        return Plugin_Continue;
    }
    // 玩家是否存活
    if (!IsPlayerAlive(targets)) {
        ReplyToCommand(client, "\x05[提示] 已经死亡, 无法杀死");
        return Plugin_Continue;
    }

    // 执行杀死
    ForcePlayerSuicide(targets);

    // 提示
    char name[PLAYER_NAME_MAX_LENGTH];
    GetClientName(targets, name, sizeof(name));
    if (client == targets) {
        ReplyToCommand(client, "\x05[提示] 已自杀");
        PrintToChatAll("\x05[提示] \x04%s \x05自杀了", name);
    } else {
        ReplyToCommand(client, "\x05[提示] 已杀死 \x04%s", name);
        PrintToChatAll("\x05[提示] \x04%s \x05被杀死了", name);
    }

	return Plugin_Handled;
}

// 设置是否允许自杀
public Action CMDSetEnableKill(int client, int args) {
    // 检查权限
    if (!isPermission(client)) {
        ReplyToCommand(client, "\x05[权限不足] 你没有权限执行此命令");
        return Plugin_Continue;
	}
    // 检查参数
    if(args != 1) {
        ReplyToCommand(client, "\x05[命令错误] 参数错误");
		ReplyToCommand(client, "\x05[提示] 使用方式: \x04!enable_kill <0|1>");
		return Plugin_Continue;
	}

    char tmp[2];
	GetCmdArg(1, tmp, sizeof(tmp));
	int enable = StringToInt(tmp);
    if (enable < 0) {
        enable = 0;
    }
    if (enable > 1) {
        enable = 1;
    }
    SetConVarBool(cEnableSuicide, enable, false, false);

    // 提示发送者
    ReplyToCommand(client, "\x05[提示] \x04%s \x05设置为 \x04%d", CON_VAR_ENABLE_SUICIDE, enable);

    // 提示全体玩家
    if (enable) {
        PrintToChatAll("\x05[提示] 服务器开启了自杀功能");
    } else {
        PrintToChatAll("\x05[提示] 服务器关闭了自杀功能");
    }
    return Plugin_Handled;
}
