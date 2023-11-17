/*
 * ProgressoBar

 *  CRIADO POR: Chapei

 (c) 2023 - 2025
*/

#include <a_samp>

enum ProgressInfo{
	p_callback[32],
	p_title[64],
	p_time,
	p_timer,
	Float:p_percent
}
new Progress_Info[MAX_PLAYERS][ProgressInfo], PlayerText:ProgressoBar[MAX_PLAYERS][14],PlayerBar:ProgressoBar_pp[MAX_PLAYERS][1],Reloginho[MAX_PLAYERS];

#define CallProg::%0(%1) forward %0(%1); public %0(%1)

#define DEFAULT_TIMER (50) // Melhor

#define Progresso:%0(%1,%2) \
	forward Progress_%0(%1,Float:%2); public Progress_%0(%1,Float:%2)

stock CreateProgress(playerid, callback[],title[], time = 1000){
	new string[128];
	Progress_Info[playerid][p_percent] = 0;
	Reloginho[playerid] = 0;
	CreateTDProgress(playerid);
	format(Progress_Info[playerid][p_callback], 32, "Progress_%s", callback);
	format(string,sizeof(string),"%s",title);
	PlayerTextDrawSetString(playerid, ProgressoBar[playerid][9], string);
	PlayerTextDrawShow(playerid, ProgressoBar[playerid][9]);
	Progress_Info[playerid][p_time] = time;
	Reloginho[playerid] = gettime()+(time / 10);

	Progress_Info[playerid][p_timer] = SetTimerEx("UpdateProgress", Progress_Info[playerid][p_time], true, "i", playerid);
	return 1;
}

CallProg:: UpdateProgress(playerid)
{
	if(Progress_Info[playerid][p_percent] >= 100.0)
	{
		return KillProgress(playerid);
	}
	new string[80];
	Progress_Info[playerid][p_percent] += 1; //(100 / Progress_Info[playerid][p_percent]); //
	SetPlayerProgressBarValue(playerid, ProgressoBar_pp[playerid][0], Progress_Info[playerid][p_percent]); 
	format(string, sizeof(string), "%.0f%", Progress_Info[playerid][p_percent]);
	PlayerTextDrawSetString(playerid, ProgressoBar[playerid][7], string);
	format(string, sizeof(string), "%s", ConvertTime(Reloginho[playerid]-gettime()));
	PlayerTextDrawSetString(playerid, ProgressoBar[playerid][13], string);
	PlayerTextDrawShow(playerid, ProgressoBar[playerid][7]);
	PlayerTextDrawShow(playerid, ProgressoBar[playerid][13]);
	
	CallLocalFunction(Progress_Info[playerid][p_callback], "df", playerid, Progress_Info[playerid][p_percent]);
	return 1;
}

stock KillProgress(playerid)
{
	for(new i = 0; i < 14; i++)
	{
		PlayerTextDrawDestroy(playerid, ProgressoBar[playerid][i]);
	}
	DestroyPlayerProgressBar(playerid, ProgressoBar_pp[playerid][0]);
	format(Progress_Info[playerid][p_callback], 32, ""); 
	KillTimer(Progress_Info[playerid][p_timer]);
	Progress_Info[playerid][p_time] = 18;
	Progress_Info[playerid][p_percent] = 0;
	return 1;
}

