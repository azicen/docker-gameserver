# l4d2-campaign

## 使用的模组和插件

### 模组

这些模组被引入仓库中用于自动化构建，因为 `Steam` 创意工坊上的模组通过 `steamcmd` 安装时会遇到问题，而我无法解决遇到的问题。

| 名称                            | 文件名                           | 介绍           | 来源                                                         |
| ------------------------------- | -------------------------------- | -------------- | ------------------------------------------------------------ |
| Automatic Guns/Autofire VScript | automatic_guns.vpk               | 半自动枪械连发 | https://steamcommunity.com/sharedfiles/filedetails/?id=2949667423 |
| Grenade Launcher & M60 Fix [Server Mod] | devlosglm60fix.vpk | 榴弹发射器 & M60 允许备弹和拾取子弹 | https://steamcommunity.com/sharedfiles/filedetails/?id=2937327357 |
| Full Health When Change Level   | full_health_when_changelevel.vpk | 安全屋满血     | https://steamcommunity.com/sharedfiles/filedetails/?id=2614530662 |
| 血量显示mod修正增强版                        | health_bar.vpk            |  血条显示              | https://steamcommunity.com/sharedfiles/filedetails/?id=3322300698 |
| Ladder fall Damage fix[Any Map Useful] | ladder_fix.vpk | 取消了梯子处的掉落伤害 | https://steamcommunity.com/sharedfiles/filedetails/?id=3317760504 |
| L4DToolZ | l4dtoolz | L4DToolZ | https://github.com/lakwsh/l4dtoolz |



### 插件

| 名称                                         | 文件名                      | 介绍                                                         | 来源                                                         |
| -------------------------------------------- | --------------------------- | ------------------------------------------------------------ | ------------------------------------------------------------ |
| SMExt-SourceScramble                         | sourcescramble_manager.smx  | 用于处理内存相关操作的 SourceMod 扩展                        | https://github.com/nosoop/SMExt-SourceScramble               |
| Auto Infected Spawner                        | autois.smx                  | 多特控制                                                     | https://forums.alliedmods.net/showthread.php?p=954529        |
| Charger Collision patch                      | charger_collision_patch.smx | 修复了 Charger 只允许击中 1 个幸存者的问题                   | https://forums.alliedmods.net/showthread.php?p=2647017       |
| Clear Dead Body Entity                       | clear_dead_body.smx         | 删除尸体实体                                                 | https://github.com/fbef0102/L4D2-Plugins/tree/master/clear_dead_body |
| Command and ConVar - Buffer Overflow Fixer   | command_buffer.smx          | 缓冲区溢出修复                                               | https://forums.alliedmods.net/showthread.php?t=309656        |
| Coop Markers - Flow Distance                 | coop_markers.smx            | 显示战役进行进度                                             | https://forums.alliedmods.net/showthread.php?t=321288        |
| Coop save weapon when map transition         | ty_saveweapons.smx          | 保存玩家过关时的血量以及携带的武器、物品                     | https://github.com/fbef0102/L4D2-Plugins/tree/master/l4d2_ty_saveweapons |
| Drop Secondary                               | drop_secondary.smx          | 玩家死亡时会掉落副武器                                       | https://github.com/fbef0102/L4D2-Plugins/tree/master/drop_secondary |
| Heartbeat (Revive Fix - Post Revive Options) | heartbeat.smx               | 调整幸存者可救助次数                                         | https://github.com/fbef0102/L4D1_2-Plugins/tree/master/l4d_heartbeat |
| Item Give                                    | item_give.smx               | 使用 `!give` 或 `sm_give` 来生成物品无需将设置 `sv_cheats 1` | https://github.com/wyxls/SourceModPlugins-L4D2/tree/master/item_give |
| Item Hint                                    | item_hint.smx               | 标记物品                                                     | https://github.com/fbef0102/L4D2-Plugins/tree/master/l4d2_item_hint |
| Incapped Magnum                              | incap_magnum.smx            | 倒地的幸存者切换 Magnum                                      | https://forums.alliedmods.net/showthread.php?p=1109372       |
| Infinite Ammo                                | iiammo.smx                  | 允许管理员为玩家切换无限弹药                                 | https://forums.alliedmods.net/showpost.php?p=2628891&postcount=68 |
| Fixes upgrade packs pickup bug               | lfd_both_fixUpgradePack.smx | 修复玩家升级包拾取错误                                       | https://github.com/fbef0102/L4D2-Plugins/tree/master/lfd_both_fixUpgradePack |
| Rescue glow                                  | rescue_glow.smx             | 修复需要营救的幸存者发光不可见                               | https://github.com/fbef0102/L4D2-Plugins/tree/master/rescue_glow |
| Show Mic                                     | show_mic.smx                | 显示谁在说话                                                 | https://github.com/fbef0102/L4D2-Plugins/tree/master/show_mic |
| Survivor Legs                                | survivor_legs.smx           | 第一人称显示腿                                               | https://forums.alliedmods.net/showthread.php?p=2536139       |
| Use Priority Patch                           | use_priority.smx            | 修复实体附着在玩家身上出现的一些问题                         | https://forums.alliedmods.net/showthread.php?t=327511        |
| Melee In The Saferoom                        | melee_in_the_saferoom.smx   | 安全屋开局掉落近战                                           | https://forums.alliedmods.net/showpost.php?p=2719475&postcount=500 |
| More item                                    | more_item.smx               | 根据玩家数量设置物品可拾取数量                               | https://github.com/wyxls/SourceModPlugins-L4D2/tree/master/l4d2_more_item |
| Actions                                      | actions.ext.zip             | 依赖                                                         | https://forums.alliedmods.net/showthread.php?t=336374        |
| Left 4 DHooks Direct                         | left4dhooks.zip             | 依赖                                                         | https://forums.alliedmods.net/showthread.php?t=321696        |

