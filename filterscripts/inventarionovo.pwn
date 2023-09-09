#define SSCANF_NO_NICE_FEATURES
#include <a_samp>
#include <zcmd>
#include <DOF2>
#include <foreach>
#include <sscanf2>
#include <streamer>

#define Callback::%0(%1) 		forward %0(%1);\
							public %0(%1)

#define Pasta_Inventario		"Inventarios/%s.ini"
#define COLOR_GRAD2             0xBFC0C2AA
#define COLOR_GRAD1             0xB4B5B7AA
#define COLOR_AVISO				0x4F4F4FAA
#define COLOR_GRAD5             0xF0F0F0AA
#define COLOR_LIGHTGREEN		0x2DFF2DAA

enum iInv
{
    DropItem,
    DropItemUni,
    DropItemID,
    Pickup,
    Virtual,
    Interior,
    Text3D:LabelItem,
    Slot,
    Unidades
};

new PlayerInventario[MAX_PLAYERS][33][iInv];
new DropItemSlot[MAX_OBJECTS][iInv];
new PlayerText:DrawInv[MAX_PLAYERS][40];
new InventarioAberto[MAX_PLAYERS];
new BigEar[MAX_PLAYERS];

static stock PlayerName(playerid)
{
	new Name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, Name, sizeof Name);
	return Name;
}

public OnGameModeExit()
{
    DOF2_Exit();
	return 1;
}

public OnPlayerConnect(playerid)
{
	InventarioAberto[playerid] = 0;
	TextDrawInv(playerid);
	CriarInventario(playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	InventarioAberto[playerid] = 0;
	SalvarInventario(playerid);
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText: playertextid)
{
	new str[64];
	for(new i = 1; i < 33; ++i)
	{
		if(playertextid == DrawInv[playerid][i])
		{
			if(PlayerInventario[playerid][i][Slot] == -1)
			{
				PlayerTextDrawSetString(playerid, DrawInv[playerid][38], "");
			}
			else
			{
				format(str, sizeof(str), "%s - %s unidades", ItemNomeInv(PlayerInventario[playerid][i][Slot]), ConvertMoney(PlayerInventario[playerid][i][Unidades]));
				PlayerTextDrawSetString(playerid, DrawInv[playerid][38], str);
			}
			PlayerTextDrawShow(playerid, DrawInv[playerid][38]);
			SetPVarInt(playerid, #VarSlotInv, i);
			return 1;
		}
	}
	if(playertextid == DrawInv[playerid][36]) return FuncaoItens(playerid, GetPVarInt(playerid, #VarSlotInv));
	if(playertextid == DrawInv[playerid][35]) return cmd_inventario(playerid);
	if(playertextid == DrawInv[playerid][37]) return DroparItem(playerid, GetPVarInt(playerid, #VarSlotInv));
	return 0;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
		for(new i = 0; i < 40; ++i)
		{
			PlayerTextDrawHide(playerid, DrawInv[playerid][i]);
		}
		InventarioAberto[playerid] = 0;
		return 1;
	}
	return 0;
}

CMD:pegaritem (playerid)
{
    new Float:x, Float:y, Float:z, str[128];
    for(new i = 0; i < sizeof(DropItemSlot); i++)
    {
        GetDynamicObjectPos(DropItemSlot[i][DropItem], x,y,z);
        if(DropItemSlot[i][DropItem] != 0)
        {
            if(IsPlayerInRangeOfPoint(playerid, 1.5, x,y,z+1) && GetPlayerVirtualWorld(playerid) == DropItemSlot[i][Virtual] && GetPlayerInterior(playerid) == DropItemSlot[i][Interior])
            {
                if(!CheckInventario(playerid, DropItemSlot[i][DropItemID])) return SendClientMessage(playerid, -1, "Sua Mochila está cheia.");
                GanharItem(playerid, DropItemSlot[i][DropItemID], DropItemSlot[i][DropItemUni]);
                format(str, 64, "Você pegou %s do chão com %s unidades.", ItemNomeInv(DropItemSlot[i][DropItemID]), ConvertMoney(DropItemSlot[i][DropItemUni]));
				DestroyDynamicObject(DropItemSlot[i][DropItem]);
				DestroyDynamic3DTextLabel(DropItemSlot[i][LabelItem]);
				DropItemSlot[i][DropItem] = 0;
				DropItemSlot[i][DropItemID] = -1;
				DropItemSlot[i][DropItemUni] = 0;
				DropItemSlot[i][Interior] = 0;
				DropItemSlot[i][Virtual] = 0;
				SendClientMessage(playerid, 0xB384FFAA, str);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
                return 1;
            }
        }
    }
    return 1;
}

CMD:inventario(playerid)
{
	new str[64];
	if(InventarioAberto[playerid])
	{
		for(new i = 0; i < 40; ++i)
		{
			PlayerTextDrawHide(playerid, DrawInv[playerid][i]);
		}
		InventarioAberto[playerid] = 0;
		CancelSelectTextDraw(playerid);
		format(str, 64, "*%s fechou seu inventario.", PlayerName(playerid));
        SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
		return 1;
	}
	else
	{
		format(str, sizeof(str), "Inventario: %s", PlayerName(playerid));
		PlayerTextDrawSetString(playerid, DrawInv[playerid][34], str);
		PlayerTextDrawSetString(playerid, DrawInv[playerid][38], "");
		for(new i = 1; i < 33; ++i)
		{
			PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][i], PlayerInventario[playerid][i][Slot]);
			if(PlayerInventario[playerid][i][Slot] == -1)
			{
				PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][i], 0.000000, 0.000000, 0.000000, 999);
			}
			else
			{
				PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][i], 0.000000, 0.000000, 0.000000, 1);
			}
		}
		for(new i = 0; i < 40; ++i)
		{
			PlayerTextDrawShow(playerid, DrawInv[playerid][i]);
		}
		SelectTextDraw(playerid, 0xC4C4C4AA);
		InventarioAberto[playerid] = 1;
		format(str, 64, "*%s abriu seu inventario.", PlayerName(playerid));
        SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
	}
	return 1;
}