stock CreateTDProgress(playerid)
{
	ProgressoBar[playerid][0] = CreatePlayerTextDraw(playerid, 317.000000, 332.000000, "_");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][0], 0.600000, 4.149989);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][0], 298.500000, 106.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][0], 2);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][0], 471604479);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][0], 0);

	ProgressoBar[playerid][1] = CreatePlayerTextDraw(playerid, 259.000000, 324.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][1], 11.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][1], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][1], 471604479);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][1], 0);

	ProgressoBar[playerid][2] = CreatePlayerTextDraw(playerid, 322.000000, 330.000000, "_");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][2], 0.600000, 4.649991);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][2], 298.500000, 108.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][2], 2);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][2], 471604479);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][2], 0);

	ProgressoBar[playerid][3] = CreatePlayerTextDraw(playerid, 259.000000, 366.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][3], 11.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][3], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][3], 471604479);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][3], 0);

	ProgressoBar[playerid][4] = CreatePlayerTextDraw(playerid, 372.000000, 324.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][4], 11.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][4], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][4], 471604479);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][4], 0);

	ProgressoBar[playerid][5] = CreatePlayerTextDraw(playerid, 371.000000, 367.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][5], 12.000000, 12.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][5], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][5], 471604479);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][5], 0);

	ProgressoBar[playerid][6] = CreatePlayerTextDraw(playerid, 325.000000, 333.000000, "_");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][6], 0.600000, 4.049987);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][6], 298.500000, 107.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][6], 2);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][6], 471604479);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][6], 0);

	ProgressoBar[playerid][7] = CreatePlayerTextDraw(playerid, 275.000000, 348.000000, "0%");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][7], 0.195832, 1.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][7], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][7], 2);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][7], -18);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][7], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][7], 0);

	ProgressoBar[playerid][8] = CreatePlayerTextDraw(playerid, 287.000000, 348.000000, "Progresso");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][8], 0.195832, 1.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][8], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][8], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][8], -18);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][8], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][8], 0);

	ProgressoBar[playerid][9] = CreatePlayerTextDraw(playerid, 268.000000, 338.000000, "Roubando cofre...");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][9], 0.195832, 1.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][9], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][9], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][9], -1094795538);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][9], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][9], 0);

	ProgressoBar[playerid][10] = CreatePlayerTextDraw(playerid, 345.000000, 349.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][10], 4);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][10], 10.000000, 10.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][10], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][10], -18);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][10], -18);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][10], 0);

	ProgressoBar[playerid][11] = CreatePlayerTextDraw(playerid, 346.000000, 350.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][11], 4);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][11], 8.000000, 8.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][11], 1);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][11], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][11], 471604479);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][11], -18);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][11], 0);

	ProgressoBar[playerid][12] = CreatePlayerTextDraw(playerid, 349.000000, 350.000000, "L");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][12], 0.145833, 0.649999);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][12], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][12], 1);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][12], -18);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][12], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][12], 0);

	ProgressoBar[playerid][13] = CreatePlayerTextDraw(playerid, 367.000000, 350.000000, "00:00:40");
	PlayerTextDrawFont(playerid, ProgressoBar[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, ProgressoBar[playerid][13], 0.141665, 0.699999);
	PlayerTextDrawTextSize(playerid, ProgressoBar[playerid][13], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, ProgressoBar[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, ProgressoBar[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, ProgressoBar[playerid][13], 2);
	PlayerTextDrawColor(playerid, ProgressoBar[playerid][13], -1094795538);
	PlayerTextDrawBackgroundColor(playerid, ProgressoBar[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, ProgressoBar[playerid][13], 50);
	PlayerTextDrawUseBox(playerid, ProgressoBar[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, ProgressoBar[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, ProgressoBar[playerid][13], 0);
	ProgressoBar_pp[playerid][0] = CreatePlayerProgressBar(playerid, 270.000000, 366.000000, 108.000000, 1.000000, 1804477439, 100.000000, 0);
	SetPlayerProgressBarValue(playerid, ProgressoBar_pp[playerid][0], 0);
	for(new i = 0; i < 14; i++)
	{
		PlayerTextDrawShow(playerid, ProgressoBar[playerid][i]);
	}
	ShowPlayerProgressBar(playerid, ProgressoBar_pp[playerid][0]);
	return 1;
}

ConvertTime(number)
{
    new hours = 0, mins = 0, secs = 0, string[100];
    hours = floatround(number / 3600);
    mins = floatround((number / 60) - (hours * 60));
    secs = floatround(number - ((hours * 3600) + (mins * 60)));
    new days = 0;

    if(hours >= 24)
    {
        days = floatround((hours/24), floatround_floor);
        hours = hours % 24;
    }

    if(days > 0)
    {
        format(string, 100, "%d dias, %02d:%02d:%02d", days, hours, mins, secs);
    }
    else if(hours > 0)
    {
        format(string, 100, "%02d:%02d:%02d", hours, mins, secs);
    }
    else
    {
        format(string, 100, "00:%02d:%02d", mins, secs);
    }
    return string;
}


/*
	// Uso:
	
	public OnPlayerConnect(playerid)
	{
		CreateProgress(playerid, "Teste","Pescando...", 50); //   0.50 * 100 = (0.50ms)
	}

	Progresso:Teste(playerid, progress)
	{
		if(progress == 1){ SendClientMessage(playerid, -1, "Running"); }
		if(progress >= 100)
		{
			SendClientMessage(playerid, -1, "Finish");
		}
		return 1;
	}
*/