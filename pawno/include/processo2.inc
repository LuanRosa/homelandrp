#include <a_samp>
new PlayerText:PROGRESSBAR[MAX_PLAYERS][21];
new LoadingPlayerBar[MAX_PLAYERS];
new TimerLoading[MAX_PLAYERS];
new ProgressTimer[MAX_PLAYERS][128];

HideProgressBar(playerid)
{
	for(new idx; idx < 21; idx++) PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][idx]);
	return 1;
}
/* Create TD */
CreateProgress(playerid)
{
	PROGRESSBAR[playerid][0] = CreatePlayerTextDraw(playerid, 291.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][0], 2.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][0], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][0], -1);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][0], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][0], 1);

	PROGRESSBAR[playerid][1] = CreatePlayerTextDraw(playerid, 291.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][1], -11.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][1], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][1], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][1], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][1], 1);

	PROGRESSBAR[playerid][2] = CreatePlayerTextDraw(playerid, 283.000, 423.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][2], -3.000, -23.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][2], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][2], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][2], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][2], 1);

	PROGRESSBAR[playerid][3] = CreatePlayerTextDraw(playerid, 304.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][3], -11.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][3], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][3], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][3], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][3], 1);

	PROGRESSBAR[playerid][4] = CreatePlayerTextDraw(playerid, 304.000, 423.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][4], -3.000, -23.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][4], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][4], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][4], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][4], 1);

	PROGRESSBAR[playerid][5] = CreatePlayerTextDraw(playerid, 301.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][5], -19.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][5], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][5], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][5], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][5], 1);

	PROGRESSBAR[playerid][6] = CreatePlayerTextDraw(playerid, 291.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][6], -11.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][6], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][6], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][6], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][6], 1);

	PROGRESSBAR[playerid][7] = CreatePlayerTextDraw(playerid, 283.000, 423.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][7], -3.000, -23.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][7], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][7], 859394047);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][7], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][7], 1);

	PROGRESSBAR[playerid][8] = CreatePlayerTextDraw(playerid, 292.000, 407.000, "100");
	PlayerTextDrawLetterSize(playerid, PROGRESSBAR[playerid][8], 0.180, 1.199);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][8], 2);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][8], 150);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][8], 1);

	PROGRESSBAR[playerid][9] = CreatePlayerTextDraw(playerid, 308.000, 407.000, "Mengambil Bulu..");
	PlayerTextDrawLetterSize(playerid, PROGRESSBAR[playerid][9], 0.180, 1.199);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][9], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][9], 150);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][9], 1);

	PROGRESSBAR[playerid][10] = CreatePlayerTextDraw(playerid, 291.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][10], -4.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][10], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][10], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][10], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][10], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][10], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][10], 1);

	PROGRESSBAR[playerid][11] = CreatePlayerTextDraw(playerid, 287.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][11], -4.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][11], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][11], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][11], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][11], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][11], 1);

	PROGRESSBAR[playerid][12] = CreatePlayerTextDraw(playerid, 283.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][12], -3.000, -10.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][12], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][12], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][12], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][12], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][12], 1);

	PROGRESSBAR[playerid][13] = CreatePlayerTextDraw(playerid, 283.000, 416.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][13], -3.000, -10.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][13], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][13], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][13], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][13], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][13], 1);

	PROGRESSBAR[playerid][14] = CreatePlayerTextDraw(playerid, 283.000, 406.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][14], -3.000, -6.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][14], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][14], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][14], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][14], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][14], 1);

	PROGRESSBAR[playerid][15] = CreatePlayerTextDraw(playerid, 282.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][15], 9.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][15], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][15], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][15], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][15], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][15], 1);

	PROGRESSBAR[playerid][16] = CreatePlayerTextDraw(playerid, 291.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][16], 13.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][16], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][16], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][16], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][16], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][16], 1);

	PROGRESSBAR[playerid][17] = CreatePlayerTextDraw(playerid, 301.000, 403.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][17], 3.000, 10.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][17], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][17], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][17], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][17], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][17], 1);

	PROGRESSBAR[playerid][18] = CreatePlayerTextDraw(playerid, 301.000, 412.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][18], 3.000, 11.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][18], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][18], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][18], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][18], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][18], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][18], 1);

	PROGRESSBAR[playerid][19] = CreatePlayerTextDraw(playerid, 298.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][19], 6.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][19], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][19], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][19], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][19], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][19], 1);

	PROGRESSBAR[playerid][20] = CreatePlayerTextDraw(playerid, 292.000, 426.000, "LD_SPAC:white");
	PlayerTextDrawTextSize(playerid, PROGRESSBAR[playerid][20], 6.000, -3.000);
	PlayerTextDrawAlignment(playerid, PROGRESSBAR[playerid][20], 1);
	PlayerTextDrawColor(playerid, PROGRESSBAR[playerid][20], 1689621759);
	PlayerTextDrawSetShadow(playerid, PROGRESSBAR[playerid][20], 0);
	PlayerTextDrawSetOutline(playerid, PROGRESSBAR[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, PROGRESSBAR[playerid][20], 255);
	PlayerTextDrawFont(playerid, PROGRESSBAR[playerid][20], 4);
	PlayerTextDrawSetProportional(playerid, PROGRESSBAR[playerid][20], 1);
	return 1;
}
/* Func */
ShowProgressbar(playerid, text[] = "", Times)
{
	if(pData[playerid][pProgress] > 0) return 1;
	LoadingPlayerBar[playerid] = 0;
	pData[playerid][pProgress] = 1;
	new Timer = Times*1000/100;
	PlayerTextDrawSetString(playerid, PROGRESSBAR[playerid][9], text);
	for(new idx; idx < 10; idx++) PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][idx]);
	TogglePlayerControllable(playerid, 0);
	TimerLoading[playerid] = SetTimerEx("UpdtLoading", Timer, true, "d", playerid);
	return 1;
}

