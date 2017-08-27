# [CS:GO] AMMO BOX FIX 1.0
Replacement/solution for the broken class *_game_player_equip_*. Weapons are now being refilled by this plugin as before the [CS:GO update 2017-08-17](http://blog.counter-strike.net/index.php/2017/08/19239/). This problem has also been [reported](https://github.com/ValveSoftware/csgo-osx-linux/issues/1500) to Valve.

## Cvars
  - `sm_ammobox_fix_enabled` `1` - *_Enabled or disabled [1/0]._*
  - `sm_ammobox_fix_extrarefill` `1.5` - *_Some maps refil ammo slowly this can be used to smooth it out. Enter in seconds. (0=Disabled, 0.1 to 5.0 secs)._*
  
## Tested and works on the maps:
  - ze_castlevania_p1_5
  - ze_ffxiv_wanderers_palace_v4_10
  - ze_shroomforest2_b5_e2
  - ze_fapescape_p5  
  - ze_l0v0l_a7_csgo4
  - ze_fapescape_rote_v1_3
  
  It should work on all maps, otherwise [contact me.](https://github.com/IT-KiLLER/HOW-TO-CONTACT-ME)
  
## Requires
  - Soucemod
  - [Stripper:Source](https://www.bailopan.net/stripper/) [Lastest: [stripper-1.2.2-git125+](https://www.bailopan.net/stripper/snapshots/1.2/)]
  
## Paths:
  - `csgo\addons\sourcemod\plugins\ammo_box_fix.smx`
  - `csgo\addons\sourcemod\scripting\ammo_box_fix.sp` **(optional)**  
  - `csgo\addons\stripper\global_filters.cfg`
  - `csgo\scripts\vscripts\IT-KILLER\ammoboxfixer.nut`

## Download
### [Download/Source code (zip)](https://github.com/IT-KiLLER/CSGO-AMMO-BOX-FIX/archive/master.zip)

Please feel free to contact me if you have any questions. [contact information here.](https://github.com/IT-KiLLER/HOW-TO-CONTACT-ME)
## Creator and credit
#### Created by me [IT-KiLLER](https://github.com/IT-KiLLER)

Thanks to Snowy @ GFL for tests of the plugin.
## Change log
- **1.0** - 2017-08-26
  - Released!
  
## Gameplay 
![](https://image.ibb.co/gDYM95/ammoboxfix_gameplay.gif)
