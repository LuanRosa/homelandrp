#include <a_samp>
#include <dof2>
#include <streamer>
#include <zcmd>

#define CallBack::%0(%1) 		forward %0(%1);\
							public %0(%1)

#define Pasta_Eastereggs       		"Halloween.ini"
#define MAX_EASTER_EGGS         	31

enum eastE{

    eaDescricao [50],
    bool:		eaDescoberto,
	Float:		eaX,
	Float:		eaY,
	Float:		eaZ,
	Float:      eaRange,
	Text3D:     eaText,

	eaNick		[MAX_PLAYER_NAME],
};
new EEInfo[MAX_EASTER_EGGS][eastE];
new MEGAString[2860];
new Str2[255];
new string[70];

CallBack:: createEE(eeid, descricao[], modelid, Float:range, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz){

    EEInfo[eeid][eaX]                       = x;
    EEInfo[eeid][eaY]                       = y;
    EEInfo[eeid][eaZ]                       = z;
    EEInfo[eeid][eaRange]                   = range;

	EEInfo[eeid][eaDescoberto] 				= false;
	format(EEInfo[eeid][eaNick], 24, 		"Ninguem");
	format(EEInfo[eeid][eaDescricao], 50, 	descricao);

	CreateDynamicObject(modelid, x, y, z, rx, ry, rz);

	format(Str2, sizeof Str2, "''%s''{FFFFFF}\nDescoberto por %s", EEInfo[eeid][eaDescricao], EEInfo[eeid][eaNick]);
	EEInfo[eeid][eaText] = CreateDynamic3DTextLabel(Str2, 0xFFA500AA, x, y, z, EEInfo[eeid][eaRange]);
}

CallBack:: loadEE(){

	for(new e; e != MAX_EASTER_EGGS; e++){

	    format(string, sizeof string, "%d_descoberto", e);
        EEInfo[e][eaDescoberto] = DOF2_GetBool(Pasta_Eastereggs, string);
	    format(string, sizeof string, "%d_nick", e);
        format(EEInfo[e][eaNick], 24, DOF2_GetString(Pasta_Eastereggs, string));

        if(strlen(EEInfo[e][eaNick]) < 2){

            format(EEInfo[e][eaNick], 24, "Ninguem");
        }

        if(EEInfo[e][eaDescoberto]){

            DestroyDynamic3DTextLabel(EEInfo[e][eaText]);
			format(Str2, sizeof Str2, "''%s''{FFFFFF}\nDescoberto por %s", EEInfo[e][eaDescricao], EEInfo[e][eaNick]);
			EEInfo[e][eaText] = CreateDynamic3DTextLabel(Str2, 0xFFA500AA, EEInfo[e][eaX], EEInfo[e][eaY], EEInfo[e][eaZ], EEInfo[e][eaRange]);
        }
	}
}

CallBack:: saveEE(){
	if(!DOF2_FileExists(Pasta_Eastereggs))DOF2_CreateFile(Pasta_Eastereggs);

	for(new e; e != MAX_EASTER_EGGS; e++){

	    format(string, sizeof string, "%d_descoberto", e);
     	DOF2_SetBool(Pasta_Eastereggs, string, EEInfo[e][eaDescoberto]);
	    format(string, sizeof string, "%d_nick", e);
        DOF2_SetString(Pasta_Eastereggs, string, EEInfo[e][eaNick]);
	}
	DOF2_SaveFile();
}