CMD:daritem(playerid, const params[])
{
	new id, item, quantia;
	if(sscanf(params, "iii", id, item, quantia)) return SendClientMessage(playerid, COLOR_GRAD2, "Use: /daritem [ID] [ITEM ID] [UNIDADES].");
	if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_GRAD1, "Jogador não conectado.");
	if(!IsValidItemInv(item)) return SendClientMessage(playerid, COLOR_GRAD1, "Item Indefinido no servidor.");
	if(quantia < 1) return SendClientMessage(playerid, COLOR_GRAD1, "A quantia deve ser no mínimo 1.");
	if(!CheckInventario(id, item)) return SendClientMessage(playerid, COLOR_GRAD1, "O inventario desse jogador está cheio.");
	GanharItem(id, item, quantia);
	new str[256];
	format(str, sizeof(str), "[Items]: {%06x}%s setou o item %s com %s unidades no inventario de %s.", COLOR_AVISO>>>8, PlayerName(playerid),
		ItemNomeInv(item), ConvertMoney(quantia), PlayerName(id));
	SendClientMessageToAll(0xEA6AACAA, str);
	return 1;
}

split(const strsrc[], const strdest[][], delimiter)
{
    new i, li;
    new aNum;
    new len;
    while(i <= strlen(strsrc))
    {
        if(strsrc[i]==delimiter || i==strlen(strsrc))
        {
            len = strmid(strdest[aNum], strsrc, li, i, 128);
            strdest[aNum][len] = 0;
            li = i+1;
            aNum++;
        }
        i++;
    }
    return true;
}

GanharItem(playerid, itemid, quantia)
{
	for(new i = 1; i < 33; ++i)
	{
		if(PlayerInventario[playerid][i][Slot] == itemid)
		{
			PlayerInventario[playerid][i][Slot] = itemid;
			PlayerInventario[playerid][i][Unidades]+= quantia;
			return 1;
		}
		else if(PlayerInventario[playerid][i][Slot] == -1)
		{
			PlayerInventario[playerid][i][Slot] = itemid;
			PlayerInventario[playerid][i][Unidades] = quantia;
			return 1;
		}
	}
	SendClientMessage(playerid, -1, "Seu inventario está cheio.");
	return 1;
}

Callback::CriarInventario(playerid)
{
	new file[64], str[128], string[128];
	format(file, sizeof(file), Pasta_Inventario, PlayerName(playerid));
	
	if(!DOF2_FileExists(file))
	{
		DOF2_CreateFile(file); printf("Criou arquivo!");
		for(new i = 1; i < 33; ++i)
		{
		    PlayerInventario[playerid][i][Slot] = -1;
		    PlayerInventario[playerid][i][Unidades] = -1;

			format(string, sizeof(string), "Item_%d", i);
			format(str, sizeof(str), "%d|%d", PlayerInventario[playerid][i][Slot], PlayerInventario[playerid][i][Unidades]);
			DOF2_SetString(file, string, str);
			DOF2_SaveFile();
		}
	}else{
		LoadInv(playerid);
	}
	return 1;
}

Callback::LoadInv(playerid)
{
	new file[64], key[64], string[2][64], str[64];
	format(file, sizeof(file), Pasta_Inventario, PlayerName(playerid));
	SetPVarInt(playerid, #VarSlotInv, 0);
	for(new i = 1; i < 33; ++i)
	{
		PlayerInventario[playerid][i][Slot] = -1;
		PlayerInventario[playerid][i][Unidades] = 0;
		format(key, sizeof(key), "Item_%d", i);
		format(str, sizeof(str), DOF2_GetString(file, key));
		split(str, string, '|');
		PlayerInventario[playerid][i][Slot] = strval(string[0]);
		PlayerInventario[playerid][i][Unidades] = strval(string[1]);
	}
	return 1;
}

Callback::SalvarInventario(playerid)
{
	new file[64], str[128], string[128];
	format(file, sizeof(file), Pasta_Inventario, PlayerName(playerid));
	if(!DOF2_FileExists(file)){DOF2_CreateFile(file);}
	for(new i = 1; i < 33; ++i)
	{
		format(string, sizeof(string), "Item_%d", i);
		format(str, sizeof(str), "%d|%d", PlayerInventario[playerid][i][Slot], PlayerInventario[playerid][i][Unidades]);
		DOF2_SetString(file, string, str);
		DOF2_SaveFile();
	}
	return 1;
}

SendClientMessageInRange(Float:_r, playerid, const _s[],c1,c2,c3,c4,c5)
{
    new Float:_x, Float:_y, Float:_z;
    GetPlayerPos(playerid, _x, _y, _z);
    foreach(new i : Player)
    {
        if(!BigEar[i])
        {
            if(GetPlayerVirtualWorld(i) != GetPlayerVirtualWorld(playerid) && GetPlayerInterior(i) != GetPlayerInterior(playerid))continue;
            if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/16)
                SendClientMessage(i, c1, _s);
            else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/8)
                SendClientMessage(i, c2, _s);
            else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/4)
                SendClientMessage(i, c3, _s);
            else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r/2)
                SendClientMessage(i, c4, _s);
            else if(GetPlayerDistanceFromPoint(i,_x,_y,_z) < _r)
                SendClientMessage(i, c5, _s);
        }
        else
        {
            SendClientMessage(i, c1, _s);
        }
    }
    return true;
}

