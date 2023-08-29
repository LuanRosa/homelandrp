
#define 	MAXNOTIFICACAONATELA 		(10)
#define 	MAXNOTIFICACOMENSAGEM 	(320)
#define 	MAXNOTIFICACOTITULO 	(64)
#define 	MAXTEMPONATELA 		(10)

enum ntInfo
{ 
	ntIcon[32], 
	ntTitulo[MAXNOTIFICACOTITULO], 
	ntMensagem[MAXNOTIFICACOMENSAGEM], 
	ntLines 
}
static notificacaoinfo[MAX_PLAYERS][MAXNOTIFICACAONATELA][ntInfo], 
	PlayerText:notificacaotxd[MAX_PLAYERS][MAXNOTIFICACAONATELA * 6], 
	notificacaoindex[MAX_PLAYERS];

#define notify::%0(%1) forward %0(%1); public %0(%1)

static const TxdCaracters[] = 
{
	0,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,12,
	12,12,12,12,12,12,12,13,13,28,28,28,28,8,17,17,30,28,28,12,9,21,28,14,28,28,
	28,28,28,28,28,28,13,13,30,30,30,30,10,25,23,21,24,22,20,24,24,17,20,22,20,
	30,27,27,26,26,24,23,24,31,23,31,24,23,21,28,33,33,14,28,10,11,12,9,11,10,
	10,12,12,7,7,13,5,18,12,10,12,11,10,12,8,13,13,18,17,13,12,30,30,37,35,37,
	25,25,25,25,33,21,24,24,24,24,17,17,17,17,27,27,27,27,31,31,31,31,11,11,11,
	11,11,20,9,10,10,10,10,7,7,7,7,10,10,10,10,13,13,13,13,27,12,30
};

stock pegartamanhomensagem(const string:mensagem[], largura=500) 
{
	new tamanho = 0, linhas=1, i=-1, ultimoponto = 0;

	while(mensagem[++i]) 
	{
		tamanho += TxdCaracters[mensagem[i]];

		switch(mensagem[i]) 
		{
			case ' ': 
				ultimoponto = i;

			default: 
				if(tamanho >= largura) 
					++linhas, 
					tamanho -= largura, 
					tamanho += i - ultimoponto;
		}
	}
	return linhas;
}

