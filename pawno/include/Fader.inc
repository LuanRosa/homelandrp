

forward Fader_PlayerProcess(playerid);
forward OnPlayerFadeIn(playerid);
forward OnPlayerFadeOut(playerid);
stock fadeIn(playerid, ms, color = 0x000000FF);
stock fadeOut(playerid, ms, color = 0x000000FF);

const
	MAX_TRANSPARENCY = 0xFF,
	TIMER_FRAME = 85;

enum {
	FADE_IN = 1,
	FADE_OUT
}

enum E_PLAYER_FADE_INFO {
	fadeCurrentAlpha,

	fadeTotalFrames,
	fadeTransparencyPerFrame,
	fadeColor,

	fadeTimer,
	fadeType
}
new gPlayerFadeInfo[MAX_PLAYERS][E_PLAYER_FADE_INFO];
new PlayerText:gPlayerFaderTextId;

#define CAP_MAX(%0) ((%0 > MAX_TRANSPARENCY) ? (MAX_TRANSPARENCY) : %0)
#define CAP_MIN(%0) ((%0 < 0) ? (0) : %0)

/* Natives:
*	native fadeIn(playerid, ms, color = 0x000000FF);
*	native fadeOut(playerid, ms, color = 0x000000FF);
*
* 	por Stewie`
*/

stock fadeIn(playerid, ms, color = 0x000000FF) {
	if(!IsPlayerConnected(playerid))
		return 0;

	// pegar a transpar�ncia atual da textdraw
	new alpha = gPlayerFadeInfo[playerid][fadeCurrentAlpha];
	// no caso da textdraw tiver a transpar�ncia cheia, ou mais do que o permitido, o nosso trabalho est� feito
	if((MAX_TRANSPARENCY - alpha) <= 0) {
		gPlayerFadeInfo[playerid][fadeCurrentAlpha] = MAX_TRANSPARENCY;
		gPlayerFadeInfo[playerid][fadeType] = 0;

		PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | alpha);
		PlayerTextDrawShow(playerid, gPlayerFaderTextId);
		return 1;
	}
	// configurar o tipo de fade que estamos aplicando
	gPlayerFadeInfo[playerid][fadeType] = FADE_IN;

	// mover um byte para a direita para 'apagar' a transpar�ncia
	// e '>>' para n�o voltar para o come�o os primeiros bits
	gPlayerFadeInfo[playerid][fadeColor] = color >> 8;

	// a quantidade de frames que o PlayerProcess ir� processar
	// voc� pode perceber que a dura��o � dividida pelos frames por processamento e, se existe restante, � adicinado mais um processamento
	gPlayerFadeInfo[playerid][fadeTotalFrames] = ((ms / TIMER_FRAME) + _:((ms % TIMER_FRAME) > 0));
	// o tanto de transpar�ncia que ser� adicionado por cada processamento
	// no fim, deve ser checado a quantidade de transar�ncia que a textdraw possui
	// a transpar�ncia que ser� adicionada at� o final � dividida pela quantidade de frames que ser�o rodados
	gPlayerFadeInfo[playerid][fadeTransparencyPerFrame] =  (MAX_TRANSPARENCY - alpha) / gPlayerFadeInfo[playerid][fadeTotalFrames];

	if(gPlayerFadeInfo[playerid][fadeTransparencyPerFrame] <= 0) {
		gPlayerFadeInfo[playerid][fadeTransparencyPerFrame] = 10;
	}

	PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | alpha);
	PlayerTextDrawShow(playerid, gPlayerFaderTextId);
	// se n�o existir o timer, cri�-lo!
	if(!gPlayerFadeInfo[playerid][fadeTimer]) {
		gPlayerFadeInfo[playerid][fadeTimer] = SetTimerEx("Fader_PlayerProcess", TIMER_FRAME, 1, "i", playerid);
	}
	return 1;
}