CheckInventario(playerid, itemid)
{
	for(new i = 1; i < 33; ++i)
	{
		if(PlayerInventario[playerid][i][Slot] == itemid || PlayerInventario[playerid][i][Slot] == -1) return 1;
	}
	return 0;
}

ItemNomeInv(itemid) // AQUI VOCÊ PODE ADICIONAR OS ID DOS ITENS E SETAR SEU NOME (OBS: TOME CUIDADO AO OPTAR O USO DE LOOPS)
{
	new name[25];
	format(name, 25, "(null)");
    if(itemid >= 330 && itemid < 372) format(name, 25, NomeArmas(GetArmaInv(itemid))); // se for armas
	else
	switch(itemid)
	{
		case 19625: name = "Cigarro do K2";//Editavel
		case 11746: name = "Chave";
		case 3044: name = "Baseado";//Editavel
		case 19039: name = "Relogio de Ouro";
		case 19040: name = "Relogio de Prata";
		case 19042: name = "Relogio Dourado";
		case 19044: name = "Relogio Rosa";
		case 19045: name = "Relogio Vermelho";
		case 19046: name = "Relogio Verde";
		case 19047: name = "Relogio Roxo";
		case 11747: name = "Baseado";
		case 18865: name = "Celular Laranja";
		case 18866: name = "Celular Azul";
		case 18867: name = "Celular Laranja";
		case 18868: name = "Celular Preto";
		case 18869: name = "Celular Rosa";
		case 18870: name = "Celular Vermelho";
		case 18871: name = "Celular Verde";
		case 18872: name = "Celular Azul";
		case 18873: name = "Celular Amarelo";
		case 18874: name = "Celular Branco";
		case 19513: name = "Celular Branco";
		case 18875: name = "GPS";
		case 19874: name = "Barra de Ouro";
		case 19138: name = "Oculos Preto";
		case 19139: name = "Oculos Vermelho";
		case 19140: name = "Oculos Azul";
		case 19022: name = "Oculos Prata";
		case 19023: name = "Oculos Azul";
		case 19024: name = "Oculos Roxo";
		case 19025: name = "Oculos Rosa";
		case 19026: name = "Oculos Vermelho";
		case 19027: name = "Oculos Laranja";
		case 19028: name = "Oculos Amarelo";
		case 19029: name = "Oculos Verde";
		case 19030: name = "Oculos";
		case 19031: name = "Oculos";
		case 19032: name = "Oculos";
		case 19033: name = "Oculos Preto";
		case 19034: name = "Oculos";
		case 19035: name = "Oculos Azul";
		case 2992: name = "Aurea de Anjo";
		case 3065: name = "Bola de Basquete";
		case 11712: name = "Cruz";
		case 18953: name = "Toca Preta";
		case 18954: name = "Toca Verde";
		case 19554: name = "Gorro";
		case 18974: name = "Mascara Zorro";
		case 2114: name = "Bola de Basquete";
		case 18894: name = "Bandana";
		case 18903: name = "Bandana";
		case 18898: name = "Bandana";
		case 18899: name = "Bandana";
		case 18891: name = "Bandana";
		case 18909: name = "Bandana";
		case 18908: name = "Bandana";
		case 18907: name = "Bandana";
		case 18906: name = "Bandana";
		case 18905: name = "Bandana";
		case 18904: name = "Bandana";
		case 18901: name = "Bandana";
		case 18902: name = "Bandana";
		case 18892: name = "Bandana";
		case 18900: name = "Bandana";
		case 18897: name = "Bandana";
		case 18896: name = "Bandana";
		case 18895: name = "Bandana";
		case 18893: name = "Bandana";
		case 18810: name = "Bandana";
		case 18947: name = "Chapeu";
		case 18948: name = "Chapeu";
		case 18949: name = "Chapeu";
		case 18950: name = "Chapeu";
		case 18951: name = "Chapeu";
		case 19488: name = "Chapeu";
		case 18921: name = "Boina";
		case 18922: name = "Boina";
		case 18923: name = "Boina";
		case 18924: name = "Boina";
		case 18925: name = "Boina";
		case 18939: name = "Bone";
		case 18940: name = "Bone";
		case 18941: name = "Bone";
		case 18942: name = "Bone";
		case 18943: name = "Bone";
		case 18646: name = "Sirene";
		case 1314: name = "2 Players";
		case 19578: name = "Banana";
		case 18636: name = "Bone COP";
		case 19942: name = "Radio Policial";
		case 19141: name = "Capacete S.W.A.T";
		case 19558: name = "Bone Pizzaiolo";
		case 19801: name = "Mascara de Assalto";
		case 19330: name = "Chapeu de Bombeiro";
		case 1210: name = "Maleta";
		case 19528: name = "Chapeu de Mago";
		case 19134: name = "Seta Verde";
		case 19904: name = "Colete de Operario";
		case 19515: name = "Colete";
		case 19142: name = "Colete COP";
		case 19315: name = "Cervo";
		case 19527: name = "Caldeirao";
		case 19317: name = "Guitarra Eletrica";
		case 18688: name = "Efeito Fogo";
		case 18702: name = "Efeito Nitro";
		case 18728: name = "Efeito Sinalizador";
		case 19605: name = "Marker Vermelho";
		case 19606: name = "Marker Verde";
		case 19607: name = "Marker Azul";
		case 19823: name = "Whiskey";
		case 19820: name = "Conhaque";
		case 11722: name = "Ketchup";
		case 11723: name = "Mostarda";
		case 19570: name = "Leite";
		case 19824: name = "Champanhe";
		case 1486: name = "Cerveja";
		case 19822: name = "Vinho";
		case 1668: name = "Agua";
		case 2958: name = "Cerveja";
		case 19577: name = "Tomate";
		case 1485: name = "Baseado";
		case 19574: name = "Laranja";
		case 19575: name = "Maca";
		case 19576: name = "Maca Verde";
		case 2703: name = "Hamburger";
		case 2880: name = "Hamburger";
		case 19883: name = "Fatia de Pao";
		case 19896: name = "Maco de Cigarro";
		case 19897: name = "Maco de Cigarro";
		case 1546: name = "Refrigerante";
		case 2768: name = "Hamburger";
		case 1212: name = "Dinheiro";
		case 2601: name = "Refrigerante";
		case 19835: name = "Cafe";
		case 2881: name = "Fatia de Pizza";
		case 2702: name = "Fatia de Pizza";
		case 2769: name = "Taco";
		case 2709: name = "Remedio";
		case 19579: name = "Pao";
		case 19630: name = "Peixe";
		case 19094: name = "Hamburger";
		case 1582: name = "Pizza Media";
		case 19580: name = "Pizza Grande";
		case 19602: name = "Mina Terrestre";
		case 11738: name = "Remedio Grande";
		case 1654: name = "Dinamite";
		case 11736: name = "MedKit";
		case 1650: name = "Galao de Gasolina";
		case 1252: name = "C4";
		case 19893: name = "Notebook";
		case 19921: name = "Caixa de Ferramentas";
		case 2226: name = "Radio";
		case 19054: name = "Caixa Pequena";
		case 19056: name = "Caixa Grande";
		case 19055: name = "Caixa Media";
		case 19057: name = "Caixa Ouro";
		case 19058: name = "Caixa VIP";
		case 331: name = "Soco Ingles";
		case 333: name = "Taco de Golfe";
		case 334: name = "Cacetete";
		case 335: name = "Faca";
		case 336: name = "Taco de Baseball";
		case 337: name = "Pa";
		case 338: name = "Taco de Sinuca";
		case 339: name = "Katana";
		case 341: name = "Motoserra";
		case 321: name = "Dildo Roxo";
		case 322: name = "Dildo";
		case 323: name = "Vibrador";
		case 324: name = "Vibrador de Prata";
		case 325: name = "Flores";
		case 326: name = "Cano";
		case 342: name = "Granada";
		case 343: name = "Gas Lacrimogenio";
		case 344: name = "Coquetel Molotov";
		case 346: name = "Pistola 9mm";
		case 347: name = "Silenciadora 9mm";
		case 348: name = "Desert Eagle";
		case 349: name = "Shotgun";
		case 350: name = "Sawnoff";
		case 351: name = "Combat Shotgun";
		case 352: name = "Uzi";
		case 353: name = "MP5";
		case 355: name = "AK - 47";
		case 356: name = "M4";
		case 372: name = "Tec-9";
		case 357: name = "Country Rifle";
		case 358: name = "Sniper Rifle";
		case 359: name = "RPG";
		case 360: name = "HS Rocket";
		case 361: name = "Lanca-Chamas";
		case 362: name = "Minigun";
		case 363: name = "Satchel Charge";
		case 364: name = "Detonador";
		case 365: name = "Lata de Spray";
		case 366: name = "Extintor";
		case 367: name = "Camera";
		case 368: name = "Oculos Noturno";
		case 369: name = "Osculo Termal";
		case 371: name = "Parachute";
		default: name = "(null)";
	}
    return name;
}