stock notificacao(const playerid, const string:titulo[], const string:mensagem[], const string:icon[] = "hud:radar_triads") 
{
	for(new x=-1;++x<notificacaoindex[playerid];) 
	{
		for(new i=-1;++i<6;) PlayerTextDrawDestroy(playerid, notificacaotxd[playerid][(x*6) + i]);
		notificacaoinfo[playerid][notificacaoindex[playerid]-x] = notificacaoinfo[playerid][(notificacaoindex[playerid]-x)-1];
	}

	strmid(notificacaoinfo[playerid][0][ntTitulo], titulo, 0, MAXNOTIFICACOTITULO);
	strmid(notificacaoinfo[playerid][0][ntMensagem], mensagem, 0, MAXNOTIFICACOMENSAGEM);
	strmid(notificacaoinfo[playerid][0][ntIcon], icon, 0, 20);
	notificacaoinfo[playerid][0][ntLines] = pegartamanhomensagem(mensagem);

	++notificacaoindex[playerid];

	new Float:static_x=0.0;
	for(new x=-1;++x<notificacaoindex[playerid];) 
	{
		criarnoticacao(playerid, x, x * 6, static_x);
		static_x+=(notificacaoinfo[playerid][x][ntLines] * 7.5) + 25.0;
	}
	PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
	SetTimerEx(#destruirnotificacao, MAXTEMPONATELA * 1000, false, #i, playerid);
	return 1;
}

notify::destruirnotificacao(playerid) 
{
	if(!notificacaoindex[playerid]) return 1;
	--notificacaoindex[playerid];
	for(new i=-1;++i<6;) PlayerTextDrawDestroy(playerid, notificacaotxd[playerid][(notificacaoindex[playerid]*6) + i]);
	StopAudioStreamForPlayer(playerid);
	return 1;
}

stock criarnoticacao(const playerid, index, i, const Float:static_x) {
	new linhas = notificacaoinfo[playerid][index][ntLines],Float:x = (linhas * 7.5) + static_x;

	notificacaotxd[playerid][i] = CreatePlayerTextDraw(playerid, 29.42, 292.73 - x, "box");
	PlayerTextDrawLetterSize(playerid, notificacaotxd[playerid][i], 0.0, 2.0 + (linhas *0.9));
	PlayerTextDrawTextSize(playerid, notificacaotxd[playerid][i], 132.0, 0.0);
	PlayerTextDrawAlignment(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawColor(playerid, notificacaotxd[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, notificacaotxd[playerid][i], 113);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, notificacaotxd[playerid][i], 255);
	PlayerTextDrawFont(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawSetProportional(playerid, notificacaotxd[playerid][i], 1); 
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawShow(playerid, notificacaotxd[playerid][i]);

	notificacaotxd[playerid][++i] = CreatePlayerTextDraw(playerid, 27.84, 298.5 - x, "particle:lamp_shad_64");
	PlayerTextDrawLetterSize(playerid, notificacaotxd[playerid][i], 0.0, 0.0);
	PlayerTextDrawTextSize(playerid, notificacaotxd[playerid][i], 109.0, 15.0 + (linhas * 7.2));
	PlayerTextDrawAlignment(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawColor(playerid, notificacaotxd[playerid][i], -16777184);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, notificacaotxd[playerid][i], 255);
	PlayerTextDrawFont(playerid, notificacaotxd[playerid][i], 4);
	PlayerTextDrawSetProportional(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawShow(playerid, notificacaotxd[playerid][i]);

	notificacaotxd[playerid][++i] = CreatePlayerTextDraw(playerid, 29.34, 292.7 - x, "box");
	PlayerTextDrawLetterSize(playerid, notificacaotxd[playerid][i], 0.0, 1.428);
	PlayerTextDrawTextSize(playerid, notificacaotxd[playerid][i], 44.0, 0.0);
	PlayerTextDrawAlignment(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawColor(playerid, notificacaotxd[playerid][i], -1);
	PlayerTextDrawUseBox(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawBoxColor(playerid, notificacaotxd[playerid][i], 113);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, notificacaotxd[playerid][i], 255);
	PlayerTextDrawFont(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawSetProportional(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawShow(playerid, notificacaotxd[playerid][i]);

	notificacaotxd[playerid][++i] = CreatePlayerTextDraw(playerid, 29.69, 292.83 - x, notificacaoinfo[playerid][index][ntIcon]);
	PlayerTextDrawLetterSize(playerid, notificacaotxd[playerid][i], 0.0, 0.0);
	PlayerTextDrawTextSize(playerid, notificacaotxd[playerid][i], 13.0, 13.0);
	PlayerTextDrawAlignment(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawColor(playerid, notificacaotxd[playerid][i], -1);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, notificacaotxd[playerid][i], 255);
	PlayerTextDrawFont(playerid, notificacaotxd[playerid][i], 4);
	PlayerTextDrawSetProportional(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawShow(playerid, notificacaotxd[playerid][i]);

	notificacaotxd[playerid][++i] = CreatePlayerTextDraw(playerid, 47.47, 291.44 - x, notificacaoinfo[playerid][index][ntTitulo]);
	PlayerTextDrawLetterSize(playerid, notificacaotxd[playerid][i], 0.134, 0.861);
	PlayerTextDrawAlignment(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawColor(playerid, notificacaotxd[playerid][i], -1);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, notificacaotxd[playerid][i], 255);
	PlayerTextDrawFont(playerid, notificacaotxd[playerid][i], 2);
	PlayerTextDrawSetProportional(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawShow(playerid, notificacaotxd[playerid][i]);

	notificacaotxd[playerid][++i] = CreatePlayerTextDraw(playerid, 30.61, 308.96 - x, notificacaoinfo[playerid][index][ntMensagem]);
	PlayerTextDrawLetterSize(playerid, notificacaotxd[playerid][i], 0.145, 0.887);
	PlayerTextDrawTextSize(playerid, notificacaotxd[playerid][i], 132.0, 0.0);
	PlayerTextDrawAlignment(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawColor(playerid, notificacaotxd[playerid][i], -1);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawSetOutline(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawBackgroundColor(playerid, notificacaotxd[playerid][i], 255);
	PlayerTextDrawFont(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawSetProportional(playerid, notificacaotxd[playerid][i], 1);
	PlayerTextDrawSetShadow(playerid, notificacaotxd[playerid][i], 0);
	PlayerTextDrawShow(playerid, notificacaotxd[playerid][i]);
	return true;
}

public OnPlayerConnect(playerid)
{
	
	notificacaoindex[playerid] = 0;

	#if defined NT_OnPlayerConnect
		return NT_OnPlayerConnect(playerid);
	#else
		return 1;
	#endif
}
#if defined _ALS_OnPlayerConnect
	#undef OnPlayerConnect
#else
	#define _ALS_OnPlayerConnect
#endif

#define OnPlayerConnect NT_OnPlayerConnect
#if defined NT_OnPlayerConnect
	forward NT_OnPlayerConnect(playerid);
#endif