
/*	Copyright (C) 2017 IT-KiLLER
	This program is free software: you can redistribute it and/or modify
	it under the terms of the GNU General Public License as published by
	the Free Software Foundation, either version 3 of the License, or
	(at your option) any later version.
	This program is distributed in the hope that it will be useful,
	but WITHOUT ANY WARRANTY; without even the implied warranty of
	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
	GNU General Public License for more details.
	
	You should have received a copy of the GNU General Public License
	along with this program. If not, see <http://www.gnu.org/licenses/>.
*/

#include <sourcemod>
#include <sdktools>
#include <sdkhooks>

#pragma semicolon 1
#pragma newdecls required

int activeOffset = -1;
int clip1Offset = -1;
int clip2Offset = -1;
Handle arrayWeapon;
ConVar sm_ammobox_fix_enabled, sm_ammobox_fix_extrarefill;

public Plugin myinfo =
{
	name = "[CS:GO] AMMO BOX FIX.", 
	author = "IT-KiLLER",
	description = "Replacement for the broken class game_player_equip.",
	version = "1.1",
	url = "https://github.com/IT-KiLLER"
};

public void OnPluginStart()
{
	activeOffset = FindSendPropInfo("CAI_BaseNPC", "m_hActiveWeapon");
	clip1Offset = FindSendPropInfo("CBaseCombatWeapon", "m_iClip1");
	clip2Offset = FindSendPropInfo("CBaseCombatWeapon", "m_iClip2");
	sm_ammobox_fix_enabled  = CreateConVar("sm_ammobox_fix_enabled", "1", "Enabled or Disabled", _, true, 0.0, true, 1.0);
	sm_ammobox_fix_extrarefill  = CreateConVar("sm_ammobox_fix_extrarefill", "1.5", "Some maps refil ammo slowly this can be used to smooth it out. Enter in seconds. (0=Disabled, 0.1 to 5.0 secs)", _, true, 0.0, true, 5.0);
	HookEvent("round_start", Event_RoundStart, EventHookMode_PostNoCopy);
	if(arrayWeapon == INVALID_HANDLE) {
		arrayWeapon = InitWeaponTrie();
	}
}

public void Event_RoundStart(Event event, const char[] name, bool dontbroadcast)
{
	if(!sm_ammobox_fix_enabled.BoolValue) return;
	int entity = INVALID_ENT_REFERENCE;
	while ((entity = FindEntityByClassname(entity, "game_player_equip")) != INVALID_ENT_REFERENCE) {
		SDKHook(entity, SDKHook_UsePost, OnUsePost);
	}
}

public void OnUsePost(int entity, int client)
{
	if(!client || !sm_ammobox_fix_enabled.BoolValue) return;
	RefillWeapon(client);
	if(sm_ammobox_fix_extrarefill.FloatValue!=0.0) {
		CreateTimer(sm_ammobox_fix_extrarefill.FloatValue, Timer_ExtraRefill, client, TIMER_FLAG_NO_MAPCHANGE);
	}
} 

stock void RefillWeapon(int client)
{
	if(!(1 <= client <= MaxClients) ||!IsClientConnected(client) || !IsClientInGame(client) || !IsPlayerAlive(client)) return;

	int weaponid, ammo;
	char classname[32];
	weaponid = GetEntDataEnt2(client, activeOffset);
	if(weaponid==-1 || !IsValidEdict(weaponid)) {
		return;
	}
	GetEdictClassname(weaponid, classname, sizeof(classname));
	if(!GetTrieValue(arrayWeapon, classname, ammo) || (-1 <= ammo <= 0)) {
		return;
	}

	if (clip1Offset != -1) 
	{
		SetEntData(weaponid, clip1Offset,  ammo, 4, true);
	}
	if (clip2Offset != -1)
	{
		SetEntData(weaponid, clip2Offset,  ammo, 4, true);
	}
}

public Action Timer_ExtraRefill(Handle timer, any client)
{
	RefillWeapon(client);
	return Plugin_Handled;
}

stock Handle InitWeaponTrie() {
	Handle weapons_trie = CreateTrie();
	SetTrieValue(weapons_trie, "weapon_ak47", 30);
	SetTrieValue(weapons_trie, "weapon_aug", 30);
	SetTrieValue(weapons_trie, "weapon_bizon",  64);
	SetTrieValue(weapons_trie, "weapon_deagle", 7);
	SetTrieValue(weapons_trie, "weapon_elite", 30);
	SetTrieValue(weapons_trie, "weapon_famas", 25);
	SetTrieValue(weapons_trie, "weapon_fiveseven", 20);
	SetTrieValue(weapons_trie, "weapon_g3sg1", 20);
	SetTrieValue(weapons_trie, "weapon_galilar", 35);
	SetTrieValue(weapons_trie, "weapon_glock", 20);
	SetTrieValue(weapons_trie, "weapon_hkp2000", 13);
	SetTrieValue(weapons_trie, "weapon_m249", 100);
	SetTrieValue(weapons_trie, "weapon_m4a1", 30);
	SetTrieValue(weapons_trie, "weapon_mac10", 30);
	SetTrieValue(weapons_trie, "weapon_mag7", 5);
	SetTrieValue(weapons_trie, "weapon_mp7", 30);
	SetTrieValue(weapons_trie, "weapon_mp9", 30);
	SetTrieValue(weapons_trie, "weapon_negev", 150);
	SetTrieValue(weapons_trie, "weapon_nova", 8);
	SetTrieValue(weapons_trie, "weapon_p250", 13);
	SetTrieValue(weapons_trie, "weapon_p90", 50);
	SetTrieValue(weapons_trie, "weapon_sawedoff", 7);
	SetTrieValue(weapons_trie, "weapon_scar20", 20);
	SetTrieValue(weapons_trie, "weapon_sg556", 30);
	SetTrieValue(weapons_trie, "weapon_ssg08", 10);
	SetTrieValue(weapons_trie, "weapon_tec9", 18);
	SetTrieValue(weapons_trie, "weapon_ump45", 25);
	SetTrieValue(weapons_trie, "weapon_xm1014", 7);
	SetTrieValue(weapons_trie, "weapon_awp", 10);
	SetTrieValue(weapons_trie, "weapon_m4a1_silencer", 20);
	SetTrieValue(weapons_trie, "weapon_cz75a", 12);
	SetTrieValue(weapons_trie, "weapon_usp_silencer", 12);
	SetTrieValue(weapons_trie, "weapon_revolver", 8);
	return weapons_trie;
}