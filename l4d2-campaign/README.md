# l4d2-campaign

## 使用的模组和插件

### 模组

这些模组被引入仓库中用于自动化构建，因为 `Steam` 创意工坊上的模组通过 `steamcmd` 安装时会遇到问题，而我无法解决遇到的问题。

| 文件名                           | 名称                            | 介绍           | 来源                                                         |
| -------------------------------- | ------------------------------- | -------------- | ------------------------------------------------------------ |
| automatic_guns.vpk               | Automatic Guns/Autofire VScript | 半自动枪械连发 | https://steamcommunity.com/sharedfiles/filedetails/?id=2949667423 |
| devlosglm60fix.vpk | Grenade Launcher & M60 Fix [Server Mod] | 榴弹发射器 & M60 允许备弹和拾取子弹 | https://steamcommunity.com/sharedfiles/filedetails/?id=2937327357 |
| full_health_when_changelevel.vpk | Full Health When Change Level   | 安全屋满血     | https://steamcommunity.com/sharedfiles/filedetails/?id=2614530662 |
| health_bar.vpk            | 血量显示mod修正增强版                        |  血条显示              | https://steamcommunity.com/sharedfiles/filedetails/?id=3322300698 |
| ladder_fix.vpk | Ladder fall Damage fix[Any Map Useful] | 取消了梯子处的掉落伤害 | https://steamcommunity.com/sharedfiles/filedetails/?id=3317760504 |
| l4dtoolz | L4DToolZ | L4DToolZ | https://github.com/lakwsh/l4dtoolz |



### 插件

| 文件名                      | 名称                                         | 介绍                                     | 来源                                                         |
| --------------------------- | -------------------------------------------- | ---------------------------------------- | ------------------------------------------------------------ |
| sourcescramble_manager.smx  | SMExt-SourceScramble                         | 用于处理内存相关操作的 SourceMod 扩展    | https://github.com/nosoop/SMExt-SourceScramble               |
| autois.smx                  | Auto Infected Spawner                        | 多特控制                                 | https://forums.alliedmods.net/showthread.php?p=954529        |
| charger_collision_patch.smx | Charger Collision patch                      | 修复了Charger只允许击中1个幸存者的问题   | https://forums.alliedmods.net/showthread.php?p=2647017       |
| clear_dead_body.smx         | Clear Dead Body Entity                       | 删除尸体实体                             | https://github.com/fbef0102/L4D2-Plugins/tree/master/clear_dead_body |
| command_buffer.smx          | Command and ConVar - Buffer Overflow Fixer   | 缓冲区溢出修复                           | https://forums.alliedmods.net/showthread.php?t=309656        |
| drop_secondary.smx          | Drop Secondary                               | 玩家死亡时会掉落副武器                   | https://github.com/fbef0102/L4D2-Plugins/tree/master/drop_secondary |
| heartbeat.smx               | Heartbeat (Revive Fix - Post Revive Options) | 调整幸存者可救助次数                     | https://github.com/fbef0102/L4D1_2-Plugins/tree/master/l4d_heartbeat |
| item_hint.smx               | Item Hint                                    | 标记物品                                 | https://github.com/fbef0102/L4D2-Plugins/tree/master/l4d2_item_hint |
| lfd_both_fixUpgradePack.smx | Fixes upgrade packs pickup bug               | 修复玩家升级包拾取错误                   | https://github.com/fbef0102/L4D2-Plugins/tree/master/lfd_both_fixUpgradePack |
| rescue_glow.smx             | Rescue glow                                  | 修复需要营救的幸存者发光不可见           | https://github.com/fbef0102/L4D2-Plugins/tree/master/rescue_glow |
| show_mic.smx                | Show Mic                                     | 显示谁在说话                             | https://github.com/fbef0102/L4D2-Plugins/tree/master/show_mic |
| survivor_legs.smx           | Survivor Legs                                | 第一人称显示腿                           | https://forums.alliedmods.net/showthread.php?p=2536139       |
| use_priority.smx            | Use Priority Patch                           | 修复实体附着在玩家身上出现的一些问题     | https://forums.alliedmods.net/showthread.php?t=327511        |
| melee_in_the_saferoom.smx   | Melee In The Saferoom                        | 安全屋开局掉落近战                       | https://forums.alliedmods.net/showpost.php?p=2719475&postcount=500 |
| more_item.smx               | More item                                    | 根据玩家数量设置物品可拾取数量           | https://github.com/wyxls/SourceModPlugins-L4D2/tree/master/l4d2_more_item |
| ty_saveweapons.smx          | Coop save weapon when map transition         | 保存玩家过关时的血量以及携带的武器、物品 | https://github.com/fbef0102/L4D2-Plugins/tree/master/l4d2_ty_saveweapons |
| --                          | Actions                                      | 依赖                                     | https://forums.alliedmods.net/showthread.php?t=336374        |
| --                          | Left 4 DHooks Direct                         | 依赖                                     | https://forums.alliedmods.net/showthread.php?t=321696        |