CallBack:: descobrirEE(playerid, eeid){
	new kaka = randomEx(0,15);
	if(kaka == 0 || kaka == 8)
	{
		GivePlayerMoney(playerid, 3000);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 3mil coins!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 1 || kaka == 9)
	{
		GivePlayerMoney(playerid, 6000);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 6mil coins!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 2 || kaka == 10)
	{
		GivePlayerMoney(playerid, 12000);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 12mil reais!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 3 || kaka == 11)
	{
		GivePlayerMoney(playerid, 24000);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 24mil reais!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 4 || kaka == 12)
	{
		SetPlayerScore(playerid, GetPlayerScore(playerid)+1);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 1 Level!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 5 || kaka == 13)
	{
		SetPlayerScore(playerid, GetPlayerScore(playerid)+2);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 2 Level!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 6 || kaka == 14)
	{
		SetPlayerScore(playerid, GetPlayerScore(playerid)+4);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 4 Level!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 7 || kaka == 15)
	{
		SetPlayerScore(playerid, GetPlayerScore(playerid)+8);
		format(string, sizeof string, "%s acaba de descobrir ''%s'' ganhou 8 Level!", Name(playerid), EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	EEInfo[eeid][eaDescoberto] = true;
	format(EEInfo[eeid][eaNick], 24, Name(playerid));
	DestroyDynamic3DTextLabel(EEInfo[eeid][eaText]);
	format(string, sizeof string, "''%s''{FFFFFF}\nDescoberto por %s", EEInfo[eeid][eaDescricao], EEInfo[eeid][eaNick]);
	EEInfo[eeid][eaText] = CreateDynamic3DTextLabel(string, 0xFFA500AA, EEInfo[eeid][eaX], EEInfo[eeid][eaY], EEInfo[eeid][eaZ], EEInfo[eeid][eaRange]);
	saveEE();
}

CallBack:: checkEE(playerid){

	for(new e; e != MAX_EASTER_EGGS; e++){

	    if(IsPlayerInRangeOfPoint(playerid, EEInfo[e][eaRange], EEInfo[e][eaX], EEInfo[e][eaY], EEInfo[e][eaZ]) && !EEInfo[e][eaDescoberto]){

	        descobrirEE(playerid, e);
	    }
	}

	return 0;
}

stock Name(playerid)
{
	new pNameVar[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pNameVar, 24);
	return pNameVar;
}

stock randomEx(minnum = cellmin, maxnum = cellmax)
	return random(maxnum - minnum + 1) + minnum;// by Y_Less

public OnFilterScriptInit()
{
	createEE(0, "HALLOWEEN EVENT 1", 19320,3.0, -984.33557, 1293.37805, 33.30560,   0.00000, 0.00000, 0.00000);
	createEE(1, "HALLOWEEN EVENT 2", 19320,3.0, -2354.78540, 142.00720, 38.22280,  0.00000, 0.00000, 0.00000);
	createEE(2, "HALLOWEEN EVENT 3", 19320,3.0, -1077.87439, -1157.65149, 128.21820,   0.00000, 0.00000, 0.00000);
	createEE(3, "HALLOWEEN EVENT 4", 19320,3.0, 420.86520, 1166.28906, 18.71620,   0.00000, 0.00000, 0.00000);
	createEE(4, "HALLOWEEN EVENT 5", 19320,3.0, 2294.35547, 547.58868, 0.75320,   0.00000, 0.00000, 0.00000);
	createEE(5, "HALLOWEEN EVENT 6", 19320,3.0, 2773.04443, 609.84949, 8.07760,   0.00000, 0.00000, 0.00000);
	createEE(6, "HALLOWEEN EVENT 7", 19320,3.0, -379.65137, -1043.83838, 58.02332,   0.00000, 0.00000, 0.00000);
	createEE(7, "HALLOWEEN EVENT 8", 19320,3.0, -1694.38672, -626.94012, 23.19030,   0.00000, 0.00000, 0.00000);
	createEE(8, "HALLOWEEN EVENT 9", 19320,3.0, -473.87051, -171.93179, 77.20510,   0.00000, 0.00000, 0.00000);
	createEE(9, "HALLOWEEN EVENT 10", 19320,3.0, 2500.31226, -422.05249, 75.93670,   0.00000, 0.00000, 0.00000);
	createEE(10, "HALLOWEEN EVENT 11", 19320,3.0, -2095.61694, -815.23132, 31.29690,   0.00000, 0.00000, 0.00000);
	createEE(11, "HALLOWEEN EVENT 12", 19320,3.0, 1378.12842, 982.94397, 9.79970,   0.00000, 0.00000, 0.00000);
	createEE(12, "HALLOWEEN EVENT 13", 19320,3.0, 2061.73608, -2208.81519, 15.40100, 0.0, 0.00000, 0.00000);
	createEE(13, "HALLOWEEN EVENT 14", 19320,3.0, 2288.71631, -1926.96106, 12.61170,   0.00000, 0.00000, 0.00000);
	createEE(14, "HALLOWEEN EVENT 15", 19320,3.0, 2856.96631, -414.79031, 7.52820,   0.00000, 0.00000, 0.00000);
	createEE(15, "HALLOWEEN EVENT 16", 19320,3.0, 2884.63208, -131.83350, 0.99060,   0.00000, 0.00000, 0.00000);
	createEE(16, "HALLOWEEN EVENT 17", 19320,3.0, 2768.49756, -1368.27319, 39.31690,   0.00000, 0.00000, 0.00000);
	createEE(17, "HALLOWEEN EVENT 18", 19320,3.0, 2102.88184, -1647.44495, 13.00600,   8.00000, 0.00000, 0.00000);
	createEE(18, "HALLOWEEN EVENT 19", 19320,3.0, 2117.53174, -1941.52344, 12.57650,   0.00000, 0.00000, 0.00000);
	createEE(19, "HALLOWEEN EVENT 20", 19320,3.0, 1766.90125, -2022.21533, 13.19720,   0.00000, 0.00000, 0.00000);
	createEE(20, "HALLOWEEN EVENT 21", 19320,3.0, -2350.917480, -40.718368, 35.312500,   0.00000, 0.00000, 0.00000);
	createEE(21, "HALLOWEEN EVENT 22", 19320,3.0, -2708.878662, 378.932891, 4.968750,   0.00000, 0.00000, 0.00000);
	createEE(22, "HALLOWEEN EVENT 23", 19320,3.0, -2037.736816, 1036.313476, 55.660934,   0.00000, 0.00000, 0.00000);
	createEE(23, "HALLOWEEN EVENT 24", 19320,3.0, -1966.798339, 113.898818, 27.687500,   0.00000, 0.00000, 0.00000);
	createEE(24, "HALLOWEEN EVENT 25", 19320,3.0, -2044.767211, 148.988311, 28.835937,   0.00000, 0.00000, 0.00000);
	createEE(25, "HALLOWEEN EVENT 26", 19320,3.0, -1714.471313, 1367.025512, 7.185316,   0.00000, 0.00000, 0.00000);
	createEE(26, "HALLOWEEN EVENT 27", 19320,3.0, -2502.430908, 2290.441162, 4.984375,   0.00000, 0.00000, 0.00000);
	createEE(27, "HALLOWEEN EVENT 28", 19320,3.0, -2779.038818, 1317.380981, 7.590801,   0.00000, 0.00000, 0.00000);
	createEE(28, "HALLOWEEN EVENT 29", 19320,3.0, -476.585144, -541.589050, 25.529611,   0.00000, 0.00000, 0.00000);
	createEE(29, "HALLOWEEN EVENT 30", 19320,3.0, -25.881288, 1359.155029, 9.171875,   0.00000, 0.00000, 0.00000);
	createEE(30, "HALLOWEEN EVENT 31", 19320,3.0, -1909.961059, 277.745422, 41.046875,   0.00000, 0.00000, 0.00000);
	loadEE();
	saveEE();
	return 1;
}

public OnFilterScriptExit()
{
	DOF2_Exit();
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, -1, "Sistema de Halloween de Luan P Rosa(RosaScripter) está sendo utilizado nesse servidor.");
	return 1;
}


public OnPlayerUpdate(playerid)
{
	checkEE(playerid);
	return 1;
}

CMD:halloween(playerid){

	MEGAString[0] = EOS;
    strcat(MEGAString, "HALLOWEEN EVENT\tQuem descobriu\n");
	for(new e; e != MAX_EASTER_EGGS; e++){

	    if(EEInfo[e][eaDescoberto]){

	    	format(Str2, sizeof Str2, "{888888}%s \t%s\n", EEInfo[e][eaDescricao], EEInfo[e][eaNick]);
		}
		else{

		    format(Str2, sizeof Str2, "{888888}%s \tNinguém\n", EEInfo[e][eaDescricao]);
		}

		strcat(MEGAString, Str2);
	}

	ShowPlayerDialog(playerid, 1, DIALOG_STYLE_LIST, "Encontre os HALLOWEEN EVENT", MEGAString, "Localizar", "Sair");
	return 1;
}