static  NomeArmas(armaid)
{
    new name[35];
    switch(armaid)
    {
        case 1: name = "Soco Ingles";
        case 2: name = "Taco de Golfe";
        case 3: name = "Cacetete";
        case 4: name = "Faca";
        case 5: name = "Taco de Baseball";
        case 6: name = "Pa";
        case 7: name = "Taco de Sinuca";
        case 8: name = "Katana";
        case 9: name = "Motoserra";
        case 10: name = "Dildo Roxo";
        case 11: name = "Dildo";
        case 12: name = "Vibrador";
        case 13: name = "Vibrador de Prata";
        case 14: name = "Flores";
        case 15: name = "Cano";
        case 16: name = "Granada";
        case 17: name = "Gas Lacrimogenio";
        case 18: name = "Coquetel Molotov";
        case 22: name = "Pistola 9mm";
        case 23: name = "Silenciadora 9mm";
        case 24: name = "Desert Eagle";
        case 25: name = "Shotgun";
        case 26: name = "Sawnoff ";
        case 27: name = "Combat Shotgun";
        case 28: name = "Uzi";
        case 29: name = "MP5";
        case 30: name = "AK - 47";
        case 31: name = "M4";
        case 32: name = "Tec-9";
        case 33: name = "Country Rifle";
        case 34: name = "Sniper Rifle";
        case 35: name = "RPG";
        case 36: name = "HS Rocket";
        case 37: name = "Lanca-chamas";
        case 38: name = "Minigun";
        case 39: name = "Satchel Charge";
        case 40: name = "Detonador";
        case 41: name = "Lata de Spray";
        case 42: name = "Extintor";
        case 43: name = "Camera";
        case 44: name = "Oculos Noturno";
        case 45: name = "Osculo Termal";
        case 46: name = "Parachute";
        default: name = "Nenhuma";
    }
    return name;
}

