#include <sourcemod>
#include <sdkhooks>

#define isPlayer(%1) (%1 > 0 && IsClientInGame(%1))

#define PLUGIN_VERSION "1.0"
#define CONFIG_FILE "configs/damage_control.cfg"

// 友军伤害
#define CON_VAR_ENABLE_FRIENDLY_FIRE "enable_friendly_fire"
// 反射伤害
#define CON_VAR_ENABLE_REFLECT_DAMAGE "enable_reflect_damage"
// 反射击杀
#define CON_VAR_ENABLE_REFLECT_KILL "enable_reflect_kill"

#define CONFIG_ITEM_MAX_LENGTH 64


ConVar cEnableFriendlyFire;
ConVar cEnableReflectDamage;
ConVar cEnableReflectKill;

public Plugin myinfo = {
    name = "Damage Control",
    author = "azicen",
    description = "伤害控制, 设置友伤、反伤",
    version = PLUGIN_VERSION,
    url = "https://github.com/azicen/docker-gameserver"
}

public void OnPluginStart() {
    cEnableFriendlyFire = CreateConVar(CON_VAR_ENABLE_FRIENDLY_FIRE, "0", "0: 禁用友军伤害; 1: 启用友军伤害", FCVAR_PLUGIN);
    cEnableReflectDamage = CreateConVar(CON_VAR_ENABLE_REFLECT_DAMAGE, "0", "0: 禁用反射伤害; 1: 启用反射伤害", FCVAR_PLUGIN);
    cEnableReflectKill = CreateConVar(CON_VAR_ENABLE_REFLECT_KILL, "0", "0: 禁用反射击杀; 1: 启用反射击杀", FCVAR_PLUGIN);

    ReadConfig();
}

public void ReadConfig() {
    StringMap config = new StringMap();

    char confPath[PLATFORM_MAX_PATH];
    BuildPath(Path_SM, confPath, sizeof(confPath), CONFIG_FILE);

    File file = OpenFile(confPath, "r");
    if (file == INVALID_HANDLE) {
        return;
    }

    char line[CONFIG_ITEM_MAX_LENGTH * 2 + 1];
    while(!IsEndOfFile(file) && ReadFileLine(file, line, sizeof(line))) {
        if (strlen(line) == 0) {
            continue;
        }
        char key[CONFIG_ITEM_MAX_LENGTH];
        char value[CONFIG_ITEM_MAX_LENGTH];
        int index = BreakString(line, key, sizeof(key));
        if (index == -1) {
            continue;
        }
        BreakString(line[index], value, sizeof(value));
        TrimString(key);
        TrimString(value);
        config.SetString(key, value, true);
    }

    file.Close();

    if (config.ContainsKey(CON_VAR_ENABLE_FRIENDLY_FIRE)) {
        char value[CONFIG_ITEM_MAX_LENGTH];
        config.GetString(CON_VAR_ENABLE_FRIENDLY_FIRE, value, sizeof(value));
        SetConVarString(cEnableFriendlyFire, value, false, false);
    }
    if (config.ContainsKey(CON_VAR_ENABLE_REFLECT_DAMAGE)) {
        char value[CONFIG_ITEM_MAX_LENGTH];
        config.GetString(CON_VAR_ENABLE_REFLECT_DAMAGE, value, sizeof(value));
        SetConVarString(cEnableReflectDamage, value, false, false);
    }
    if (config.ContainsKey(CON_VAR_ENABLE_REFLECT_KILL)) {
        char value[CONFIG_ITEM_MAX_LENGTH];
        config.GetString(CON_VAR_ENABLE_REFLECT_KILL, value, sizeof(value));
        SetConVarString(cEnableReflectKill, value, false, false);
    }
}

public Action OnTakeDamage(victim, &attacker, &inflictor, &Float:damage, &damagetype) {
    if (victim == attacker) {
        // 自己杀自己
        return Plugin_Continue;
    }
    if (!isPlayer(victim) || !isPlayer(attacker)) {
        // 有一方不是玩家
        return Plugin_Continue;
    }
    if (GetClientTeam(victim) != GetClientTeam(attacker)) {
        // 不是同一个队伍
        return Plugin_Continue;
    }

    // 反射伤害
    if (GetConVarInt(cEnableReflectDamage) == 1) {
        int settleHealth = GetClientHealth(attacker) - RoundToFloor(damage);
        if (settleHealth < 1) {
            if (GetConVarInt(cEnableReflectKill) == 1) {
                // 启用反射击杀
                SetEntProp(attacker, Prop_Send, "m_isIncapacitated", true, 1);
            } else {
                // 禁用反射击杀, 保留1点血
                settleHealth = 1;
            }
        }
        SetEntityHealth(attacker, settleHealth);
    }

    // 友军伤害
    if (GetConVarInt(cEnableFriendlyFire) == 0) {
        damage = 0.0;
    }

	return Plugin_Changed;
}

public void OnClientPostAdminCheck(int client) {
	if (isPlayer(client)) {
		SDKHook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	}
}

public void OnClientDisconnect(int client) {
	if (isPlayer(client)) {
		SDKUnhook(client, SDKHook_OnTakeDamage, OnTakeDamage);
	}
}