stock fadeOut(playerid, ms, color = 0x000000FF) {
	if(!IsPlayerConnected(playerid))
		return 0;

	// pegar a transpar�ncia atual da textdraw
	new alpha = gPlayerFadeInfo[playerid][fadeCurrentAlpha];
	// no caso da textdraw n�o tiver nenhuma transpar�nca, sair
	if(alpha <= 0) {
		gPlayerFadeInfo[playerid][fadeCurrentAlpha] = MAX_TRANSPARENCY;
		gPlayerFadeInfo[playerid][fadeType] = 0;

		PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | alpha);
		PlayerTextDrawShow(playerid, gPlayerFaderTextId);
		return 1;
	}
	// configurar o tipo de fade que estamos aplicando
	gPlayerFadeInfo[playerid][fadeType] = FADE_OUT;

	// mover um byte para a direita para 'apagar' a transpar�ncia
	// e '>>' para n�o voltar para o come�o os primeiros bits
	gPlayerFadeInfo[playerid][fadeColor] = color >> 8;

	// a quantidade de frames que o PlayerProcess ir� processar
	// voc� pode perceber que a dura��o � dividida pelos frames por processamento e, se existe restante, � adicinado mais um processamento
	gPlayerFadeInfo[playerid][fadeTotalFrames] = ((ms / TIMER_FRAME) + _:((ms % TIMER_FRAME) > 0));
	// o tanto de transpar�ncia que ser� subtra�da por cada processamento
	// no fim, deve ser checado a quantidade de transar�ncia que a textdraw possui
	// a transpar�ncia que ser� subtra�da at� o final � dividida pela quantidade de frames que ser�o rodados
	gPlayerFadeInfo[playerid][fadeTransparencyPerFrame] =  (alpha) / gPlayerFadeInfo[playerid][fadeTotalFrames];

	if(gPlayerFadeInfo[playerid][fadeTransparencyPerFrame] <= 0) {
		gPlayerFadeInfo[playerid][fadeTransparencyPerFrame] = 10;
	}

	PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | alpha);
	PlayerTextDrawShow(playerid, gPlayerFaderTextId);
	// se n�o existir o timer, cri�-lo!
	if(!gPlayerFadeInfo[playerid][fadeTimer]) {
		gPlayerFadeInfo[playerid][fadeTimer] = SetTimerEx("Fader_PlayerProcess", TIMER_FRAME, 1, "i", playerid);
	}
	return 1;
}

public Fader_PlayerProcess(playerid) {
	// se o fade foi desligado para o player, mas o timer ainda est� ativo
	if(gPlayerFadeInfo[playerid][fadeType] == 0) {
		// se o timer existe
		if(gPlayerFadeInfo[playerid][fadeTimer] > 0) {
			KillTimer(gPlayerFadeInfo[playerid][fadeTimer]);
			gPlayerFadeInfo[playerid][fadeTimer] = 0;

			PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | gPlayerFadeInfo[playerid][fadeCurrentAlpha]);
			PlayerTextDrawShow(playerid, gPlayerFaderTextId);
		}
	}

	switch(gPlayerFadeInfo[playerid][fadeType]) {
		case FADE_IN: {
			gPlayerFadeInfo[playerid][fadeCurrentAlpha] += gPlayerFadeInfo[playerid][fadeTransparencyPerFrame];
			gPlayerFadeInfo[playerid][fadeCurrentAlpha] = CAP_MAX(gPlayerFadeInfo[playerid][fadeCurrentAlpha]);

			PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | gPlayerFadeInfo[playerid][fadeCurrentAlpha]);
			PlayerTextDrawShow(playerid, gPlayerFaderTextId);

			if(gPlayerFadeInfo[playerid][fadeCurrentAlpha] == MAX_TRANSPARENCY) {
				gPlayerFadeInfo[playerid][fadeType] = 0;
				KillTimer(gPlayerFadeInfo[playerid][fadeTimer]);
				gPlayerFadeInfo[playerid][fadeTimer] = 0;

				#if defined OnPlayerFadeIn
				    OnPlayerFadeIn(playerid);
				#endif
				
				//PlayerTextDrawHide(playerid, gPlayerFaderTextId);
			}
		}
		case FADE_OUT: {
			gPlayerFadeInfo[playerid][fadeCurrentAlpha] -= gPlayerFadeInfo[playerid][fadeTransparencyPerFrame];
			gPlayerFadeInfo[playerid][fadeCurrentAlpha] = CAP_MIN(gPlayerFadeInfo[playerid][fadeCurrentAlpha]);

			PlayerTextDrawBoxColor(playerid, gPlayerFaderTextId, (gPlayerFadeInfo[playerid][fadeColor] << 8) | gPlayerFadeInfo[playerid][fadeCurrentAlpha]);
			PlayerTextDrawShow(playerid, gPlayerFaderTextId);

			if(gPlayerFadeInfo[playerid][fadeCurrentAlpha] == 0) {
				gPlayerFadeInfo[playerid][fadeType] = 0;
				KillTimer(gPlayerFadeInfo[playerid][fadeTimer]);
				gPlayerFadeInfo[playerid][fadeTimer] = 0;

				#if defined OnPlayerFadeOut
				    OnPlayerFadeOut(playerid);
				#endif
				
				PlayerTextDrawHide(playerid, gPlayerFaderTextId);
			}
		}
	}
	return 1;
}
