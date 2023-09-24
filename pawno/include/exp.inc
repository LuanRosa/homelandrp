/*

	Exp.inc
	 - Bem essa 'include' não é das melhores, mais fiz com vontade.
	 - Feito por: skyMateus

	Exp:
	 TEXT_SIZE_DEFAULT (float) [pos x - "string"] "default null"
	 TEXT_SOUND_DEFAULT (bool) [sound option] "default sound on"
	 TEXT_TIME_DEFAULT (time) [time to disappearance] "default 2 seconds"

	 ExpFunc(playerid, Nivel Atual, Nivel Aproximado, Porcentagem, 15);
*/


#if !defined( TEXT_SIZE_DEFAULT )
	#define TEXT_SIZE_DEFAULT (1.5)
#endif

#if !defined( TEXT_SOUND_DEFAULT )
	#define TEXT_SOUND_DEFAULT (true)
#endif

#if !defined( TEXT_TIME_DEFAULT )
	#define TEXT_TIME_DEFAULT (2000) //2s
#endif

static PlayerText:XPTXD[MAX_PLAYERS][20];

#define XP_::%1(%2) forward %1(%2); public %1(%2)

stock ExpFunc(playerid, XP, XP_Prox, Float:XP_Porc = 0.0, masganho = _:0.0)
{
    new string[20] = _:0.0; //const string[20] = _:0.0;

    for(new i; i < sizeof XPTXD[]; i++){ PlayerTextDrawDestroy(playerid, XPTXD[playerid][i]); }
    XPTXD[playerid][0] = CreatePlayerTextDraw(playerid, 241.000000, 12.044451, "box");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][0], 0.000000, 0.127000);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][0], 405.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][0], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][0], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][0], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][0], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][0], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][0], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][0], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][0], 0);

    XPTXD[playerid][1] = CreatePlayerTextDraw(playerid, 241.800048, 13.344456, "xp_progress");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][1], 0.000000, -0.043000);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][1], 239.597900+(XP_Porc*1.62), 1.0);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][1], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][1], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][1], 512819114);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][1], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][1], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][1], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][1], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][1], 0);

    XPTXD[playerid][2] = CreatePlayerTextDraw(playerid, 256.100921, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][2], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][2], 253.100677, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][2], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][2], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][2], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][2], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][2], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][2], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][2], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][2], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][2], 0);

    XPTXD[playerid][3] = CreatePlayerTextDraw(playerid, 271.801879, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][3], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][3], 268.801635, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][3], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][3], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][3], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][3], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][3], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][3], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][3], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][3], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][3], 0);

    XPTXD[playerid][4] = CreatePlayerTextDraw(playerid, 288.102874, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][4], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][4], 285.102630, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][4], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][4], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][4], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][4], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][4], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][4], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][4], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][4], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][4], 0);

    XPTXD[playerid][5] = CreatePlayerTextDraw(playerid, 304.003845, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][5], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][5], 301.003601, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][5], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][5], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][5], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][5], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][5], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][5], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][5], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][5], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][5], 0);

    XPTXD[playerid][6] = CreatePlayerTextDraw(playerid, 319.804809, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][6], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][6], 316.804565, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][6], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][6], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][6], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][6], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][6], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][6], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][6], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][6], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][6], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][6], 0);

    XPTXD[playerid][7] = CreatePlayerTextDraw(playerid, 334.805725, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][7], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][7], 331.805480, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][7], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][7], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][7], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][7], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][7], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][7], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][7], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][7], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][7], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][7], 0);

    XPTXD[playerid][8] = CreatePlayerTextDraw(playerid, 349.706634, 12.844454, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][8], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][8], 346.706390, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][8], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][8], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][8], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][8], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][8], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][8], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][8], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][8], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][8], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][8], 0);

    XPTXD[playerid][9] = CreatePlayerTextDraw(playerid, 366.000000, 13.000000, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][9], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][9], 363.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][9], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][9], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][9], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][9], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][9], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][9], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][9], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][9], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][9], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][9], 0);

    XPTXD[playerid][10] = CreatePlayerTextDraw(playerid, 382.000000, 13.000000, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][10], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][10], 379.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][10], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][10], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][10], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][10], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][10], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][10], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][10], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][10], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][10], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][10], 0);

    XPTXD[playerid][11] = CreatePlayerTextDraw(playerid, 395.000000, 13.000000, "box_rp");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][11], 0.000000, 0.013999);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][11], 392.000000, 0.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][11], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][11], -1);
    PlayerTextDrawUseBox(playerid, XPTXD[playerid][11], 1);
    PlayerTextDrawBoxColor(playerid, XPTXD[playerid][11], -76);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][11], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][11], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][11], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][11], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][11], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][11], 0);

    XPTXD[playerid][12] = CreatePlayerTextDraw(playerid, 218.000000, 2.555553, "LD_POOL:ball");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][12], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][12], 18.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][12], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][12], 512819114);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][12], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][12], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][12], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][12], 4);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][12], 0);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][12], 0);

    XPTXD[playerid][13] = CreatePlayerTextDraw(playerid, 218.700042, 3.688885, "LD_POOL:ball");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][13], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][13], 16.810018, 19.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][13], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][13], -1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][13], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][13], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][13], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][13], 4);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][13], 0);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][13], 0);

    XPTXD[playerid][14] = CreatePlayerTextDraw(playerid, 410.711761, 2.555553, "LD_POOL:ball");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][14], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][14], 18.000000, 21.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][14], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][14], 512819114);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][14], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][14], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][14], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][14], 4);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][14], 0);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][14], 0);

    XPTXD[playerid][15] = CreatePlayerTextDraw(playerid, 411.100067, 3.533331, "LD_POOL:ball");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][15], 0.000000, 0.000000);
    PlayerTextDrawTextSize(playerid, XPTXD[playerid][15], 16.810018, 19.000000);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][15], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][15], -1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][15], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][15], 0);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][15], 255);
    PlayerTextDrawFont(playerid, XPTXD[playerid][15], 4);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][15], 0);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][15], 0);

    format(string, 20, "%d", XP); XPTXD[playerid][16] = CreatePlayerTextDraw(playerid, 216.700042+TEXT_SIZE_DEFAULT, 5.599997, string);
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][16], 0.296999, 1.494222);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][16], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][16], 512819199);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][16], 1);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][16], 1);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][16], -1);
    PlayerTextDrawFont(playerid, XPTXD[playerid][16], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][16], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][16], 1);

    format(string, 20, "%d", XP_Prox); XPTXD[playerid][17] = CreatePlayerTextDraw(playerid, 409.799987+TEXT_SIZE_DEFAULT, 5.700000, string);
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][17], 0.296999, 1.494222);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][17], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][17], 512819199);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][17], 1);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][17], 1);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][17], -1);
    PlayerTextDrawFont(playerid, XPTXD[playerid][17], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][17], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][17], 1);

    format(string, 20, "+%d de Respeito", masganho); XPTXD[playerid][18] = CreatePlayerTextDraw(playerid, 295.899688, 17.500005, string);
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][18], 0.189500, 0.983999);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][18], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][18], 512819114);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][18], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][18], 1);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][18], -1);
    PlayerTextDrawFont(playerid, XPTXD[playerid][18], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][18], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][18], 0);

    XPTXD[playerid][19] = CreatePlayerTextDraw(playerid, 318.000000, 2.000000, "XP");
    PlayerTextDrawLetterSize(playerid, XPTXD[playerid][19], 0.184000, 0.815999);
    PlayerTextDrawAlignment(playerid, XPTXD[playerid][19], 1);
    PlayerTextDrawColor(playerid, XPTXD[playerid][19], 512819114);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][19], 0);
    PlayerTextDrawSetOutline(playerid, XPTXD[playerid][19], 1);
    PlayerTextDrawBackgroundColor(playerid, XPTXD[playerid][19], -1);
    PlayerTextDrawFont(playerid, XPTXD[playerid][19], 1);
    PlayerTextDrawSetProportional(playerid, XPTXD[playerid][19], 1);
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][19], 0);
    
    for(new i; i < sizeof XPTXD[]; i++){ 
    	PlayerTextDrawShow(playerid, XPTXD[playerid][i]); 
	}
	
	#if TEXT_SOUND_DEFAULT == true
		PlayerPlaySound(playerid, 5202, 0.0, 0.0, 0.0);
	#endif

	#if defined TEXT_TIME_DEFAULT
		SetTimerEx("XP_Hide", TEXT_TIME_DEFAULT, 0, "i", playerid);
	#endif

    return 1;
}

//forward XP_Hide(playerid);
XP_::XP_Hide(playerid)
{
    for(new i; i < 20; i++)
    {
        PlayerTextDrawHide(playerid, XPTXD[playerid][i]);
    }
    PlayerPlaySound(playerid, 6402, 0.0, 0.0, 0.0);
}
