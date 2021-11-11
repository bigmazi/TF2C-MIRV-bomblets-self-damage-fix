#pragma semicolon 1

#include <sdkhooks>
#include <sdktools>

#define PLUGIN_VERSION "1.1"

public Plugin myinfo = {
	name = "MIRV self-damage fix",
	author = "bigmazi",
	description = "Halves MIRV bomblet self-damage",
	version = PLUGIN_VERSION,
	url = ""
};

public OnPluginStart()
{		
	for(int c = 1; c <= MaxClients; c++)
	if (IsClientInGame(c)) SDKHook(c, SDKHook_OnTakeDamage, Hook_TakeDamage);
}

public OnClientPutInServer(c)
{
	SDKHook(c, SDKHook_OnTakeDamage, Hook_TakeDamage);
}

Action Hook_TakeDamage(
	victim, &attacker, &inflictor, 
	float &damage, &damagetype, &weapon, 
	float damageForce[3], float damagePosition[3], damagecustom)
{
	if (attacker == victim && IsValidEntity(inflictor))
	{
		char cls[PLATFORM_MAX_PATH];
		GetEntityClassname(inflictor, cls, PLATFORM_MAX_PATH);
		
		if (StrEqual(cls, "tf_weapon_grenade_mirv_bomb"))
		{
			damage *= 0.5;
			return Plugin_Changed;
		}
	}
	
	return Plugin_Continue;
}