DroparItem(playerid, modelid)
{
    if(IsPlayerConnected(playerid))
    {
    	new str[128], Float:x, Float:y, Float:z;
	    if(PlayerInventario[playerid][modelid][Slot] != -1)
	    {
	        GetPlayerPos(playerid, x,y,z);
	        for(new i = 0; i < MAX_OBJECTS; i++)
	        {
	            if(DropItemSlot[i][DropItem] == 0)
	            {
	               	DropItemSlot[i][DropItem] = CreateDynamicObject(PlayerInventario[playerid][modelid][Slot], x,y,z-1, 0, 0, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	                DropItemSlot[i][DropItemUni] = PlayerInventario[playerid][modelid][Unidades];
	                DropItemSlot[i][DropItemID] = PlayerInventario[playerid][modelid][Slot];
	                DropItemSlot[i][Virtual] = GetPlayerVirtualWorld(playerid);
	                DropItemSlot[i][Interior] = GetPlayerInterior(playerid);
	                format(str, sizeof(str), "Item: %s\nUnidades: %s", ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), ConvertMoney(PlayerInventario[playerid][modelid][Unidades]));
	                DropItemSlot[i][LabelItem] = CreateDynamic3DTextLabel(str, COLOR_GRAD5, x,y,z-1, 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
	                format(str, 100, "*%s largou o item %s com %s unidades no chão.", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), ConvertMoney(PlayerInventario[playerid][modelid][Unidades]));
	                SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
	                format(str, 128, "%s dropou o item %s no chão com %s Unidades.", PlayerName(playerid), ItemNomeInv(DropItemSlot[i][DropItemID]), ConvertMoney(DropItemSlot[i][DropItemUni]));
	                PlayerInventario[playerid][modelid][Unidades] = 0;
	                AtualizarInventario(playerid, modelid);
	                ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
	                return 1;
	            }
	        }
	    }
	}
    return 0;
}

AtualizarInventario(playerid, i)
{
    new str[64];
    if(PlayerInventario[playerid][i][Unidades] < 1)
    {
        PlayerInventario[playerid][i][Unidades] = 0;
        PlayerInventario[playerid][i][Slot] = -1;
    }
    if(PlayerInventario[playerid][i][Slot] == -1)
	{
		PlayerTextDrawSetString(playerid, DrawInv[playerid][38], "");
		PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][i], 0.000000, 0.000000, 0.000000, 999);
	}
	else
	{
		format(str, sizeof(str), "%s - %s unidades", ItemNomeInv(PlayerInventario[playerid][i][Slot]), ConvertMoney(PlayerInventario[playerid][i][Unidades]));
		PlayerTextDrawSetString(playerid, DrawInv[playerid][38], str);
		PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][i], 0.000000, 0.000000, 0.000000, 1);
	}
	PlayerTextDrawShow(playerid, DrawInv[playerid][38]);
	PlayerTextDrawShow(playerid, DrawInv[playerid][i]);
    return 1;
}