stock UpdateLoading(playerid)
{
	new str[100];
	format(str, sizeof(str), "%d", LoadingPlayerBar[playerid]);
	PlayerTextDrawSetString(playerid, PROGRESSBAR[playerid][8], str);
	PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][8]);
	
	if(LoadingPlayerBar[playerid] >= 10)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][10]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][10]);
	}
	if(LoadingPlayerBar[playerid] >= 20)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][11]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][11]);
	}
	if(LoadingPlayerBar[playerid] >= 30)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][12]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][12]);
	}
	if(LoadingPlayerBar[playerid] >= 40)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][13]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][13]);
	}
	if(LoadingPlayerBar[playerid] >= 50)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][14]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][14]);
	}
	if(LoadingPlayerBar[playerid] >= 60)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][15]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][15]);
	}
	if(LoadingPlayerBar[playerid] >= 70)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][16]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][16]);
	}
	if(LoadingPlayerBar[playerid] >= 80)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][17]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][17]);
	}
	if(LoadingPlayerBar[playerid] >= 85)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][18]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][18]);
	}
	if(LoadingPlayerBar[playerid] >= 95)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][19]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][19]);
	}
	if(LoadingPlayerBar[playerid] >= 97)
	{
	    PlayerTextDrawShow(playerid, PROGRESSBAR[playerid][20]);
	}
	else
	{
	    PlayerTextDrawHide(playerid, PROGRESSBAR[playerid][20]);
	}
	return 1;
}

forward UpdtLoading(playerid);
public UpdtLoading(playerid)
{
	LoadingPlayerBar[playerid] += 1;
	UpdateLoading(playerid);
	if(LoadingPlayerBar[playerid] >= 100)
	{
		KillTimer(TimerLoading[playerid]);
		LoadingPlayerBar[playerid] = 0;
		pData[playerid][pProgress] = 0;
		HideProgressBar(playerid);
		SetTimerEx(ProgressTimer[playerid], 500, false, "d", playerid);
		TogglePlayerControllable(playerid, 1);
		for(new i=0; i<MAX_PLAYER_ATTACHED_OBJECTS; i++)
		{
			if(IsPlayerAttachedObjectSlotUsed(playerid, i)) RemovePlayerAttachedObject(playerid, i);
		}
	}
	return 1;
}
CMD:testprog(playerid, params[])
{
   	if(pData[playerid][pProgress] == 1) return ErrorMsg(playerid, "Anda sedang melakukan activity progress");
	ShowProgressbar(playerid, "Test aja", 3);
	return 1;
}