FuncaoItens(playerid, modelid)//  AQUI VOCÊ PODE DEFINIR AS FUNÇÕES DE CADA ITEM. SEGUE AS FUNÇÕES PRONTAS ABAIXO
{
	new str[128], Float:life;
	switch(PlayerInventario[playerid][modelid][Slot])
	{
		case 331..371://
        {
            GivePlayerWeapon(playerid, GetArmaInv(PlayerInventario[playerid][modelid][Slot]), PlayerInventario[playerid][modelid][Unidades]);
            format(str, sizeof(str), "*%s retirou uma %s de sua mochila.", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            PlayerInventario[playerid][modelid][Unidades] = 0;
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 19823, 19820, 1486, 19824, 19822, 2958://Bebidas Alcoolicas
        {
        	PlayerInventario[playerid][modelid][Unidades]--;
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+1);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	format(str, 128, "*%s bebeu uma garrava de %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	ApplyAnimation(playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 0, 0, 0, 0, 1);
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_BEER);
            SetPlayerSpecialAction(playerid, SPECIAL_ACTION_DRINK_WINE);
            return 1;
        }
        case 11722, 11723://Mostarda & Ketchup
        {
        	PlayerInventario[playerid][modelid][Unidades]--;
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+3);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	format(str, 128, "*%s comeu sache de %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 19570, 1668, 1546, 2601://Leite & Agua & Refrigerante
        {
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+25);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	PlayerInventario[playerid][modelid][Unidades]--;
        	format(str, 128, "*%s bebeu uma garrava de %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	ApplyAnimation(playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 0, 0, 0, 0, 1);
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 1485, 19896, 19897://Baseado & Maco de Cigarro
        {
        	PlayerInventario[playerid][modelid][Unidades]--;
        	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_SMOKE_CIGGY);
        	ApplyAnimation(playerid,"SMOKING","M_smk_drag", 4.1, 0, 0, 0, 0, 0, 1);
        	format(str, 128, "*%s fumou um %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 19574, 19575, 19576://Frutas
        {
        	PlayerInventario[playerid][modelid][Unidades]--;
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+3);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	format(str, 128, "*%s comeu uma %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 2703, 2880, 2768, 19094, 2769, 19579, 19630://Hamburgers & Peixes & Taco & Pão
        {
        	PlayerInventario[playerid][modelid][Unidades]--;
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+35);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	format(str, 128, "*%s comeu um %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 2881, 2702, 1582, 19580://Pizzas
        {
        	PlayerInventario[playerid][modelid][Unidades]--;
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+35);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	format(str, 128, "*%s comeu uma %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
        	ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 2709://Remedio
        {
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+10);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	PlayerInventario[playerid][modelid][Unidades]--;
        	format(str, 128, "*%s usou um frasco de %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            SendClientMessage(playerid, -1, "+10 de vida.");
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 11738://Remedio Grande
        {
        	GetPlayerHealth(playerid, life);
        	SetPlayerHealth(playerid, life+50);
        	GetPlayerHealth(playerid, life);
        	if(life > 100){SetPlayerHealth(playerid, 100);}
        	PlayerInventario[playerid][modelid][Unidades]--;
        	format(str, 128, "*%s usou um frasco de %s", PlayerName(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
            SendClientMessageInRange(10, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
            SendClientMessage(playerid, -1, "+50 de vida.");
            AtualizarInventario(playerid, modelid);
            return 1;
        }
        case 1212:
        {
        	GivePlayerMoney(playerid, PlayerInventario[playerid][modelid][Unidades]);
        	format(str, sizeof(str), "Você retirou R$ %s de sua mochila.", ConvertMoney(PlayerInventario[playerid][modelid][Unidades]));
        	PlayerInventario[playerid][modelid][Unidades] = 0;
        	SendClientMessage(playerid, COLOR_LIGHTGREEN, str);
        	AtualizarInventario(playerid, modelid);
        	return 1;
        }
	}
	return 0;
}

static  GetArmaInv(i)
{
    switch(i)
    {
        case 331: return 1;
        case 333: return 2;
        case 334: return 3;
        case 335: return 4;
        case 336: return 5;
        case 337: return 6;
        case 338: return 7;
        case 339: return 8;
        case 341: return 9;
        case 321: return 10;
        case 322: return 11;
        case 323: return 12;
        case 324: return 13;
        case 325: return 14;
        case 326: return 15;
        case 342: return 16;
        case 343: return 17;
        case 344: return 18;
        case 346: return 22;
        case 347: return 23;
        case 348: return 24;
        case 349: return 25;
        case 350: return 26;
        case 351: return 27;
        case 352: return 28;
        case 353: return 29;
        case 355: return 30;
        case 356: return 31;
        case 372: return 32;
        case 357: return 33;
        case 358: return 34;
        case 359: return 35;
        case 360: return 36;
        case 361: return 37;
        case 362: return 38;
        case 363: return 39;
        case 364: return 40;
        case 365: return 41;
        case 366: return 42;
        case 367: return 43;
        case 368: return 44;
        case 369: return 45;
        case 371: return 46;
    }
    return 1;
}

IsValidItemInv(itemid) //AQUI VOCÊ DEVE DEFINIR OS ID'S DOS ITENS PARA SER VALIDO AO SETAR, CASO CONTRARIO RETORNARA COMO ERRO
{
	if(GetArmaInv(itemid)) return 1;
	switch(itemid)
	{
		case 19823, 19820, 11722, 11723, 19570, 19824, 1486, 19822, 1668, 2958, 19625, 11746,
		3044, 19039, 19040, 19042, 19044, 19045, 19046, 19047, 11747, 18865, 18866, 18867,
		18868, 18869, 18870, 18871, 18872, 18873, 18874, 19513, 18875, 19874, 19138, 19139,
		19140, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032,
		19033, 19034, 19035, 2992, 3065, 11712, 18953, 18954, 19554, 18974, 2114,
		18894, 18903, 18898, 18899, 18891, 18909, 18908, 18907, 18906, 18905, 18904, 18901,
		18902, 18892, 18900, 18897, 18896, 18895, 18893, 18810, 18947, 18948, 18949, 18950,
		18951, 19488, 18921, 18922, 18923, 18924, 18925, 18939, 18940, 18941, 18942, 18943,
		1314, 19578, 18636, 19942, 18646, 19141, 19558, 19801, 19330, 1210, 19528,
		19134, 19904, 19515, 19142, 19315, 19527, 19317, 18688, 18702, 18728, 19605, 19606,
		19607, 19577, 1485, 19574, 19575, 19576, 2703, 2880, 19883, 19896, 19897, 1546, 2768, 1212,
		2601, 19835, 2881, 2702, 2769, 2709, 19579, 19630, 19094, 1582, 19580, 19602, 11738,
		1654, 11736, 1650, 1252, 19893, 19921, 2226, 19054, 19056, 19055, 19057,19058: return 1;
	}
	return 0;
}

ConvertMoney(number)
{
    new real,mil,milhao,milhaor,bilhao,bilhaor,string[100];
    if(number > 999999999)
    {
        bilhao = number / 1000000000;
        bilhaor = number % 1000000000;
        milhao =  bilhaor / 1000000;
        milhaor = bilhaor % 1000000;
        mil = milhaor / 1000;
        real = milhaor % 1000;
    }
    else if(number > 999999)
    {
        milhao = number / 1000000;
        milhaor = number % 1000000;
        mil = milhaor / 1000;
        real = milhaor % 1000;
    }
    else if(number > 999)
    {
        mil = number / 1000;
        real = number % 1000;
    }
    if(number > 999999999)
    {
        format(string, 100, "%d.%03d.%03d.%03d", bilhao, milhao, mil, real);
    }
    else if(number > 999999)
    {
        format(string, 100, "%d.%03d.%03d", milhao, mil, real);
    }
    else if(number > 999)
    {
        format(string, 100, "%d.%03d", mil, real);
    }
    else
    {
        format(string, 100, "%d", number);
    }
    return string;
}

Callback::TextDrawInv(playerid)
{
	DrawInv[playerid][0] = CreatePlayerTextDraw(playerid, 317.000000, 1.000000, "_");
	PlayerTextDrawFont(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][0], 1.208333, 49.799999);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][0], 353.500000, 735.000000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][0], 2);
	PlayerTextDrawColor(playerid, DrawInv[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][0], 135);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][0], 0);

	DrawInv[playerid][1] = CreatePlayerTextDraw(playerid, 172.000000, 70.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][1], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][1], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][1], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][1], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][1], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][1], 1, 1);

	DrawInv[playerid][2] = CreatePlayerTextDraw(playerid, 228.000000, 70.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][2], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][2], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][2], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][2], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][2], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][2], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][2], 1, 1);

	DrawInv[playerid][3] = CreatePlayerTextDraw(playerid, 284.000000, 70.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][3], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][3], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][3], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][3], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][3], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][3], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][3], 1, 1);

	DrawInv[playerid][4] = CreatePlayerTextDraw(playerid, 340.000000, 70.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][4], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][4], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][4], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][4], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][4], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][4], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][4], 1, 1);

	DrawInv[playerid][5] = CreatePlayerTextDraw(playerid, 396.000000, 70.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][5], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][5], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][5], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][5], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][5], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][5], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][5], 1, 1);

	DrawInv[playerid][6] = CreatePlayerTextDraw(playerid, 172.000000, 116.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][6], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][6], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][6], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][6], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][6], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][6], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][6], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][6], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][6], 1, 1);

	DrawInv[playerid][7] = CreatePlayerTextDraw(playerid, 228.000000, 116.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][7], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][7], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][7], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][7], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][7], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][7], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][7], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][7], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][7], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][7], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][7], 1, 1);

	DrawInv[playerid][8] = CreatePlayerTextDraw(playerid, 284.000000, 116.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][8], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][8], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][8], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][8], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][8], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][8], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][8], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][8], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][8], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][8], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][8], 1, 1);

	DrawInv[playerid][9] = CreatePlayerTextDraw(playerid, 340.000000, 116.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][9], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][9], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][9], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][9], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][9], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][9], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][9], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][9], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][9], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][9], 1, 1);

	DrawInv[playerid][10] = CreatePlayerTextDraw(playerid, 396.000000, 116.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][10], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][10], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][10], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][10], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][10], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][10], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][10], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][10], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][10], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][10], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][10], 1, 1);

	DrawInv[playerid][11] = CreatePlayerTextDraw(playerid, 172.000000, 162.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][11], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][11], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][11], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][11], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][11], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][11], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][11], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][11], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][11], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][11], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][11], 1, 1);

	DrawInv[playerid][12] = CreatePlayerTextDraw(playerid, 228.000000, 162.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][12], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][12], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][12], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][12], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][12], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][12], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][12], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][12], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][12], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][12], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][12], 1, 1);

	DrawInv[playerid][13] = CreatePlayerTextDraw(playerid, 284.000000, 162.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][13], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][13], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][13], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][13], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][13], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][13], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][13], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][13], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][13], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][13], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][13], 1, 1);

	DrawInv[playerid][14] = CreatePlayerTextDraw(playerid, 340.000000, 162.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][14], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][14], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][14], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][14], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][14], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][14], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][14], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][14], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][14], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][14], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][14], 1, 1);

	DrawInv[playerid][15] = CreatePlayerTextDraw(playerid, 396.000000, 162.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][15], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][15], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][15], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][15], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][15], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][15], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][15], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][15], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][15], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][15], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][15], 1, 1);

	DrawInv[playerid][16] = CreatePlayerTextDraw(playerid, 172.000000, 208.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][16], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][16], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][16], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][16], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][16], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][16], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][16], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][16], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][16], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][16], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][16], 1, 1);

	DrawInv[playerid][17] = CreatePlayerTextDraw(playerid, 228.000000, 208.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][17], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][17], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][17], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][17], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][17], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][17], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][17], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][17], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][17], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][17], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][17], 1, 1);

	DrawInv[playerid][18] = CreatePlayerTextDraw(playerid, 284.000000, 208.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][18], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][18], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][18], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][18], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][18], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][18], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][18], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][18], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][18], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][18], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][18], 1, 1);

	DrawInv[playerid][19] = CreatePlayerTextDraw(playerid, 340.000000, 208.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][19], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][19], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][19], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][19], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][19], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][19], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][19], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][19], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][19], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][19], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][19], 1, 1);

	DrawInv[playerid][20] = CreatePlayerTextDraw(playerid, 396.000000, 208.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][20], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][20], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][20], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][20], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][20], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][20], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][20], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][20], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][20], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][20], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][20], 1, 1);

	DrawInv[playerid][21] = CreatePlayerTextDraw(playerid, 172.000000, 254.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][21], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][21], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][21], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][21], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][21], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][21], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][21], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][21], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][21], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][21], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][21], 1, 1);

	DrawInv[playerid][22] = CreatePlayerTextDraw(playerid, 228.000000, 254.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][22], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][22], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][22], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][22], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][22], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][22], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][22], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][22], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][22], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][22], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][22], 1, 1);

	DrawInv[playerid][23] = CreatePlayerTextDraw(playerid, 284.000000, 254.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][23], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][23], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][23], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][23], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][23], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][23], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][23], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][23], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][23], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][23], 1, 1);

	DrawInv[playerid][24] = CreatePlayerTextDraw(playerid, 340.000000, 254.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][24], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][24], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][24], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][24], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][24], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][24], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][24], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][24], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][24], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][24], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][24], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][24], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][24], 1, 1);

	DrawInv[playerid][25] = CreatePlayerTextDraw(playerid, 396.000000, 254.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][25], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][25], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][25], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][25], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][25], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][25], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][25], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][25], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][25], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][25], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][25], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][25], 1, 1);

	DrawInv[playerid][26] = CreatePlayerTextDraw(playerid, 172.000000, 300.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][26], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][26], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][26], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][26], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][26], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][26], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][26], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][26], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][26], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][26], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][26], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][26], 1, 1);

	DrawInv[playerid][27] = CreatePlayerTextDraw(playerid, 228.000000, 300.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][27], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][27], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][27], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][27], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][27], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][27], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][27], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][27], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][27], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][27], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][27], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][27], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][27], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][27], 1, 1);

	DrawInv[playerid][28] = CreatePlayerTextDraw(playerid, 284.000000, 300.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][28], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][28], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][28], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][28], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][28], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][28], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][28], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][28], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][28], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][28], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][28], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][28], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][28], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][28], 1, 1);

	DrawInv[playerid][29] = CreatePlayerTextDraw(playerid, 340.000000, 300.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][29], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][29], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][29], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][29], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][29], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][29], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][29], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][29], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][29], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][29], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][29], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][29], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][29], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][29], 1, 1);

	DrawInv[playerid][30] = CreatePlayerTextDraw(playerid, 396.000000, 300.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, DrawInv[playerid][30], 5);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][30], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][30], 55.000000, 45.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][30], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][30], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][30], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][30], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][30], 125);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][30], 255);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][30], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][30], 1);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][30], 15985);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][30], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, DrawInv[playerid][30], 1, 1);

	for(new i = 1; i < 33; ++i)
	{
		PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][i], 0.000000, 0.000000, 0.000000, 999);
	}

	DrawInv[playerid][34] = CreatePlayerTextDraw(playerid, 172.000000, 53.000000, "INVENTARIO:_MAX_PLAYER_NAME");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][34], 0.491665, 1.350000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][34], 737.000000, 17.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][34], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][34], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][34], 0);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][34], 1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][34], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][34], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][34], 1);

	DrawInv[playerid][35] = CreatePlayerTextDraw(playerid, 584.375000, 163.166656, "X");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][35], 0.298748, 0.824165);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][35], 590, 10.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][35], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][35], -16776961);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][35], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][35], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][35], 3);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][35], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][35], true);

	DrawInv[playerid][36] = CreatePlayerTextDraw(playerid, 503.000000, 154.000000, "UTILIZAR");
	PlayerTextDrawFont(playerid, DrawInv[playerid][36], 2);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][36], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][36], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][36], 4);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][36], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][36], 2);
	PlayerTextDrawColor(playerid, DrawInv[playerid][36], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][36], 255);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][36], 200);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][36], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][36], true);

	DrawInv[playerid][37] = CreatePlayerTextDraw(playerid, 503.000000, 197.000000, "DESCARTAR");
	PlayerTextDrawFont(playerid, DrawInv[playerid][37], 2);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][37], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][37], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][37], 4);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][37], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][37], 2);
	PlayerTextDrawColor(playerid, DrawInv[playerid][37], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][37], 255);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][37], 200);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][37], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][37], true);

	DrawInv[playerid][38] = CreatePlayerTextDraw(playerid, 294.000000, 347.000000, "Vara de Pesca 100 unidades");
	PlayerTextDrawFont(playerid, DrawInv[playerid][38], 1);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][38], 0.312500, 1.350000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][38], 576.500000, 17.000000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][38], 0);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][38], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][38], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][38], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][38], 255);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][38], 50);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][38], 0);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][38], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][38], 0);

	DrawInv[playerid][39] = CreatePlayerTextDraw(playerid, 503.000000, 175.000000, "SEPARAR");
	PlayerTextDrawFont(playerid, DrawInv[playerid][39], 2);
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][39], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][39], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][39], 4);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][39], 0);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][39], 2);
	PlayerTextDrawColor(playerid, DrawInv[playerid][39], -1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][39], 255);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][39], 200);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][39], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][39], true);
	return 1;
}
