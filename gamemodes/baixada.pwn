/*
	*	(c) Copyright 2022 - 2023
	*
	*	Nome Servidor:			Baixada Roleplay
	*	Desenvolvedores:		Luan Rosa (RosaScripter) | Allison Gomes (chapei)
	*   Mappers:                Mauricio (Aox-Mauricio).
	*	Version:				2.0.9
	*
	*	Base: Gamemode Inside Roleplay Espanhol por Luan Rosa.
	*
*/

//                          INCLUDES

#define SSCANF_NO_NICE_FEATURES
#define DEBUG
#include        <  	    a_samp  		>
#if defined MAX_PLAYERS
	#undef MAX_PLAYERS
#endif 
// numero de slots do servidor, isso otimiza muito o servidor.
#define MAX_PLAYERS 500
#define FIXES_Single 1
#include        <  	    fixes  		    >
#include 		<	    crashdetect 	> 
#include 		<  	    sscanf2 		>
#include 		<  	    streamer 		>
#include 		< 		foreach 		>
#include		<		Pawn.RakNet		> 
#include 		<		sampvoice 		>
#include 		<		mobile			>
#include 		< 		timerfix 		> 
#include 		<   discord-connector   > 
#include 		< 		discord-cmd		>   
#include 		<	  nex-ac_pt_br.lang	>
#include 		<	    nex-ac		 	>
#include        <   	DOF2   			>
#include        <   	ZCMD	   		>
#include 		<	    mapfix		 	>
#include 		< 		notify2	 		>
#include 		< 		enterfix 		> 
#include		<		progress2		>
#include		<		processo		> 
#include		<		Fader			>
#pragma warning disable 239

main()
{} 

#define MAX_CAIXAS               	50
#define MAX_ZONE_NAME 				28
#define MAX_VAGAS          			20+1
#define MAX_ORGS           			14
#define MAX_MACONHA         		300
#define Max_Crescida        		10
#define MAX_CASAS        			500
#define MAX_RADAR        			500
#define MAX_PICKUPS_ROUBO       	50 
#define MAX_DVEHICLES 				500
#define MAX_DEALERSHIPS 			100
#define MAX_FUEL_STATIONS 			100
#define MAX_PLAYER_VEHICLES 		10
#define MAX_FREQUENCIAS				10000
new	UltimaFala[MAX_PLAYERS];
#define MAX_SEGUNDOSFALAR  			2  
#define MAX_EASTER_EGGS         	31

#define PASTA_BANIDOS 				"Banidos/Contas/%s.ini"
#define PASTA_BANIDOSIP 			"Banidos/IPs/%s.ini"
#define PASTA_CONTAS 				"Contas/%s.ini"
#define PASTA_MISSOES 				"Missoes/%s.ini"
#define PASTA_AGENDADOS 			"Agendados/%s.ini"
#define PASTA_BACKUPBAN 			"Backups/Banidos/%s.ini"
#define PASTA_BACKUPBANIP 			"Backups/IPsBanidos/%s.ini"
#define PASTA_INVENTARIO			"Inventarios/%s.ini"
#define PASTA_VIPS 					"VIPS/%s.ini"
#define PASTA_ORGS           		"InfoOrg/%d.ini"	
#define PASTA_COFREORG  			"InfoOrg/CofreOrg/Org%d.cfg"
#define PASTA_COFRES                "BauOrgs/Cofre%d.ini"
#define PASTA_SAVEARMAS 			"Armas/%s.ini"
#define PASTA_KEYS 					"Codigos/%d.ini"
#define PASTA_CASAS       			"Casas/%d.ini"
#define PASTA_PLANTACAO 			"Plantacoes/PL%d.ini"
#define PASTA_RADAR		  			"Radares/Radar%d.ini"	
#define VEHICLE_FILE_PATH 			"Conce/Veiculos/"
#define DEALERSHIP_FILE_PATH 		"Conce/Locais/"
#define FUEL_STATION_FILE_PATH 		"Conce/Postos/"
#define PASTA_SLOTS 				"Cacaniquel/Slot%i.ini"
#define PASTA_MORTOS 				"Mortos/%s.ini"
#define PASTA_AVALIACAO				"AdminAvaliacao/%s.ini"
#define Pasta_Eastereggs       		"EasterEggs.cfg"
#define Pasta_Relatorios        	"Relatorios/%d.ini"

#define CallBack::%0(%1) 		forward %0(%1);\
							public %0(%1)
#define XP_::%1(%2) forward %1(%2); public %1(%2)

// Encrypt de password
#define passwordSalt                "akjhf2bh36s"

#if !defined( TEXT_SIZE_DEFAULT )
	#define TEXT_SIZE_DEFAULT (1.5)
#endif

#if !defined( TEXT_SOUND_DEFAULT )
	#define TEXT_SOUND_DEFAULT (true)
#endif

#if !defined( TEXT_TIME_DEFAULT )
	#define TEXT_TIME_DEFAULT (5000) //2s
#endif

//                          CONVERT-TEMPOS

#define minutos(%0) 				(1000 * %0 * 60)
#define horas(%0) 					(1000 * %0 * 60 * 60)
#define segundos(%0) 				(1000 * %0)
#define dias(%0) 					(1000 * %0 * 60 * 60  * 24)

//                          DEFINES FORMATADAS

#define ShowErrorDialog(%1,%2) ShowPlayerDialog(%1, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "ERRO", %2, "OK", "")
#define Kick(%0) 					SetTimerEx("KickPlayer", 500, false, "i", %0)
#define SpawnPlayerID(%0) 			SetTimerEx("SpawnP", 500, false, "i", %0)
#define Controle 					TogglePlayerControllable
#define SERVERFORUM     			"discord.gg/QYpxa5SvNB"
#define VERSAOSERVER     			"Baixada v2.0.9" 
#define NA 5
#define PTP 						PlayerToPoint

//                          SISTEMA DEALERSHIP (CONCE E POSTO)

#define TEMPO_SOM_ALARME 			minutos(2)
#define PLACA_CONCESSIONARIA 		"SEMPLACA"
#define VEHICLE_DEALERSHIP 			1
#define VEHICLE_PLAYER 				2
#define PRECO_GASOLINA 				1200
#define PRECO_GALAO 				500

//                          DISCORD

static DCC_Channel:Chat;
static DCC_Channel:Dinn;
static DCC_Channel:EntradaeSaida;
static DCC_Channel:ChatAdm;
static DCC_Channel:Sets;
static DCC_Channel:Reports;
static DCC_Channel:AtivarCoins;
static DCC_Channel:VIPAtivado;
static DCC_Channel:IDNAME;
static DCC_Channel:MAILLOG;
static DCC_Channel:Punicoes;
static DCC_Channel:ComandosIG;

//                          SAMP VOICE

new SV_GSTREAM:gstream;
new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };
new SV_LSTREAM:Gritandos[MAX_PLAYERS] = { SV_NULL, ... };
new SV_LSTREAM:Susurrandos[MAX_PLAYERS] = { SV_NULL, ... };
new SV_GSTREAM:Frequencia[MAX_FREQUENCIAS] = SV_NULL;
new FrequenciaConectada[MAX_PLAYERS];
new bool:Susurrando[MAX_PLAYERS] = false;
new bool:Susurrou[MAX_PLAYERS] = false;
new bool:Gritando[MAX_PLAYERS] = false;
new bool:Gritou[MAX_PLAYERS] = false;
new bool:Falando[MAX_PLAYERS] = true;
new bool:Falou[MAX_PLAYERS] = false;

//                          DIALOGS

enum
{
	DIALOG_LOGIN,
	DIALOG_REGISTRO,
	DIALOG_EMAIL,
	//DIALOG_SELIDADE,
	DIALOG_BANIDO,
	DIALOG_POS,
	DIALOG_PRESOS,
	DIALOG_BANCO4,
	DIALOG_BANCO5,
	DIALOG_SEDEX,
	DIALOG_SELTRABALHO, 
	DIALOG_ALIMENTOS,
	DIALOG_CATLANCHE,
	DIALOG_REFRECOS,
	DIALOG_AJUDA,
	DIALOG_AJUDA1,
	DIALOG_CATCOINS,
	DIALOG_CATVIPS,
	DIALOG_AUTO_ESCOLA,
	DIALOG_CONFIRMA_ESCOLA1,
	DIALOG_CONFIRMA_ESCOLA2,
	DIALOG_CONFIRMA_ESCOLA3,
	DIALOG_CONFIRMA_ESCOLA4,
	D_VOIP,
	DIALOG_CELULAR,
	DIALOG_RG1,
	DIALOG_RG2,
	DIALOG_RG3,
	DIALOG_RG4,
	DIALOG_RG5,
	DIALOG_EMP1, 
	DIALOG_EMP2, 
	DIALOG_EMP3,
	DIALOG_EMP4,
	DIALOG_EMP5,
	DIALOG_CMDRG,
	DIALOG_REANIMAR,
	DIALOG_CARGA,
	DIALOG_CONVITE,
	DIALOG_LTAGS,
	DIALOG_ORGS,
	DIALOG_MEMBROSORG,
	DIALOG_AJUDA_ADMIN,
	DIALOG_ROPACOP,
	DIALOG_COFREORG,
	DIALOG_COFREORG1,
	DIALOG_COFREORG12,
	DIALOG_COFREORG2,
	DIALOG_COFREORG22,
	DIALOG_COFREORG3,
	DIALOG_COFREORG31,
	DIALOG_COFREORG32,
	DIALOG_COFREORG4,
	DIALOG_COFREORG41,
	DIALOG_COFREORG42,
	DIALOG_TIENDAILEGAL,
	DIALOG_LMARIHUANA,
	DIALOG_BETCASINO,
	DIALOG_FAQ,
	DIALOG_AJUDACOMANDOS,
	DIALOG_EMP0,
	DIALOG_AJUDAJEFORG,
	DIALOG_AJUDAORG,
	DIALOG_AJUDAVEH,
	DIALOG_AJUDAINVENTARIO,
	DIALOG_FAQ1,
	DIALOG_GPS,
	DIALOG_GPS1,
	DIALOG_GPS2,
	DIALOG_LTUMBA,
	DIALOG_CASAS, 
	DIALOG_LOCALIZARCASA,
	DIALOG_CATVEHINV,
	DIALOG_PAYDAY,
	DIALOG_MENUANIM,
	DIALOG_ARMARIOMEC,
	DIALOG_MISSOES,
	DIALOG_ERROR,
	DIALOG_VEHICLE,
	DIALOG_VEHICLE_BUY,
	DIALOG_VEHICLE_SELL,
	DIALOG_FINDVEHICLE,
	DIALOG_TRUNK,
	DIALOG_TRUNK_ACTION,
	DIALOG_VEHICLE_PLATE,
	DIALOG_FUEL,
	DIALOG_EDITVEHICLE, 
	DIALOG_SLOTMACHINE,
	DIALOG_BET,
	DIALOG_ARMAS2,
	DIALOG_ARMAS12,
	DIALOG_BENEVIP,
	DIALOG_AVALIAR,
	DIALOG_TELEPORTARMAP,
	DIALOG_VEHCORP1,
	DIALOG_VEHCORP2,
	DIALOG_VEHCORP3,
	DIALOG_VEHCORP4,
	DIALOG_ANUNCIOOLX,
	DIALOG_VALORTRANSACAO,
	DIALOG_GPS3,
	DIALOG_PROCURADOS,
	DIALOG_LOJA247,
	DIALOG_PREFEITURA,
	DIALOG_ATIVARCOINS,
	DIALOG_CREDITOS,
	DIALOG_CATITENS
}

//                          VARIAVEIS

enum anuncios
{
	Texto[75]
};
new Anuncio[NA][anuncios];
new TiempoAnuncio[MAX_PLAYERS],Text:TextDraw[5];


new	CofreLoja1,
	CofreLoja2,
	CofreLoja3,
	CofreLoja4,
	CofreLoja5,
	CofreRestaurante,
	CofreNiobio,
	CofreGoverno,
	CofreBanco;

new bool:RouboLoja1 = false,
	bool:RouboLoja2 = false,
	bool:RouboLoja3 = false,
	bool:RouboLoja4 = false,
	bool:RouboLoja5 = false,
	bool:RouboRestaurante = false;

new GuerraBarragem = 0,
	GuerraParabolica = 0;


enum pInfo
{
	pSenha[24],
	pEmail[64],
	IDF,
	pSkin,
	pSexo,
	pDinheiro,
	pBanco,
	pIdade,
	pSegundosJogados,
	pAvisos,
	pCadeia,
	pAdmin,
	pLastLogin[24],
	pInterior,
	Float:pPosX,
	Float:pPosY,
	Float:pPosZ,
	Float:pPosA,
	Float:pCamX,
	Float:pCamY,
	Float:pCamZ,
	bool:pCongelado,
	bool:pCalado,
	pVIP,
	ExpiraVIP,
	vKey,
	vCoins,
	pCoins,
	pProfissao,
	Org,
	Cargo,
	convite,
	pProcurado,
	pMultas,
	Casa,
	Entrada,
	pAvaliacao,
	pLevel,
	pXP,
	LicencaConduzir,
	pNome[80],
	pNascimento[30],
	pPai[80],
	pMae[80],
	pRG,
	pCarteiraT,
	PecasArma
}
new PlayerInfo[MAX_PLAYERS][pInfo];
new FomePlayer[MAX_PLAYERS], SedePlayer[MAX_PLAYERS];
new timerloginname[MAX_PLAYERS];

enum RInfo
{
	RadarID,
	RadarVelocidade,

	Float:RadarPosX,
	Float:RadarPosY,
	Float:RadarPosZ,
	Float:RadarPosR
};
new RadarInfo[MAX_RADAR][RInfo];
new ObjetoRadar[MAX_RADAR];
new ObjetoRadar2[MAX_RADAR];
new PassouRadar[MAX_PLAYERS];
new Text3D:TextoRadar[MAX_RADAR];
new IniciarRadares;

enum misiones
{
	MISSAO1,
	MISSAO2,
	MISSAO3,
	MISSAO4,
	MISSAO5,
	MISSAO6,
	MISSAO7,
	MISSAO8,
	MISSAO9,
	MISSAO10,
	MISSAO11,
	MISSAO12,
	MISSAO13,

	CMISSAO1,
	CMISSAO2,
	CMISSAO3,
	CMISSAO4,
	CMISSAO5,
	CMISSAO6,
	CMISSAO7,
	CMISSAO8,
	CMISSAO9,
	CMISSAO10,
	CMISSAO11,
	CMISSAO12,
	CMISSAO13
}
new MissaoPlayer[MAX_PLAYERS][misiones];

enum CInfo
{
	CasaDono[30],
	CasaTexto[64],
	CasaId,
	CasaAVenda,
	CasaPickup,
	CasaMapIcon,
	CasaValor,

	CasaInterior,

	Float:CasaX,
	Float:CasaY,
	Float:CasaZ,

	Float:CasaInteriorX,
	Float:CasaInteriorY,
	Float:CasaInteriorZ
};
new CasaInfo[MAX_CASAS][CInfo];
new PickupCasa[MAX_CASAS];
new MapIconCasa[MAX_CASAS];
new Text3D:TextoCasa[MAX_CASAS];
new IniciarCasas;

enum CofreInfoD
{
	Dinheiro,
	Maconha,
	Cocaina,
	Crack,
	Equipar,
};
new CofreOrg[MAX_ORGS][CofreInfoD];

enum CofreInfo2
{
	CofreID,

	Float:CofrePosX,
	Float:CofrePosY,
	Float:CofrePosZ,
    Float:CofrePosR
};
new CofreInfo[MAX_ORGS][CofreInfo2];
new CofreArma[20][MAX_ORGS];
new CofreAmmo[20][MAX_ORGS];
new ItemOpcao[MAX_PLAYERS];
new ObjetoCofre[MAX_ORGS];
new Text3D:TextoCofreOrg[MAX_ORGS];

enum minfo
{
	Crescida,
	Timer,
	Dono[MAX_PLAYER_NAME],
	Float:mX,
	Float:mY,
	Float:mZ,
	Object,
	Text3D:TT,
	bool:PodeUsar,
	GramasProntas
}
new MaconhaInfo[MAX_MACONHA][minfo];
new LocalizeMaconha[11][MAX_PLAYERS];
new bool:PlantandoMaconha[MAX_PLAYERS] = false;

enum pMorto
{
	Float:pPosMt1,
    Float:pPosMt2,
    Float:pPosMt3,
    pInteriorMxxx,
    pVirtual,
    pEstaMorto,
    pSegMorto,
    pMinMorto
};
new PlayerMorto[MAX_PLAYERS][pMorto];

new Float:VarPlayerOldPos[MAX_PLAYERS][3];
new TimerMorto[MAX_PLAYERS];
new Text:TDmorte[9];
new PlayerText:TDmorte_p[MAX_PLAYERS][1];
new Text:TD_RG[24];
new PlayerText:RG_p[MAX_PLAYERS][6];
new Text:Velomob[4];
new PlayerText:Velomob_p[MAX_PLAYERS][3];

new VagasORG[][MAX_VAGAS] = 
{
	"Lider", 
	"Vaga-01", 
	"Vaga-02", 
	"Vaga-03", 
	"Vaga-04", 
	"Vaga-05", 
	"Vaga-06", 
	"Vaga-07", 
	"Vaga-08", 
	"Vaga-09", 
	"Vaga-10", 
	"Vaga-11", 
	"Vaga-12", 
	"Vaga-13", 
	"Vaga-14", 
	"Vaga-15", 
	"Vaga-16", 
	"Vaga-17", 
	"Vaga-18", 
	"Vaga-19", 
	"Vaga-20"
};

enum caixa_info
{
	bool:Caixa_Roubada,
	Caixa_Dinheiro,
	Caixa_Object,
	Caixa_Pickup,
	Text3D:Caixa_Text,
	Caixa_Pickups,
	//--- Objeto bomba
	Caixa_ObjectBomba,
};
new CaixaInfo[MAX_CAIXAS][caixa_info];
new Pickups_Roubo[MAX_CAIXAS][MAX_PICKUPS_ROUBO];
new caixaid = 1;
new bool:TendoRoubo = false;
new Float:UltimaCaixaRoubada[3];
new bool:RoubandoCaixa[MAX_PLAYERS] = false;
new Float:RdonPickups[][] =
{
	{0.1},{0.2},{0.3},{0.4},
	{0.5},{0.6},{0.7},{0.8},
	{0.9},{1.0},{1.2},{1.3},
	{1.4},{1.5},{1.6},{1.7},
	{1.8},{1.9},{2.0},{2.1},
	{2.2},{2.3},{2.4},{2.5},
	{2.6},{2.7},{2.8},
	//
	{-0.1},{-0.2},{-0.3},{-0.4},
	{-0.5},{-0.6},{-0.7},{-0.8},
	{-0.9},{-1.0},{-1.2},{-1.3},
	{-1.4},{-1.5},{-1.6},{-1.7},
	{-1.8},{-1.9},{-2.0},{-2.1},
	{-2.2},{-2.3},{-2.4},{-2.5},
	{-2.6},{-2.7},{-2.8}
};
#define Temporoubo  				(6*60000)

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
new InventarioAberto[MAX_PLAYERS] = false;
new BigEar[MAX_PLAYERS];

new
	Text:wBase[4],
	PlayerText:wMenu[9],
	PlayerText:wMenuCores[11],
	PlayerText:wMenuRodas[11],
	PlayerText:wMenuPaintJobs[4],
	PlayerText:wMenuNitro[4],
	PlayerText:wMenuNeon[8]
;

enum neon_tuning
{
	NEON_DIREITO,
	NEON_ESQUERDO,
};
new bool:wTuning[MAX_PLAYERS];
new neon_add[MAX_VEHICLES][neon_tuning];

// DOMINAÇÃO
new Barragem;
new Parabolica;

//                          STRINGS

new	Motivo[255],
	Str[1200];
new MEGAString[2860];

// lockpick system

new PlayerText:LockText[12], bool:LockUse[MAX_PLAYERS], Float:LockProgress = 207.0, Float:LockLocation[MAX_PLAYERS], Float:LockSize[MAX_PLAYERS], LockCount[MAX_PLAYERS], LockTimer[MAX_PLAYERS], Correct[MAX_PLAYERS], VehicleLockedID[MAX_PLAYERS];
new Engine[MAX_PLAYERS], Lights[MAX_PLAYERS], Alarm[MAX_PLAYERS], DoorsLockPick[MAX_PLAYERS], Bonnet[MAX_PLAYERS], Boot[MAX_PLAYERS], Objective[MAX_PLAYERS];

//                          BOOLS

new bool:RotaMaconha[MAX_PLAYERS];
new bool:RotaCocaina[MAX_PLAYERS];
new	bool:AntiAFK_Ativado = true,
	bool:Moved[MAX_PLAYERS] = false,
	bool:FoiCriado[MAX_VEHICLES] = false,
	bool:FirstLogin[MAX_PLAYERS] = true,
	bool:pJogando[MAX_PLAYERS] = true,
	bool:pLogado[MAX_PLAYERS] = false,
	bool:IsAssistindo[MAX_PLAYERS] = false,
	bool:ContagemIniciada = false,
	bool:ChatLigado = true;
new bool:GPS[MAX_PLAYERS] = false;
new bool:UsouCMD[MAX_PLAYERS] = false;
new bool:Patrulha[MAX_PLAYERS] = false;
new policiaon = 0;
new bool:PegouMaterial[MAX_PLAYERS] = false; 
new bool:LavouMao[MAX_PLAYERS] = false;
new bool:PegouLixo[MAX_PLAYERS] = false;
new bool:Podecmd[MAX_PLAYERS] = true;
new bool:MostrandoRG[MAX_PLAYERS] = false;
//                          TEXTDRAWS

new PlayerText:BancoTD[MAX_PLAYERS][34];
new Text:gServerTextdraws;
static PlayerText:XPTXD[MAX_PLAYERS][20];
new	PlayerText:Textdraw2[MAX_PLAYERS];
new PlayerText:HudCop[MAX_PLAYERS][4];
new PlayerText:CopGuns[MAX_PLAYERS][6];
new Text:Textdraw0,
	Text:Textdraw1;
new Text:HudServer[17];
new PlayerText:HudServer_p[MAX_PLAYERS][7];
new PlayerText:Registration_PTD[MAX_PLAYERS][23];
new Text:TDCadastro[18];
new PlayerText:TDCadastro_p[MAX_PLAYERS][7];

//                          VARIAVEIS DA CONCE

new maintimer;
new savetimer;

new SaveVehicleIndex;

new RefuelTime[MAX_PLAYERS];
new TrackCar[MAX_PLAYERS];
new DialogReturn[MAX_PLAYERS];

new Float:Fuel[MAX_VEHICLES] = {100.0, ...};
new VehicleSecurity[MAX_VEHICLES];

new VehicleCreated[MAX_DVEHICLES];
new VehicleID[MAX_DVEHICLES];
new VehicleModel[MAX_DVEHICLES];
new Float:VehiclePos[MAX_DVEHICLES][4];
new VehicleColor[MAX_DVEHICLES][2];
new VehicleInterior[MAX_DVEHICLES];
new VehicleWorld[MAX_DVEHICLES];
new VehicleOwner[MAX_DVEHICLES][MAX_PLAYER_NAME];
new VehicleNumberPlate[MAX_DVEHICLES][16];
new VehicleValue[MAX_DVEHICLES];
new VehicleLock[MAX_DVEHICLES];
new VehicleAlarm[MAX_DVEHICLES];
new VehicleTrunk[MAX_DVEHICLES][5][2];
new VehicleMods[MAX_DVEHICLES][14];
new VehiclePaintjob[MAX_DVEHICLES] = {255, ...};
new Text3D:VehicleLabel[MAX_DVEHICLES];

new DealershipCreated[MAX_DEALERSHIPS];
new Float:DealershipPos[MAX_DEALERSHIPS][3];
new Text3D:DealershipLabel[MAX_DEALERSHIPS];

new FuelStationCreated[MAX_FUEL_STATIONS];
new Float:FuelStationPos[MAX_FUEL_STATIONS][3];
new Text3D:FuelStationLabel[MAX_FUEL_STATIONS];

//                          VARIAVEIS DO TIMER

new TimerFomebar[MAX_PLAYERS];
new TimerSedebar[MAX_PLAYERS];
new TimerColete[MAX_PLAYERS];
new TimerUpdate[MAX_PLAYERS];
new TimerPBugar[MAX_PLAYERS];
new TimerPayDay[MAX_PLAYERS];
new TimerAttVeh[MAX_PLAYERS];
new TimerLocalizar[MAX_PLAYERS];
new TimerTesteAerea[MAX_PLAYERS];
new TimerTesteCaminhao[MAX_PLAYERS];
new TimerTesteVeiculo[MAX_PLAYERS];
new TimerTesteMoto[MAX_PLAYERS];
new TimerHacker[MAX_PLAYERS];
new TimerRelogio;
new TimerCadeia;
new TimerAfk;
new TimerMaconha;
new TimerMensagemAuto;
new TimerMensagemAutoBot;

//                          VARIAVEIS SEM COMENT

new Armazenar[MAX_PLAYERS];
new chosenpid;
new ChatAtendimento[MAX_PLAYERS];
new NumeroChatAtendimento[MAX_PLAYERS];
new IDAvaliou[MAX_PLAYERS];
new InviteAtt[MAX_PLAYERS];
new ArmazenarString[30][MAX_PLAYERS];
new stringZCMD[180];
new ModoTransacao[MAX_PLAYERS];
new jogadoreson = 0;
new bool:EntregaSdx[MAX_PLAYERS];
new RecentlyShot[MAX_PLAYERS];
new CaixasSdxObj[MAX_PLAYERS][11];
new bool:CaixaMao[MAX_PLAYERS] = false;
new CaixasSdx[MAX_PLAYERS];
new bool:PegandoCaixas[MAX_PLAYERS] = false;
new bool:EmServico[MAX_PLAYERS] = false;
new sdxobj[10];
new carID[MAX_PLAYERS];
new	Assistindo[MAX_PLAYERS] = -1,
	Erro[MAX_PLAYERS],
	ID,
	Numero,
	Float:Pos[3];
new MotorOn[MAX_PLAYERS];
new EquipouCasco[MAX_PLAYERS];
new Localizando[MAX_PLAYERS];
new bool:Cargase[MAX_PLAYERS] = false,
	Carregou[MAX_PLAYERS];
new ocupadodemais[MAX_PLAYERS];
new bool:MostrandoMenu[MAX_PLAYERS];
new TimerCad[MAX_PLAYERS];
new RepairCar[MAX_PLAYERS];
new bool:TemCinto[MAX_PLAYERS] = false;
new bool:PegouVehProf[MAX_PLAYERS] = false;
new TemMinerio[MAX_PLAYERS];
new Desossando[MAX_PLAYERS];
new Page[MAX_PLAYERS];
new Preview[MAX_PLAYERS][6];
new ObjetoAcougue[MAX_PLAYERS][3];
new actorcad[MAX_PLAYERS];
// velocimetro //
new TimerVelo[MAX_PLAYERS];
new mostrandovelo[MAX_PLAYERS];
new Text:VeloC_G[52];
new PlayerText:VeloC[MAX_PLAYERS][10];

//TdCinto
new Text:Tdcinto[5];

//Tela de carregamento
new CarregandoTelaLogin[MAX_PLAYERS];
new TimerLogin[MAX_PLAYERS];
new Text:Loadsc[17];
new PlayerText:Loadsc_p[MAX_PLAYERS][1];
new PlayerBar:Loadsc_b[MAX_PLAYERS][1];

//                          FLOATS E LOCAIS DEFINIDOS

new Float:PosRota[303][3] =
{
    {1189.3232,-1083.6021,29.2662},
    {2324.4709,-1218.8455,27.9766},
    {2438.6965,-1105.7920,43.0816},
    {2191.6624,-1275.6002,25.1563},
    {2523.2693,-1679.3563,15.4970},
    {2465.3257,-2020.7903,14.1242},
    {1907.7842,-2040.8531,13.5469},
    {718.8144,-1476.2092,5.4688},
    {167.8979,-1308.3531,70.3513},
    {891.2316,-783.1387,101.3139},
    {1496.9061,-687.8947,95.5633},
    {300.1995,-1154.4076,81.3907},
    {2332.7795,30.9252,26.6752},
    {1640.3507,2102.8794,11.3125},
    {1363.9659,1931.7354,11.4683},
    {-227.4116,2711.9507,62.9766},
    {-2583.7375,2307.8694,7.0029},
    {-2075.1589,898.8646,64.1328},
    {-2055.2559,6.8913,35.3281},
    {-2718.9626,-318.7583,7.8438},
    {829.1451,-1553.7571,12.4845},
    {-2238.308837, 1154.232421, 59.688453},//rota
    {-2558.788085, -118.725936, 10.957287},//rota
    {-2558.679931, -145.863983, 9.419777},//rota
    {-2238.312255, 1135.671264, 67.258468},//rota
    {-2621.016357, -134.732391, 5.000000},//rota
    {-2238.308593, 1117.715698, 74.820777},//rota
    {-2619.753906, -127.678237, 4.771946},//rota
    {-2208.570556, 1108.044799, 80.007812},//rota
    {-2620.815429, -120.211967, 7.203125},//rota
    {-2126.619384, 1092.551879, 80.007812},//rota
    {-2622.361816, -112.546058, 4.342578},//rota
    {-2126.544433, 1050.710815, 80.007812},//rota
    {-2126.547851, 1038.848876, 80.007812},//rota
    {-2625.844970, -105.142417, 7.203125},//rota
    {-2126.979980, 1018.653442, 80.007812},//rota
    {-2126.438964, 996.308410, 80.007812},//rota
    {-2623.431396, -99.401641, 7.203125},//rota
    {-2117.041259, 927.828857, 86.079063},//rota
    {-2158.606445, 888.087158, 80.006103},//rota
    {-2631.806884, -95.378646, 7.203125},//rota
    {-2159.077880, 867.213684, 75.632202},//rota
    {-2126.836669, 832.837036, 69.562500},//rota
    {-2678.094970, -96.557868, 7.203125},//rota
    {-2159.233642, 786.599792, 69.521308},//rota
    {-2126.183593, 773.890686, 69.562500},//rota
    {-2681.804931, -106.560340, 7.203125},//rota
    {-2126.197021, 756.115844, 69.562500},//rota
    {-2632.499755, -107.727050, 4.328125},//rota
    {-2167.593994, 744.006713, 65.204032},//rota
    {-2186.491210, 743.997131, 57.549987},//rota
    {-2192.322753, 720.368896, 55.354583},//rota
    {-2679.946777, -114.094375, 4.328125},//rota
    {-2223.556884, 743.836669, 49.432346},//rota
    {-2237.851562, 720.241943, 49.406250},//rota
    {-2630.873535, -116.228248, 4.328125},//rota
    {-2630.303222, -131.732620, 4.328125},//rota
    {-2631.220458, -134.752944, 4.328125},//rota
    {-2278.706542, 748.450012, 49.445312},//rota
    {-2278.710449, 766.181640, 49.445312},//rota
    {-2278.696289, 788.021789, 49.445312},//rota
    {-2285.312744, 829.437805, 57.164062},//rota
    {-2677.759765, -122.684417, 4.328125},//rota
    {-2285.082275, 849.930480, 65.648437},//rota
    {-2679.378906, -134.347549, 4.328125},//rota
    {-2282.415039, 872.965637, 66.923141},//rota
    {-2282.368896, 916.420837, 66.648437},//rota
    {-2631.225341, -134.632202, 4.328125},//rota
    {-2630.871093, -150.106430, 4.328125},//rota
    {-2295.698242, 969.907897, 65.326774},//rota
    {-2308.202392, 944.738403, 61.319202},//rota
    {-2679.026367, -152.814727, 4.328125},//rota
    {-2327.382080, 944.371459, 54.674552},//rota
    {-2098.866455, 258.047149, 36.133728},//rota
    {-2679.945800, -155.763275, 4.328125},//rota
    {-2348.337402, 995.436950, 50.898437},//rota
    {-2630.870361, -153.126831, 4.328125},//rota
    {-2632.496337, -164.921752, 4.328125},//rota
    {-2416.463134, 1025.667358, 50.390625},//rota
    {-2679.380615, -171.522354, 4.328125},//rota
    {-2431.242675, 1028.685913, 50.390625},//rota
    {-2679.948974, -155.849395, 4.328125},//rota
    {-2630.306640, -172.993804, 4.335672},//rota
    {-2628.442626, -181.234848, 7.203125},//rota
    {-2369.316650, 1122.290283, 55.726562},//rota
    {-2383.567382, 1128.053588, 55.726562},//rota
    {-2632.155761, -190.989028, 7.203125},//rota
    {-2396.054687, 1132.551513, 55.726562},//rota
    {-2423.371826, 1139.282104, 55.726562},//rota
    {-2678.443359, -191.848098, 7.203125},//rota
    {-2438.176269, 1141.008789, 55.726562},//rota
    {-2461.724609, 1141.903198, 55.726562},//rota
    {-2478.523681, 1141.976440, 55.726562},//rota
    {-2724.250244, -191.265960, 4.335937},//rota
    {-2493.029296, 1141.931762, 55.726562},//rota
    {-2686.817382, -188.263580, 7.203125},//rota
    {-2506.591064, 1142.139160, 55.726562},//rota
    {-2517.138183, 1142.401611, 55.726562},//rota
    {-2728.163574, -184.026123, 7.203125},//rota
    {-2534.166015, 1143.742187, 55.726562},//rota
    {32.015903, -2657.136962, 40.519855},//rota
    {-2684.605712, -182.450714, 7.203125},//rota
    {-2548.707763, 1145.651000, 55.726562},//rota
    {-2563.186035, 1149.128051, 55.726562},//rota
    {-2573.537597, 1152.250488, 55.726562},//rota
    {-2723.024414, -179.076477, 7.203125},//rota
    {-2587.226074, 1162.275024, 55.437500},//rota
    {-2723.099853, -166.552734, 5.000000},//rota
    {-2687.890625, -175.339996, 4.342578},//rota
    {-76.863235, -1136.516723, 1.078125},//rota
    {-2689.495849, -167.287322, 7.203125},//rota
    {-2544.874511, 1152.551269, 55.648471},//rota
    {-2506.656494, 1148.913940, 55.544425},//rota
    {-2489.774902, 1149.208007, 55.631183},//rota
    {-2479.177490, 1148.432617, 55.603717},//rota
    {-2728.161865, -155.447402, 7.203125},//rota
    {-2451.085693, 1148.383544, 55.726562},//rota
    {154.452636, -1946.547119, 5.338891},//rota
    {-2434.350097, 1147.981811, 55.695846},//rota
    {-2423.378906, 1146.043823, 55.726562},//rota
    {-2722.929199, -139.392669, 7.203125},//rota
    {-2395.276611, 1139.211547, 55.530704},//rota
    {-2377.885742, 1133.612670, 55.570823},//rota
    {-2723.335449, -127.772056, 5.000000},//rota
    {-2367.640380, 1128.744995, 55.726562},//rota
    {-2722.072265, -120.667419, 4.770585},//rota
    {-2358.876464, 1118.071289, 55.726562},//rota
    {-2687.894042, -117.940994, 4.342578},//rota
    {-2369.863525, 1122.499633, 55.726562},//rota
    {-2383.633789, 1128.080322, 55.726562},//rota
    {-2396.735839, 1132.781616, 55.726562},//rota
    {-2406.810546, 1135.834472, 55.726562},//rota
    {-2424.053955, 1139.453735, 55.726562},//rota
    {-2438.486328, 1141.026000, 55.726562},//rota
    {-2443.331054, 1141.390991, 55.726562},//rota
    {-2055.172851, 6.890789, 35.328094},//rota
    {-2451.272705, 1141.769287, 55.726562},//rota
    {2748.918212, -2451.035888, 13.648437},//rota
    {-2458.395019, 1141.879882, 55.726562},//rota
    {-2070.617919, 6.891303, 35.320312},//rota
    {-2478.683593, 1141.983642, 55.726562},//rota
    {-2493.156738, 1141.954589, 55.726562},//rota
    {-2097.124023, 17.312450, 35.320312},//rota
    {-2506.031738, 1142.132812, 55.726562},//rota
    {-2081.548828, 71.644233, 35.249626},//rota
    {-2523.646972, 1142.593994, 55.726562},//rota
    {-2533.802734, 1143.696777, 55.726562},//rota
    {-2549.218017, 1145.753173, 55.726562},//rota
    {-2563.129638, 1149.108276, 55.726562},//rota
    {-2574.303222, 1152.517700, 55.726562},//rota
    {-2620.914062, 96.699966, 5.000000},//rota
    {-2620.861816, 103.146728, 7.203125},//rota
    {-2510.987792, 1054.117553, 65.161437},//rota
    {-2511.744140, 1045.888793, 65.507812},//rota
    {-2621.036376, 115.011268, 5.000000},//rota
    {-2511.090087, 1029.033935, 73.590026},//rota
    {-2620.940185, 120.814117, 7.203125},//rota
    {-2511.763427, 1020.700195, 77.216331},//rota
    {-2623.441406, 131.718658, 7.203125},//rota
    {-2511.768798, 1008.922119, 78.343750},//rota
    {-2511.766113, 1000.844421, 78.343750},//rota
    {-2621.973876, 168.514297, 7.195312},//rota
    {-2511.772460, 992.550231, 78.338996},//rota
    {-2511.740722, 976.061401, 77.229988},//rota
    {-2510.898437, 968.052062, 73.530578},//rota
    {-2431.034667, 1028.751098, 50.390625},//rota
    {-2511.032470, 942.695678, 65.289062},//rota
    {-2537.141357, 929.867919, 65.012092},//rota
    {-2639.403808, 168.514038, 7.195312},//rota
    {-2543.569824, 922.278198, 67.093750},//rota
    {-2621.972656, 168.507797, 7.195312},//rota
    {-2573.015136, 920.358886, 64.984375},//rota
    {-2580.582519, 920.374328, 64.984375},//rota
    {-2583.803222, 896.274047, 64.984375},//rota
    {-2620.156005, 883.012084, 63.250000},//rota
    {-2620.692871, 855.264953, 53.562500},//rota
    {-2619.741943, 844.892822, 50.589817},//rota
    {-2618.740966, 830.869201, 49.984375},//rota
    {-2621.676025, 802.885803, 49.984375},//rota
    {-2069.265625, -2495.046386, 31.066806},//rota
    {-1711.074951, 399.794555, 7.179687},//rota
    {-2621.502441, 790.264465, 48.556636},//rota
    {-2622.521728, 782.982788, 44.859375},//rota
    {-2086.968505, -2510.480712, 31.066806},//rota
    {-2622.441894, 772.348449, 41.333545},//rota
    {-2622.517089, 766.820129, 36.835937},//rota
    {-2058.176513, -2503.690185, 31.066806},//rota
    {-2622.517333, 757.395263, 35.328125},//rota
    {-2622.520751, 749.578552, 31.421875},//rota
    {-2045.168212, -2522.346679, 31.066806},//rota
    {-2625.341552, 733.388732, 28.025754},//rota
    {-2031.351562, -2538.985107, 31.066806},//rota
    {-2639.766357, 730.671691, 30.070312},//rota
    {-2042.504760, -2558.680175, 30.841997},//rota
    {-2641.510986, 728.034057, 27.960937},//rota
    {-2665.334960, 722.251220, 27.957107},//rota
    {-2661.670410, 722.242370, 27.957012},//rota
    {-2677.773437, 722.252929, 28.592304},//rota
    {-2686.300292, 722.858215, 32.217872},//rota
    {-2134.751953, -2504.258789, 31.816270},//rota
    {-2706.036376, 722.852539, 37.539062},//rota
    {-2723.335693, 722.854675, 41.273437},//rota
    {-2075.158203, 976.026855, 62.921875},//rota
    {-2731.233886, 723.691284, 41.273437},//rota
    {-2132.591796, -2510.845947, 31.816272},//rota
    {-2738.847900, 734.003173, 45.428325},//rota
    {-2738.322021, 746.120056, 49.187976},//rota
    {-2161.476074, -2535.531738, 31.816270},//rota
    {-2738.317382, 754.760131, 52.765228},//rota
    {-2738.320068, 771.840759, 54.382812},//rota
    {-2181.113281, -2529.043701, 31.816270},//rota
    {-2738.317382, 779.610351, 54.382812},//rota
    {-2180.969970, -2520.029785, 31.816270},//rota
    {-2738.319824, 788.581054, 54.382812},//rota
    {-2059.073486, 889.453857, 61.849555},//rota
    {-2738.314697, 797.640686, 53.268825},//rota
    {-2738.314941, 804.929809, 53.062500},//rota
    {-2737.584228, 822.985290, 53.723175},//rota
    {-2737.839843, 836.703308, 56.250629},//rota
    {-2736.878662, 846.480346, 59.265625},//rota
    {-2193.151611, -2510.337158, 31.816272},//rota
    {-2737.557617, 866.089294, 64.632812},//rota
    {-2716.694824, 865.557067, 70.703125},//rota
    {-2173.733642, -2481.594726, 31.816272},//rota
    {-2708.985839, 853.195312, 70.703125},//rota
    {-2641.432861, 935.719665, 71.953125},//rota
    {-2224.567871, -2482.879638, 31.816272},//rota
    {-2591.168945, 927.433410, 65.015625},//rota
    {-2239.260498, -2423.711914, 32.707267},//rota
    {-2591.178466, 935.896606, 68.929687},//rota
    {-2591.174072, 944.359802, 70.429687},//rota
    {-2220.455810, -2399.975097, 32.582267},//rota
    {-2591.170410, 960.565551, 78.453125},//rota
    {-2597.324707, 979.760375, 78.273437},//rota
    {-2596.646972, 985.978637, 78.273437},//rota
    {-2191.760498, -2255.304199, 30.694179},//rota
    {-2193.325439, -2254.059814, 30.703521},//rota
    {-2193.391601, -2254.008789, 33.320312},//rota
    {-2192.004638, -2255.112792, 33.320312},//rota
    {-2180.438964, -2258.054931, 33.320312},//rota
    {743.247985, -509.322784, 18.012922},//rota
    {745.061462, -556.781188, 18.012926},//rota
    {736.766906, -556.784545, 18.012926},//rota
    {768.218933, -503.482299, 18.012926},//rota
    {776.873779, -503.483215, 18.012926},//rota
    {-516.099975, -539.369506, 25.523437},//rota
    {766.516601, -556.783508, 18.012924},//rota
    {795.140625, -506.148986, 18.012922},//rota
    {818.300964, -509.318725, 18.012922},//rota
    {-98.982307, 1083.284545, 19.742187},//rota
    {252.888015, -121.340339, 3.535393},//rota
    {252.888214, -92.429885, 3.535394},//rota
    {267.779205, -54.543376, 2.777209},//rota
    {271.676147, -48.755737, 2.777208},//rota
    {294.864685, -54.543560, 2.777210},//rota
    {344.624053, -71.166564, 2.430808},//rota
    {312.721160, -92.351791, 3.535393},//rota
    {312.721954, -121.360137, 3.535394},//rota
    {784.281066, 1954.298461, 5.707432},//rota
    {261.935455, -269.951843, 1.640490},//rota
    {255.925506, -278.558990, 1.656115},//rota
    {253.552658, -274.579376, 1.656115},//rota
    {264.513305, -283.587951, 1.726427},//rota
    {264.513641, -288.570343, 1.726427},//rota
    {253.249206, -289.703277, 1.702990},//rota
    {241.588851, -282.510742, 1.632677},//rota
    {238.956176, -286.237579, 1.632677},//rota
    {242.056915, -298.600006, 1.687365},//rota
    {226.324661, -302.813110, 1.926182},//rota
    {235.074569, -309.458465, 1.710802},//rota
    {260.455383, -303.153564, 1.918369},//rota
    {1144.889648, 2036.684814, 10.820312},//rota
    {1296.343872, 191.051803, 20.523302},//rota
    {1300.577758, 193.348037, 20.523302},//rota
    {1303.659423, 186.240692, 20.538927},//rota
    {1295.397827, 174.512771, 20.910556},//rota
    {1283.309448, 158.386245, 20.793369},//rota
    {1294.571166, 157.441223, 20.577989},//rota
    {1307.292358, 153.335357, 20.492052},//rota
    {1305.751098, 148.728240, 20.492052},//rota
    {1299.458740, 140.331222, 20.538927},//rota
    {2323.849365, 116.324333, 28.441642},//rota
    {2363.995605, 116.185218, 28.441644},//rota
    {2363.997070, 142.013885, 28.441642},//rota
    {2323.846679, 136.395782, 28.441642},//rota
    {2323.847900, 162.365051, 28.441644},//rota
    {2363.993652, 166.024337, 28.441644},//rota
    {2363.995361, 187.061584, 28.441642},//rota
    {2323.846435, 191.330917, 28.441642},//rota
    {2285.821533, 161.765563, 28.441642},//rota
    {2258.191162, 168.338363, 28.153551},//rota
    {2266.235839, 168.338989, 28.153551},//rota
    {2236.564208, 168.303558, 28.153549},//rota
    {2203.849609, 106.140846, 28.441642},//rota
    {2249.234863, 111.767997, 28.441642},//rota
    {2269.481445, 111.766822, 28.441644},//rota
    {2269.530761, 6.161549, 28.153547},//rota
    {2253.876464, -1.661808, 28.153551},//rota
    {2245.370605, -1.660442, 28.153551},//rota
    {2245.623291, -122.291252, 28.153547},//rota
    {2272.455322, -119.133529, 28.153547},//rota
    {2293.577392, -124.964012, 28.153549},//rota
    {2313.880371, -124.964256, 28.153551}//rota	
};

new Float:Entradas[5][3] =
{
	{2447.910644, -1962.689453, 13.546875},//Mercado Negro
	{1481.094482, -1772.313720, 18.795755},//Prefeitura
	{649.302062, -1357.399658, 13.567605},//San News
	{1081.261840, -1696.785888, 13.546875},//LICENCAS
	{2501.888916, -1494.696533, 24.000000}//AÇOUGUE
};

new Float:AutoEscolaPosicao[13][3] =
{
	{-2136.8550,-171.7946,35.3699}, // CHECKT1
	{-2105.0032,-168.1990,35.3713}, // CHECKT2
	{-2127.3130,-70.1681,35.2315}, // CHECKT3
	{-2314.6829,-70.2550,35.2203}, // CHECKT4
	{-2452.6184,-69.6506,33.5335}, // CHECKT5
	{-2604.2202,-69.9949,4.3527}, // CHECKT6
	{-2602.1624,39.4735,4.3639}, // CHECKT7
	{-2706.5222,41.6627,4.3510}, // CHECKT8
	{-2706.8948,-142.7336,4.2351}, // CHECKT9
	{-2655.2539,-209.0300,4.3502}, // CHECKT10
	{-2698.9197,-281.4757,7.0918}, // CHECKT11
	{-2756.5627,-283.0206,7.0957}, // CHECKT12
	{-2793.3970,-381.4399,7.0987} // CHECKT13
};
new CheckpointPontosMoto[MAX_PLAYERS];
new CheckpointPontosVeiculo[MAX_PLAYERS];
new CheckpointPontosCaminhao[MAX_PLAYERS];
new IniciouTesteHabilitacaoA[MAX_PLAYERS];
new AutoEscolaMoto[MAX_PLAYERS];
new IniciouTesteHabilitacaoB[MAX_PLAYERS];
new AutoEscolaVeiculo[MAX_PLAYERS];
new IniciouTesteHabilitacaoC[MAX_PLAYERS];
new AutoEscolaCaminhao[MAX_PLAYERS];
new IniciouTesteHabilitacaoD[MAX_PLAYERS];
new RotaHabilitacaoMoto[MAX_PLAYERS];
new RotaHabilitacaoVeiculo[MAX_PLAYERS];
new RotaHabilitacaoCaminhao[MAX_PLAYERS];
new RotaHabilitacaoAerea[MAX_PLAYERS];

new Float:AutoEscolaPosicaoAerea[3][3] =
{
	{1477.7679,1456.2830,11.7426}, // checkpoint auto escola
	{-1408.5021,85.4643,15.0698}, // checkpoint auto escola
	{2056.9551,-2494.0383,14.4683} // checkpoint auto escola
};
new CheckpointPontosAerea[MAX_PLAYERS];
new AutoEscolaAerea[MAX_PLAYERS];

static Float:SpawnAT[5][4] = // Checkpoints Aleat?ios Auto Escola
{
	{-2131.0688,-243.0120,35.6608,270.3189}, // SPAWNA1
	{-2131.7361,-234.1879,35.6614,269.7769}, // SPAWNA2
	{-2131.4294,-225.8509,35.6629,268.0889}, // SPAWNA3
	{-2103.3574,-271.5654,35.6684,359.5244}, // SPAWNA4
	{-2110.8416,-271.0301,35.6640,359.6555} // SPAWNA5
};

new Float:PosPesca[13][4] =
{
	{161.495742, -1920.614990, 3.791874, 271.360412},//pesca
	{161.504058, -1927.149291, 3.791874, 306.305938},//pesca
	{161.385360, -1931.044433, 3.791874, 246.922775},//pesca
	{161.194046, -1934.136474, 3.791874, 238.138854},//pesca
	{170.612197, -1949.765869, 3.773437, 300.551391},//pesca
	{159.289993, -1967.208618, 3.791874, 184.406295},//pesca
	{155.322967, -1967.156005, 3.791874, 115.729957},//pesca
	{150.507659, -1967.120727, 3.791874, 73.192962},//pesca
	{138.105529, -1954.054199, 3.773437, 127.607780},//pesca
	{148.346557, -1934.766723, 3.791874, 291.937133},//pesca
	{148.159835, -1931.131958, 3.791874, 3.920514},//pesca
	{148.474090, -1927.095214, 3.791874, 126.725654},//pesca
	{148.396408, -1920.851684, 3.791874, 15.281173}//pesca
};

new Float:PosDesossa[8][4] =
{
	{956.002807, 2120.503662, 1011.723022},
	{958.202270, 2122.305419, 1011.723022},
	{956.002807, 2124.407470, 1011.723022}, 
	{958.402221, 2126.409423, 1011.723022}, 
	{956.002807, 2128.511474, 1011.723022},
	{960.201782, 2120.503662, 1011.723022},
	{960.201782, 2124.007080, 1011.723022},
	{960.201782, 2128.311279, 1011.723022}
};

new EtapasMinerador[MAX_PLAYERS];

new Float:PosEquipar[4][4] =
{
	{-2010.984252, -999.047912, 37.254680},//Policia Militar
	{-2454.447998, 503.778869, 30.079460},//ROTA
	{1628.541625, -251.347473, 49.000457},//PRF
	{-1253.534545, 2712.009521, 55.174671}//BAEP
};

new Float:PosEquiparORG[6][4] =
{
	{-777.775939, 1610.302246, 27.117187},//Tropa dos Azul
	{-107.637207, 1055.019042, 19.823585},//Tropa dos Verdes
	{189.356140, -94.972740, 1.549072},//Tropa dos Amarelos
	{-2087.778564, -2561.794189, 30.598144},//Tropa dos Vermelhos
	{-692.328979, 939.155517, 13.632812},//Mafia Russa
	{693.719665, 1967.682250, 5.539062}//Moto Clube
};

new Float:PosVeiculos[9][4] =
{
	{-2033.141479, -988.619567, 32.212158},//Policia Militar
	{-2441.137939, 522.140869, 29.486917},//ROTA
	{1662.606811, -285.948333, 39.627510},//PRF
	{1683.301391, -2311.982910, 13.546875},//Spawn
	{1179.630615, -1339.028686, 13.838010},//Hospital
	{-478.623901, -506.406524, 25.517845},//Camionero
	{590.086975, 871.486694, -42.734603},//Minerador
	{-2074.854492, 1428.281982, 7.101562},//Mecanica
	{-1278.216552, 2711.282714, 50.132141}//BAEP
};
new VehAlugado[MAX_PLAYERS];
new VeiculoCivil[MAX_PLAYERS];

new Float:Covas[42][3] = 
{
	{-28.7889300,1379.0467500,8.1596200},
	{-24.5955100,1380.2988300,8.1596200},
	{-20.5087100,1375.3441200,8.1596200},
	{-25.4446900,1376.8653600,8.1596200},
	{-19.6301300,1380.3686500,8.1596200},
	{-16.0543500,1379.4997600,8.1596200},
	{-16.5507200,1382.6367200,8.1596200},
	{-19.6393900,1384.5189200,8.1596200},
	{-15.7933800,1386.5805700,8.1596200},
	{-12.2813800,1384.9256600,8.1596200},
	{-6.8099400,1383.3078600,8.1596200},
	{-6.8099400,1383.3078600,8.1596200},
	{-6.8180500,1380.2120400,8.1596200},
	{-14.5410700,1369.8890400,8.1596200},
	{-11.4580600,1367.5421100,8.1596200},
	{-16.2408800,1367.4298100,8.1596200},
	{-20.6409000,1371.5003700,8.1596200},
	{-17.0732400,1362.6203600,8.1596200},
	{-13.3348200,1363.7563500,8.1596200},
	{-9.4271600,1359.8040800,8.1596200},
	{-7.6991100,1364.0034200,8.1596200},
	{-4.3158500,1361.0543200,8.1596200},
	{-19.4902400,1356.4051500,8.1596200},
	{-14.7592200,1354.6652800,8.1596200},
	{-15.5424700,1350.9129600,8.1596200},
	{-10.4427400,1347.8689000,8.1596200},
	{-8.6327400,1354.6868900,8.1596200},
	{-4.2283800,1354.9172400,8.1596200},
	{-1.7661200,1348.6899400,8.1596200},
	{2.8387900,1353.7301000,8.1596200},
	{10.1562200,1349.2440200,8.1596200},
	{7.7120800,1345.6491700,8.1596200},
	{14.6718700,1346.9879200,8.1596200},
	{1.3651600,1360.3045700,8.1596200},
	{0.6464000,1366.8504600,8.1596200},
	{5.9902300,1369.4633800,8.1596200},
	{15.3831400,1373.5233200,8.1596200},
	{11.4213700,1378.0418700,8.1596200},
	{11.4213700,1378.0418700,8.1596200},
	{8.0537300,1384.1206100,8.1596200},
	{13.9457200,1384.2580600,8.1596200},
	{-1.0947900,1385.5531000,8.1596200}
};
new cova[MAX_PLAYERS];
new bool:Covaconcerto[MAX_PLAYERS] = false;
new bool:ltumba[MAX_PLAYERS] = false,
	CargoTumba[MAX_PLAYERS];

new const AnimLibs[][] = {
  "AIRPORT",      "ATTRACTORS",   "BAR",          "BASEBALL",     "BD_FIRE",
  "BEACH",        "BENCHPRESS",   "BF_INJECTION", "BIKE_DBZ",     "BIKED",
  "BIKEH",        "BIKELEAP",     "BIKES",        "BIKEV",        "BLOWJOBZ",
  "BMX",          "BOMBER",       "BOX",          "BSKTBALL",     "BUDDY",
  "BUS",          "CAMERA",       "CAR",          "CAR_CHAT",     "CARRY",
  "CASINO",       "CHAINSAW",     "CHOPPA",       "CLOTHES",      "COACH",
  "COLT45",       "COP_AMBIENT",  "COP_DVBYZ",    "CRACK",        "CRIB",
  "DAM_JUMP",     "DANCING",      "DEALER",       "DILDO",        "DODGE",
  "DOZER",        "DRIVEBYS",     "FAT",          "FIGHT_B",      "FIGHT_C",
  "FIGHT_D",      "FIGHT_E",      "FINALE",       "FINALE2",      "FLAME",
  "FLOWERS",      "FOOD",         "FREEWEIGHTS",  "GANGS",        "GFUNK",
  "GHANDS",       "GHETTO_DB",    "GOGGLES",      "GRAFFITI",     "GRAVEYARD",
  "GRENADE",      "GYMNASIUM",    "HAIRCUTS",     "HEIST9",       "INT_HOUSE",
  "INT_OFFICE",   "INT_SHOP",     "JST_BUISNESS", "KART",         "KISSING",
  "KNIFE",        "LAPDAN1",      "LAPDAN2",      "LAPDAN3",      "LOWRIDER",
  "MD_CHASE",     "MD_END",       "MEDIC",        "MISC",         "MTB",
  "MUSCULAR",     "NEVADA",       "ON_LOOKERS",   "OTB",          "PARACHUTE",
  "PARK",         "PAULNMAC",     "PED",          "PLAYER_DVBYS", "PLAYIDLES",
  "POLICE",       "POOL",         "POOR",         "PYTHON",       "QUAD",
  "QUAD_DBZ",     "RAPPING",      "RIFLE",        "RIOT",         "ROB_BANK",
  "ROCKET",       "RUNNINGMAN",   "RUSTLER",      "RYDER",        "SCRATCHING",
  "SEX",          "SHAMAL",       "SHOP",         "SHOTGUN",      "SILENCED",
  "SKATE",        "SMOKING",      "SNIPER",       "SNM",          "SPRAYCAN",
  "STRIP",        "SUNBATHE",     "SWAT",         "SWEET",        "SWIM",
  "SWORD",        "TANK",         "TATTOOS",      "TEC",          "TRAIN",
  "TRUCK",        "UZI",          "VAN",          "VENDING",      "VORTEX",
  "WAYFARER",     "WEAPONS",      "WOP",          "WUZI"
};

new ArmaProibidaIDs[] = {2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 14, 15, 16, 17, 18, 26, 27, 28, 32, 33, 35, 36, 37, 38, 39, 40, 44, 45, 46}; // Lista de IDs de armas proibidas

new VehicleNames[][] = {
	"Landstalker","Bravura","Buffalo","Linerunner","Perennial","Sentinel","Dumper","Firetruck","Trashmaster","Stretch","Manana","Infernus",
	"Voodoo","Pony","Mule","Cheetah","Ambulance","Leviathan","Moonbeam","Esperanto","Taxi","Washington","Bobcat","Mr Whoopee","BF Injection",
	"Hunter","Premier","Enforcer","Securicar","Banshee","Predator","Bus","Rhino","Barracks","Hotknife","Trailer","Previon","Coach","Cabbie",
	"Stallion","Rumpo","RC Bandit","Romero","Packer","Monster","Admiral","Squalo","Seasparrow","Pizzaboy","Tram","Trailer","Turismo","Speeder",
	"Reefer","Tropic","Flatbed","Yankee","Caddy","Solair","Berkley's RC Van","Skimmer","PCJ-600","Faggio","Freeway","RC Baron","RC Raider",
	"Glendale","Oceanic","Sanchez","Sparrow","Patriot","Quad","Coastguard","Dinghy","Hermes","Sabre","Rustler","ZR3 50","Walton","Regina",
	"Comet","BMX","Burrito","Camper","Marquis","Baggage","Dozer","Maverick","News Chopper","Rancher","FBI Rancher","Virgo","Greenwood",
	"Jetmax","Hotring","Sandking","Blista Compact","Police Maverick","Boxville","Benson","Mesa","RC Goblin","Hotring Racer A","Hotring Racer B",
	"Bloodring Banger","Rancher","Super GT","Elegant","Journey","Bike","Mountain Bike","Beagle","Cropdust","Stunt","Tanker","RoadTrain",
	"Nebula","Majestic","Buccaneer","Shamal","Hydra","FCR-900","NRG-500","HPV1000","Cement Truck","Tow Truck","Fortune","Cadrona","FBI Truck",
	"Willard","Forklift","Tractor","Combine","Feltzer","Remington","Slamvan","Blade","Freight","Streak","Vortex","Vincent","Bullet","Clover",
	"Sadler","Firetruck","Hustler","Intruder","Primo","Cargobob","Tampa","Sunrise","Merit","Utility","Nevada","Yosemite","Windsor","Monster A",
	"Monster B","Uranus","Jester","Sultan","Stratum","Elegy","Raindance","RC Tiger","Flash","Tahoma","Savanna","Bandito","Freight","Trailer",
	"Kart","Mower","Duneride","Sweeper","Broadway","Tornado","AT-400","DFT-30","Huntley","Stafford","BF-400","Newsvan","Tug","Trailer A","Emperor",
	"Wayfarer","Euros","Hotdog","Club","Trailer B","Trailer C","Andromada","Dodo","RC Cam","Launch","Police Car (LSPD)","Police Car (SFPD)",
	"Police Car (LVPD)","Police Ranger","Picador","S.W.A.T. Van","Alpha","Phoenix","Glendale","Sadler","Luggage Trailer A","Luggage Trailer B",
	"Stair Trailer","Boxville","Farm Plow","Utility Trailer"
};

enum SAZONE_MAIN
{
	SAZONE_NAME[28],
	Float:SAZONE_AREA[6]
};

new const gSAZones[][SAZONE_MAIN] = {
	{"The Big Ear",	                {-410.00,1403.30,-3.00,-137.90,1681.20,200.00}},
	{"Aldea Malvada",               {-1372.10,2498.50,0.00,-1277.50,2615.30,200.00}},
	{"Angel Pine",                  {-2324.90,-2584.20,-6.10,-1964.20,-2212.10,200.00}},
	{"Arco del Oeste",              {-901.10,2221.80,0.00,-592.00,2571.90,200.00}},
	{"Avispa Country Club",         {-2646.40,-355.40,0.00,-2270.00,-222.50,200.00}},
	{"Avispa Country Club B",         {-2831.80,-430.20,-6.10,-2646.40,-222.50,200.00}},
	{"Avispa Country Club C",         {-2361.50,-417.10,0.00,-2270.00,-355.40,200.00}},
	{"Avispa Country Club D",         {-2667.80,-302.10,-28.80,-2646.40,-262.30,71.10}},
	{"Avispa Country Club E",         {-2470.00,-355.40,0.00,-2270.00,-318.40,46.10}},
	{"Avispa Country Club F",         {-2550.00,-355.40,0.00,-2470.00,-318.40,39.70}},
	{"Back o Beyond",               {-1166.90,-2641.10,0.00,-321.70,-1856.00,200.00}},
	{"Battery Point",               {-2741.00,1268.40,-4.50,-2533.00,1490.40,200.00}},
	{"Bayside",                     {-2741.00,2175.10,0.00,-2353.10,2722.70,200.00}},
	{"Bayside Marina",              {-2353.10,2275.70,0.00,-2153.10,2475.70,200.00}},
	{"Beacon Hill",                 {-399.60,-1075.50,-1.40,-319.00,-977.50,198.50}},
	{"Blackfield",                  {964.30,1203.20,-89.00,1197.30,1403.20,110.90}},
	{"Blackfield B ",                  {964.30,1403.20,-89.00,1197.30,1726.20,110.90}},
	{"Blackfield Chapel",           {1375.60,596.30,-89.00,1558.00,823.20,110.90}},
	{"Blackfield Chapel B",           {1325.60,596.30,-89.00,1375.60,795.00,110.90}},
	{"Blackfield C",     				{1197.30,1044.60,-89.00,1277.00,1163.30,110.90}},
	{"Blackfield D",   				{1166.50,795.00,-89.00,1375.60,1044.60,110.90}},
	{"Blackfield E",     				{1277.00,1044.60,-89.00,1315.30,1087.60,110.90}},
	{"Blackfield F",     				{1375.60,823.20,-89.00,1457.30,919.40,110.90}},
	{"Blueberry",                   {104.50,-220.10,2.30,349.60,152.20,200.00}},
	{"Blueberry B",                   {19.60,-404.10,3.80,349.60,-220.10,200.00}},
	{"Blueberry Acres",             {-319.60,-220.10,0.00,104.50,293.30,200.00}},
	{"Caligula's Palace",           {2087.30,1543.20,-89.00,2437.30,1703.20,110.90}},
	{"Caligula's Palace B",           {2137.40,1703.20,-89.00,2437.30,1783.20,110.90}},
	{"Calton Heights",              {-2274.10,744.10,-6.10,-1982.30,1358.90,200.00}},
	{"Chinatown",                   {-2274.10,578.30,-7.60,-2078.60,744.10,200.00}},
	{"City H	all",                   {-2867.80,277.40,-9.10,-2593.40,458.40,200.00}},
	{"Castelo",           			{2087.30,943.20,-89.00,2623.10,1203.20,110.90}},
	{"Commerce",                    {1323.90,-1842.20,-89.00,1701.90,-1722.20,110.90}},
	{"Commerce B",                    {1323.90,-1722.20,-89.00,1440.90,-1577.50,110.90}},
	{"Commerce C",                    {1370.80,-1577.50,-89.00,1463.90,-1384.90,110.90}},
	{"Commerce D",                    {1463.90,-1577.50,-89.00,1667.90,-1430.80,110.90}},
	{"Commerce E",                    {1583.50,-1722.20,-89.00,1758.90,-1577.50,110.90}},
	{"Commerce F",                    {1667.90,-1577.50,-89.00,1812.60,-1430.80,110.90}},
	{"Conference Center",           {1046.10,-1804.20,-89.00,1323.90,-1722.20,110.90}},
	{"Conference Center",           {1073.20,-1842.20,-89.00,1323.90,-1804.20,110.90}},
	{"Cranberry Station",           {-2007.80,56.30,0.00,-1922.00,224.70,100.00}},
	{"Creek",                       {2749.90,1937.20,-89.00,2921.60,2669.70,110.90}},
	{"Dillimore",                   {580.70,-674.80,-9.50,861.00,-404.70,200.00}},
	{"Doherty",                     {-2270.00,-324.10,-0.00,-1794.90,-222.50,200.00}},
	{"Doherty",                     {-2173.00,-222.50,-0.00,-1794.90,265.20,200.00}},
	{"Downtown",                    {-1982.30,744.10,-6.10,-1871.70,1274.20,200.00}},
	{"Downtown",                    {-1871.70,1176.40,-4.50,-1620.30,1274.20,200.00}},
	{"Downtown",                    {-1700.00,744.20,-6.10,-1580.00,1176.50,200.00}},
	{"Downtown",                    {-1580.00,744.20,-6.10,-1499.80,1025.90,200.00}},
	{"Downtown",                    {-2078.60,578.30,-7.60,-1499.80,744.20,200.00}},
	{"Downtown",                    {-1993.20,265.20,-9.10,-1794.90,578.30,200.00}},
	{"Downtown Los Santos",         {1463.90,-1430.80,-89.00,1724.70,-1290.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1430.80,-89.00,1812.60,-1250.90,110.90}},
	{"Downtown Los Santos",         {1463.90,-1290.80,-89.00,1724.70,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1384.90,-89.00,1463.90,-1170.80,110.90}},
	{"Downtown Los Santos",         {1724.70,-1250.90,-89.00,1812.60,-1150.80,110.90}},
	{"Downtown Los Santos",         {1370.80,-1170.80,-89.00,1463.90,-1130.80,110.90}},
	{"Downtown Los Santos",         {1378.30,-1130.80,-89.00,1463.90,-1026.30,110.90}},
	{"Downtown Los Santos",         {1391.00,-1026.30,-89.00,1463.90,-926.90,110.90}},
	{"Downtown Los Santos",         {1507.50,-1385.20,110.90,1582.50,-1325.30,335.90}},
	{"East Beach",                  {2632.80,-1852.80,-89.00,2959.30,-1668.10,110.90}},
	{"East Beach",                  {2632.80,-1668.10,-89.00,2747.70,-1393.40,110.90}},
	{"East Beach",                  {2747.70,-1668.10,-89.00,2959.30,-1498.60,110.90}},
	{"East Beach",                  {2747.70,-1498.60,-89.00,2959.30,-1120.00,110.90}},
	{"East Los Santos",             {2421.00,-1628.50,-89.00,2632.80,-1454.30,110.90}},
	{"East Los Santos",             {2222.50,-1628.50,-89.00,2421.00,-1494.00,110.90}},
	{"East Los Santos",             {2266.20,-1494.00,-89.00,2381.60,-1372.00,110.90}},
	{"East Los Santos",             {2381.60,-1494.00,-89.00,2421.00,-1454.30,110.90}},
	{"East Los Santos",             {2281.40,-1372.00,-89.00,2381.60,-1135.00,110.90}},
	{"East Los Santos",             {2381.60,-1454.30,-89.00,2462.10,-1135.00,110.90}},
	{"East Los Santos",             {2462.10,-1454.30,-89.00,2581.70,-1135.00,110.90}},
	{"Easter Basin",                {-1794.90,249.90,-9.10,-1242.90,578.30,200.00}},
	{"Easter Basin",                {-1794.90,-50.00,-0.00,-1499.80,249.90,200.00}},
	{"Easter Bay Airport",          {-1499.80,-50.00,-0.00,-1242.90,249.90,200.00}},
	{"Easter Bay Airport",          {-1794.90,-730.10,-3.00,-1213.90,-50.00,200.00}},
	{"Easter Bay Airport",          {-1213.90,-730.10,0.00,-1132.80,-50.00,200.00}},
	{"Easter Bay Airport",          {-1242.90,-50.00,0.00,-1213.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1213.90,-50.00,-4.50,-947.90,578.30,200.00}},
	{"Easter Bay Airport",          {-1315.40,-405.30,15.40,-1264.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1354.30,-287.30,15.40,-1315.40,-209.50,25.40}},
	{"Easter Bay Airport",          {-1490.30,-209.50,15.40,-1264.40,-148.30,25.40}},
	{"Easter Bay Chemicals",        {-1132.80,-768.00,0.00,-956.40,-578.10,200.00}},
	{"Easter Bay Chemicals",        {-1132.80,-787.30,0.00,-956.40,-768.00,200.00}},
	{"El Castillo del Diablo",      {-464.50,2217.60,0.00,-208.50,2580.30,200.00}},
	{"El Castillo del Diablo",      {-208.50,2123.00,-7.60,114.00,2337.10,200.00}},
	{"El Castillo del Diablo",      {-208.50,2337.10,0.00,8.40,2487.10,200.00}},
	{"El Corona",                   {1812.60,-2179.20,-89.00,1970.60,-1852.80,110.90}},
	{"El Corona",                   {1692.60,-2179.20,-89.00,1812.60,-2018.92,110.90}},
	{"Estacao Unity",               {1692.60,-2018.92,-89.00,1812.60,-1842.20,110.90}},
	{"El Quebrados",                {-1645.20,2498.50,0.00,-1372.10,2777.80,200.00}},
	{"Esplanade East",              {-1620.30,1176.50,-4.50,-1580.00,1274.20,200.00}},
	{"Esplanade East",              {-1580.00,1025.90,-6.10,-1499.80,1274.20,200.00}},
	{"Esplanade East",              {-1499.80,578.30,-79.60,-1339.80,1274.20,20.30}},
	{"Esplanade North",             {-2533.00,1358.90,-4.50,-1996.60,1501.20,200.00}},
	{"Esplanade North",             {-1996.60,1358.90,-4.50,-1524.20,1592.50,200.00}},
	{"Esplanade North",             {-1982.30,1274.20,-4.50,-1524.20,1358.90,200.00}},
	{"Fallen Tree",                 {-792.20,-698.50,-5.30,-452.40,-380.00,200.00}},
	{"Fallow Bridge",               {434.30,366.50,0.00,603.00,555.60,200.00}},
	{"Fern Ridge",                  {508.10,-139.20,0.00,1306.60,119.50,200.00}},
	{"Financial",                   {-1871.70,744.10,-6.10,-1701.30,1176.40,300.00}},
	{"Fisher's Lagoon",             {1916.90,-233.30,-100.00,2131.70,13.80,200.00}},
	{"Flint ",          			{-187.70,-1596.70,-89.00,17.00,-1276.60,110.90}},
	{"Flint Range",                 {-594.10,-1648.50,0.00,-187.70,-1276.60,200.00}},
	{"Fort Carson",                 {-376.20,826.30,-3.00,123.70,1220.40,200.00}},
	{"Foster Valley",               {-2270.00,-430.20,-0.00,-2178.60,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-599.80,-0.00,-1794.90,-324.10,200.00}},
	{"Foster Valley",               {-2178.60,-1115.50,0.00,-1794.90,-599.80,200.00}},
	{"Foster Valley",               {-2178.60,-1250.90,0.00,-1794.90,-1115.50,200.00}},
	{"Frederick Bridge",            {2759.20,296.50,0.00,2774.20,594.70,200.00}},
	{"Gant Bridge",                 {-2741.40,1659.60,-6.10,-2616.40,2175.10,200.00}},
	{"Gant Bridge",                 {-2741.00,1490.40,-6.10,-2616.40,1659.60,200.00}},
	{"Ganton",                      {2222.50,-1852.80,-89.00,2632.80,-1722.30,110.90}},
	{"Ganton",                      {2222.50,-1722.30,-89.00,2632.80,-1628.50,110.90}},
	{"Garcia",                      {-2411.20,-222.50,-0.00,-2173.00,265.20,200.00}},
	{"Garcia",                      {-2395.10,-222.50,-5.30,-2354.00,-204.70,200.00}},
	{"Garver Bridge",               {-1339.80,828.10,-89.00,-1213.90,1057.00,110.90}},
	{"Garver Bridge",               {-1213.90,950.00,-89.00,-1087.90,1178.90,110.90}},
	{"Garver Bridge",               {-1499.80,696.40,-179.60,-1339.80,925.30,20.30}},
	{"Pista de Skate",                   {1812.60,-1449.60,-89.00,1996.90,-1350.70,110.90}},
	{"Parque Gleen",                   {1812.60,-1100.80,-89.00,1994.30,-973.30,110.90}},
	{"Parque Gleen",              {1812.60,-1350.70,-89.00,2056.80,-1100.80,110.90}},
	{"Green Palms",                 {176.50,1305.40,-3.00,338.60,1520.70,200.00}},
	{"Greenglass College",          {964.30,1044.60,-89.00,1197.30,1203.20,110.90}},
	{"Greenglass College",          {964.30,930.80,-89.00,1166.50,1044.60,110.90}},
	{"Hampton Barns",               {603.00,264.30,0.00,761.90,366.50,200.00}},
	{"Hankypanky Point",            {2576.90,62.10,0.00,2759.20,385.50,200.00}},
	{"Harry Gold Parkway",          {1777.30,863.20,-89.00,1817.30,2342.80,110.90}},
	{"Hashbury",                    {-2593.40,-222.50,-0.00,-2411.20,54.70,200.00}},
	{"Hilltop Farm",                {967.30,-450.30,-3.00,1176.70,-217.90,200.00}},
	{"Hunter Quarry",               {337.20,710.80,-115.20,860.50,1031.70,203.70}},
	{"Idlewood",                    {1812.60,-1852.80,-89.00,1971.60,-1742.30,110.90}},
	{"Idlewood",                    {1812.60,-1742.30,-89.00,1951.60,-1602.30,110.90}},
	{"Idlewood",                    {1951.60,-1742.30,-89.00,2124.60,-1602.30,110.90}},
	{"Idlewood",                    {1812.60,-1602.30,-89.00,2124.60,-1449.60,110.90}},
	{"Idlewood",                    {2124.60,-1742.30,-89.00,2222.50,-1494.00,110.90}},
	{"Idlewood",                    {1971.60,-1852.80,-89.00,2222.50,-1742.30,110.90}},
	{"Jefferson",                   {1996.90,-1449.60,-89.00,2056.80,-1350.70,110.90}},
	{"Jefferson",                   {2124.60,-1494.00,-89.00,2266.20,-1449.60,110.90}},
	{"Jefferson",                   {2056.80,-1372.00,-89.00,2281.40,-1210.70,110.90}},
	{"Jefferson",                   {2056.80,-1210.70,-89.00,2185.30,-1126.30,110.90}},
	{"Jefferson",                   {2185.30,-1210.70,-89.00,2281.40,-1154.50,110.90}},
	{"Jefferson",                   {2056.80,-1449.60,-89.00,2266.20,-1372.00,110.90}},
	{"Julius Thruway East",         {2623.10,943.20,-89.00,2749.90,1055.90,110.90}},
	{"Julius Thruway East",         {2685.10,1055.90,-89.00,2749.90,2626.50,110.90}},
	{"Julius Thruway East",         {2536.40,2442.50,-89.00,2685.10,2542.50,110.90}},
	{"Julius Thruway East",         {2625.10,2202.70,-89.00,2685.10,2442.50,110.90}},
	{"Julius Thruway North",        {2498.20,2542.50,-89.00,2685.10,2626.50,110.90}},
	{"Julius Thruway North",        {2237.40,2542.50,-89.00,2498.20,2663.10,110.90}},
	{"Julius Thruway North",        {2121.40,2508.20,-89.00,2237.40,2663.10,110.90}},
	{"Julius Thruway North",        {1938.80,2508.20,-89.00,2121.40,2624.20,110.90}},
	{"Julius Thruway North",        {1534.50,2433.20,-89.00,1848.40,2583.20,110.90}},
	{"Julius Thruway North",        {1848.40,2478.40,-89.00,1938.80,2553.40,110.90}},
	{"Julius Thruway North",        {1704.50,2342.80,-89.00,1848.40,2433.20,110.90}},
	{"Julius Thruway North",        {1377.30,2433.20,-89.00,1534.50,2507.20,110.90}},
	{"Julius Thruway South",        {1457.30,823.20,-89.00,2377.30,863.20,110.90}},
	{"Julius Thruway South",        {2377.30,788.80,-89.00,2537.30,897.90,110.90}},
	{"Julius Thruway West",         {1197.30,1163.30,-89.00,1236.60,2243.20,110.90}},
	{"Julius Thruway West",         {1236.60,2142.80,-89.00,1297.40,2243.20,110.90}},
	{"Juniper Hill",                {-2533.00,578.30,-7.60,-2274.10,968.30,200.00}},
	{"Juniper Hollow",              {-2533.00,968.30,-6.10,-2274.10,1358.90,200.00}},
	{"K.A.C.C. Military Fuels",     {2498.20,2626.50,-89.00,2749.90,2861.50,110.90}},
	{"Kincaid Bridge",              {-1339.80,599.20,-89.00,-1213.90,828.10,110.90}},
	{"Kincaid Bridge",              {-1213.90,721.10,-89.00,-1087.90,950.00,110.90}},
	{"Kincaid Bridge",              {-1087.90,855.30,-89.00,-961.90,986.20,110.90}},
	{"King's",                      {-2329.30,458.40,-7.60,-1993.20,578.30,200.00}},
	{"King's",                      {-2411.20,265.20,-9.10,-1993.20,373.50,200.00}},
	{"King's",                      {-2253.50,373.50,-9.10,-1993.20,458.40,200.00}},
	{"LVA Freight Depot",           {1457.30,863.20,-89.00,1777.40,1143.20,110.90}},
	{"LVA Freight Depot",           {1375.60,919.40,-89.00,1457.30,1203.20,110.90}},
	{"LVA Freight Depot",           {1277.00,1087.60,-89.00,1375.60,1203.20,110.90}},
	{"LVA Freight Depot",           {1315.30,1044.60,-89.00,1375.60,1087.60,110.90}},
	{"LVA Freight Depot",           {1236.60,1163.40,-89.00,1277.00,1203.20,110.90}},
	{"Las Barrancas",               {-926.10,1398.70,-3.00,-719.20,1634.60,200.00}},
	{"Las Brujas",                  {-365.10,2123.00,-3.00,-208.50,2217.60,200.00}},
	{"Morro",                 {1994.30,-1100.80,-89.00,2056.80,-920.80,110.90}},
	{"Morro",                 {2056.80,-1126.30,-89.00,2126.80,-920.80,110.90}},
	{"Morro",                 {2185.30,-1154.50,-89.00,2281.40,-934.40,110.90}},
	{"Morro",                 {2126.80,-1126.30,-89.00,2185.30,-934.40,110.90}},
	{"Morro",                 {2747.70,-1120.00,-89.00,2959.30,-945.00,110.90}},
	{"Morro",                 {2632.70,-1135.00,-89.00,2747.70,-945.00,110.90}},
	{"Morro",                 {2281.40,-1135.00,-89.00,2632.70,-945.00,110.90}},
	{"Las Payasadas",               {-354.30,2580.30,2.00,-133.60,2816.80,200.00}},
	{"Las Venturas Airport",        {1236.60,1203.20,-89.00,1457.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1203.20,-89.00,1777.30,1883.10,110.90}},
	{"Las Venturas Airport",        {1457.30,1143.20,-89.00,1777.40,1203.20,110.90}},
	{"Las Venturas Airport",        {1515.80,1586.40,-12.50,1729.90,1714.50,87.50}},
	{"Last Dime Motel",             {1823.00,596.30,-89.00,1997.20,823.20,110.90}},
	{"Leafy Hollow",                {-1166.90,-1856.00,0.00,-815.60,-1602.00,200.00}},
	{"Liberty City",                {-1000.00,400.00,1300.00,-700.00,600.00,1400.00}},
	{"Lil' Probe Inn",              {-90.20,1286.80,-3.00,153.80,1554.10,200.00}},
	{"Linden Side",                 {2749.90,943.20,-89.00,2923.30,1198.90,110.90}},
	{"Linden Station",              {2749.90,1198.90,-89.00,2923.30,1548.90,110.90}},
	{"Linden Station",              {2811.20,1229.50,-39.50,2861.20,1407.50,60.40}},
	{"Little Mexico",               {1701.90,-1842.20,-89.00,1812.60,-1722.20,110.90}},
	{"Little Mexico",               {1758.90,-1722.20,-89.00,1812.60,-1577.50,110.90}},
	{"Los Flores",                  {2581.70,-1454.30,-89.00,2632.80,-1393.40,110.90}},
	{"Los Flores",                  {2581.70,-1393.40,-89.00,2747.70,-1135.00,110.90}},
	{"HQ ADM",            			{3033.17, -2053.81,-89.00,3102.69,-1933.12,110.90}},
	{"Aeroporto Los Santos",    			{1249.60,-2394.30,-89.00,1852.00,-2179.20,110.90}},
	{"Aeroporto Los Santos",    			{1852.00,-2394.30,-89.00,2089.00,-2179.20,110.90}},
	{"Aeroporto Los Santos",    			{1382.70,-2730.80,-89.00,2201.80,-2394.30,110.90}},
	{"Aeroporto Los Santos",    			{1974.60,-2394.30,-39.00,2089.00,-2256.50,60.90}},
	{"Aeroporto Los Santos",    			{1400.90,-2669.20,-39.00,2189.80,-2597.20,60.90}},
	{"Aeroporto Los Santos",    			{2051.60,-2597.20,-39.00,2152.40,-2394.30,60.90}},
	{"Marina",                      {647.70,-1804.20,-89.00,851.40,-1577.50,110.90}},
	{"Marina",                      {647.70,-1577.50,-89.00,807.90,-1416.20,110.90}},
	{"Marina",                      {807.90,-1577.50,-89.00,926.90,-1416.20,110.90}},
	{"Market",                      {787.40,-1416.20,-89.00,1072.60,-1310.20,110.90}},
	{"Market",                      {952.60,-1310.20,-89.00,1072.60,-1130.80,110.90}},
	{"Market",                      {1072.60,-1416.20,-89.00,1370.80,-1130.80,110.90}},
	{"Market",                      {926.90,-1577.50,-89.00,1370.80,-1416.20,110.90}},
	{"Market Station",              {787.40,-1410.90,-34.10,866.00,-1310.20,65.80}},
	{"Martin Bridge",               {-222.10,293.30,0.00,-122.10,476.40,200.00}},
	{"Missionary Hill",             {-2994.40,-811.20,0.00,-2178.60,-430.20,200.00}},
	{"Montgomery",                  {1119.50,119.50,-3.00,1451.40,493.30,200.00}},
	{"Montgomery",                  {1451.40,347.40,-6.10,1582.40,420.80,200.00}},
	{"Montgomery",     				{1546.60,208.10,0.00,1745.80,347.40,200.00}},
	{"Montgomery",     				{1582.40,347.40,0.00,1664.60,401.70,200.00}},
	{"Mulholland",                  {1414.00,-768.00,-89.00,1667.60,-452.40,110.90}},
	{"Mulholland",                  {1281.10,-452.40,-89.00,1641.10,-290.90,110.90}},
	{"Mulholland",                  {1269.10,-768.00,-89.00,1414.00,-452.40,110.90}},
	{"Mulholland",                  {1357.00,-926.90,-89.00,1463.90,-768.00,110.90}},
	{"Mulholland",                  {1318.10,-910.10,-89.00,1357.00,-768.00,110.90}},
	{"Mulholland",                  {1169.10,-910.10,-89.00,1318.10,-768.00,110.90}},
	{"Mulholland",                  {768.60,-954.60,-89.00,952.60,-860.60,110.90}},
	{"Richman",                     {321.30,-768.00,-89.00,700.70,-674.80,110.90}},
	{"Robada",         				{-1119.00,1178.90,-89.00,-862.00,1351.40,110.90}},
	{"Roca Escalante",              {2237.40,2202.70,-89.00,2536.40,2542.50,110.90}},
	{"Roca Escalante",              {2536.40,2202.70,-89.00,2625.10,2442.50,110.90}},
	{"Rockshore East",              {2537.30,676.50,-89.00,2902.30,943.20,110.90}},
	{"Rockshore West",              {1997.20,596.30,-89.00,2377.30,823.20,110.90}},
	{"Rockshore West",              {2377.30,596.30,-89.00,2537.30,788.80,110.90}},
	{"Rodeo",                       {72.60,-1684.60,-89.00,225.10,-1544.10,110.90}},
	{"Rodeo",                       {72.60,-1544.10,-89.00,225.10,-1404.90,110.90}},
	{"Rodeo",                       {225.10,-1684.60,-89.00,312.80,-1501.90,110.90}},
	{"Rodeo",                       {225.10,-1501.90,-89.00,334.50,-1369.60,110.90}},
	{"Rodeo",                       {334.50,-1501.90,-89.00,422.60,-1406.00,110.90}},
	{"Rodeo",                       {312.80,-1684.60,-89.00,422.60,-1501.90,110.90}},
	{"Rodeo",                       {422.60,-1684.60,-89.00,558.00,-1570.20,110.90}},
	{"Rodeo",                       {558.00,-1684.60,-89.00,647.50,-1384.90,110.90}},
	{"Rodeo",                       {466.20,-1570.20,-89.00,558.00,-1385.00,110.90}},
	{"Rodeo",                       {422.60,-1570.20,-89.00,466.20,-1406.00,110.90}},
	{"Rodeo",                       {466.20,-1385.00,-89.00,647.50,-1235.00,110.90}},
	{"Rodeo",                       {334.50,-1406.00,-89.00,466.20,-1292.00,110.90}},
	{"Royal Casino",                {2087.30,1383.20,-89.00,2437.30,1543.20,110.90}},
	{"San Andreas Sound",           {2450.30,385.50,-100.00,2759.20,562.30,200.00}},
	{"Santa Flora",                 {-2741.00,458.40,-7.60,-2533.00,793.40,200.00}},
	{"Santa Maria Beach",           {342.60,-2173.20,-89.00,647.70,-1684.60,110.90}},
	{"Santa Maria Beach",           {72.60,-2173.20,-89.00,342.60,-1684.60,110.90}},
	{"Shady Cabin",                 {-1632.80,-2263.40,-3.00,-1601.30,-2231.70,200.00}},
	{"Shady Creeks",                {-1820.60,-2643.60,-8.00,-1226.70,-1771.60,200.00}},
	{"Shady Creeks",                {-2030.10,-2174.80,-6.10,-1820.60,-1771.60,200.00}},
	{"Sobell Rail Yards",           {2749.90,1548.90,-89.00,2923.30,1937.20,110.90}},
	{"Spinybed",                    {2121.40,2663.10,-89.00,2498.20,2861.50,110.90}},
	{"Starfish Casino",             {2437.30,1783.20,-89.00,2685.10,2012.10,110.90}},
	{"Starfish Casino",             {2437.30,1858.10,-39.00,2495.00,1970.80,60.90}},
	{"Starfish Casino",             {2162.30,1883.20,-89.00,2437.30,2012.10,110.90}},
	{"Temple",                      {1252.30,-1130.80,-89.00,1378.30,-1026.30,110.90}},
	{"Temple",                      {1252.30,-1026.30,-89.00,1391.00,-926.90,110.90}},
	{"Temple",                      {1252.30,-926.90,-89.00,1357.00,-910.10,110.90}},
	{"Temple",                      {952.60,-1130.80,-89.00,1096.40,-937.10,110.90}},
	{"Temple",                      {1096.40,-1130.80,-89.00,1252.30,-1026.30,110.90}},
	{"Temple",                      {1096.40,-1026.30,-89.00,1252.30,-910.10,110.90}},
	{"The Camel's Toe",             {2087.30,1203.20,-89.00,2640.40,1383.20,110.90}},
	{"The Clown's Pocket",          {2162.30,1783.20,-89.00,2437.30,1883.20,110.90}},
	{"The Emerald Isle",            {2011.90,2202.70,-89.00,2237.40,2508.20,110.90}},
	{"The Farm",                    {-1209.60,-1317.10,114.90,-908.10,-787.30,251.90}},
	{"Four Dragons Casino",         {1817.30,863.20,-89.00,2027.30,1083.20,110.90}},
	{"The High Roller",             {1817.30,1283.20,-89.00,2027.30,1469.20,110.90}},
	{"The Mako Span",               {1664.60,401.70,0.00,1785.10,567.20,200.00}},
	{"The Panopticon",              {-947.90,-304.30,-1.10,-319.60,327.00,200.00}},
	{"The Pink Swan",               {1817.30,1083.20,-89.00,2027.30,1283.20,110.90}},
	{"The Sherman Dam",             {-968.70,1929.40,-3.00,-481.10,2155.20,200.00}},
	{"The Strip",                   {2027.40,863.20,-89.00,2087.30,1703.20,110.90}},
	{"The Strip",                   {2106.70,1863.20,-89.00,2162.30,2202.70,110.90}},
	{"The Strip",                   {2027.40,1783.20,-89.00,2162.30,1863.20,110.90}},
	{"The Strip",                   {2027.40,1703.20,-89.00,2137.40,1783.20,110.90}},
	{"The Visage",                  {1817.30,1863.20,-89.00,2106.70,2011.80,110.90}},
	{"The Visage",                  {1817.30,1703.20,-89.00,2027.40,1863.20,110.90}},
	{"Unity Station",               {1692.60,-1971.80,-20.40,1812.60,-1932.80,79.50}},
	{"Valle Ocultado",              {-936.60,2611.40,2.00,-715.90,2847.90,200.00}},
	{"Verdant Bluffs",              {930.20,-2488.40,-89.00,1249.60,-2006.70,110.90}},
	{"Verdant Bluffs",              {1073.20,-2006.70,-89.00,1249.60,-1842.20,110.90}},
	{"Verdant Bluffs",              {1249.60,-2179.20,-89.00,1692.60,-1842.20,110.90}},
	{"Verdant Meadows",             {37.00,2337.10,-3.00,435.90,2677.90,200.00}},
	{"Verona Beach",                {647.70,-2173.20,-89.00,930.20,-1804.20,110.90}},
	{"Verona Beach",                {930.20,-2006.70,-89.00,1073.20,-1804.20,110.90}},
	{"Verona Beach",                {851.40,-1804.20,-89.00,1046.10,-1577.50,110.90}},
	{"Verona Beach",                {1161.50,-1722.20,-89.00,1323.90,-1577.50,110.90}},
	{"Verona Beach",                {1046.10,-1722.20,-89.00,1161.50,-1577.50,110.90}},
	{"Vinewood",                    {787.40,-1310.20,-89.00,952.60,-1130.80,110.90}},
	{"Vinewood",                    {787.40,-1056.02,-89.00,952.60,-954.60,110.90}},
	{"Cemiterio",                   {787.40,-1130.80,-89.00,952.59,-1056.01,110.90}},
	{"Vinewood",                    {647.50,-1227.20,-89.00,787.40,-1118.20,110.90}},
	{"Vinewood",                    {647.70,-1416.20,-89.00,787.40,-1227.20,110.90}},
	{"Whitewood Estates",           {883.30,1726.20,-89.00,1098.30,2507.20,110.90}},
	{"Whitewood Estates",           {1098.30,1726.20,-89.00,1197.30,2243.20,110.90}},
	{"Willowfield",                 {1970.60,-2179.20,-89.00,2089.00,-1852.80,110.90}},
	{"Willowfield",                 {2089.00,-2235.80,-89.00,2201.80,-1989.90,110.90}},
	{"Willowfield",                 {2089.00,-1989.90,-89.00,2324.00,-1852.80,110.90}},
	{"Willowfield",                 {2201.80,-2095.00,-89.00,2324.00,-1989.90,110.90}},
	{"Willowfield",                 {2541.70,-1941.40,-89.00,2703.50,-1852.80,110.90}},
	{"Willowfield",                 {2324.00,-2059.20,-89.00,2541.70,-1852.80,110.90}},
	{"Willowfield",                 {2541.70,-2059.20,-89.00,2703.50,-1941.40,110.90}},
	{"Yellow Bell Station",         {1377.40,2600.40,-21.90,1492.40,2687.30,78.00}},
	{"Navio de Cargas",            	{721.48,-2263.62,-89.00,985.48,-2173.20,110.90}},
	// Citys Zones
	{"Los Santos",                  {44.60,-2892.90,-242.90,2997.00,-768.00,900.00}},
	{"Las Venturas",                {869.40,596.30,-242.90,2997.00,2993.80,900.00}},
	{"Bone County",                 {-480.50,596.30,-242.90,869.40,2993.80,900.00}},
	{"Tierra Robada",               {-2997.40,1659.60,-242.90,-480.50,2993.80,900.00}},
	{"Tierra Robada",               {-1213.90,596.30,-242.90,-480.50,1659.60,900.00}},
	{"San Fierro",                  {-2997.40,-1115.50,-242.90,-1213.90,1659.60,900.00}},
	{"Red County",                  {-1213.90,-768.00,-242.90,2997.00,596.30,900.00}},
	{"Flint County",                {-1213.90,-2892.90,-242.90,44.60,-768.00,900.00}},
	{"Whetstone",                   {-2997.40,-2892.90,-242.90,-1213.90,-1115.50,900.00}}
};

new RandomPresence[][] = 
{
	"Servidor Online",
	"Baixada Roleplay v2.0.9",
	"San Andreas Multiplayer",
	"Estamos na versao v2.0.9 do servidor"
};

new RandomMSG[][] =
{
	"Entre em nosso discord <-> Link: https://discord.gg/QYpxa5SvNB",
	"Creditos aos desenvolvedores no /creditos.",
	"Boas vindas a um dos melhores servidores inovadores!",
	"Necessita de ajuda? Use /ajuda para verificar os comandos.",
	"Seu dinheiro tem muito valor em nossa cidade, cuide bem dele.",
	"Disfrute o maximo do nosso servidor!",
	"Garanta seu vip em nosso servidor use /lojavip",
	"Encontre lugares importantes no /gps",
	"Para denunciar um jogador use /report",
	"Faca missoes no servidor use /missoes",
	"Para ver orgs disponiveis use /orgs",
	"Caso necesita de um atendimento use /atendimento",
	"Mude a forma de falar do seu voip utilizando /mvoip"
};

//                          PUBLICS

CallBack:: EstaSegurandoArmaProibida(playerid)
{
    new idArma = GetPlayerWeapon(playerid);

    for (new i = 0; i < sizeof(ArmaProibidaIDs); i++)
    {
        if (idArma == ArmaProibidaIDs[i])
            return true;
    }

    return false;
}

Progresso:PegandoCaixasP(playerid, progress){
	if(progress >= 100){
		if(CaixaMao[playerid] == false){
			new Float:PosV[3];
			new engine, lights, alarm, doors, bonnet, boot, objective,idv = carID[playerid];
			GetVehicleParamsEx(idv, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(idv, engine, lights, alarm, doors, bonnet, 1, objective);
			GetVehicleTrunkPosition(carID[playerid], PosV[0], PosV[1], PosV[2]);
			TogglePlayerControllable(playerid, 1);
			ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, 1, 1220, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
			SuccesMsg(playerid, "Leve a caixa ate a van.");
			SetPlayerCheckpoint(playerid, PosV[0], PosV[1], PosV[2],1);
			CaixaMao[playerid] = true;
			CaixasSdx[playerid]++;
			DestroyPlayerObject(playerid,CaixasSdxObj[playerid][CaixasSdx[playerid]]); 
		}
	}
	return 1;
}

Progresso:ColocandoCaixa(playerid, progress){
	if(progress >= 100){
		if(CaixasSdx[playerid] == 10){
			SuccesMsg(playerid, "Agora voce deve entrar na van e iniciar as entregas.");
			RemovePlayerAttachedObject(playerid, 1);
			TogglePlayerControllable(playerid, 1);
			ClearAnimations(playerid);
			SetPlayerSpecialAction(playerid, 0);
			new Alt = random(303);
			SetPlayerCheckpoint(playerid, PosRota[Alt][0],PosRota[Alt][1],PosRota[Alt][2], 0.5);
			CaixasSdx[playerid] = 0;
			new engine, lights, alarm, doors, bonnet, boot, objective,idv = carID[playerid];
			GetVehicleParamsEx(idv, engine, lights, alarm, doors, bonnet, boot, objective);
			SetVehicleParamsEx(idv, engine, lights, alarm, doors, bonnet, 0, objective);
		}else{
			switch(CaixasSdx[playerid]){
				case 0:{
					SetPlayerCheckpoint(playerid, 954.7924,1707.8540,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 1:{
					SetPlayerCheckpoint(playerid, 954.7924,1707.8540,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 2:{
					SetPlayerCheckpoint(playerid, 955.9162,1708.0720,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 3:{
					SetPlayerCheckpoint(playerid, 955.9162,1708.0720,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 4:{
					SetPlayerCheckpoint(playerid, 956.8380,1708.0153,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 5:{
					SetPlayerCheckpoint(playerid, 956.8380,1708.0153,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 6:{
					SetPlayerCheckpoint(playerid, 957.9166,1708.4794,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 7:{
					SetPlayerCheckpoint(playerid, 957.9166,1708.4794,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 8:{
					SetPlayerCheckpoint(playerid, 958.5190,1708.7068,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
				case 9:{
					SetPlayerCheckpoint(playerid, 958.5190,1708.7068,8.6484, 1);
					EntregaSdx[playerid] = true;
				}
			}
			SuccesMsg(playerid, "Pegue a proxima caixa e leve ate a van.");
			RemovePlayerAttachedObject(playerid, 1);
			TogglePlayerControllable(playerid, 1);
			ClearAnimations(playerid);
			SetPlayerSpecialAction(playerid, 0);
			
		}
	}
	return 1;
}

Progresso:DominarLBarragem(playerid, progress)
{
	if(progress >= 100)
	{
		if(IsPlayerInPlace(playerid,-1434.2429809570312, 1902.6701049804688, -987.2429809570312, 2672.6701049804688))
		{
			if(IsPolicial(playerid))
	        {
	        	GangZoneHideForAll(Barragem);
		        GangZoneShowForAll(Barragem,0x328fc00);
		        SuccesMsg(playerid, "O local foi pacificado.");
		        GuerraBarragem = 1;
	        }
	        else if(PlayerInfo[playerid][Org] == 5)
	        {
	        	GangZoneHideForAll(Barragem);
	            GangZoneShowForAll(Barragem,0xfcf00300);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraBarragem = 5;
	        }
	        else if(PlayerInfo[playerid][Org] == 6)
	        {
	        	GangZoneHideForAll(Barragem);
	            GangZoneShowForAll(Barragem,0x0398fc00);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraBarragem = 6;
	        }
	        else if(PlayerInfo[playerid][Org] == 7)
	        {
	        	GangZoneHideForAll(Barragem);
	            GangZoneShowForAll(Barragem,0xfc030300);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraBarragem = 7;
	        }
	        else if(PlayerInfo[playerid][Org] == 8)
	        {
	        	GangZoneHideForAll(Barragem);
	            GangZoneShowForAll(Barragem,0x13fc0300);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraBarragem = 8;
	        }
	        else if(PlayerInfo[playerid][Org] == 12)
	        {
	        	GangZoneHideForAll(Barragem);
	            GangZoneShowForAll(Barragem,0xe3a65600);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraBarragem = 12;
	        }
	        else if(PlayerInfo[playerid][Org] == 13)
	        {
	        	GangZoneHideForAll(Barragem);
	            GangZoneShowForAll(Barragem,0x59422500);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraBarragem = 13;
	        }
	        SalvarGZ();
	    }
	    else
	    {
	    	ErrorMsg(playerid, "Voce saiu da gangzone");
	    }
	}
}

Progresso:DominarLParabolica(playerid, progress)
{
	if(progress >= 100)
	{
		if(IsPlayerInPlace(playerid,-460.22906494140625, 1281.9999694824219, -140.22906494140625, 1643.9999694824219))
		{
			if(IsPolicial(playerid))
	        {
	        	GangZoneHideForAll(Parabolica);
		        GangZoneShowForAll(Parabolica,0x328fc00);
		        SuccesMsg(playerid, "O local foi pacificado.");
		        GuerraParabolica = 1;
	        }
	        else if(PlayerInfo[playerid][Org] == 5)
	        {
	        	GangZoneHideForAll(Parabolica);
	            GangZoneShowForAll(Parabolica,0xfcf00300);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraParabolica = 5;
	        }
	        else if(PlayerInfo[playerid][Org] == 6)
	        {
	        	GangZoneHideForAll(Parabolica);
	            GangZoneShowForAll(Parabolica,0x0398fc00);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraParabolica = 6;
	        }
	        else if(PlayerInfo[playerid][Org] == 7)
	        {
	        	GangZoneHideForAll(Parabolica);
	            GangZoneShowForAll(Parabolica,0xfc030300);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraParabolica = 7;
	        }
	        else if(PlayerInfo[playerid][Org] == 8)
	        {
	        	GangZoneHideForAll(Parabolica);
	            GangZoneShowForAll(Parabolica,0x13fc0300);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraParabolica = 8;
	        }
	        else if(PlayerInfo[playerid][Org] == 12)
	        {
	        	GangZoneHideForAll(Parabolica);
	            GangZoneShowForAll(Parabolica,0xe3a65600);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraParabolica = 12;
	        }
	        else if(PlayerInfo[playerid][Org] == 13)
	        {
	        	GangZoneHideForAll(Parabolica);
	            GangZoneShowForAll(Parabolica,0x59422500);
	            SuccesMsg(playerid, "O local foi dominado.");
	            GuerraParabolica = 13;
	        }
	        SalvarGZ();
	    }
	    else
	    {
	    	ErrorMsg(playerid, "Voce saiu da gangzone");
	    }
	}
}

CallBack::AChatAtendimento(COLOR,const string[],level)
{
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
		    if(NumeroChatAtendimento[i] == level)
		    {
				if (ChatAtendimento[i] > 0)
				{
					SendClientMessage(i, COLOR, string);
				}
			}
		}
	}
	return 1;
}

CallBack::TxdLogin(playerid)
{
	for(new i = 0; i < 23; ++i)
	{
		PlayerTextDrawHide(playerid, Registration_PTD[playerid][i]);	
	}
	for(new i = 0; i < 7; i ++)
	{
		PlayerTextDrawShow(playerid, HudServer_p[playerid][i]);
	}
	for(new i = 0; i < 17; i ++)
	{
		TextDrawShowForPlayer(playerid, HudServer[i]);
	}
}
//------------- Sistema de Easter Eggs ------------------
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

createEE(eeid, descricao[], modelid, Float:range, Float:x, Float:y, Float:z, Float:rx, Float:ry, Float:rz){

	static
		Str2[98]
	;

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

loadEE(){

	static
	    string[70],
	    Str2[79]
	;

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

saveEE(){

	static
	        string[70]
	;

	if(!DOF2_FileExists(Pasta_Eastereggs))DOF2_CreateFile(Pasta_Eastereggs);

	for(new e; e != MAX_EASTER_EGGS; e++){

	    format(string, sizeof string, "%d_descoberto", e);
     	DOF2_SetBool(Pasta_Eastereggs, string, EEInfo[e][eaDescoberto]);
	    format(string, sizeof string, "%d_nick", e);
        DOF2_SetString(Pasta_Eastereggs, string, EEInfo[e][eaNick]);
	}
	DOF2_SaveFile();
}

descobrirEE(playerid, eeid){

	static string[1000];
	new kaka = randomEx(0,10);
	if(kaka == 6)
	{
		PlayerInfo[playerid][pCoins] += 3000;
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou 3mil coins!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 5)
	{
		PlayerInfo[playerid][pCoins] += 6000;
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou 6mil coins!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 4)
	{
		PlayerInfo[playerid][pDinheiro] += 3000;
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou 3mil reais!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 3)
	{
		PlayerInfo[playerid][pDinheiro] += 6000;
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou 6mil reais!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 8)
	{
		new vip[255];
		PlayerInfo[playerid][ExpiraVIP] = ConvertDays(10); 
		PlayerInfo[playerid][pVIP] = 1;
		format(vip, sizeof(vip), PASTA_VIPS, Name(playerid)); 
		DOF2_CreateFile(vip); 
		DOF2_SetInt(vip,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
		DOF2_SaveFile(); 
		SuccesMsg(playerid, "Comprou um vip e recebeu seus beneficios.");
		new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
		format(vip,sizeof(vip),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP BASICO\nValor: 10000", PlayerInfo[playerid][IDF]);
		DCC_SetEmbedColor(embed, 0xFFFF00);
		DCC_SetEmbedDescription(embed, vip);
		DCC_SendChannelEmbedMessage(VIPAtivado, embed);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou 10d de VIP BASICO!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 9)
	{
		new vip[255];
		PlayerInfo[playerid][ExpiraVIP] = ConvertDays(30); 
		PlayerInfo[playerid][pVIP] = 1;
		format(vip, sizeof(vip), PASTA_VIPS, Name(playerid)); 
		DOF2_CreateFile(vip); 
		DOF2_SetInt(vip,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
		DOF2_SaveFile(); 
		new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
		format(vip,sizeof(vip),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP BASICO\nValor: 10000", PlayerInfo[playerid][IDF]);
		DCC_SetEmbedColor(embed, 0xFFFF00);
		DCC_SetEmbedDescription(embed, vip);
		DCC_SendChannelEmbedMessage(VIPAtivado, embed);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou 10d de VIP BASICO!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 0)
	{
		GanharItem(playerid, 560, 1);
		new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
		format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: Sultan", PlayerInfo[playerid][IDF]);
		DCC_SetEmbedColor(embed, 0xFFFF00);
		DCC_SetEmbedDescription(embed, string);
		DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_560.jpg");
		DCC_SendChannelEmbedMessage(VIPAtivado, embed);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou um SULTAN de inventario!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 10)
	{
		GanharItem(playerid, 434, 1);
		new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
		format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: HotKnife", PlayerInfo[playerid][IDF]);
		DCC_SetEmbedColor(embed, 0xFFFF00);
		DCC_SetEmbedDescription(embed, string);
		DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_434.jpg");
		DCC_SendChannelEmbedMessage(VIPAtivado, embed);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou um HOTKNIFE de inventario!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 1)
	{
		new vip[255];
		new daysvip = randomEx(3,30);
		PlayerInfo[playerid][ExpiraVIP] = ConvertDays(daysvip); 
		PlayerInfo[playerid][pVIP] = 1;
		format(vip, sizeof(vip), PASTA_VIPS, Name(playerid)); 
		DOF2_CreateFile(vip); 
		DOF2_SetInt(vip,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
		DOF2_SaveFile(); 
		new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
		format(vip,sizeof(vip),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP BASICO\nValor: 10000", PlayerInfo[playerid][IDF]);
		DCC_SetEmbedColor(embed, 0xFFFF00);
		DCC_SetEmbedDescription(embed, vip);
		DCC_SendChannelEmbedMessage(VIPAtivado, embed);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou VIP BASICO!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 7)
	{
		new qds = randomEx(1000, 50000);
		GanharItem(playerid, 1212, qds);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou dinheiro sujo!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	if(kaka == 2)
	{
		new qds = randomEx(1000, 10000);
		GanharItem(playerid, 1212, qds);
		format(string, sizeof string, "%04d acaba de descobrir ''%s'' ganhou dinheiro sujo!", PlayerInfo[playerid][IDF], EEInfo[eeid][eaDescricao]);
		SendClientMessageToAll(0xFFFF99FF, string);
	}
	EEInfo[eeid][eaDescoberto] = true;
	format(EEInfo[eeid][eaNick], 24, Name(playerid));
	DestroyDynamic3DTextLabel(EEInfo[eeid][eaText]);
	format(string, sizeof string, "''%s''{FFFFFF}\nDescoberto por %s", EEInfo[eeid][eaDescricao], EEInfo[eeid][eaNick]);
	EEInfo[eeid][eaText] = CreateDynamic3DTextLabel(string, 0xFFA500AA, EEInfo[eeid][eaX], EEInfo[eeid][eaY], EEInfo[eeid][eaZ], EEInfo[eeid][eaRange]);
	saveEE();
}

checkEE(playerid){

	for(new e; e != MAX_EASTER_EGGS; e++){

	    if(IsPlayerInRangeOfPoint(playerid, EEInfo[e][eaRange], EEInfo[e][eaX], EEInfo[e][eaY], EEInfo[e][eaZ]) && !EEInfo[e][eaDescoberto]){

	        descobrirEE(playerid, e);
	    }
	}

	return 0;
}

CMD:halloween(playerid){

	MEGAString[0] = EOS;

	static
		Str2[128]
	;
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

	ShowPlayerDialog(playerid, 8764, DIALOG_STYLE_TABLIST_HEADERS, "Encontre os HALLOWEEN EVENT", MEGAString, "Localizar", "Sair");
	return 1;
}

new bool:pulou2vezes[MAX_PLAYERS] = false;
CallBack::ResetarPulo(playerid)
{
	pulou2vezes[playerid] = false;
}

CreateLocPick(playerid)
{
	ApplyAnimation(playerid, "INT_HOUSE", "WASH_UP", 4.1, 1, 0, 0, 0, 2000, 1), LockLocation[playerid] = randomEx(243, 423), LockSize[playerid] = randomEx(2, 10), LockTimer[playerid] = SetTimerEx("LockpickTimer", 30, true, "i", playerid);
	LockText[8] = CreatePlayerTextDraw(playerid, LockLocation[playerid], 385.0, "_"), PlayerTextDrawUseBox(playerid, LockText[8], 1);
	PlayerTextDrawLetterSize(playerid, LockText[8], 0.5, 1.4), PlayerTextDrawTextSize(playerid, LockText[8], LockLocation[playerid]+LockSize[playerid], 71.0);
	PlayerTextDrawFont(playerid, LockText[8], 1), PlayerTextDrawSetProportional(playerid, LockText[8], 1);
	PlayerTextDrawBackgroundColor(playerid, LockText[8], 255), PlayerTextDrawBoxColor(playerid, LockText[8], -1094795521);
	
	LockText[9] = CreatePlayerTextDraw(playerid, 207.0, 385.0, "_"), PlayerTextDrawUseBox(playerid, LockText[9], 1);
	PlayerTextDrawLetterSize(playerid, LockText[9], 0.5, 1.4), PlayerTextDrawTextSize(playerid, LockText[9], 207.0, 71.0);
	PlayerTextDrawFont(playerid, LockText[9], 1), PlayerTextDrawSetProportional(playerid, LockText[9], 1);
	PlayerTextDrawBackgroundColor(playerid, LockText[9], 255), PlayerTextDrawBoxColor(playerid, LockText[9], -5963521);

	LockText[10] = CreatePlayerTextDraw(playerid, 315.0, 386.0, "Pressione (ESPACO) na barra para prosseguir"), PlayerTextDrawSetShadow(playerid, LockText[10], 0);
	PlayerTextDrawBackgroundColor(playerid, LockText[10], 255), PlayerTextDrawLetterSize(playerid, LockText[10], 0.18, 1.0);
	PlayerTextDrawFont(playerid, LockText[10], 2), PlayerTextDrawSetProportional(playerid, LockText[10], 1);
	PlayerTextDrawAlignment(playerid, LockText[10], 2), PlayerTextDrawSetShadow(playerid, LockText[10], 0), PlayerTextDrawColor(playerid, LockText[10], -56);
	return 1;
}
CallBack:: LockpickTimer(playerid)
{
	LockProgress = LockProgress+4, PlayerTextDrawTextSize(playerid, LockText[9], LockProgress, 71.0);
	for(new i; i < 12; i++) { PlayerTextDrawShow(playerid, LockText[i]); }
	if(LockCount[playerid] < 4 && LockProgress > 428.9) return PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA), DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
	if(LockCount[playerid] == 4 && LockProgress > 428.9)
	{
		PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA), PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);
    	if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], 1, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), InfoMsg(playerid, "A lockpick quebrou e acionou o alarme");
		if(DoorsLockPick[playerid] == 0) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 1, Bonnet[playerid], Boot[playerid], Objective[playerid]), InfoMsg(playerid, "A lockpick quebrou!"), Correct[playerid] = 0;
		SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 0, Bonnet[playerid], Boot[playerid], Objective[playerid]), SuccesMsg(playerid, "O veiculo foi aberto!"), Correct[playerid] = 0;
	}
	return 1;
}
CallBack:: DestroyLockPick(playerid)
{
    PlayerTextDrawDestroy(playerid, LockText[8]), PlayerTextDrawDestroy(playerid, LockText[9]), PlayerTextDrawDestroy(playerid, LockText[10]);
    if(LockCount[playerid] == 4)
    {
		PlayerTextDrawColor(playerid, LockText[2], 1768516095), PlayerTextDrawColor(playerid, LockText[3], 1768516095), PlayerTextDrawColor(playerid, LockText[4], 1768516095), PlayerTextDrawColor(playerid, LockText[5], 1768516095), PlayerTextDrawColor(playerid, LockText[6], 1768516095);
		LockUse[playerid] = false, LockProgress = 207.0, Correct[playerid] = 0, LockCount[playerid] = 0;
		for(new i; i < 12; i++) { PlayerTextDrawHide(playerid, LockText[i]); }
	}
	return 0;
}

CallBack::TimerAn()
{
	for(new i, j = GetPlayerPoolSize(); i <= j; i++)
	{
	    if(IsPlayerConnected(i) && TiempoAnuncio[i] > 0) TiempoAnuncio[i] --;
	}
	return true;
}
XP_::XP_Hide(playerid)
{
    for(new i; i < 20; i++)
    {
        PlayerTextDrawHide(playerid, XPTXD[playerid][i]);
    }
    PlayerPlaySound(playerid, 6402, 0.0, 0.0, 0.0);
}

Progresso:DesmancharVeh(playerid, progress)
{
	if(progress >= 100)
	{
		new vehicleidd = GetPlayerVehicleID(playerid);
		new vehicleid = GetPVarInt(playerid, "DialogValue1");	
		new value = VehicleValue[vehicleid]/3;
		new a[255];
		new noti = randomEx(0, 2);
		format(a, 255, "Veiculo desmanchado com sucesso e ganhou %s de dinheiro sujo", ConvertMoney(value));
		SuccesMsg(playerid, a);
		new location[MAX_ZONE_NAME];
		GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);
		if(noti == 1)
		{
			foreach(Player, i)
			{
				if(Patrulha[i] == true)
				{
					format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo desmanchando um veiculo em %s", location);
					WarningMsg(i, Str);
				}
			}
		}
		GanharItem(playerid, 1212, value);
		RemovePlayerFromVehicle(playerid);
		DestroyVehicle(vehicleidd);
		Controle(playerid, 1);
	}
}

Progresso:RepararVeh(playerid, progress)
{
	if(progress >= 100)
	{
		new wVeiculo = GetPlayerVehicleID(playerid);
		SuccesMsg(playerid, "Veiculo reparado.");
		RepairVehicle(wVeiculo);
		SetVehicleHealth(wVeiculo, 1000.0);
		TogglePlayerControllable(playerid, 1);
	}
	return 1;
}
Progresso:DescarregarCarga(playerid, progress)
{
	if(progress >= 100)
	{
		if(PlayerToPoint(3.0, playerid, -225.2885,-209.2343,2.0181))
		{
			Cargase[playerid] = false;
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2100;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$2100.");
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2100*2;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$4200.");
			}
			DisablePlayerCheckpoint(playerid);
			Carregou[playerid] = 0;
		}
		if(PlayerToPoint(3.0, playerid, 219.3734,9.5520,3.1495))
		{
			Cargase[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2150;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$2150.");
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2150*2;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$4300.");
			}
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DisablePlayerCheckpoint(playerid);
			Carregou[playerid] = 0;
		}
		if(PlayerToPoint(3.0, playerid, 1338.3881,286.8327,20.1563))
		{
			Cargase[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2150;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$2150.");
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2150*2;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$4300.");
			}
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DisablePlayerCheckpoint(playerid);
			Carregou[playerid] = 0;
		}
		if(PlayerToPoint(3.0, playerid, 1635.2142,2192.1284,11.4099))
		{
			Cargase[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2400;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$2400.");
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2400*2;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$4800.");
			}
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DisablePlayerCheckpoint(playerid);
			Carregou[playerid] = 0;
				
		}
		if(PlayerToPoint(3.0, playerid, -1934.6858,259.0710,41.6420))
		{
			Cargase[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2500; 
				SuccesMsg(playerid, "Entregou a carga e ganhou R$2500.");
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2500*2;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$5000.");
			}
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DisablePlayerCheckpoint(playerid);
			Carregou[playerid] = 0;
		}
		if(PlayerToPoint(3.0, playerid, -1823.9757,54.3441,15.1228))
		{
			Cargase[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2250;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$2250.");
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2250*2;
				SuccesMsg(playerid, "Entregou a carga e ganhou R$4500.");
			}
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DisablePlayerCheckpoint(playerid);	
			Carregou[playerid] = 0;
		}
		TogglePlayerControllable(playerid, 1);
	}
	return 1;
}

Progresso:RotaCova1(playerid, progress)
{
	if(progress >= 100)
	{
		CargoTumba[playerid] = 1;
		TogglePlayerControllable(playerid, 1);
		SetPlayerCheckpoint(playerid, 934.1115,-1103.3857,24.3118, 10);
		InfoMsg(playerid, "Pegou um cadaver volte ao cemiterio.");
	}
	return 1;
}

Progresso:RotaCova2(playerid, progress)
{
	if(progress >= 100)
	{
		CargoTumba[playerid] = 2;
		TogglePlayerControllable(playerid, 1);
		SetPlayerCheckpoint(playerid, 934.1115,-1103.3857,24.3118, 10);
		InfoMsg(playerid, "Pegou um cadaver volte ao cemiterio.");
	}
	return 1;
}

Progresso:RotaCova3(playerid, progress)
{
	if(progress >= 100)
	{
		CargoTumba[playerid] = 3;
		TogglePlayerControllable(playerid, 1);
		SetPlayerCheckpoint(playerid, 934.1115,-1103.3857,24.3118, 10);
		InfoMsg(playerid, "Pegou um cadaver volte ao cemiterio.");
	}
	return 1;
}

Progresso:BotouBau(playerid, progress)
{
	if(progress >= 100)
	{
		new covastr[255];
		new dincova = random(100);
		if(PlayerInfo[playerid][pVIP] >= 1)
		{
			PlayerInfo[playerid][pDinheiro] += dincova*2;
			format(covastr,sizeof(covastr),"Ganhou %s coletando esse lixo.", ConvertMoney(dincova*2));
			SuccesMsg(playerid, covastr);
		}else{
			PlayerInfo[playerid][pDinheiro] += dincova;
			format(covastr,sizeof(covastr),"Ganhou %s coletando esse lixo.", ConvertMoney(dincova));
			SuccesMsg(playerid, covastr);
		}
		RemovePlayerAttachedObject(playerid, 5);
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, 1);
		PegouLixo[playerid] = false;
		SetTimerEx("ExpireAntComannd",5000,false,"i",playerid);
	}
	return 1;
}
Progresso:Cova(playerid, progress)
{
	if(progress >= 100)
	{
		new locallixo = random(10);
		switch(locallixo){
			case 0:{
				SetPlayerCheckpoint(playerid, 24.118854, 1384.762695, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 1:{
				SetPlayerCheckpoint(playerid, 24.118854, 1384.762695, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 2:{
				SetPlayerCheckpoint(playerid, 20.505460, 1387.800292, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 3:{
				SetPlayerCheckpoint(playerid, 33.100147, 1348.264160, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 4:{
				SetPlayerCheckpoint(playerid, 30.621374, 1345.285400, 9.171875, 1);
			InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 5:{
				SetPlayerCheckpoint(playerid, 28.793310, 1342.226318, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 6:{
				SetPlayerCheckpoint(playerid, 27.303512, 1339.422729, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 7:{
				SetPlayerCheckpoint(playerid, 26.155256, 1337.490844, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 8:{
				SetPlayerCheckpoint(playerid, 23.932958, 1336.910034, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 9:{
				SetPlayerCheckpoint(playerid, 21.434928, 1335.923828, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
			case 10:{
				SetPlayerCheckpoint(playerid, 18.442813, 1334.873413, 9.171875, 1);
				InfoMsg(playerid, "Leve o lixo ate o bau.");
			}
		}
		TogglePlayerControllable(playerid, 1);
		SetPlayerAttachedObject(playerid, 5, 1265, 5);
		PegouLixo[playerid] = true;
		Covaconcerto[playerid] = false;
	}
	return 1;
}

Progresso:Desossar(playerid, progress)
{
	if(progress >= 100)
	{
		ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
		SetPlayerAttachedObject(playerid, 1, 2804, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
		Desossando[playerid] = 1;
		UsouCMD[playerid] = false;
		TogglePlayerControllable(playerid, 1);
		InfoMsg(playerid, "Terminou de desossar a carne, faca o processamento dela.");
	}
	return 1;
}
Progresso:Minerar(playerid, progress)
{
	if(progress >= 100)
	{
		new mineiro = randomEx(0,3);
		new checkfinal = randomEx(1,2);
		ClearAnimations(playerid);
		if(mineiro == 0)
		{
			ErrorMsg(playerid, "Encontrou nenhum minerio.");
		}
		if(mineiro == 1)
		{
			if(checkfinal == 1)
			{
				SetPlayerCheckpoint(playerid, 693.332824, 844.813354, -26.768863, 1.0);
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 1, 2936, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
				EtapasMinerador[playerid] = 2;
				InfoMsg(playerid, "Encontrou um minerio, entregue no ponto marcado.");
			}
			if(checkfinal == 2)
			{
				SetPlayerCheckpoint(playerid, 681.241149, 823.651245, -26.795570, 1.0);
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 1, 2936, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
				EtapasMinerador[playerid] = 2;
				InfoMsg(playerid, "Encontrou um minerio, entregue no ponto marcado.");
			}
			
		}
		if(mineiro == 2)
		{
			if(checkfinal == 1)
			{
				SetPlayerCheckpoint(playerid, 693.332824, 844.813354, -26.768863, 1.0);
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 1, 1303, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
				EtapasMinerador[playerid] = 2;
				InfoMsg(playerid, "Encontrou um minerio, entregue no ponto marcado.");
			}
			if(checkfinal == 2)
			{
				SetPlayerCheckpoint(playerid, 681.241149, 823.651245, -26.795570, 1.0);
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 1, 1303, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
				EtapasMinerador[playerid] = 2;
				InfoMsg(playerid, "Encontrou um minerio, entregue no ponto marcado.");
			}
			
		}
		if(mineiro == 3)
		{
			if(checkfinal == 1)
			{
				SetPlayerCheckpoint(playerid, 693.332824, 844.813354, -26.768863, 1.0);
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 1, 828, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
				EtapasMinerador[playerid] = 2;
				InfoMsg(playerid, "Encontrou um minerio, entregue no ponto marcado.");
			}
			if(checkfinal == 2)
			{
				SetPlayerCheckpoint(playerid, 681.241149, 823.651245, -26.795570, 1.0);
				ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
				SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
				SetPlayerAttachedObject(playerid, 1, 828, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
				EtapasMinerador[playerid] = 2;
				InfoMsg(playerid, "Encontrou um minerio, entregue no ponto marcado.");
			}
			
		}
		UsouCMD[playerid] = false;
		TogglePlayerControllable(playerid, 1);
	}
	return 1;
}
Progresso:Pesca(playerid, progress)
{
	if(progress == 1)
	{ 
		// EM PROGRESSO
	}
	if(progress >= 100)
	{
		new peixes = randomEx(1,5);
		new peixe = randomEx(0,6);
		new s[255];
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 383.2907,-2088.7842,7.8359))
		if(peixe == 0)
		{
			GanharItem(playerid,902, peixes);
			format(s,sizeof(s),"Pescou %i estrela do mar.",peixes);
			SuccesMsg(playerid, s);
		}
		if(peixe == 3)
		{
			GanharItem(playerid,19630, peixes);
			format(s,sizeof(s),"Pescou %i peixe tilapia.",peixes);
			SuccesMsg(playerid, s);
		}
		if(peixe == 2)
		{
			GanharItem(playerid,1599, peixes);
			format(s,sizeof(s),"Pescou %i peixe amarelo.",peixes);
			SuccesMsg(playerid, s);
		}
		if(peixe == 4)
		{
			GanharItem(playerid,1600, peixes);
			format(s,sizeof(s),"Pescou %i peixe azul.",peixes);
			SuccesMsg(playerid, s);
		}
		if(peixe == 6)
		{
			GanharItem(playerid,1603, peixes);
			format(s,sizeof(s),"Pescou %i agua viva.",peixes);
			SuccesMsg(playerid, s);
		}
		if(peixe == 5)
		{
			GanharItem(playerid,1604, peixes);
			format(s,sizeof(s),"Pescou %i peixe rain.",peixes);
			SuccesMsg(playerid, s);
		}
		if(peixe == 1)
		{
			GanharItem(playerid,1608, peixes);
			format(s,sizeof(s),"Pescou %i tubarao.",peixes);
			SuccesMsg(playerid, s);
		}
		TogglePlayerControllable(playerid, 1);
		UsouCMD[playerid] = false;
	}
	return 1;
}

CallBack::criandorg(playerid){
	SuccesMsg(playerid, "Acabou de receber seus documentos, verifique seu inventario.");	
	PlayerInfo[playerid][pRG] = 1;
	ShowPlayerDialog(playerid, DIALOG_RG5, DIALOG_STYLE_MSGBOX, "EMITIR RG", "{00FF00}PARABENS!\n{FFFFFF}Seu RG foi emitido com sucesso.\nUse /rg para ver seu rg.", "Ok", "");
	return 1;
}

CallBack::AntiSpam(playerid) 
{
	RecentlyShot[playerid] = 0;
	return 1;
}
CallBack::ExpireAntComannd(playerid){
	if(Podecmd[playerid] == false){
		Podecmd[playerid] = true;
	}
	return 1;
}

CallBack::AttCad(playerid){
	if(MostrandoMenu[playerid] == true){
		if(Page[playerid] == 1){
			Preview[playerid][0] = 1;
			Preview[playerid][1] = 2;
			Preview[playerid][2] = 3;
			Preview[playerid][3] = 4;
			Preview[playerid][4] = 5;
			Preview[playerid][5] = 6;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 2){
			Preview[playerid][0] = 7;
			Preview[playerid][1] = 8;
			Preview[playerid][2] = 9;
			Preview[playerid][3] = 10;
			Preview[playerid][4] = 11;
			Preview[playerid][5] = 12;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 3){
			Preview[playerid][0] = 13;
			Preview[playerid][1] = 14;
			Preview[playerid][2] = 15;
			Preview[playerid][3] = 16;
			Preview[playerid][4] = 17;
			Preview[playerid][5] = 18;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 4){
			Preview[playerid][0] = 19;
			Preview[playerid][1] = 20;
			Preview[playerid][2] = 21;
			Preview[playerid][3] = 22;
			Preview[playerid][4] = 23;
			Preview[playerid][5] = 24;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 5){
			Preview[playerid][0] = 25;
			Preview[playerid][1] = 26;
			Preview[playerid][2] = 27;
			Preview[playerid][3] = 28;
			Preview[playerid][4] = 29;
			Preview[playerid][5] = 30;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 6){
			Preview[playerid][0] = 31;
			Preview[playerid][1] = 32;
			Preview[playerid][2] = 33;
			Preview[playerid][3] = 34;
			Preview[playerid][4] = 35;
			Preview[playerid][5] = 36;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 7){
			Preview[playerid][0] = 37;
			Preview[playerid][1] = 38;
			Preview[playerid][2] = 39;
			Preview[playerid][3] = 40;
			Preview[playerid][4] = 41;
			Preview[playerid][5] = 42;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 8){
			Preview[playerid][0] = 43;
			Preview[playerid][1] = 44;
			Preview[playerid][2] = 45;
			Preview[playerid][3] = 46;
			Preview[playerid][4] = 47;
			Preview[playerid][5] = 48;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 9){
			Preview[playerid][0] = 49;
			Preview[playerid][1] = 50;
			Preview[playerid][2] = 51;
			Preview[playerid][3] = 52;
			Preview[playerid][4] = 53;
			Preview[playerid][5] = 54;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 10){
			Preview[playerid][0] = 55;
			Preview[playerid][1] = 56;
			Preview[playerid][2] = 57;
			Preview[playerid][3] = 58;
			Preview[playerid][4] = 59;
			Preview[playerid][5] = 60;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 11){
			Preview[playerid][0] = 61;
			Preview[playerid][1] = 62;
			Preview[playerid][2] = 63;
			Preview[playerid][3] = 64;
			Preview[playerid][4] = 65;
			Preview[playerid][5] = 66;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 12){
			Preview[playerid][0] = 67;
			Preview[playerid][1] = 68;
			Preview[playerid][2] = 69;
			Preview[playerid][3] = 70;
			Preview[playerid][4] = 71;
			Preview[playerid][5] = 72;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 13){
			Preview[playerid][0] = 73;
			Preview[playerid][1] = 74;
			Preview[playerid][2] = 75;
			Preview[playerid][3] = 76;
			Preview[playerid][4] = 77;
			Preview[playerid][5] = 78;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 14){
			Preview[playerid][0] = 79;
			Preview[playerid][1] = 80;
			Preview[playerid][2] = 81;
			Preview[playerid][3] = 82;
			Preview[playerid][4] = 83;
			Preview[playerid][5] = 84;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 15){
			Preview[playerid][0] = 85;
			Preview[playerid][1] = 86;
			Preview[playerid][2] = 87;
			Preview[playerid][3] = 88;
			Preview[playerid][4] = 89;
			Preview[playerid][5] = 90;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 16){
			Preview[playerid][0] = 91;
			Preview[playerid][1] = 92;
			Preview[playerid][2] = 93;
			Preview[playerid][3] = 94;
			Preview[playerid][4] = 95;
			Preview[playerid][5] = 96;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 17){
			Preview[playerid][0] = 97;
			Preview[playerid][1] = 98;
			Preview[playerid][2] = 99;
			Preview[playerid][3] = 100;
			Preview[playerid][4] = 101;
			Preview[playerid][5] = 102;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 18){
			Preview[playerid][0] = 103;
			Preview[playerid][1] = 104;
			Preview[playerid][2] = 105;
			Preview[playerid][3] = 106;
			Preview[playerid][4] = 107;
			Preview[playerid][5] = 108;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 19){
			Preview[playerid][0] = 109;
			Preview[playerid][1] = 110;
			Preview[playerid][2] = 111;
			Preview[playerid][3] = 112;
			Preview[playerid][4] = 113;
			Preview[playerid][5] = 114;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 20){
			Preview[playerid][0] = 115;
			Preview[playerid][1] = 116;
			Preview[playerid][2] = 117;
			Preview[playerid][3] = 118;
			Preview[playerid][4] = 119;
			Preview[playerid][5] = 120;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 21){
			Preview[playerid][0] = 121;
			Preview[playerid][1] = 122;
			Preview[playerid][2] = 123;
			Preview[playerid][3] = 124;
			Preview[playerid][4] = 125;
			Preview[playerid][5] = 126;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 22){
			Preview[playerid][0] = 127;
			Preview[playerid][1] = 128;
			Preview[playerid][2] = 129;
			Preview[playerid][3] = 130;
			Preview[playerid][4] = 131;
			Preview[playerid][5] = 132;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 23){
			Preview[playerid][0] = 133;
			Preview[playerid][1] = 134;
			Preview[playerid][2] = 135;
			Preview[playerid][3] = 136;
			Preview[playerid][4] = 137;
			Preview[playerid][5] = 138;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 24){
			Preview[playerid][0] = 139;
			Preview[playerid][1] = 140;
			Preview[playerid][2] = 141;
			Preview[playerid][3] = 142;
			Preview[playerid][4] = 143;
			Preview[playerid][5] = 144;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 25){
			Preview[playerid][0] = 145;
			Preview[playerid][1] = 146;
			Preview[playerid][2] = 147;
			Preview[playerid][3] = 148;
			Preview[playerid][4] = 149;
			Preview[playerid][5] = 150;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 26){
			Preview[playerid][0] = 151;
			Preview[playerid][1] = 152;
			Preview[playerid][2] = 153;
			Preview[playerid][3] = 154;
			Preview[playerid][4] = 155;
			Preview[playerid][5] = 156;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 27){
			Preview[playerid][0] = 157;
			Preview[playerid][1] = 158;
			Preview[playerid][2] = 159;
			Preview[playerid][3] = 160;
			Preview[playerid][4] = 161;
			Preview[playerid][5] = 162;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 28){
			Preview[playerid][0] = 163;
			Preview[playerid][1] = 164;
			Preview[playerid][2] = 165;
			Preview[playerid][3] = 166;
			Preview[playerid][4] = 167;
			Preview[playerid][5] = 168;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 29){
			Preview[playerid][0] = 169;
			Preview[playerid][1] = 170;
			Preview[playerid][2] = 171;
			Preview[playerid][3] = 172;
			Preview[playerid][4] = 173;
			Preview[playerid][5] = 174;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 30){
			Preview[playerid][0] = 175;
			Preview[playerid][1] = 176;
			Preview[playerid][2] = 177;
			Preview[playerid][3] = 178;
			Preview[playerid][4] = 179;
			Preview[playerid][5] = 180;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 31){
			Preview[playerid][0] = 181;
			Preview[playerid][1] = 182;
			Preview[playerid][2] = 183;
			Preview[playerid][3] = 184;
			Preview[playerid][4] = 185;
			Preview[playerid][5] = 186;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 32){
			Preview[playerid][0] = 187;
			Preview[playerid][1] = 188;
			Preview[playerid][2] = 189;
			Preview[playerid][3] = 190;
			Preview[playerid][4] = 191;
			Preview[playerid][5] = 192;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 33){
			Preview[playerid][0] = 193;
			Preview[playerid][1] = 194;
			Preview[playerid][2] = 195;
			Preview[playerid][3] = 196;
			Preview[playerid][4] = 197;
			Preview[playerid][5] = 198;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 34){
			Preview[playerid][0] = 199;
			Preview[playerid][1] = 200;
			Preview[playerid][2] = 201;
			Preview[playerid][3] = 202;
			Preview[playerid][4] = 203;
			Preview[playerid][5] = 204;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 35){
			Preview[playerid][0] = 205;
			Preview[playerid][1] = 206;
			Preview[playerid][2] = 207;
			Preview[playerid][3] = 208;
			Preview[playerid][4] = 209;
			Preview[playerid][5] = 210;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 36){
			Preview[playerid][0] = 212;
			Preview[playerid][1] = 213;
			Preview[playerid][2] = 214;
			Preview[playerid][3] = 215;
			Preview[playerid][4] = 216;
			Preview[playerid][5] = 218;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 37){
			Preview[playerid][0] = 219;
			Preview[playerid][1] = 220;
			Preview[playerid][2] = 221;
			Preview[playerid][3] = 222;
			Preview[playerid][4] = 223;
			Preview[playerid][5] = 224;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 38){
			Preview[playerid][0] = 225;
			Preview[playerid][1] = 226;
			Preview[playerid][2] = 227;
			Preview[playerid][3] = 228;
			Preview[playerid][4] = 229;
			Preview[playerid][5] = 230;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 39){
			Preview[playerid][0] = 231;
			Preview[playerid][1] = 232;
			Preview[playerid][2] = 233;
			Preview[playerid][3] = 234;
			Preview[playerid][4] = 235;
			Preview[playerid][5] = 236;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 40){
			Preview[playerid][0] = 237;
			Preview[playerid][1] = 238;
			Preview[playerid][2] = 239;
			Preview[playerid][3] = 240;
			Preview[playerid][4] = 241;
			Preview[playerid][5] = 242;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 41){
			Preview[playerid][0] = 243;
			Preview[playerid][1] = 244;
			Preview[playerid][2] = 245;
			Preview[playerid][3] = 246;
			Preview[playerid][4] = 247;
			Preview[playerid][5] = 248;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 42){
			Preview[playerid][0] = 249;
			Preview[playerid][1] = 250;
			Preview[playerid][2] = 251;
			Preview[playerid][3] = 252;
			Preview[playerid][4] = 253;
			Preview[playerid][5] = 254;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 43){
			Preview[playerid][0] = 255;
			Preview[playerid][1] = 256;
			Preview[playerid][2] = 257;
			Preview[playerid][3] = 258;
			Preview[playerid][4] = 259;
			Preview[playerid][5] = 260;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 44){
			Preview[playerid][0] = 261;
			Preview[playerid][1] = 262;
			Preview[playerid][2] = 263;
			Preview[playerid][3] = 264;
			Preview[playerid][4] = 268;
			Preview[playerid][5] = 269;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}else if(Page[playerid] == 45){
			Preview[playerid][0] = 270;
			Preview[playerid][1] = 271;
			Preview[playerid][2] = 272;
			Preview[playerid][3] = 273;
			Preview[playerid][4] = 289;
			Preview[playerid][5] = 290;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}
		else if(Page[playerid] == 46){
			Page[playerid] = 1;
			Preview[playerid][0] = 291;
			Preview[playerid][1] = 292;
			Preview[playerid][2] = 293;
			Preview[playerid][3] = 294;
			Preview[playerid][4] = 295;
			Preview[playerid][5] = 296;
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
			PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
		}
		for(new i=0;i<7;i++){
			PlayerTextDrawShow(playerid, TDCadastro_p[playerid][i]);
		}
	}else{
		KillTimer(TimerCad[playerid]);
	}
	return 1;
}

CallBack::CANIM(playerid){
	ClearAnimations(playerid);
	return 1;
}

CallBack::Attplayer(playerid)
{
	static str[300];
	if(pJogando[playerid] == false && Falou[playerid] == false && Susurrou[playerid] == false && Gritou[playerid] == false && PlayerMorto[playerid][pEstaMorto] == 1)
	{
		format(str,sizeof(str),"%s\n{FFFFFF}(%04d)",AdminCargo(playerid), PlayerInfo[playerid][IDF]);
	}
	else if(Falou[playerid] == true)
	{
		format(str,sizeof(str),"{FFF000}(%04d)",PlayerInfo[playerid][IDF]);
	}
	else if(Susurrou[playerid] == true)
	{
		format(str,sizeof(str),"{FFF000}(%04d)",PlayerInfo[playerid][IDF]);
	}
	else if(Gritou[playerid] == true)
	{
		format(str,sizeof(str),"{FFF000}(%04d)",PlayerInfo[playerid][IDF]);
	}
	else if(PlayerMorto[playerid][pEstaMorto] == 1)
	{
		format(str,sizeof(str),"{61050b}(FERIDO)\n{FFFFFF}(%04d)",PlayerInfo[playerid][IDF]);
	}
	else
	{
		format(str,sizeof(str),"{FFFFFF}(%04d)",PlayerInfo[playerid][IDF]);
	}
	SetPlayerChatBubble(playerid, str, 0xFFFF00FF, 30.0, 20000);
	return 1;
}

CallBack::attloginname(playerid)
{
	new stringg[50];
	format(stringg, sizeof(stringg), "%s", Name(playerid));
	PlayerTextDrawSetString(playerid, Registration_PTD[playerid][20], stringg);
	PlayerTextDrawSetString(playerid, BancoTD[playerid][12], stringg);
}

GetVehicleModelEx(Model)
{
    switch(Model)
	{
        case 417, 425, 430, 432, 446, 447, 448, 452, 453, 454, 460,
			 461, 462, 463, 464, 465, 468, 469, 471, 472, 473, 476,
			 481, 484, 487, 488, 493, 497, 501, 509, 510, 511, 512,
			 513, 521, 522, 523, 548: return 0;
    }
    return true;
}

TextDrawBase()
{
    wBase[0] = TextDrawCreate(529.000000, 60.000000+50, "_");
	TextDrawBackgroundColor(wBase[0], 255);
	TextDrawFont(wBase[0], 1);
	TextDrawLetterSize(wBase[0], 0.529999, 1.500000);
	TextDrawColor(wBase[0], -1);
	TextDrawSetOutline(wBase[0], 0);
	TextDrawSetProportional(wBase[0], 1);
	TextDrawSetShadow(wBase[0], 1);
	TextDrawUseBox(wBase[0], 1);
	TextDrawBoxColor(wBase[0], 7274495);
	TextDrawTextSize(wBase[0], 110.000000, 0.000000);
	TextDrawSetSelectable(wBase[0], 0);

	wBase[1] = TextDrawCreate(529.000000, 78.000000+50, "_");
	TextDrawBackgroundColor(wBase[1], 255);
	TextDrawFont(wBase[1], 1);
	TextDrawLetterSize(wBase[1], 0.529999, 1.500000);
	TextDrawColor(wBase[1], -1);
	TextDrawSetOutline(wBase[1], 0);
	TextDrawSetProportional(wBase[1], 1);
	TextDrawSetShadow(wBase[1], 1);
	TextDrawUseBox(wBase[1], 1);
	TextDrawBoxColor(wBase[1], 255);
	TextDrawTextSize(wBase[1], 110.000000, 0.000000);
	TextDrawSetSelectable(wBase[1], 0);

	wBase[2] = TextDrawCreate(289.000000, 96.000000+50, "_");
	TextDrawBackgroundColor(wBase[2], 255);
	TextDrawFont(wBase[2], 1);
	TextDrawLetterSize(wBase[2], 0.529999, 26.000001);
	TextDrawColor(wBase[2], -1);
	TextDrawSetOutline(wBase[2], 0);
	TextDrawSetProportional(wBase[2], 1);
	TextDrawSetShadow(wBase[2], 1);
	TextDrawUseBox(wBase[2], 1);
	TextDrawBoxColor(wBase[2], 150);
	TextDrawTextSize(wBase[2], 110.000000, 0.000000);
	TextDrawSetSelectable(wBase[2], 0);

	wBase[3] = TextDrawCreate(297.000000, 61.000000+50, "Tunagem");
	TextDrawBackgroundColor(wBase[3], -65281);
	TextDrawFont(wBase[3], 2);
	TextDrawLetterSize(wBase[3], 0.200000, 1.200000);
	TextDrawColor(wBase[3], -1);
	TextDrawSetOutline(wBase[3], 0);
	TextDrawSetProportional(wBase[3], 1);
	TextDrawSetShadow(wBase[3], 0);
	TextDrawSetSelectable(wBase[3], 0);

}

CallBack::mortoxx(playerid)
{
    if(PlayerMorto[playerid][pEstaMorto] == 1)
    {
        if(PlayerMorto[playerid][pMinMorto] < 0)
        {
            VaiProHospital(playerid);
            PlayerMorto[playerid][pEstaMorto] = 0;
            return 1; 
        }
        PlayerMorto[playerid][pSegMorto]--;
        if(PlayerMorto[playerid][pSegMorto] <= 0)
        {
            PlayerMorto[playerid][pSegMorto] = 60;
            PlayerMorto[playerid][pMinMorto]-= 1;
        }
    
        new Jtempo[90];
        format(Jtempo, sizeof(Jtempo),"~r~%s:%s", ConvertTimeX(PlayerMorto[playerid][pMinMorto]) ,ConvertTimeX(PlayerMorto[playerid][pSegMorto]));
        PlayerTextDrawSetString(playerid,TDmorte_p[playerid][0],Jtempo);
        SetPlayerHealth(playerid, 100);
        SetPlayerPos(playerid, PlayerMorto[playerid][pPosMt1], PlayerMorto[playerid][pPosMt2], PlayerMorto[playerid][pPosMt3]);
        SetPlayerInterior(playerid, PlayerMorto[playerid][pInteriorMxxx]);
        SetPlayerVirtualWorld(playerid, PlayerMorto[playerid][pVirtual]);
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 0, 1, 1, 1, 60000, 1);
        return 1; 
    }else{
        KillTimer(TimerMorto[playerid]);
    }
    return 1; 
}

CallBack::mostrarTelaLogin(playerid)
{
	if(CarregandoTelaLogin[playerid] < 100){
	    CarregandoTelaLogin[playerid]++;
	    new newtext[5];
	    format(newtext, sizeof(newtext), "%d%", CarregandoTelaLogin[playerid]);
	    PlayerTextDrawSetString(playerid, Loadsc_p[playerid][0], newtext);
		SetPlayerProgressBarValue(playerid, Loadsc_b[playerid][0], CarregandoTelaLogin[playerid]);
	    TimerLogin[playerid] = SetTimerEx("mostrarTelaLogin", 100, false, "d", playerid);
	}else{
		for(new t=0;t<17;t++){
			TextDrawHideForPlayer(playerid, Loadsc[t]);
		}
		DestroyPlayerProgressBar(playerid, Loadsc_b[playerid][0]);
		PlayerTextDrawDestroy(playerid, Loadsc_p[playerid][0]);
		KillTimer(TimerLogin[playerid]);
		SetTimerEx("loginp", 40, false, "i", playerid);
	}
	return 1;
}

CallBack::loginp(playerid)
{
	new File[255];
	for(new i = 0; i < 23; ++i)
	{
		PlayerTextDrawShow(playerid, Registration_PTD[playerid][i]);	
	}
	SelectTextDraw(playerid, 1);
	format(File, sizeof(File), PASTA_BANIDOS, Name(playerid));
	if(DOF2_FileExists(File))
	{
		if(gettime() > DOF2_GetInt(File, "DDesban"))
		{
			DOF2_RemoveFile(File);
			format(File, sizeof(File), PASTA_CONTAS, Name(playerid));
			if(DOF2_FileExists(File))
			{
				format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Entrar", "X");
				return 0;
			}
			else
			{
				format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
				ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Voce e novo aqui", Str, "Confirmar", "X");
				return 0;
			}
		}
		else
		{
			LimparChat(playerid, 10);
			new StrM[450];
			strcat(StrM, "\t\t{FFFFFF}-x-x-x-x-x- {FFFF00}BANIDO{FFFFFF} -x-x-x-x-x-\n\nEsta conta esta banida deste servidor !\n\n{FFA500}Conta:{E64022} ");
			strcat(StrM, Name(playerid));
			strcat(StrM, "\n{FFFF00}Administrador:{FFFFFF} ");
			strcat(StrM, DOF2_GetString(File, "Administrador"));
			strcat(StrM, "\n{FFFF00}Motivo:{FFFFFF} ");
			strcat(StrM, DOF2_GetString(File, "Motivo"));
			strcat(StrM, "\n{FFFF00}Dia do Ban:{FFFFFF} ");
			strcat(StrM, DOF2_GetString(File, "Data"));
			strcat(StrM, "\n{FFFF00}Dia de Desban:{FFFFFF} ");
			strcat(StrM, DOF2_GetString(File, "Desban"));
			strcat(StrM, "\n\n{FFFFFF}Se considera um erro, entre em nosso discord\n{FFFF00}\t\t*******{FFFFFF}");
			strcat(StrM, SERVERFORUM);
			strcat(StrM, "{FFFF00}*******");
			ShowPlayerDialog(playerid, DIALOG_BANIDO, DIALOG_STYLE_MSGBOX, "BANIDO:", StrM, "X", "");
			Kick(playerid);
			return 0;
		}
	}
	format(File, sizeof(File), PASTA_BANIDOSIP, GetPlayerIpEx(playerid));
	if(DOF2_FileExists(File))
	{
		new StrM[450];
		strcat(StrM, "\t\t{FFFFFF}-x-x-x-x-x- {FFFF00}BANIDO{FFFFFF} -x-x-x-x-x-\n\nEste IP esta banido no servidor. !\n\n{FFFF00}IP:{FFFFFF} ");
		strcat(StrM, GetPlayerIpEx(playerid));
		strcat(StrM, "\n{FFFF00}Administrador:{FFFFFF} ");
		strcat(StrM, DOF2_GetString(File, "Administrador"));
		strcat(StrM, "\n{FFFF00}Motivo:{FFFFFF} ");
		strcat(StrM, DOF2_GetString(File, "Motivo"));
		strcat(StrM, "\n{FFFF00}Dia do seu Ban:{FFFF00} ");
		strcat(StrM, DOF2_GetString(File, "Data"));
		strcat(StrM, "\n\nSe considera um erro, entre em nosso discord\n{FFFF00}\t\t*******{FFFFFF}");
		strcat(StrM, SERVERFORUM);
		strcat(StrM, "{FFFF00}*******");
		ShowPlayerDialog(playerid, DIALOG_BANIDO, DIALOG_STYLE_MSGBOX, "BANIDO:", StrM, "X", "");
		Kick(playerid);
		return 0;
	}
	return 1;
}

CallBack::VelocimetroEx(playerid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new str[60];
		if(IsPlayerMobile(playerid)){
			format(str,sizeof(str),"%02d",VelocidadeDoVeiculo(GetPlayerVehicleID(playerid)));
			PlayerTextDrawSetString(playerid, Velomob_p[playerid][0], str);
			format(str,sizeof(str),"~r~F:~w~ %0.f",Fuel[GetPlayerVehicleID(playerid)]);
			PlayerTextDrawSetString(playerid, Velomob_p[playerid][2], str);
			new velo = VelocidadeDoVeiculo(GetPlayerVehicleID(playerid));
			if(velo >= 110){
				PlayerTextDrawSetString(playerid, Velomob_p[playerid][1], "5");
			}else if(velo >= 80){
				PlayerTextDrawSetString(playerid, Velomob_p[playerid][1], "4");
			}else if(velo >= 60){
				PlayerTextDrawSetString(playerid, Velomob_p[playerid][1], "3");
			}else if(velo >= 30){
				PlayerTextDrawSetString(playerid, Velomob_p[playerid][1], "2");
			}else if(velo > 0){
				PlayerTextDrawSetString(playerid, Velomob_p[playerid][1], "1");
			}else{
				PlayerTextDrawSetString(playerid, Velomob_p[playerid][1], "N");
			}
			PlayerTextDrawShow(playerid,Velomob_p[playerid][0]);
			PlayerTextDrawShow(playerid,Velomob_p[playerid][1]);
			PlayerTextDrawShow(playerid,Velomob_p[playerid][2]);
			if(mostrandovelo[playerid] == 0){
				for(new t=0;t<4;t++){
					TextDrawShowForPlayer(playerid,Velomob[t]);
				}
				mostrandovelo[playerid] = 1;
			}
		}else{
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(GetPlayerVehicleID(playerid), engine, lights, alarm, doors, bonnet, boot, objective);

			if(engine == 1){
				PlayerTextDrawColor(playerid, VeloC[playerid][5], 16711935); //bolinha verde
			}else{
				PlayerTextDrawColor(playerid, VeloC[playerid][5], -16776961); //bolinha vermelha
			}
			if(TemCinto[playerid] == true){
				PlayerTextDrawColor(playerid, VeloC[playerid][6], 16711935); //bolinha verde
			}else{
				PlayerTextDrawColor(playerid, VeloC[playerid][6], -16776961); //bolinha vermelha
			}
			if(doors != 0 && VehicleLock[GetPlayerVehicleID(playerid)] != 0){
				PlayerTextDrawColor(playerid, VeloC[playerid][7], 16711935);
			}else{
				PlayerTextDrawColor(playerid, VeloC[playerid][7], -16776961);
			}

			if(Fuel[GetPlayerVehicleID(playerid)] >= 80){
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][0], 16711935);
			}else{
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][0], -16776961);
			}
			if(Fuel[GetPlayerVehicleID(playerid)] >= 60){
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][1], 16711935);
			}else{
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][1], -16776961);
			}
			if(Fuel[GetPlayerVehicleID(playerid)] >= 40){
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][2], 16711935);
			}else{
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][2], -16776961);
			}
			if(Fuel[GetPlayerVehicleID(playerid)] >= 20){
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][3], 16711935);
			}else{
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][3], -16776961);
			}
			if(Fuel[GetPlayerVehicleID(playerid)] > 19){
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][4], 16711935); 
			}else{
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][4], -65281); //amarelo critico
			}if(Fuel[GetPlayerVehicleID(playerid)] == 0){
				PlayerTextDrawBoxColor(playerid, VeloC[playerid][4], -16776961);
			}
			format(str, sizeof(str), "%03d", VelocidadeDoVeiculo(GetPlayerVehicleID(playerid)));
			PlayerTextDrawSetString(playerid, VeloC[playerid][8], str);
			new velo = VelocidadeDoVeiculo(GetPlayerVehicleID(playerid));
			if(velo >= 110){
				PlayerTextDrawSetString(playerid, VeloC[playerid][9], "5");
			}else if(velo >= 80){
				PlayerTextDrawSetString(playerid, VeloC[playerid][9], "4");
			}else if(velo >= 60){
				PlayerTextDrawSetString(playerid, VeloC[playerid][9], "3");
			}else if(velo >= 30){
				PlayerTextDrawSetString(playerid, VeloC[playerid][9], "2");
			}else if(velo > 0){
				PlayerTextDrawSetString(playerid, VeloC[playerid][9], "1");
			}else{
				PlayerTextDrawSetString(playerid, VeloC[playerid][9], "N");
			}
			for(new t=0;t<10;t++){
				PlayerTextDrawShow(playerid,VeloC[playerid][t]);
			}
			if(mostrandovelo[playerid] == 0){
				for(new t=0;t<52;t++){
					TextDrawShowForPlayer(playerid,VeloC_G[t]);
				}
				mostrandovelo[playerid] = 1;
			}
		}
	}else{
		if(IsPlayerMobile(playerid)){
			if(mostrandovelo[playerid] != 0){
				for(new t=0;t<3;t++){
					PlayerTextDrawHide(playerid,Velomob_p[playerid][t]);
				}
				for(new t=0;t<4;t++){
					TextDrawHideForPlayer(playerid,Velomob[t]);
				}
				mostrandovelo[playerid] = 0;
			}
		}else{
			if(mostrandovelo[playerid] != 0){
				for(new t=0;t<10;t++){
					PlayerTextDrawHide(playerid,VeloC[playerid][t]);
				}
				for(new t=0;t<52;t++){
					TextDrawHideForPlayer(playerid,VeloC_G[t]);
				}
				mostrandovelo[playerid] = 0;
			}
		}
		KillTimer(TimerVelo[playerid]);
	}
	return 1;
}

CallBack::ConectarNaFrequencia(playerid, freq)
{
	FrequenciaConectada[playerid] = freq;
	SvAttachListenerToStream(Frequencia[freq], playerid);
	return 1;
}

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid)
{
	if(keyid == 0x42 && Falando[playerid] == true)
	{
		SvAttachSpeakerToStream(lstream[playerid], playerid); //local falando
		Falou[playerid] = true;
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], 16711935);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][5], 16711935);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
	}
	if(keyid == 0x42 && Susurrando[playerid] == true)
	{
		SvAttachSpeakerToStream(Susurrandos[playerid], playerid); //local susurrando
		Susurrou[playerid] = true;
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], 16711935);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
	}
	if(keyid == 0x42 && Gritando[playerid] == true)
	{
		SvAttachSpeakerToStream(Gritandos[playerid], playerid); //local gritando
		Gritou[playerid] = true;
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], 16711935);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][5], 16711935);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][6], 16711935);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][6]);
	}
	if(keyid == 0x5A && gstream)
	{
	    if(IsPlayerAdmin(playerid))
	    {
			SvAttachSpeakerToStream(gstream, playerid); //global
			PlayerTextDrawColor(playerid, HudServer_p[playerid][4], 16711935);
			PlayerTextDrawColor(playerid, HudServer_p[playerid][5], 16711935);
			PlayerTextDrawColor(playerid, HudServer_p[playerid][6], 16711935);
			PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
			PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
			PlayerTextDrawShow(playerid, HudServer_p[playerid][6]);
		}
	}
	if(keyid == 0x42 && FrequenciaConectada[playerid] >= 1)
	{
		ApplyAnimation(playerid, "ped", "phone_talk", 4.1, 1, 1, 1, 0, 0, 0);
		if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, 19942, 2, 0.0300, 0.1309, -0.1060, 118.8998, 19.0998, 164.2999);
		SvAttachSpeakerToStream(Frequencia[FrequenciaConectada[playerid]], playerid);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], 16711935);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][5], 16711935);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
	}
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid,SV_UINT:keyid)
{
	if(keyid == 0x42 && Falando[playerid] == true)
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		Falou[playerid] = false;
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], -16776961);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][5], -16776961);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
	}
	if(keyid == 0x42 && Susurrando[playerid] == true)
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		Susurrou[playerid] = false;
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], -16776961);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
	}
	if(keyid == 0x42 && Gritando[playerid] == true)
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		Gritou[playerid] = false;
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], -16776961);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][5], -16776961);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][6], -16776961);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][6]);
	}
	if(keyid == 0x5A && gstream)
	{
	    if(IsPlayerAdmin(playerid))
	    {
			SvDetachSpeakerFromStream(gstream, playerid);
			PlayerTextDrawColor(playerid, HudServer_p[playerid][4], -16776961);
			PlayerTextDrawColor(playerid, HudServer_p[playerid][5], -16776961);
			PlayerTextDrawColor(playerid, HudServer_p[playerid][6], -16776961);
			PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
			PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
			PlayerTextDrawShow(playerid, HudServer_p[playerid][6]);
		}
	}
	if(keyid == 0x42 && FrequenciaConectada[playerid] >= 1)
	{
		SvDetachSpeakerFromStream(Frequencia[FrequenciaConectada[playerid]], playerid);
		ClearAnimations(playerid);
		if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][4], -16776961);
		PlayerTextDrawColor(playerid, HudServer_p[playerid][5], -16776961);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][4]);
		PlayerTextDrawShow(playerid, HudServer_p[playerid][5]);
	}
}	

CallBack::SendMSG()
{
	for(new i = GetPlayerPoolSize(); i != -1; --i) //Loop through all players
	{
		if(pLogado[i] == true)
		{
			LimparChat(i, 10);
			InfoMsg(i, RandomMSG[random(sizeof(RandomMSG))]);
		}
	}
	RouboLoja1 = false;
	RouboLoja2 = false;
	RouboLoja3 = false;
	RouboLoja4 = false;
	RouboLoja5 = false;
	RouboRestaurante = false;
	return 1;
}

CallBack::SendMSGBot()
{
	DCC_SetBotActivity(RandomPresence[random(sizeof(RandomPresence))]);
	return 1;
}


CallBack::TimerHack(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pDinheiro]);
	SetTimerEx("TimerHack", segundos(1), false, "i", playerid);
	if(EstaSegurandoArmaProibida(playerid))
    {
        SendClientMessage(playerid, -1, "Você está segurando uma arma proibida! Você foi expulso!");
        Kick(playerid);
    }
	return true;
}

ShowDialog(playerid, dialogid)
{
	switch(dialogid)
	{
		case DIALOG_VEHICLE:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Veiculo {FFFF00}%d", vehicleid);
			strcat(info, "{FFFF00}-{FFFFFF} Motor\n{FFFF00}- {FFFFFF}Luzes\n{FFFF00}-{FFFFFF} Capo\n{FFFF00}-{FFFFFF} Porta Malas", sizeof(info));
			strcat(info, "\n{FFFF00}-{FFFFFF} Tanque de Combustible", sizeof(info));
			if(GetPlayerVehicleAccess(playerid, vehicleid) >= 2)
			{
				new value = VehicleValue[vehicleid]/2;
				format(info, sizeof(info), "%s\n{FFFF00}-{FFFFFF} Vender veiculo (R${FFFF00}%d{FFFFFF})\n{FFFF00}-{FFFFFF} Estacionar vehiculo", info, value);
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, caption, info, "Selecionar", "X");
		}
		case DIALOG_VEHICLE_BUY:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Veiculo {FFFF00}%d", vehicleid);
			format(info, sizeof(info), "Este veiculo esta a venda por (R$%d)\n-", VehicleValue[vehicleid]);
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, caption, info, "Comprar", "X");
		}
		case DIALOG_VEHICLE_SELL:
		{
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new id = GetPVarInt(playerid, "DialogValue2");
			new price = GetPVarInt(playerid, "DialogValue3");
			new info[256];
			format(info, sizeof(info), "%04d quer vender  {FFFF00}%s {FFFFFF}por {FFFF00}R$%d.", PlayerInfo[targetid][IDF],
				VehicleNames[VehicleModel[id]-400], price);
			strcat(info, "\n\n Te gustaria comprar?", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, "Comprar Veiculo", info, "Comprar", "X");
		}
		case DIALOG_TRUNK:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new name[32], info[256];
			for(new i=0; i < sizeof(VehicleTrunk[]); i++)
			{
				if(VehicleTrunk[vehicleid][i][1] > 0)
				{
					GetWeaponName(VehicleTrunk[vehicleid][i][0], name, sizeof(name));
					format(info, sizeof(info), "%s%d. %s (%d)\n", info, i+1, name, VehicleTrunk[vehicleid][i][1]);
				}
				else
				{
					format(info, sizeof(info), "%s%d. Vacio\n", info, i+1);
				}
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Porta Malas", info, "Selecionar", "X");
		}
		case DIALOG_TRUNK_ACTION:
		{
			new info[128];
			strcat(info, "Colocar\nRetirar", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Porta Malas", info, "Selecionar", "X");
		}
		case DIALOG_VEHICLE_PLATE:
		{
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, "Editar Placa", "Introduza nueva placa:", "Alterar", "X");
		}
		case DIALOG_FUEL:
		{
			new info[255];
			strcat(info, "Abastecer Veiculo ({FFFF00}R$" #PRECO_GASOLINA "{FFFFFF})\nComprar galao ({FFFF00}R$" #PRECO_GALAO "{FFFFFF})", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Posto Gasolina", info, "OK", "X");
		}
		case DIALOG_EDITVEHICLE:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Veiculo %d", vehicleid);
			format(info, sizeof(info), "1. Valor: [R$%s]\n2. Modelo: [%d (%s)]\n3. Cores: [%d] [%d]\n4. Placa[%s]",
				ConvertMoney(VehicleValue[vehicleid]), VehicleModel[vehicleid], VehicleNames[VehicleModel[vehicleid]-400],
				VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], VehicleNumberPlate[vehicleid]);
			strcat(info, "\n5. Deletar veiculo\n6. Estacionar veiculo\n7. Ir para veiculo", sizeof(info));
			strcat(info, "\n\nEnter: [nr] [value1] [value2]", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_INPUT, caption, info, "Confirmar", "X");
		}
	}
}

LoadVehicles()
{
	new string[64];
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		format(filename, sizeof(filename), VEHICLE_FILE_PATH "v%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line))
		{
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) VehicleCreated[i] = strval(line[s]);
			else if(strcmp(key, "Model") == 0) VehicleModel[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p<,>ffff", VehiclePos[i][0], VehiclePos[i][1],
				VehiclePos[i][2], VehiclePos[i][3]);
			else if(strcmp(key, "Colors") == 0) sscanf(line[s], "p<,>dd", VehicleColor[i][0], VehicleColor[i][1]);
			else if(strcmp(key, "Interior") == 0) VehicleInterior[i] = strval(line[s]);
			else if(strcmp(key, "VirtualWorld") == 0) VehicleWorld[i] = strval(line[s]);
			else if(strcmp(key, "Owner") == 0) strmid(VehicleOwner[i], line, s, sizeof(line));
			else if(strcmp(key, "NumberPlate") == 0) strmid(VehicleNumberPlate[i], line, s, sizeof(line));
			else if(strcmp(key, "Value") == 0) VehicleValue[i] = strval(line[s]);
			else if(strcmp(key, "Lock") == 0) VehicleLock[i] = strval(line[s]);
			else if(strcmp(key, "Alarm") == 0) VehicleAlarm[i] = strval(line[s]);
			else if(strcmp(key, "Paintjob") == 0) VehiclePaintjob[i] = strval(line[s]);
			else
			{
				for(new t=0; t < sizeof(VehicleTrunk[]); t++)
				{
					format(string, sizeof(string), "Trunk%d", t+1);
					if(strcmp(key, string) == 0) sscanf(line[s], "p<,>dd", VehicleTrunk[i][t][0], VehicleTrunk[i][t][1]);
				}
				for(new m=0; m < sizeof(VehicleMods[]); m++)
				{
					format(string, sizeof(string), "Mod%d", m);
					if(strcmp(key, string) == 0) VehicleMods[i][m] = strval(line[s]);
				}
			}
		}
		fclose(handle);
		if(VehicleCreated[i]) count++;
	}
	printf("=> Veiculos Conce       		: %d Carregados", count);
}

SaveVehicle(vehicleid)
{
	new filename[64], line[256];
	format(filename, sizeof(filename), VEHICLE_FILE_PATH "v%d.ini", vehicleid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", VehicleCreated[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Model=%d\r\n", VehicleModel[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f,%.3f\r\n", VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
		VehiclePos[vehicleid][2], VehiclePos[vehicleid][3]);
	fwrite(handle, line);
	format(line, sizeof(line), "Colors=%d,%d\r\n", VehicleColor[vehicleid][0], VehicleColor[vehicleid][1]); fwrite(handle, line);
	format(line, sizeof(line), "Interior=%d\r\n", VehicleInterior[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "VirtualWorld=%d\r\n", VehicleWorld[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Owner=%s\r\n", VehicleOwner[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "NumberPlate=%s\r\n", VehicleNumberPlate[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Value=%d\r\n", VehicleValue[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Lock=%d\r\n", VehicleLock[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Alarm=%d\r\n", VehicleAlarm[vehicleid]); fwrite(handle, line);
	format(line, sizeof(line), "Paintjob=%d\r\n", VehiclePaintjob[vehicleid]); fwrite(handle, line);
	for(new t=0; t < sizeof(VehicleTrunk[]); t++)
	{
		format(line, sizeof(line), "Trunk%d=%d,%d\r\n", t+1, VehicleTrunk[vehicleid][t][0], VehicleTrunk[vehicleid][t][1]);
		fwrite(handle, line);
	}
	for(new m=0; m < sizeof(VehicleMods[]); m++)
	{
		format(line, sizeof(line), "Mod%d=%d\r\n", m, VehicleMods[vehicleid][m]);
		fwrite(handle, line);
	}
	fclose(handle);
}

UpdateVehicle(vehicleid, removeold)
{
	if(VehicleCreated[vehicleid])
	{
		if(removeold)
		{
			new Float:health;
			GetVehicleHealth(VehicleID[vehicleid], health);
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			new panels, doorsd, lightsd, tires;
			GetVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
			DestroyVehicle(VehicleID[vehicleid]);
			VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 50);
			SetVehicleHealth(VehicleID[vehicleid], health);
			SetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			UpdateVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
		}
		else
		{
			VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 5000);
		}
		LinkVehicleToInterior(VehicleID[vehicleid], VehicleInterior[vehicleid]);
		SetVehicleVirtualWorld(VehicleID[vehicleid], VehicleWorld[vehicleid]);
		SetVehicleNumberPlate(VehicleID[vehicleid], VehicleNumberPlate[vehicleid]);
		for(new i=0; i < sizeof(VehicleMods[]); i++)
		{
			AddVehicleComponent(VehicleID[vehicleid], VehicleMods[vehicleid][i]);
		}
		ChangeVehiclePaintjob(VehicleID[vehicleid], VehiclePaintjob[vehicleid]);
		if(VehicleLock[vehicleid]) ToggleDoors(VehicleID[vehicleid], VEHICLE_PARAMS_ON);
		if(VehicleAlarm[vehicleid]) VehicleSecurity[VehicleID[vehicleid]] = 1;
		UpdateVehicleLabel(vehicleid, removeold);
	}
}

UpdateVehicleLabel(vehicleid, removeold)
{
	if(VehicleCreated[vehicleid] == VEHICLE_DEALERSHIP)
	{
		if(removeold)
		{
			Delete3DTextLabel(VehicleLabel[vehicleid]);
		}
		new labeltext[500];
		format(labeltext, sizeof(labeltext), "{FFFF00}%s\n{FFFFFF}ID: {FFFF00}%d\n{FFFFFF}Concessionaria ID: {FFFF00}%s\n{FFFFFF}Valor: {FFFF00}R$%s", VehicleNames[VehicleModel[vehicleid]-400],
			vehicleid, VehicleOwner[vehicleid], ConvertMoney(VehicleValue[vehicleid]));
		VehicleLabel[vehicleid] = Create3DTextLabel(labeltext, 0xBB7700DD, 0, 0, 0, 10.0, 0);
		Attach3DTextLabelToVehicle(VehicleLabel[vehicleid], VehicleID[vehicleid], 0, 0, 0);
	}
}

IsValidVehicle1(vehicleid)
{
	if(vehicleid < 1 || vehicleid >= MAX_DVEHICLES) return 0;
	if(VehicleCreated[vehicleid]) return 1;
	return 0;
}

GetFreeVehicleID()
{
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(!VehicleCreated[i]) return i;
	}
	return 0;
}

GetVehicleID(vehicleid)
{
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] && VehicleID[i] == vehicleid) return i;
	}
	return 0;
}

GetPlayerVehicles(playerid)
{
	new playername[24];
	GetPlayerName(playerid, playername, sizeof(playername));
	new count;
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], playername) == 0)
		{
			count++;
		}
	}
	return count;
}

GetPlayerVehicleAccess(playerid, vehicleid)
{
	if(IsValidVehicle1(vehicleid))
	{
		if(VehicleCreated[vehicleid] == VEHICLE_DEALERSHIP)
		{
			if(pJogando[playerid] == false)
			{
				return 1;
			}
		}
		else if(VehicleCreated[vehicleid] == VEHICLE_PLAYER)
		{
			if(strcmp(VehicleOwner[vehicleid], Name(playerid)) == 0)
			{
				return 2;
			}
			else if(GetPVarInt(playerid, "CarKeys") == vehicleid)
			{
				return 1;
			}
		}
	}
	else
	{
		return 1;
	}
	return 0;
}

LoadDealerships()
{
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		format(filename, sizeof(filename), DEALERSHIP_FILE_PATH "d%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line))
		{
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) DealershipCreated[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p<,>fff", DealershipPos[i][0],
				DealershipPos[i][1], DealershipPos[i][2]);
		}
		fclose(handle);
		if(DealershipCreated[i]) count++;
	}
	printf("=> Concessionarias       		: %d Carregados", count);
}

SaveDealership(dealerid)
{
	new filename[64], line[256];
	format(filename, sizeof(filename), DEALERSHIP_FILE_PATH "d%d.ini", dealerid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", DealershipCreated[dealerid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f\r\n", DealershipPos[dealerid][0],
		DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	fwrite(handle, line);
	fclose(handle);
}

UpdateDealership(dealerid, removeold)
{
	if(DealershipCreated[dealerid])
	{
		if(removeold)
		{
			Delete3DTextLabel(DealershipLabel[dealerid]);
		}
		new labeltext[500];
		format(labeltext, sizeof(labeltext), "{FFFF00}Spawn Veiculo\n{FFFFFF}ID: {FFFF00}%d", dealerid);
		DealershipLabel[dealerid] = Create3DTextLabel(labeltext, 0x00BB00DD, DealershipPos[dealerid][0],
			DealershipPos[dealerid][1], DealershipPos[dealerid][2]+0.5, 20.0, 0);
	}
}

IsValidDealership(dealerid)
{
	if(dealerid < 1 || dealerid >= MAX_DEALERSHIPS) return 0;
	if(DealershipCreated[dealerid]) return 1;
	return 0;
}

LoadFuelStations()
{
	new File:handle, count;
	new filename[64], line[256], s, key[64];
	for(new i=1; i < MAX_FUEL_STATIONS; i++)
	{
		format(filename, sizeof(filename), FUEL_STATION_FILE_PATH "f%d.ini", i);
		if(!fexist(filename)) continue;
		handle = fopen(filename, io_read);
		while(fread(handle, line))
		{
			StripNL(line);
			s = strfind(line, "=");
			if(!line[0] || s < 1) continue;
			strmid(key, line, 0, s++);
			if(strcmp(key, "Created") == 0) FuelStationCreated[i] = strval(line[s]);
			else if(strcmp(key, "Pos") == 0) sscanf(line[s], "p<,>fff", FuelStationPos[i][0],
				FuelStationPos[i][1], FuelStationPos[i][2]);
		}
		fclose(handle);
		if(FuelStationCreated[i]) count++;
	}
	printf("=> Postos de Gasolinas       		: %d Carregados", count);
}

SaveFuelStation(stationid)
{
	new filename[64], line[256];
	format(filename, sizeof(filename), FUEL_STATION_FILE_PATH "f%d.ini", stationid);
	new File:handle = fopen(filename, io_write);
	format(line, sizeof(line), "Created=%d\r\n", FuelStationCreated[stationid]); fwrite(handle, line);
	format(line, sizeof(line), "Pos=%.3f,%.3f,%.3f\r\n", FuelStationPos[stationid][0],
		FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	fwrite(handle, line); 
	fclose(handle);
}

UpdateFuelStation(stationid, removeold)
{
	if(FuelStationCreated[stationid])
	{
		if(removeold)
		{
			Delete3DTextLabel(FuelStationLabel[stationid]);
		}
		new labeltext[500];
		format(labeltext, sizeof(labeltext), "{FFFF00}Posto de Gasolina\n{FFFFFF}ID: {FFFF00}%d\n{FFFFFF}/abastecer", stationid);
		FuelStationLabel[stationid] = Create3DTextLabel(labeltext, 0x00BBFFDD, FuelStationPos[stationid][0],
			FuelStationPos[stationid][1], FuelStationPos[stationid][2]+0.5, 20.0, 0);
	}
}

IsValidFuelStation(stationid)
{
	if(stationid < 1 || stationid >= MAX_FUEL_STATIONS) return 0;
	if(FuelStationCreated[stationid]) return 1;
	return 0;
}

CallBack::MainTimer()  
{
	new string[128];
	new Float:x, Float:y, Float:z;
	SalvarPlantacao();
	foreach(Player, i)
	{
		if(IsPlayerConnected(i))
		{
			if(GetPlayerState(i) == PLAYER_STATE_DRIVER)
			{
				new vehicleid = GetPlayerVehicleID(i);
				if(!IsBicycle(vehicleid) && Fuel[vehicleid] > 0)
				  {
					if(Fuel[vehicleid] <= 0)
					{
						ToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
						InfoMsg(i, "Veiculo sem combustivel.");
					}
				}
			}
			if(RefuelTime[i] > 0 && GetPVarInt(i, "FuelStation"))
			{
				new vehicleid = GetPlayerVehicleID(i);
				Fuel[vehicleid] += 2.0;
				RefuelTime[i]--;
				if(RefuelTime[i] == 0)
				{
					if(Fuel[vehicleid] >= 100.0) Fuel[vehicleid] = 100.0;
					new stationid = GetPVarInt(i, "FuelStation");
					new cost = floatround(Fuel[vehicleid]-GetPVarFloat(i, "Fuel"))*PRECO_GASOLINA;
					if(GetPlayerState(i) != PLAYER_STATE_DRIVER || Fuel[vehicleid] >= 100.0 || GetPlayerMoney(i) < cost
					|| !IsPlayerInRangeOfPoint(i, 10.0, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]))
					{
						if(GetPlayerMoney(i) < cost) cost = GetPlayerMoney(i);
						PlayerInfo[i][pDinheiro] -= cost;
						format(string, sizeof(string), "Voce pagou R$%d pelo abastecimento", cost);
						SuccesMsg(i, string);
						SetPVarInt(i, "FuelStation", 0);
						SetPVarFloat(i, "Fuel", 0.0);
					}
					else
					{
						RefuelTime[i] = 5;
					}
				}
			}
			if(TrackCar[i])
			{
				GetVehiclePos(TrackCar[i], x, y, z);
				SetPlayerCheckpoint(i, x, y, z, 3);
			}
		}
	}
}

CallBack::SaveTimer()
{
	SaveVehicleIndex++;
	if(SaveVehicleIndex >= MAX_DVEHICLES) SaveVehicleIndex = 1;
	if(IsValidVehicle1(SaveVehicleIndex)) SaveVehicle(SaveVehicleIndex);
}

CallBack::StopAlarm(vehicleid)
{
	ToggleAlarm(vehicleid, VEHICLE_PARAMS_OFF);
}

CallBack::GetVehicleIDFromPlate(Plate[])
{
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleNumberPlate[i], Plate) == 0)
		{
			return i;
		}
	}
	return 0;
}

AntiDeAMX()
{
	new antidamx[][] =
	{
		"Unarmed (Fist)",
		"Brass K",
		"Fire Ex"
	};
	printf("=> AntiAMX       		: Carregado");
	#pragma unused antidamx
}

CallBack::carregarobj(playerid)
{
	TogglePlayerControllable(playerid, true);
}
CallBack::LiberarRadar(playerid)
{
	PassouRadar[playerid] = 0;
	return 1;
}

CallBack::AttVeh(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	GetPlayerPos(playerid, VarPlayerOldPos[playerid][0], VarPlayerOldPos[playerid][1], VarPlayerOldPos[playerid][2]);
	if(IsPlayerInAnyVehicle(playerid))
	{
		new veiculoidb;
		veiculoidb = GetPlayerVehicleID(playerid);
		new Float:vhealth;
		GetVehicleHealth(veiculoidb, vhealth);
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicle = GetPlayerVehicleID(playerid);
			new Float:vida;
			GetVehicleHealth(vehicle, vida);
			new vehicleid = GetPlayerVehicleID(playerid);
			new engine, lights, alarm, doors, bonnet, boot, objective;
			GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
			if(vida < 300.0)
			{
				GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
				SetVehicleParamsEx(vehicle,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
				RepairCar[playerid] = GetPlayerVehicleID(playerid);
				SetVehicleHealth(RepairCar[playerid], 299.0);
				ShowErrorDialog(playerid, "Veiculo quebrado\nchame um mecanico");
				RemovePlayerFromVehicle(playerid);
				return 1;
			}
			new Account[255];
			new carid = GetVehicleModel(GetPlayerVehicleID(playerid));
			for(new i; i < MAX_RADAR; i++)
			{
				if(carid != 417 && carid != 425 && carid != 430 && carid != 446 && carid != 447 && carid != 449 && carid != 452 && carid != 453 && carid != 454 &&
				carid != 460 && carid != 469 && carid != 472 && carid != 473 && carid != 476 && carid != 481 && carid != 484 && carid != 487 && carid != 488 && carid != 493 &&
				carid != 497 && carid != 509 && carid != 510 && carid != 511 && carid != 512 && carid != 513 && carid != 519 && carid != 520 && carid != 537 && carid != 538 &&
				carid != 548 && carid != 553 && carid != 563 && carid != 577 && carid != 592 && carid != 593 && carid != 595)
				{
					format(Account, sizeof(Account), PASTA_RADAR, i);
					if(IsPlayerInRangeOfPoint(playerid, 20.0, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]))
					{
						new velocidade = VelocidadeDoVeiculo(GetPlayerVehicleID(playerid));
						if(velocidade <= RadarInfo[i][RadarVelocidade])
						{
							if(PassouRadar[playerid] == 0)
							{
								PassouRadar[playerid] = 1;
								SetTimerEx("LiberarRadar", segundos(5), false, "d", playerid);
								return 1;
							}
						}
						else
						{
							if(PassouRadar[playerid] == 0)
							{
								if(Patrulha[playerid] == true || PlayerInfo[playerid][pVIP] == 2)
								{
									PassouRadar[playerid] = 1;
									SetTimerEx("LiberarRadar", segundos(5), false, "d", playerid);
									return 1;
								}
								else
								{
									new multaradar = randomEx(0, 5000);
									PassouRadar[playerid] = 1;
									GameTextForPlayer(playerid, "~n~ ~r~RADAR", 2000, 1);
									SetTimerEx("LiberarRadar", segundos(5), false, "d", playerid);
									PlayerPlaySound(playerid,1132,0.0,0.0,0.0);
									PlayerInfo[playerid][pMultas] += multaradar;
								}
								return 1;
							}
						}
					}
				}
			}
		}
	}
	return 1;
}

CallBack::SalvarPlantacao()
{
	new string[128];

	for(new m = 0; m < MAX_MACONHA; m++)
	{
		format(string, sizeof string, PASTA_PLANTACAO, m);
		if(DOF2_FileExists(string))DOF2_RemoveFile(string);
	}

	for(new m = 0; m < MAX_MACONHA; m++)
	{
		format(string, sizeof string, PASTA_PLANTACAO, m);
		if(!MaconhaInfo[m][PodeUsar])
		{
			if(!DOF2_FileExists(string))

			DOF2_CreateFile(string);
			Delete3DTextLabel(MaconhaInfo[m][TT]);
			DOF2_SetString(string, "Dono", MaconhaInfo[m][Dono]);
			DOF2_SetInt(string, "Crescida", MaconhaInfo[m][Crescida]);
			DOF2_SetInt(string, "GramasProntas", MaconhaInfo[m][GramasProntas]);
			DOF2_SetFloat(string, "MacX", MaconhaInfo[m][mX]);
			DOF2_SetFloat(string, "MacY", MaconhaInfo[m][mY]);
			DOF2_SetFloat(string, "MacZ", MaconhaInfo[m][mZ]);
			DOF2_SaveFile();
		}
	}
}
CallBack::CarregarPlantacao()
{
	new string[128];

	for(new maconhaid = 0; maconhaid < MAX_MACONHA; maconhaid++)
	{
		format(string, sizeof string, PASTA_PLANTACAO, maconhaid);
		if(DOF2_FileExists(string))
		{
			format(MaconhaInfo[maconhaid][Dono], 24, DOF2_GetString(string, "Dono"));
			MaconhaInfo[maconhaid][Crescida] = DOF2_GetInt(string, "Crescida");
			MaconhaInfo[maconhaid][GramasProntas] = DOF2_GetInt(string, "GramasProntas");
			MaconhaInfo[maconhaid][mX] = DOF2_GetFloat(string, "MacX");
			MaconhaInfo[maconhaid][mY] = DOF2_GetFloat(string, "MacY");
			MaconhaInfo[maconhaid][mZ] = DOF2_GetFloat(string, "MacZ");
			MaconhaInfo[maconhaid][Object] = CreateDynamicObject(3409, MaconhaInfo[maconhaid][mX], MaconhaInfo[maconhaid][mY], MaconhaInfo[maconhaid][mZ]-0.6,0.0, 0.0, 0.0);
			format(string, sizeof string, "Maconha\nDono: %s\nPlantacao ID: %d\nCrescendo: %d/%d\nGramas: %dg",
			MaconhaInfo[maconhaid][Dono], maconhaid,MaconhaInfo[maconhaid][Crescida],Max_Crescida, MaconhaInfo[maconhaid][GramasProntas]);
			MaconhaInfo[maconhaid][TT] = Create3DTextLabel(string, 0x1FF61F99, MaconhaInfo[maconhaid][mX], MaconhaInfo[maconhaid][mY], MaconhaInfo[maconhaid][mZ], 10.0, 0);
			MaconhaInfo[maconhaid][PodeUsar]=false;
		}
	}
	printf("=> Plantações       		: Carregadas");
}

CallBack::MaconhaColher(playerid, mac)
{
	new gfstring[128];
	format(gfstring, sizeof gfstring, "Colheu uma maconha com %d gramas.",MaconhaInfo[mac][GramasProntas]);
	SuccesMsg(playerid, gfstring);
	GanharItem(playerid, 1576, MaconhaInfo[mac][GramasProntas]);
	DestroyDynamicObject(MaconhaInfo[mac][Object]);
	Delete3DTextLabel(MaconhaInfo[mac][TT]);
	MaconhaInfo[mac][mX] = 0.0;
	MaconhaInfo[mac][mY] = 0.0;
	MaconhaInfo[mac][mZ] = 0.0;
	MaconhaInfo[mac][PodeUsar] = true;
	ClearAnimations(playerid);
	PlantandoMaconha[playerid] = false;
	return true;
}

CallBack::MaconhaQueimar(playerid, mac)
{
	SetTimerEx("MaconhaQueimar2", 17000, false, "id", playerid, mac);
	ClearAnimations(playerid);
	PlantandoMaconha[playerid] = false;
	SuccesMsg(playerid, "Iniciou um incendio nessa plantacao.");
	return true;
}

CallBack::MaconhaQueimar2(playerid, mac)
{
	CreateExplosion(MaconhaInfo[mac][mX], MaconhaInfo[mac][mY], MaconhaInfo[mac][mZ], 10, 1.0);
	DestroyDynamicObject(MaconhaInfo[mac][Object]);
	Delete3DTextLabel(MaconhaInfo[mac][TT]);
	MaconhaInfo[mac][mX] = 0.0;
	MaconhaInfo[mac][mY] = 0.0;
	MaconhaInfo[mac][mZ] = 0.0;
	MaconhaInfo[mac][PodeUsar] = true;
	ClearAnimations(playerid);
	PlantandoMaconha[playerid] = false;
	return true;
}

CallBack::PlantarMaconhas(playerid, slt)
{
	new string[200];
	static
		Float:pX, Float:pY, Float:pZ;
	GetPlayerPos(playerid, pX, pY, pZ);
	MaconhaInfo[slt][mX] = pX;
	MaconhaInfo[slt][mY] = pY;
	MaconhaInfo[slt][mZ] = pZ-1;
	MaconhaInfo[slt][GramasProntas] = 0;
	MaconhaInfo[slt][Crescida] = 0;
	strmid(MaconhaInfo[slt][Dono], Name(playerid), 0, strlen(Name(playerid)), 35);
	format(string, sizeof string, "Maconha\nDono: %s\nPlantacao ID: %d\nCrescendo: %d/%d\nGramas: %dg",
	MaconhaInfo[slt][Dono], slt,MaconhaInfo[slt][Crescida],Max_Crescida, MaconhaInfo[slt][GramasProntas]);
	MaconhaInfo[slt][TT] = Create3DTextLabel(string, 0x1FF61F99, pX, pY, pZ, 10.0, 0);
	MaconhaInfo[slt][Object] = CreateDynamicObject(3409, pX, pY, pZ-0.6,0.0, 0.0, 0.0);
	ClearAnimations(playerid);
	PlantandoMaconha[playerid] = false;
	SuccesMsg(playerid, "Semente plantada use /maconhas para suas plantacoes.");
	return true;
}

CallBack::UpdateDrogas()
{
	new string[128];
	for(new maconhaid = 0; maconhaid < MAX_MACONHA; maconhaid++)
	{
		if(MaconhaInfo[maconhaid][PodeUsar] == false)
		{
			if(MaconhaInfo[maconhaid][Crescida] < Max_Crescida)
			{
				new updrogas = randomEx(0, 50);
				MaconhaInfo[maconhaid][GramasProntas] += updrogas;
				MaconhaInfo[maconhaid][Crescida]++;
			}
			format(string, sizeof string, "Maconha\nDono: %s\nPlantacao ID: %d\nCrescendo: %d/%d\nGramas: %dg",
			MaconhaInfo[maconhaid][Dono], maconhaid,MaconhaInfo[maconhaid][Crescida],Max_Crescida, MaconhaInfo[maconhaid][GramasProntas]);
			Update3DTextLabelText(MaconhaInfo[maconhaid][TT], 0x1FF61F99, string);
		}
	}
	for(new i = 0; i < GetPlayerPoolSize(); i++)
	{
		if(pLogado[i] == true){
			MaconhaPronta(i);
		}
	}
	for(new i; i < MAX_ORGS; i++)
    {
        SalvarCofre(i);
    }
	return true;
}

CallBack::AnimatioN(playerid)
{
	ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop",2.0,1,0,0,0,0);
	return true;
}

CallBack::SalvarArmas(playerid)
{
	/*-----------------------------------------*/
	new Slot3,Bala,Local[200],Slot1[20],Bala1[20];
	/*-----------------------------------------*/
	Local = PachWeapon(playerid);
	/*-----------------------------------------*/
	//
	if(!DOF2_FileExists(Local)) DOF2_CreateFile(Local); 
	//
	for(new i = 0; i < 13; i++)
	{
		/*-----------------------------------*/
		GetPlayerWeaponData(playerid,i,Slot3,Bala);
		/*-----------------------------------*/
		format(Slot1,sizeof(Slot1),"Slot%d",i);
		format(Bala1,sizeof(Bala1),"Bala%d",i);
		/*-----------------------------------*/
		DOF2_SetInt(Local, Slot1, Slot3);
		DOF2_SetInt(Local, Bala1, Bala);
		/*-----------------------------------*/
		DOF2_SaveFile();
		/*-----------------------------------*/
	}
	return 1;
}

CallBack::CarregarArmas(playerid)
{
	/*-----------------------------------------*/
	new Slot3,Bala,Local[200],Slot1[20],Bala1[20];
	/*-----------------------------------------*/
	Local = PachWeapon(playerid);
	/*-----------------------------------------*/
	for(new i = 0; i < 13; i++)
	{
		/*-----------------------------------*/
		format(Slot1,sizeof(Slot1),"Slot%d",i);
		format(Bala1,sizeof(Bala1),"Bala%d",i);
		/*-----------------------------------*/
		Slot3 = DOF2_GetInt(Local, Slot1);
		Bala = DOF2_GetInt(Local, Bala1);
		/*-----------------------------------*/
		GivePlayerWeapon(playerid, Slot3, Bala);
		
		/*-----------------------------------*/
	}
	return 1;
}

PachWeapon(playerid)
{
	new string[100];
	format(string, 100, PASTA_SAVEARMAS, Name(playerid));
	return string;
}

CallBack::LoadCofreOrg()
{
	new File[255];
	new idx = 1;
	while (idx < sizeof(CofreOrg))
	{
		format(File, sizeof(File), PASTA_COFREORG,idx);
		CofreOrg[idx][Dinheiro] = DOF2_GetInt(File,"Dinheiro");
		CofreOrg[idx][Maconha] = DOF2_GetInt(File,"Maconha");
		CofreOrg[idx][Cocaina] = DOF2_GetInt(File,"Cocaina");
		CofreOrg[idx][Crack] = DOF2_GetInt(File,"Crack");
		CofreOrg[idx][Equipar] = DOF2_GetInt(File,"Equipar");
		idx ++;
	}
	return printf("=> Cofres Org       		: Carregados", idx);
}

CallBack::IsPolicial(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new member = PlayerInfo[playerid][Org];
		if(member == 1 || member == 2 || member == 3 || member == 4)
		{
			return 1;
		}
	}
	return 0;
}

CallBack::IsBandido(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new member = PlayerInfo[playerid][Org];
		if(member == 5 || member == 6 || member == 7 || member == 8 || member == 12 || member == 13)
		{
			return 1;
		}
	}
	return 0;
}

CallBack::IsNeutra(playerid)
{
	if(IsPlayerConnected(playerid))
	{
		new member = PlayerInfo[playerid][Org];
		if(member == 9 || member == 10 || member == 11)
		{
			return 1;
		}
	}
	return 0;
}

CallBack::RemovePlayerWeapon(playerid, weaponid)
{
	new plyWeapons[12] = 0;
	new plyAmmo[12] = 0;
	for(new sslot = 0; sslot != 12; sslot++)
	{
		new wep, ammo;
		GetPlayerWeaponData(playerid, sslot, wep, ammo);
		if(wep != weaponid && ammo != 0) GetPlayerWeaponData(playerid, sslot, plyWeapons[sslot], plyAmmo[sslot]);
	}
	ResetPlayerWeapons(playerid);
	for(new sslot = 0; sslot != 12; sslot++)
	{
		if(plyAmmo[sslot] != 0) GivePlayerWeapon(playerid, plyWeapons[sslot], plyAmmo[sslot]);
	}
	return 1;
}

CallBack::ORGCarrega()
{
	new String[500];
	for(new vagads = 1; vagads < MAX_ORGS; vagads++)
	{
	   format(String, sizeof(String), PASTA_ORGS, vagads);
	   if(!DOF2_FileExists(String))
	   {
		   DOF2_CreateFile(String);
		   for(new i=0; i< sizeof VagasORG; i++)
		   {
				DOF2_SetString(String,VagasORG[i], "Nenhum");
		   }
		   DOF2_SaveFile();
	   }
	}
	printf("=> Organizações       		: %d Carregadas", MAX_ORGS);
	return true;
}

CallBack::AnimatioN2(playerid)
{
	ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop",2.0,1,0,0,0,0);
	return true;
}

CallBack::PegarMoney(playerid, caixa_id)
{
	RoubandoCaixa[playerid] = false;
	ClearAnimations(playerid);
	if(!CaixaInfo[caixa_id][Caixa_Roubada])return 1;
	if(!IsPlayerInRangeOfPoint(playerid, 5.0, GetPVarFloat(playerid, "RouboX"),GetPVarFloat(playerid, "RouboY"),GetPVarFloat(playerid, "RouboZ")))
	{
		return ErrorMsg(playerid, "Nao esta em nenhum local de roubo.");
	}
	new str[200];
	new picks = CaixaInfo[caixa_id][Caixa_Pickups];
	GanharItem(playerid,1212, CaixaInfo[caixa_id][Caixa_Dinheiro]/picks);

	format(str, sizeof str, "Ganhou R$%i de dinheiro sujo.",CaixaInfo[caixa_id][Caixa_Dinheiro]/picks);
	InfoMsg(playerid, str);

	CaixaInfo[caixa_id][Caixa_Dinheiro] -= (CaixaInfo[caixa_id][Caixa_Dinheiro]/picks);

	format(str, sizeof str, "{FFFFFF}Caixa Registradora\n{FFFF00}Caixa Destruido\n{FFFFFF}Dinheiro No Caixa: {FFFF00}R$%i",CaixaInfo[caixa_id][Caixa_Dinheiro]);
	Update3DTextLabelText(CaixaInfo[caixa_id][Caixa_Text], 0xFFFF00F4, str);

	CaixaInfo[caixa_id][Caixa_Pickups] --;
	
	KillTimer(GetPVarInt(playerid, "ROBj"));

	SetPVarInt(playerid, "ROBj", SetTimerEx("RObject", 2*60000, 0, "d", playerid));
	return 0;
}

CallBack::RObject(playerid)
{
	RemovePlayerAttachedObject(playerid, 2);
	SetPVarInt(playerid, "ROBj", -1);
}

CallBack::RoubarCaixa(playerid, caixa_id)
{	
	new Float:px, Float:py, Float:pz,
	Float:rx, Float:ry, Float:rz;
	if(!GetPlayerCaixa(playerid))
	{
		CaixaInfo[caixa_id][Caixa_Roubada] = false;
		GanharItem(playerid, 1654, 1);
		return ErrorMsg(playerid, "Esta longe de um caixa");
	}

	SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);
	TogglePlayerControllable(playerid, 1);
	TendoRoubo = true;
	SetTimer(#LiberarRoubo, Temporoubo, 0);
	GetDynamicObjectPos(CaixaInfo[caixa_id][Caixa_Object], px, py, pz);
	GetDynamicObjectRot(CaixaInfo[caixa_id][Caixa_Object], rx, ry, rz);
	GetXYInFrontOfCaixa(CaixaInfo[caixa_id][Caixa_Object], px, py, 0.3);

	CaixaInfo[caixa_id][Caixa_ObjectBomba] = CreateDynamicObject(1252, px, py, pz, 0.0, 0.0, rz);
	SetTimerEx("ExplodirCaixa", 10000, 0, "d", caixa_id);

	SuccesMsg(playerid, "Colocou uma bomba em um caixa, agora afasta-se.");
	ClearAnimations(playerid, 1);
	return 0;
}

Progresso:RoubarLoja(playerid, progress)
{
	if(progress >= 100)
	{
		if(PlayerToPoint(5.0, playerid, 1316.121826, -1113.496704, 24.960447))
		{
			GanharItem(playerid, 1212, CofreRestaurante);
			CofreRestaurante = 0;
			SuccesMsg(playerid, "Roubo efetuado com sucesso.");
			ClearAnimations(playerid, 1);
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);
			TogglePlayerControllable(playerid, 1);
			RouboRestaurante = true;
		}
		if(PlayerToPoint(5.0, playerid, 393.256561, -1895.308471, 7.844118))
		{
			GanharItem(playerid, 1212, CofreLoja1);
			CofreLoja1 = 0;
			SuccesMsg(playerid, "Roubo efetuado com sucesso.");
			ClearAnimations(playerid, 1);
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);
			TogglePlayerControllable(playerid, 1);
			RouboLoja1 = true;
		}
		if(PlayerToPoint(5.0, playerid, 1359.771850, -1774.149291, 13.551797))
		{
			GanharItem(playerid, 1212, CofreLoja2);
			CofreLoja2 = 0;
			SuccesMsg(playerid, "Roubo efetuado com sucesso.");
			ClearAnimations(playerid, 1);
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);
			TogglePlayerControllable(playerid, 1);
			RouboLoja2 = true;
		}
		if(PlayerToPoint(5.0, playerid, 1663.899047, -1899.635009, 13.569333))
		{
			GanharItem(playerid, 1212, CofreLoja3);
			CofreLoja3 = 0;
			SuccesMsg(playerid, "Roubo efetuado com sucesso.");
			ClearAnimations(playerid, 1);
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);
			TogglePlayerControllable(playerid, 1);
			RouboLoja3 = true;
		}
		if(PlayerToPoint(5.0, playerid, 2054.312255, -1883.058105, 13.570812))
		{
			GanharItem(playerid, 1212, CofreLoja4);
			CofreLoja4 = 0;
			SuccesMsg(playerid, "Roubo efetuado com sucesso.");
			ClearAnimations(playerid, 1);
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);
			TogglePlayerControllable(playerid, 1);
			RouboLoja4 = true;
		}
		if(PlayerToPoint(5.0, playerid, 1310.963256, -856.883911, 39.597454))
		{
			GanharItem(playerid, 1212, CofreLoja5);
			CofreLoja5 = 0;
			SuccesMsg(playerid, "Roubo efetuado com sucesso.");
			ClearAnimations(playerid, 1);
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+3);
			TogglePlayerControllable(playerid, 1);
			RouboLoja5 = true;
		}
		SalvarDinRoubos();
	}
	return 0;
}

CallBack::ExplodirCaixa(caixa_id)
{
	new Float:px, Float:py, Float:pz,
	Float:rx, Float:ry, Float:rz;

	new str[200];

	new add = random(2000);
	CaixaInfo[caixa_id][Caixa_Dinheiro] = (MAX_PICKUPS_ROUBO*1600)+add;

	format(str, sizeof str, "{FFFFFF}Caixa Registradora\n{FFFF00}Caixa Destruido\n{FFFFFF}Dinheiro No Chao: {FFFF00}R$%i",CaixaInfo[caixa_id][Caixa_Dinheiro]);
	Update3DTextLabelText(CaixaInfo[caixa_id][Caixa_Text], 0xFFFF00F4, str);

	GetDynamicObjectPos(CaixaInfo[caixa_id][Caixa_Object], px, py, pz);
	GetDynamicObjectRot(CaixaInfo[caixa_id][Caixa_Object], rx, ry, rz);
	CreateExplosion(px, py, pz, 10, 2.0);
	DestroyDynamicObject(CaixaInfo[caixa_id][Caixa_ObjectBomba]);
	DestroyDynamicObject(CaixaInfo[caixa_id][Caixa_Object]);
	CaixaInfo[caixa_id][Caixa_Object] = CreateDynamicObject(2943, px, py, pz, rx, ry, rz);
	UltimaCaixaRoubada[0] = px;
	UltimaCaixaRoubada[1] = py;
	UltimaCaixaRoubada[2] = pz;

	//--------- Jogar grana no chÃ£o --

	GetXYInFrontOfCaixa(CaixaInfo[caixa_id][Caixa_Object], px, py, 3.1);
	for(new i; i < MAX_PICKUPS_ROUBO; i++)
	{
		Pickups_Roubo[caixa_id][i] = CreatePickup(1212, 23, px+(RdonPickups[random(sizeof(RdonPickups))][0]),py-(RdonPickups[random(sizeof(RdonPickups))][0]),pz-0.3);
	}

	CaixaInfo[caixa_id][Caixa_Pickups] = MAX_PICKUPS_ROUBO;

	SetTimerEx("RestoreCaixa", 600000, 0, "d", caixa_id);

	return 1;
}
CallBack::RestoreCaixa(caixa_id)
{
	if(CaixaInfo[caixa_id][Caixa_Roubada])
	{

		new Float:px, Float:py, Float:pz,
		Float:rx, Float:ry, Float:rz;

		CaixaInfo[caixa_id][Caixa_Roubada] = false;

		Update3DTextLabelText(CaixaInfo[caixa_id][Caixa_Text], 0x33FFFFFF, "{FFFFFF}Caixa Registradora\nAperte '{FFFF00}F{FFFFFF}' para acessar");

		GetDynamicObjectPos(CaixaInfo[caixa_id][Caixa_Object], px, py, pz);
		GetDynamicObjectRot(CaixaInfo[caixa_id][Caixa_Object], rx, ry, rz);

		DestroyDynamicObject(CaixaInfo[caixa_id][Caixa_Object]);
		CaixaInfo[caixa_id][Caixa_Object] = CreateDynamicObject(2942, px, py, pz, rx, ry, rz);

		for(new i; i < MAX_PICKUPS_ROUBO; i++)
		{
			DestroyPickup(Pickups_Roubo[caixa_id][i]);
		}
	}
	return true;
}

CallBack::LocalizarPlayer(playerid, giveplayerid)
{
	new
		Float: X,
		Float: Y,
		Float: Z;
	GetPlayerPos(giveplayerid, X, Y, Z);
	SetPlayerCheckpoint(playerid, X, Y, Z, 0.0);
	return true;
}
CallBack::ProxDetectorS(Float:radi, playerid, targetid)
{
	if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

CallBack::PayDay(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	if(pLogado[playerid] == true)
	{
		if(PlayerInfo[playerid][pDinheiro] < 100000)
		{
			MissaoPlayer[playerid][MISSAO9] = 1;
		}
		new g; g = random(1000);
		new gjuros; gjuros = random(1000);
		new gimposto; gimposto = random(1000);
		new gi; gi = random(1000);
		new saldoantigo[MAX_PLAYERS];
		saldoantigo[playerid] = PlayerInfo[playerid][pBanco];
		if(PlayerInfo[playerid][pVIP] > 0)
		{
			g=g+g;
		}
		PlayerInfo[playerid][pBanco] -= gimposto;
		PlayerInfo[playerid][pBanco] -= gi;
		PlayerInfo[playerid][pBanco] -= gjuros;
		PlayerInfo[playerid][pBanco] += g;
		if(PlayerInfo[playerid][pVIP] == 1)
		{
			PlayerInfo[playerid][pBanco] += 1500;
		}
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pBanco] += 3000;
		}
		PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		SalvarDados(playerid);
		TimerPayDay[playerid] = SetTimerEx("PayDay", minutos(30), false, "i", playerid); 
		new string[100];
		format(string,sizeof(string),"%04d agora tem R$%i na mao e R$%i no banco", PlayerInfo[playerid][IDF],PlayerInfo[playerid][pDinheiro], PlayerInfo[playerid][pBanco]);
		DCC_SendChannelMessage(Dinn, string);
		InfoMsg(playerid, "Agradecemos por colaborar com a cidade, foi depositado seu pagamento de 30min ativo.");
	}
	return true;
}

CallBack::AnimyTogle(playerid)
{
	ClearAnimations(playerid);
	TogglePlayerControllable(playerid, 1);
	return 1;
} 

CallBack::AnimyTogle2(playerid)
{
	TogglePlayerControllable(playerid, 1);
	return 1;
} 

CallBack::VerificarTeste(playerid)
{
	if(IniciouTesteHabilitacaoA[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaMoto[playerid]))
		{
			new Float:Vida2;
			GetVehicleHealth(AutoEscolaMoto[playerid], Float:Vida2);
			if(Vida2 < 995) // Reprovado
			{
				RemovePlayerFromVehicle(playerid);
				DestroyVehicle(AutoEscolaMoto[playerid]);

				PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
				DisablePlayerRaceCheckpoint(playerid);
				CheckpointPontosMoto[playerid] = 0;
				KillTimer(TimerTesteMoto[playerid]);

				terminouteste(playerid);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				IniciouTesteHabilitacaoA[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Reprovado!", 5001, 6);

				ErrorMsg(playerid, "Voce foi reprovado.");

			}
		}
	}
	else if(IniciouTesteHabilitacaoB[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaVeiculo[playerid]))
		{
			new Float:Vida2;
			GetVehicleHealth(AutoEscolaVeiculo[playerid], Float:Vida2);
			if(Vida2 < 995) // Reprovado
			{
				RemovePlayerFromVehicle(playerid);
				DestroyVehicle(AutoEscolaVeiculo[playerid]);

				PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
				DisablePlayerRaceCheckpoint(playerid);
				CheckpointPontosVeiculo[playerid] = 0;
				KillTimer(TimerTesteVeiculo[playerid]);

				terminouteste(playerid);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				IniciouTesteHabilitacaoB[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Reprovado!", 5001, 6);

				ErrorMsg(playerid, "Voce foi reprovado.");

			}
		}
	}
	else if(IniciouTesteHabilitacaoC[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaCaminhao[playerid]))
		{
			new Float:Vida2;
			GetVehicleHealth(AutoEscolaCaminhao[playerid], Float:Vida2);
			if(Vida2 < 995) // Reprovado
			{
				RemovePlayerFromVehicle(playerid);
				DestroyVehicle(AutoEscolaCaminhao[playerid]);

				PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
				DisablePlayerRaceCheckpoint(playerid);
				CheckpointPontosCaminhao[playerid] = 0;
				KillTimer(TimerTesteCaminhao[playerid]);

				terminouteste(playerid);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				IniciouTesteHabilitacaoC[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Reprovado!", 5001, 6);

				ErrorMsg(playerid, "Voce foi reprovado.");

			}
		}
	}
	return 1;
}

CarregarAnims(playerid) {
  new actorid;
  for(new i = 0; i < sizeof(AnimLibs); i++) {
	  ApplyAnimation(playerid, AnimLibs[i], "null", 4.0, 0, 0, 0, 0, 0, 1);
	  ApplyDynamicActorAnimation(actorid, AnimLibs[i], "null", 4.1, 0, 0, 0, 0, 1);
  }
  return 1;
}

IsNumeric(const string[])
{
	for (new i = 0, j = strlen(string); i < j; i++)
	{
		if (string[i] > '9' || string[i] < '0') return 0;
	}
	return 1;
}

CallBack::PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		//printf("DEBUG: X:%f Y:%f Z:%f",posx,posy,posz);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

CallBack::FomeBar(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	new fome = randomEx(1,3);
	FomePlayer[playerid] -= fome;
	if(FomePlayer[playerid] <= 1)
	{
		new Float:health;
    	GetPlayerHealth(playerid,health);
		SetPlayerHealth(playerid, health-fome);
		FomePlayer[playerid] = 0;
		GameTextForPlayer(playerid, "~y~voce esta com fome", 3000, 3);
	}
	return 1;
}

CallBack::SedeBar(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;
	new sede = randomEx(1,3);
	SedePlayer[playerid] -= sede;
	if(SedePlayer[playerid] <= 1)
	{
		new Float:health;
    	GetPlayerHealth(playerid,health);
		SetPlayerHealth(playerid, health-sede);
		SedePlayer[playerid] = 0;
		GameTextForPlayer(playerid, "~y~voce esta com sede", 3000, 3);
	}
	return 1;
}

CallBack::Colete(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	new BankV[258], str[255];
	new Hora, Minuto;
	new Float:vida,Float:colete;
	GetPlayerHealth(playerid,vida);
	GetPlayerArmour(playerid,colete);
	gettime(Hora, Minuto);

	format(BankV, sizeof(BankV), "%i", PlayerInfo[playerid][pBanco]);
	PlayerTextDrawSetString(playerid, BancoTD[playerid][17], BankV);

	format(BankV, sizeof(BankV), "%i", PlayerInfo[playerid][pDinheiro]);
	PlayerTextDrawSetString(playerid, BancoTD[playerid][16], BankV);

	format(str, sizeof(str), "%d", SedePlayer[playerid]);
	PlayerTextDrawSetString(playerid, HudServer_p[playerid][3], str);

	format(str, sizeof(str), "%d", FomePlayer[playerid]);
	PlayerTextDrawSetString(playerid, HudServer_p[playerid][2], str);

	format(str, sizeof(str), "%.0f", vida);
	PlayerTextDrawSetString(playerid, HudServer_p[playerid][0], str);

	format(str, sizeof(str), "%.0f", colete);
	PlayerTextDrawSetString(playerid, HudServer_p[playerid][1], str);

	checkEE(playerid);
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
	ShowItemBox(playerid, ItemNomeInv(itemid), "Recebeu", itemid, 3);
	for(new i = 1; i < 31; ++i)
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
	ErrorMsg(playerid, "Inventario cheio.");

	return 1;
}

RetirarItem(playerid, modelid)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerInventario[playerid][modelid][Slot] != -1)
		{
			ShowItemBox(playerid, ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), "Removeu", modelid, 3);
			for(new i = 0; i < MAX_OBJECTS; i++)
			{
				if(DropItemSlot[i][DropItem] == 0)
				{
					DropItemSlot[i][DropItemUni] = PlayerInventario[playerid][modelid][Unidades];
					DropItemSlot[i][DropItemID] = PlayerInventario[playerid][modelid][Slot];
					PlayerInventario[playerid][modelid][Unidades] = 0;
					AtualizarInventario(playerid, modelid);
					return 1;
				}
			}
		}
	}
    return 1;
}

stock RetirarItem2(playerid, modelid, qtd)
{
    if(IsPlayerConnected(playerid))
	{
		if(PlayerInventario[playerid][modelid][Slot] != -1)
		{
			ShowItemBox(playerid, ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), "Removeu", modelid, 3);
			for(new i = 0; i < MAX_OBJECTS; i++)
			{
				if(DropItemSlot[i][DropItem] == 0)
				{
					DropItemSlot[i][DropItemUni] = PlayerInventario[playerid][modelid][Unidades];
					DropItemSlot[i][DropItemID] = PlayerInventario[playerid][modelid][Slot];
					if(PlayerInventario[playerid][modelid][Unidades] > 1)
					{
						PlayerInventario[playerid][modelid][Unidades] -= qtd;
					}
					else
					{
						PlayerInventario[playerid][modelid][Unidades] = 0;
						PlayerInventario[playerid][modelid][Slot] = -1;
					}
					AtualizarInventario(playerid, modelid);
					return 1;
				}
			}
		}
	}
    return 1;
}

CallBack::CriarInventario(playerid)
{
	new file[64], str[128], string[128];
	format(file, sizeof(file), PASTA_INVENTARIO, Name(playerid));
	
	if(!DOF2_FileExists(file))
	{
		DOF2_CreateFile(file);
		for(new i = 1; i < 31; ++i)
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

CallBack::LoadInv(playerid)
{
	new file[64], key[64], string[2][64], str[64];
	format(file, sizeof(file), PASTA_INVENTARIO, Name(playerid));
	SetPVarInt(playerid, #VarSlotInv, 0);
	for(new i = 1; i < 31; ++i)
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

CallBack::SalvarInventario(playerid)
{
	new file[64], str[128], string[128];
	format(file, sizeof(file), PASTA_INVENTARIO, Name(playerid));
	if(!DOF2_FileExists(file)){DOF2_CreateFile(file);}
	for(new i = 1; i < 31; ++i)
	{
		format(string, sizeof(string), "Item_%d", i);
		format(str, sizeof(str), "%d|%d", PlayerInventario[playerid][i][Slot], PlayerInventario[playerid][i][Unidades]);
		DOF2_SetString(file, string, str);
		DOF2_SaveFile();
	}
	return 1;
}

CheckInventario(playerid, itemid)
{
	for(new i = 1; i < 31; ++i)
	{
		if(PlayerInventario[playerid][i][Slot] == itemid || PlayerInventario[playerid][i][Slot] == -1) return 1;
	}
	return 0;
}

CheckInventario2(playerid, itemid)
{
	for(new i = 1; i < 31; ++i)
	{
		if(PlayerInventario[playerid][i][Slot] == itemid) return 1;
	}
	return 0;
}

ItemNomeInv(itemid) // AQUI VOCÃŠ PODE ADICIONAR OS ID DOS ITENS E SETAR SEU NOME (OBS: TOME CUIDADO AO OPTAR O USO DE LOOPS)
{
	new name[25];
	format(name, 25, "(null)");
	if(itemid >= 330 && itemid < 372) format(name, 25, NomeArmas(GetArmaInv(itemid))); // se for armas
	if(itemid > 0 && itemid < 312 ) format(name, 50, "Skin %d",itemid); // se for skin
	if(itemid > 400 && itemid < 611 ) format(name, 50, "Veiculo %d",itemid); // se for skin
	else
	switch(itemid) 
	{
		case 19625: name = "Cigarro do K2";//Editavel
		case 11746: name = "LockPick";
		case 3044: name = "Baseado";//Editavel
		case 19039: name = "Relogio de Ouro";
		case 19040: name = "Relogio de Prata";
		case 19042: name = "Relogio Dourado";
		case 19044: name = "Relogio Rosa";
		case 19045: name = "Relogio Vermelho";
		case 19046: name = "Relogio Verde";
		case 19047: name = "Relogio Roxo";
		case 11747: name = "Baseado";
		case 18865: name = "Celular -1";
		case 18866: name = "Celular Azul";
		case 18867: name = "Celular -1";
		case 18868: name = "Celular Preto";
		case 18869: name = "Celular Rosa";
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
		case 19027: name = "Oculos -1";
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
		case 19574: name = "-1";
		case 19575: name = "Maca";
		case 19576: name = "Maca Verde";
		case 2703: name = "Hamburger";
		case 2880: name = "Hamburger";
		case 19883: name = "Fatia de Pao";
		case 19896: name = "Maco de Cigarro";
		case 19897: name = "Maco de Cigarro";
		case 2768: name = "Hamburger";
		case 1212: name = "Dinheiro Sujo";
		case 19835: name = "Cafe";
		case 2881: name = "Fatia de Pizza";
		case 2702: name = "Fatia de Pizza";
		case 2769: name = "Taco";
		case 2709: name = "Remedio";
		case 19579: name = "Pao";
		case 19630: name = "Peixe Tilapia";
		case 902: name = "Estrela do Mar";
		case 1603: name = "Agua Viva";
		case 1600: name = "Peixe Azul";
		case 1599: name = "Peixe Amarelo";
		case 18644: name = "Chaira";
		case 1604: name = "Peixe Rain";
		case 1608: name = "Tubarao";
		case 19094: name = "Hamburger";
		case 1582: name = "Pizza Media";
		case 19580: name = "Pizza Grande";
		case 19602: name = "Mina Terrestre";
		case 1654: name = "Dinamite";
		case 1650: name = "Galao de Gasolina";
		case 19893: name = "Notebook";
		case 2226: name = "Radio";
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
		case 1581: name = "Documento";
		case 19792: name = "Carteira de Trabalho";
		case 2218: name = "Pizza N1";
		case 2355: name = "Pizza N2";
		case 2219: name = "Pizza N3";
		case 2220: name = "Pizza N4";
		case 1484: name = "Agua";
		case 1644: name = "Suco";
		case 1546: name = "Sprite";
		case 2601: name = "Sprunk";
		case 18645: name = "Capacete";
		case 18870: name = "Celular";
		case 11738: name = "Caixa Primeiros Socorros";
		case 3027: name = "Maconha";
		case 1279: name = "Cocaine";
		case 3930: name = "Crack";
		case 3520: name = "Semente de Maconha";
		case 19921: name = "Caixa de ferramentas";
		case 18632: name = "Vara de Pescar";
		case 11750: name = "Algema";
		case 11736: name = "Bandagem";
		case 1010: name = "Kit de Tunagem";
		case 1576: name = "Maconha";
		case 370: name = "JetPack";
		case 3016: name = "Caixa Basica";
		case 3013: name = "Caixa Media";
		case 19056: name = "Caixa Avancada";
		default: name = "Desconhecido";
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
			ShowItemBox(playerid, ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), "Dropou", modelid, 3);
			GetPlayerPos(playerid, x,y,z);
			for(new i = 0; i < MAX_OBJECTS; i++)
			{
				if(DropItemSlot[i][DropItem] == 0)
				{
					DropItemSlot[i][DropItem] = CreateDynamicObject(18631, x,y,z-1, 0, 0, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
					DropItemSlot[i][DropItemUni] = PlayerInventario[playerid][modelid][Unidades];
					DropItemSlot[i][DropItemID] = PlayerInventario[playerid][modelid][Slot];
					DropItemSlot[i][Virtual] = GetPlayerVirtualWorld(playerid);
					DropItemSlot[i][Interior] = GetPlayerInterior(playerid);
					format(str, sizeof(str), "{FFFF00}%s\n{FFFFFF}X%s", ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), ConvertMoney(PlayerInventario[playerid][modelid][Unidades]));
					DropItemSlot[i][LabelItem] = CreateDynamic3DTextLabel(str, -1, x,y,z-1, 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
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

FuncaoItens(playerid, modelid)//  AQUI VOCÃŠ PODE DEFINIR AS FUNÃ‡Ã•ES DE CADA ITEM. SEGUE AS FUNÃ‡Ã•ES PRONTAS ABAIXO
{
	new fomesede = randomEx(1,20);
	switch(PlayerInventario[playerid][modelid][Slot])
	{
		case 3016:
		{
			new caixar = randomEx(0,3);
			new string[255];
			if(caixar == 0)
			{
				GanharItem(playerid, 3013, 1);
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar uma {FFFF00}Caixa Media {FFFFFF}na Caixa Basica!", PlayerInfo[playerid][IDF]);
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 1 || caixar == 2)
			{
				new dinmoney = randomEx(0, 10000);
				PlayerInfo[playerid][pDinheiro] += dinmoney;
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}%s de dinheiro {FFFFFF}na Caixa Basica!", PlayerInfo[playerid][IDF], ConvertMoney(dinmoney));
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 3)
			{
				new dinmoneysuj = randomEx(0, 10000);
				GanharItem(playerid, 1212, dinmoneysuj);
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}%s de dinheiro {FFFFFF}sujo na Caixa Basica!", PlayerInfo[playerid][IDF], ConvertMoney(dinmoneysuj));
				SendClientMessageToAll(-1, string);
			}
			PlayerInventario[playerid][modelid][Unidades] --;
			AtualizarInventario(playerid, modelid);
		}
		case 3013:
		{
			new caixar = randomEx(0,3);
			new string[255];
			if(caixar == 0)
			{
				new vip[255];
				PlayerInfo[playerid][ExpiraVIP] = ConvertDays(10); 
				PlayerInfo[playerid][pVIP] = 1;
				format(vip, sizeof(vip), PASTA_VIPS, Name(playerid)); 
				DOF2_CreateFile(vip); 
				DOF2_SetInt(vip,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
				DOF2_SaveFile(); 
				SuccesMsg(playerid, "Comprou um vip e recebeu seus beneficios.");
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(vip,sizeof(vip),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP BASICO\nValor: 10000", PlayerInfo[playerid][IDF]);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, vip);
				DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar um {FFFF00}VIP BASICO {FFFFFF}por 10dias na Caixa Media!", PlayerInfo[playerid][IDF]);
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 1)
			{
				new dinmoney = randomEx(0, 10000);
				PlayerInfo[playerid][pDinheiro] += dinmoney;
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}%s de dinheiro {FFFFFF}na Caixa Media!", PlayerInfo[playerid][IDF], ConvertMoney(dinmoney));
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 2)
			{
				new dinmoney = randomEx(0, 10000);
				PlayerInfo[playerid][pDinheiro] += dinmoney;
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}%s de dinheiro {FFFFFF}na Caixa Media!", PlayerInfo[playerid][IDF], ConvertMoney(dinmoney));
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 3)
			{
				new dinmoneysuj = randomEx(0, 10000);
				PlayerInfo[playerid][pCoins] += dinmoneysuj;
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}%s de coins {FFFFFF}na Caixa Media!", PlayerInfo[playerid][IDF], ConvertMoney(dinmoneysuj));
				SendClientMessageToAll(-1, string);
			}
			PlayerInventario[playerid][modelid][Unidades] --;
			AtualizarInventario(playerid, modelid);
		}
		case 19056:
		{
			new caixar = randomEx(0,3);
			new string[255];
			if(caixar == 0)
			{
				new vip[255];
				PlayerInfo[playerid][ExpiraVIP] = ConvertDays(10); 
				PlayerInfo[playerid][pVIP] = 2;
				format(vip, sizeof(vip), PASTA_VIPS, Name(playerid)); 
				DOF2_CreateFile(vip); 
				DOF2_SetInt(vip,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
				DOF2_SaveFile(); 
				SuccesMsg(playerid, "Comprou um vip e recebeu seus beneficios.");
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(vip,sizeof(vip),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP PREMIUM\nValor: 25000", PlayerInfo[playerid][IDF]);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, vip);
				DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar um {FFFF00}VIP PREMIUM {FFFFFF}por 10dias na Caixa Avancada!", PlayerInfo[playerid][IDF]);
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 1)
			{
				GanharItem(playerid, 560, 1);
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: Sultan", PlayerInfo[playerid][IDF]);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_560.jpg");
				DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}Sultan de Inventario {FFFFFF}na Caixa Avancada!", PlayerInfo[playerid][IDF]);
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 2)
			{
				new dinmoney = randomEx(0, 50000);
				PlayerInfo[playerid][pDinheiro] += dinmoney;
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}%s de dinheiro {FFFFFF}na Caixa Avancada!", PlayerInfo[playerid][IDF], ConvertMoney(dinmoney));
				SendClientMessageToAll(-1, string);
			}
			if(caixar == 3)
			{
				PlayerInfo[playerid][pCoins] += 5000;
				format(string, sizeof string, "{FFFF00}%04d {FFFFFF}acaba de ganhar {FFFF00}5000 de coins {FFFFFF}na Caixa Avancada!", PlayerInfo[playerid][IDF]);
				SendClientMessageToAll(-1, string);
			}
			PlayerInventario[playerid][modelid][Unidades] --;
			AtualizarInventario(playerid, modelid);
		}
		case 11746:
		{
			new Float:VehX, Float:VehY, Float:VehZ, Count;
			if(LockUse[playerid] == true) return ErrorMsg(playerid, "Voce ja esta usando a lockpick");
			for(new i; i < MAX_VEHICLES; i++)
			{
				GetVehiclePos(i, VehX, VehY, VehZ);
				if(IsPlayerInRangeOfPoint(playerid, 2.0, VehX, VehY, VehZ))
				{
					Count++, VehicleLockedID[playerid] = i;
					if(Count == 1) break;
				}
			}
			if(Count == 0) return ErrorMsg(playerid, "Nao tem nenhum veiculo proximo!");
			cmd_inventario(playerid);
			GetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), LockUse[playerid] = true, LockCount[playerid] = 0, CreateLocPick(playerid);
			for(new i; i < 12; i++) 
			{ 
				PlayerTextDrawShow(playerid, LockText[i]); 
			}
		}
		case 19921:
		{
			if(!IsPlayerInAnyVehicle(playerid)) return ErrorMsg(playerid, "Voce nao esta em um veiculo!"); 
			if(GetPlayerVehicleSeat(playerid) != 0)	return ErrorMsg(playerid, "Nao esta dentro do veiculo.");
			if(IsPlayerInAnyVehicle(playerid)) return InfoMsg(playerid, "Voce esta em um veiculo.");

			cmd_inventario(playerid);
			TogglePlayerControllable(playerid, 0);
			CreateProgress(playerid, "RepararVeh","Reparando Veiculo...", 100);
			ocupadodemais[playerid] = 1;
			PlayerInventario[playerid][modelid][Unidades] --;
			AtualizarInventario(playerid, modelid);
			
			return true;
		}
		
		case 400..611:
		{
			//if(PlayerInfo[playerid][pVIP] < 1 || PlayerInfo[playerid][pAdmin] < 1) return ErrorMsg(playerid, "Sem permissao");
			new Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid, X,Y,Z);
			GetPlayerFacingAngle(playerid, A);
			cmd_inventario(playerid);
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(PlayerInventario[playerid][modelid][Slot], X, Y, Z, A, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
				
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
			AtualizarInventario(playerid, modelid);
		}
		case 3520:
		{

			if(GetPlayerInterior(playerid) > 0 || IsPlayerInAnyVehicle(playerid))
				return ErrorMsg(playerid, "Nao pode plantar uma semente agora!");

			if(CountPlantacao(playerid) >= 10)
				return ErrorMsg(playerid, "Ja possui 10 plantacoes.");

			if(PlantandoMaconha[playerid] == true)
				return ErrorMsg(playerid, "Ja esta plantanddo uma semente.");
			cmd_inventario(playerid);
			for(new mac = 0; mac < MAX_MACONHA; mac++)
			{
				if(MaconhaInfo[mac][PodeUsar] == false && IsPlayerInRangeOfPoint(playerid, 5.0, MaconhaInfo[mac][mX],MaconhaInfo[mac][mY],MaconhaInfo[mac][mZ]))
				{
					SuccesMsg(playerid, "Ja tem uma plantacao nesse local.");
					return true;
				}
			}

			new slt = CheckSlot();

			if(slt == -1)
				return SuccesMsg(playerid, "Ja plantou muitas sementes..");

			ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop",4.1,0,1,1,1,60000,1);
			SetTimerEx("AnimatioN", 500, false, "i", playerid);
			SetTimerEx("PlantarMaconhas", 17000, false, "id", playerid, slt);
			PlantandoMaconha[playerid] = true;
			SuccesMsg(playerid, "Espere que se complete.");

			PlayerInventario[playerid][modelid][Unidades] --;
			AtualizarInventario(playerid, modelid);
			return true;
		}
		case 18632:
		{
			if(PlayerInfo[playerid][pProfissao] != 1) 	return ErrorMsg(playerid, "Nao possui permissao.");
			if(PlayerInventario[playerid][modelid][Unidades] < 1) return ErrorMsg(playerid, "Nao tem uma vara de pesca.");
			if(UsouCMD[playerid] == true) 	return ErrorMsg(playerid, "Ainda nao finalizou a pesca atual."); 
			for(new i; i < 13; i++)
			if(IsPlayerInRangeOfPoint(playerid, 2.0, PosPesca[i][0], PosPesca[i][1], PosPesca[i][2]))
			{
				cmd_inventario(playerid);
				CreateProgress(playerid, "Pesca","Pescando...", 60);
				TogglePlayerControllable(playerid, 0);
				UsouCMD[playerid] = true;	
			}
			return 1;		
		}
		case 18644:
		{
			if(PlayerInventario[playerid][modelid][Unidades] < 1) return ErrorMsg(playerid, "Nao tem uma chaira.");
			if(PlayerInfo[playerid][pProfissao] != 3) 	return ErrorMsg(playerid, "Nao possui permissao.");
			if(UsouCMD[playerid] == true) 	return ErrorMsg(playerid, "Ainda nao finalizou a desossamento atual."); 
			if(Desossando[playerid] == 1 || Desossando[playerid] == 2 || Desossando[playerid] == 3) 	return ErrorMsg(playerid, "Voce ja esta fazendo as etapas."); 
			for(new i; i < 8; i++)
			if(IsPlayerInRangeOfPoint(playerid, 1, PosDesossa[i][0], PosDesossa[i][1], PosDesossa[i][2]))
			{
				CreateProgress(playerid, "Desossar","Desossando...", 100);
				TogglePlayerControllable(playerid, 0);
				RemovePlayerAttachedObject(playerid, 1);
				UsouCMD[playerid] = true;
			}
		}
		case 902:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(50, 550);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 entrela do mar e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 entrela do mar e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 19630:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(50, 200);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 tilapia e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 tilapia e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1599:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(50, 250);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 peixe amarelo e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 peixe amarelo e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1609:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(50, 250);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 peixe rain e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 peixe rain e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1600:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(50, 250);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 peixe azul e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 peixe azul e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1603:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(50, 800);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 agua viva e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 agua viva e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1608:
		{
			if(PlayerToPoint(3.0, playerid, 163.968444, -1941.403564, 3.773437))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return ErrorMsg(playerid, "Quantidade insuficiente");
				new dinpeixes = randomEx(200, 1000);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 tubarao e ganhou R$%i.", dinpeixes);
					SuccesMsg(playerid, Str); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 tubarao e ganhou R$%i.", dinpeixes*2);
					SuccesMsg(playerid, Str); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 331..371:
		{
			cmd_inventario(playerid);
			if(PlayerInventario[playerid][modelid][Slot] == 370)
			{
				SetPlayerSpecialAction(playerid, 2);
				SuccesMsg(playerid, "Pegou um JetPack.");
			}
			else
			{
				GivePlayerWeapon(playerid, GetArmaInv(PlayerInventario[playerid][modelid][Slot]), PlayerInventario[playerid][modelid][Unidades]);
				PlayerInventario[playerid][modelid][Unidades] = 0;
			}
			AtualizarInventario(playerid, modelid);
			return 1;
		}
		case 1010:
		{
			if(IsPlayerInRangeOfPoint(playerid, 10.0, -2067.039306, 1396.001342, 7.334959) || IsPlayerInRangeOfPoint(playerid, 10.0, -2067.137695, 1404.691040, 7.334959) || IsPlayerInRangeOfPoint(playerid, 10.0, -2067.062255, 1414.094726, 7.334959) || IsPlayerInRangeOfPoint(playerid, 10.0, -2067.082519, 1423.175659, 7.334959) || IsPlayerInRangeOfPoint(playerid, 10.0, -2066.899169, 1432.542114, 7.334959))
			{
				if(!IsPlayerInAnyVehicle(playerid)) return ErrorMsg(playerid, "Voce nao esta em um veiculo!"); 

				if(GetPlayerVehicleSeat(playerid) != 0)
					return ErrorMsg(playerid, "Nao esta dentro do veiculo.");

				if(!GetVehicleModelEx(GetVehicleModel(GetPlayerVehicleID(playerid))))
					return ErrorMsg(playerid, "Este veiculo nao pode ser tunado.");
				if(wTuning[playerid] == true)
					return ErrorMsg(playerid, "Ja esta tunando.");

				static
					nome_veiculo[40]
				;

				cmd_inventario(playerid);
				format(nome_veiculo, sizeof(nome_veiculo), "veiculo: %s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]);
				PlayerTextDrawSetString(playerid, PlayerText:wMenu[0], nome_veiculo);

				SuccesMsg(playerid, "Tunando Veiculo.");

				for(new i; i < sizeof(wBase); i++) { TextDrawShowForPlayer(playerid, Text:wBase[i]); }
				for(new i; i < sizeof(wMenu); i++) { PlayerTextDrawShow(playerid, PlayerText:wMenu[i]); }
				for(new i; i < sizeof(wMenuRodas); i++) { PlayerTextDrawShow(playerid, PlayerText:wMenuRodas[i]); }

				SelectTextDraw(playerid, 0x4F4F4FFF);
				wTuning[playerid] = true;
				PlayerInventario[playerid][modelid][Unidades]--;
				AtualizarInventario(playerid, modelid);
			}
			return 1;
		}
		case 1484, 1644, 1546, 2601:
		{
			if(SedePlayer[playerid] >= 80) return ErrorMsg(playerid, "Nao esta com sede.");
			SedePlayer[playerid] += fomesede;
			PlayerInventario[playerid][modelid][Unidades]--;
			ApplyAnimation(playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 0, 0, 0, 0, 1);
			AtualizarInventario(playerid, modelid);
			return 1;
		}
		case 2218, 2355, 2219, 2220:
		{
			if(FomePlayer[playerid] >= 80) return ErrorMsg(playerid, "Nao esta com fome.");
			FomePlayer[playerid] += fomesede;
			PlayerInventario[playerid][modelid][Unidades]--;
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
			AtualizarInventario(playerid, modelid);
			return 1;
		}
		case 1576:
		{
			for(new i; i < 303; i++)
			if(IsPlayerInRangeOfPoint(playerid,2.0,PosRota[i][0],PosRota[i][1],PosRota[i][2]))
			{
				new dinma = randomEx(100, 2000);
				new qtdka = randomEx(10, 80);
				new noti = randomEx(0, 2);
				cmd_iniciarrotamaconha(playerid);
				SuccesMsg(playerid, "Entrega feita, passe para a proxima rota.");
				PlayerInventario[playerid][modelid][Unidades] -= qtdka;
				GanharItem(playerid,1212, dinma);
				AtualizarInventario(playerid, modelid);
				new location[MAX_ZONE_NAME];
				GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);
				if(noti == 1)
				{
					foreach(new p: Player)
					{
						if(Patrulha[p] == true)
						{
							format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo vendendo entorpecentes em %s", location);
							WarningMsg(p, Str);
						}
					}
				}
			}
		}
		case 1575:
		{
			for(new i; i < 303; i++)
			if(IsPlayerInRangeOfPoint(playerid,2.0,PosRota[i][0],PosRota[i][1],PosRota[i][2]))
			{
				cmd_inventario(playerid);
				new dinma = randomEx(100, 2000);
				new qtdka = randomEx(10, 80);
				new noti = randomEx(0, 2);
				cmd_iniciarrotacocaina(playerid);
				SuccesMsg(playerid, "Entrega feita, passe para a proxima rota.");
				PlayerInventario[playerid][modelid][Unidades] -= qtdka;
				GanharItem(playerid,1212, dinma);
				AtualizarInventario(playerid, modelid);
				new location[MAX_ZONE_NAME];
				GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);
				if(noti == 1)
				{
					foreach(new p: Player)
					{
						if(Patrulha[p] == true)
						{
							format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo vendendo entorpecentes em %s", location);
							WarningMsg(p, Str);
						}
					}
				}
			}
		}
		case 18645:
		{
			cmd_inventario(playerid);
			if(EquipouCasco[playerid] == 0)
			{
				SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.07, 0, 0, 88, 75, 0);
				AtualizarInventario(playerid, modelid);
				EquipouCasco[playerid] = 1;
			}
			else
			{
				RemovePlayerAttachedObject(playerid,1);
				AtualizarInventario(playerid, modelid);
				EquipouCasco[playerid] = 0;
			}
			return 1;
		}
		case 18870:
		{
			cmd_inventario(playerid);
			AtualizarInventario(playerid, modelid);
			ShowPlayerDialog(playerid, DIALOG_CELULAR, DIALOG_STYLE_LIST, "Telefone", "Transferencia PIX\nFazer Anuncio\t{32CD32}R$5000", "Confirmar", "X");
			return 1;
		}
		case 11738:
		{
			cmd_inventario(playerid);
			format(Str, sizeof(Str),"Introduza o ID do jogador que quer reanimar");
			ShowPlayerDialog(playerid,DIALOG_REANIMAR,1,"Reanimar jogador", Str, "Confirmar",#);
			PlayerInventario[playerid][modelid][Unidades]--;
			AtualizarInventario(playerid, modelid);
		}
		case 1654:
		{
			new caixa_id;
			if(!(caixa_id=GetPlayerCaixa(playerid)))return ErrorMsg(playerid, "Nao esta proximo de um caixa.");
			if(CaixaInfo[caixa_id][Caixa_Roubada])return ErrorMsg(playerid, "Este caixa ja foi roubado.");
			if(TendoRoubo)return ErrorMsg(playerid, "Ja roubaram a pouco tempo.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");
			cmd_inventario(playerid);
			
			new
			Float:px, Float:py, Float:pz,
			Float:rx, Float:ry, Float:rz
			;

			GetDynamicObjectPos(CaixaInfo[caixa_id][Caixa_Object], px, py, pz);
			GetDynamicObjectRot(CaixaInfo[caixa_id][Caixa_Object], rx, ry, rz);
			GetXYInFrontOfCaixa(CaixaInfo[caixa_id][Caixa_Object], px, py, 0.9);

			UltimaCaixaRoubada[0] = px;
			UltimaCaixaRoubada[1] = py;
			UltimaCaixaRoubada[2] = pz;

			RoubandoCaixa[playerid] = false;

			SetPlayerSpecialAction(playerid, 0);
			SetPlayerPos(playerid, px, py, pz);
			SetPlayerFacingAngle(playerid, rz);
			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0);
			
			SetTimerEx("RoubarCaixa", 20*1000, 0, "dd", playerid, GetPlayerCaixa(playerid));
			SetTimerEx(#SetAnimRoubo, 500, 0, "d", playerid);
			PlayerInventario[playerid][modelid][Unidades]--;
			AtualizarInventario(playerid, modelid);

			CaixaInfo[caixa_id][Caixa_Roubada] = true;

			new location[MAX_ZONE_NAME];
			GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);
			new noti = randomEx(0, 2);
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar um caixa em %s", location);
						WarningMsg(i, Str);
					}
				}
			}

			InfoMsg(playerid, "Voce esta colocando um explosivo.");
			return 1;
		}
		case 11736:
		{
			new Float:health;
    		GetPlayerHealth(playerid,health);
			if(health >= 80) return ErrorMsg(playerid, "Voce nao pode usar bandagem agora.");
			
			SetPlayerHealth(playerid, health+10);
			PlayerInventario[playerid][modelid][Unidades]--;
			AtualizarInventario(playerid, modelid);
			return 1;
		}
	}
	return 0;
}

static GetArmaInv(i)
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

IsValidItemInv(itemid) //AQUI VOCÃŠ DEVE DEFINIR OS ID'S DOS ITENS PARA SER VALIDO AO SETAR, CASO CONTRARIO RETORNARA COMO ERRO
{
	if(GetArmaInv(itemid)) return 1;
	switch(itemid)
	{
		case 2218, 2355, 2219, 2220, 1484, 1644, 1546, 1581, 19823, 19820, 11722, 11723, 19570, 19824, 1486, 19822, 1668, 2958, 19625, 11746,
		1853, 1854, 1855, 19792, 3044, 19039, 19040, 19042, 19044, 19045, 19046, 19047, 11747, 18865, 18866, 18867, 
		18645, 1856, 18868, 18869, 18870, 18871, 18872, 18873, 18874, 19513, 18875, 19874, 19138, 19139, 
		19140, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19473, 3027, 3520,
		19033, 19034, 19035, 2992, 3065, 11712, 18953, 18954, 19554, 18974, 2114, 1279, 3930, 19630, 902, 1603, 1600, 1599, 1604, 1608,
		18894, 18903, 18898, 18899, 18891, 18909, 18908, 18907, 18906, 18905, 18904, 18901, 1010,
		18902, 18892, 18900, 18897, 18896, 18895, 18893, 18810, 18947, 18948, 18949, 18950, 18644,
		18951, 19488, 18921, 18922, 18923, 18924, 18925, 18939, 18940, 18941, 18942, 18943, 11750,
		1314, 19578, 18636, 19942, 18646, 19141, 19558, 19801, 19330, 1210, 19528, 1576, 370, 3016, 3013, 19056,
		19134, 19904, 19515, 19142, 19315, 19527, 19317, 18688, 18702, 18728, 19605, 19606, 18632,
		19607, 19577, 1485, 19574, 19575, 19576, 2703, 2880, 19883, 19896, 19897, 2768, 1212, 
		2601, 19835, 2881, 2702, 2769, 2709, 19579, 19094, 1582, 19580, 19602, 11738, 
		1654, 11736, 1650, 1252, 19893, 19921, 2226, 19054, 19055, 19057,19058: return 1;
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

CallBack::AntiAway()
{
	if(AntiAFK_Ativado == false) return 0;
	new Float:X, Float:Y, Float:Z;
	new Float:CX, Float:CY, Float:CZ;
	foreach(new i: Player)
	{
		if(!IsPlayerConnected(i) || pLogado[i] == false) return 0;
		GetPlayerPos(i, X, Y, Z);
		GetPlayerCameraPos(i, CX, CY, CZ);
		if(X == PlayerInfo[i][pPosX] && Y == PlayerInfo[i][pPosY] && Z == PlayerInfo[i][pPosZ]) SetTimerEx("TestAway", 1000, false, "ii", i, 10), Moved[i] = false;
		GetPlayerPos(i, PlayerInfo[i][pPosX], PlayerInfo[i][pPosY], PlayerInfo[i][pPosZ]);
		GetPlayerCameraPos(i, PlayerInfo[i][pCamX], PlayerInfo[i][pCamY], PlayerInfo[i][pCamZ]);
	}
	return 1;
}

CallBack::TestAway(playerid, TimeTo)
{
	if(AntiAFK_Ativado == false)
	{
		TextDrawHideForPlayer(playerid, Textdraw0);
		TextDrawHideForPlayer(playerid, Textdraw1);
		PlayerTextDrawHide(playerid, Textdraw2[playerid]);
		return 0;
	}
	if(Moved[playerid] == true)
	{
		TextDrawHideForPlayer(playerid, Textdraw0);
		TextDrawHideForPlayer(playerid, Textdraw1);
		PlayerTextDrawHide(playerid, Textdraw2[playerid]);
		return 0;
	}
	new Float:X, Float:Y, Float:Z;
	new Float:CX, Float:CY, Float:CZ;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerCameraPos(playerid, CX, CY, CZ);
	if(X != PlayerInfo[playerid][pPosX] || Y != PlayerInfo[playerid][pPosY] || Z != PlayerInfo[playerid][pPosZ] || CX != PlayerInfo[playerid][pCamX] || CY != PlayerInfo[playerid][pCamY] || CZ != PlayerInfo[playerid][pCamZ])
	{
		TextDrawHideForPlayer(playerid, Textdraw0);
		TextDrawHideForPlayer(playerid, Textdraw1);
		PlayerTextDrawHide(playerid, Textdraw2[playerid]);
		return 0;
	}
	if(TimeTo == 0)
	{
		InfoMsg(playerid, "Foi expulso por esta AFK.");	
		TextDrawHideForPlayer(playerid, Textdraw0);
		TextDrawHideForPlayer(playerid, Textdraw1);
		PlayerTextDrawHide(playerid, Textdraw2[playerid]);
		PlayerTextDrawDestroy(playerid, Textdraw2[playerid]);
		Kick(playerid);
		return 0;
	}
	TextDrawShowForPlayer(playerid, Textdraw0);
	TextDrawShowForPlayer(playerid, Textdraw1);
	format(Motivo, sizeof(Motivo), "%i", TimeTo);
	PlayerTextDrawSetString(playerid, Textdraw2[playerid], Motivo);
	PlayerTextDrawShow(playerid, Textdraw2[playerid]);
	return SetTimerEx("TestAway", 1000, false, "ii", playerid, TimeTo - 1);
}

CallBack::SpawnP(playerid)
{
	#undef SpawnPlayerID
	SpawnPlayer(playerid);
	#define SpawnPlayerIDerI(%0) SetTimerEx("SpawnP", 500, false, "i", %0)
	return 1;
}

CallBack::KickPlayer(playerid)
{
	#undef Kick
	Kick(playerid);
	#define Kick(%0) SetTimerEx("KickPlayer", 500, false, "i", %0)
	return 1;
}

CallBack::CheckCadeia()
{
	foreach(new i: Player)
	{
		if(!IsPlayerConnected(i) || pLogado[i] == false) return 0;
		PlayerInfo[i][pSegundosJogados] += 2;
		if(PlayerInfo[i][pCadeia] > 0)
		{
			PlayerInfo[i][pCadeia]-= 2;
			SetPlayerHealth(i, 9999);
			if(PlayerInfo[i][pCadeia] == 0)
			{
				SpawnPlayer(i);
				SetPlayerInterior(i, 0);
				SetPlayerVirtualWorld(i, 0);
				SetPlayerHealth(i, 100);
				InfoMsg(i, "esta livre.");
			}
			else
			{
				if(!IsPlayerInRangeOfPoint(i, 50.0, 322.197998, 302.497985, 999.148437))
				{
					SetPlayerVirtualWorld(i, i);
					SetPlayerPos(i, 322.197998,302.497985,999.148437);
					SetPlayerInterior(i, 5);
					TogglePlayerControllable(i, false);
					SetTimerEx("carregarobj", 5000, 0, "i", i);
					InfoMsg(i, "Ainda nao cumpriu sua prissao..");
				}
			}
		}
	}
	return 1;
}

CallBack::DiminuirTempo(Time)
{
		if(Time == 0)
		{
			GameTextForAll("~r~VAAAIVAI !", 1000, 6);
			ContagemIniciada = false;
		}
		else
		{
			format(Str, sizeof(Str), "~g~%d", Time);
			GameTextForAll(Str, 1000, 6);
			SetTimerEx("DiminuirTempo", 1000, false, "i", Time - 1);
		}
		return 1;
}

CallBack::ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
	if(IsPlayerConnected(playerid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		foreach(new i: Player)
		{
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				new playerworld, player2world;
				playerworld = GetPlayerVirtualWorld(playerid);
				player2world = GetPlayerVirtualWorld(i);
				if(playerworld == player2world)
				{
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

CallBack::Relogio()
{
	new minuto, hora, segundo, string[155];

	gettime(hora, minuto, segundo);

	switch(hora)
	{
		case 6:
			{ SetWorldTime(8); }
		case 9:
			{ SetWorldTime(10); }
		case 12:
			{ SetWorldTime(12); }
		case 13:
			{ SetWorldTime(15); }
		case 14:
			{ SetWorldTime(16); }
		case 15:
			{ SetWorldTime(18); }
		case 17:
			{ SetWorldTime(20); }
		case 18:
			{ SetWorldTime(21); }
		case 19:
			{ SetWorldTime(23); }
		case 23:
			{ SetWorldTime(0); }
		case 22:
			{ SetWorldTime(0); }
		case 0:
			{ SetWorldTime(3); }
		case 5:
			{ SetWorldTime(2); }
	}
	format(string, sizeof(string), "%02d:%02d", hora, minuto);
    TextDrawSetString(gServerTextdraws, string);
	return 1;
}

//                          STOCKS

stock IsPlayerInPlace(playerid,Float:XMin,Float:YMin,Float:XMax,Float:YMax )
{
	new RetValue = 0;
	new Float:X,Float:Y,Float:Z;
	GetPlayerPos(playerid,X,Y,Z );

	if( X >= XMin && Y >= YMin && X < XMax && Y < YMax )
	{
	RetValue = 1;
	}
	return RetValue;
}

stock GetVehicleTrunkPosition(vehicleid, &Float:x, &Float:y, &Float:z)
{
    new
        Float:vehsize,
        Float:vehangle,
        Float:n;
    
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, vehangle);
    
    GetVehicleModelInfo(GetVehicleModel(vehicleid), VEHICLE_MODEL_INFO_SIZE, n, vehsize, n);
    
    x -= ((vehsize / 1.6) * floatsin(-vehangle, degrees));
    y -= ((vehsize / 1.6) * floatcos(-vehangle, degrees));
} 

stock GuardarItem2(playerid)
{
	new Item = GetPlayerWeapon(playerid);
	new Ammo = GetPlayerAmmo(playerid);
	new orgid = GetPlayerOrg(playerid);
	if(Item == 0) return SCM(playerid, -1, "{FF2400}[ x ] {BEBEBE}Voce nao pode Guardar Sua Mao no Bau.");
	new i;
	while(i != 20)
	{
		if(CofreArma[i][orgid] == 0)
		{
			CofreArma[i][orgid]=Item;
			CofreAmmo[i][orgid]=Ammo;
			RemoverItem2(playerid, Item);
            SalvarCofre(orgid);
			break;
		}
		i++;
	}
 	return i == 20 ? SCM(playerid, -1, "{FF2400}[ x ] {BEBEBE}Seu Bau Esta Cheio!") : 1;
}

stock RemoverItem2(playerid, item)
{
	new Arma[13][2];
	for(new i = 1; i < 13; ++i) GetPlayerWeaponData(playerid, i, Arma[i][0], Arma[i][1]);
	ResetPlayerWeapons(playerid);
	for(new i = 1; i < 13; ++i)
	{
		if(item != Arma[i][0]) GivePlayerWeapon(playerid, Arma[i][0], Arma[i][1]);
	}
}

stock ItemOpcoes2(playerid, Item)
{
	new orgid = GetPlayerOrg(playerid);
	if(CofreArma[Item][orgid] == 0) return PlayerPlaySound(playerid, 1053, 0.0, 0.0, 0.0);
	ItemOpcao[playerid]=Item;
	return ShowPlayerDialog(playerid,DIALOG_ARMAS12,DIALOG_STYLE_LIST,"Bau da Org","Pegar Arma\nRetirar do Bau e Jogar no Chao","OK","Fechar");
}

stock SalvarCofreF(idbau)
{
    new Arq[5000];
	format(Arq, sizeof(Arq), PASTA_COFRES, idbau);
	if(DOF2_FileExists(Arq))
	{
	    DOF2_SetInt(Arq, "CofreID", CofreInfo[idbau][CofreID]);
	    DOF2_SetFloat(Arq, "CofrePosX", CofreInfo[idbau][CofrePosX]);
	    DOF2_SetFloat(Arq, "CofrePosY", CofreInfo[idbau][CofrePosY]);
	    DOF2_SetFloat(Arq, "CofrePosZ", CofreInfo[idbau][CofrePosZ]);
		DOF2_SetFloat(Arq, "CofrePosR", CofreInfo[idbau][CofrePosR]);
		DOF2_SaveFile();
	}
	return 1;
}

stock SalvarCofre(idorg)
{
	new Arq[5000], str[5000];
	format(Arq, sizeof(Arq), PASTA_COFRES, idorg);
	if(DOF2_FileExists(Arq))
	{
		for(new i = 0; i != 20; ++i)
		{
			format(str, sizeof(str), "Arma inv %d", i);
			DOF2_SetInt(Arq, str, CofreArma[i][idorg]);
			format(str, sizeof(str), "Ammo inv %d", i);
			DOF2_SetInt(Arq, str, CofreAmmo[i][idorg]);
		}
		DOF2_SetInt(Arq, "CofreID", CofreInfo[idorg][CofreID]);
		DOF2_SaveFile();
	}
	else
	{
	    DOF2_CreateFile(Arq);
	    for(new i = 0; i != 20; ++i)
		{
			format(str, sizeof(str), "Arma inv %d", i);
			DOF2_SetInt(Arq, str, CofreArma[i][idorg]);
			format(str, sizeof(str), "Ammo inv %d", i);
			DOF2_SetInt(Arq, str, CofreAmmo[i][idorg]);
		}
		DOF2_SetInt(Arq, "CofreID", CofreInfo[idorg][CofreID]);
		DOF2_SaveFile();
	}
	return 1;
}

stock CarregarCofre(idorg)
{
	new Arq[5000], str[5000], string[450];
	format(Arq, sizeof(Arq), PASTA_COFRES, idorg);
	if(DOF2_FileExists(Arq))
	{
		for(new i = 0; i != 20; ++i)
		{
			format(str, sizeof(str), "Arma inv %d", i);
			CofreArma[i][idorg]=DOF2_GetInt(Arq, str);
			format(str, sizeof(str), "Ammo inv %d", i);
			CofreAmmo[i][idorg]=DOF2_GetInt(Arq, str);
		}
		CofreInfo[idorg][CofreID] = DOF2_GetInt(Arq, "CofreID");

		CofreInfo[idorg][CofrePosX] = DOF2_GetInt(Arq, "CofrePosX");
		CofreInfo[idorg][CofrePosY] = DOF2_GetInt(Arq, "CofrePosY");
		CofreInfo[idorg][CofrePosZ] = DOF2_GetInt(Arq, "CofrePosZ");
		CofreInfo[idorg][CofrePosR] = DOF2_GetInt(Arq, "CofrePosR");

		ObjetoCofre[idorg] = CreateDynamicObject(19772, CofreInfo[idorg][CofrePosX], CofreInfo[idorg][CofrePosY], CofreInfo[idorg][CofrePosZ]-1, 0.0, 0.0, CofreInfo[idorg][CofrePosR]);
		format(string, sizeof(string), "{BEBEBE}ID Cofre: %d\nAperte {FF2400}H\n{BEBEBE}Para Abrir o Menu do Bau", CofreInfo[idorg][CofreID]);
		TextoCofreOrg[idorg] = CreateDynamic3DTextLabel(string, -1, CofreInfo[idorg][CofrePosX], CofreInfo[idorg][CofrePosY], CofreInfo[idorg][CofrePosZ], 25.0);
		return 1;
	}
    return 1;
}

stock CarregarDinRoubos()
{
	static controlFile[] = "CofreRoubos.ini";
	if(!DOF2_FileExists(controlFile))
	{
		DOF2_CreateFile(controlFile);
		CofreLoja1 = DOF2_GetInt(controlFile, "Loja1");
		CofreLoja2 = DOF2_GetInt(controlFile, "Loja2");
		CofreLoja3 = DOF2_GetInt(controlFile, "Loja3");
		CofreLoja4 = DOF2_GetInt(controlFile, "Loja4");
		CofreLoja5 = DOF2_GetInt(controlFile, "Loja5");
		CofreRestaurante = DOF2_GetInt(controlFile, "Restaurante");
		CofreNiobio = DOF2_GetInt(controlFile, "Niobio");
		CofreGoverno = DOF2_GetInt(controlFile, "Governo");
		CofreBanco = DOF2_GetInt(controlFile, "Banco");
	}
	CofreLoja1 = DOF2_GetInt(controlFile, "Loja1");
	CofreLoja2 = DOF2_GetInt(controlFile, "Loja2");
	CofreLoja3 = DOF2_GetInt(controlFile, "Loja3");
	CofreLoja4 = DOF2_GetInt(controlFile, "Loja4");
	CofreLoja5 = DOF2_GetInt(controlFile, "Loja5");
	CofreRestaurante = DOF2_GetInt(controlFile, "Restaurante");
	CofreNiobio = DOF2_GetInt(controlFile, "Niobio");
	CofreGoverno = DOF2_GetInt(controlFile, "Governo");
	CofreBanco = DOF2_GetInt(controlFile, "Banco");
	return 1;
}

stock SalvarDinRoubos()
{
	static controlFile[] = "CofreRoubos.ini";

	if(!DOF2_FileExists(controlFile))
	{
		DOF2_CreateFile(controlFile);
		DOF2_SetInt(controlFile, "Loja1", CofreLoja1);
		DOF2_SetInt(controlFile, "Loja2", CofreLoja2);
		DOF2_SetInt(controlFile, "Loja3", CofreLoja3);
		DOF2_SetInt(controlFile, "Loja4", CofreLoja4);
		DOF2_SetInt(controlFile, "Loja5", CofreLoja5);
		DOF2_SetInt(controlFile, "Restaurante",CofreRestaurante);
		DOF2_SetInt(controlFile, "Niobio", CofreNiobio);
		DOF2_SetInt(controlFile, "Governo", CofreGoverno);
		DOF2_SetInt(controlFile, "Banco", CofreBanco);
	}
	DOF2_SetInt(controlFile, "Loja1", CofreLoja1);
	DOF2_SetInt(controlFile, "Loja2", CofreLoja2);
	DOF2_SetInt(controlFile, "Loja3", CofreLoja3);
	DOF2_SetInt(controlFile, "Loja4", CofreLoja4);
	DOF2_SetInt(controlFile, "Loja5", CofreLoja5);
	DOF2_SetInt(controlFile, "Restaurante",CofreRestaurante);
	DOF2_SetInt(controlFile, "Niobio", CofreNiobio);
	DOF2_SetInt(controlFile, "Governo", CofreGoverno);
	DOF2_SetInt(controlFile, "Banco", CofreBanco);
    return 1;
}

stock CarregarGZ2()
{
	static controlFile[] = "GangZones.ini";
	if(!DOF2_FileExists(controlFile))
	{
		DOF2_CreateFile(controlFile);
		GuerraBarragem = DOF2_GetInt(controlFile, "DonoBarragem");
		GuerraParabolica = DOF2_GetInt(controlFile, "DonoParabolica");
	}
	GuerraBarragem = DOF2_GetInt(controlFile, "DonoBarragem");
	GuerraParabolica = DOF2_GetInt(controlFile, "DonoParabolica");
	return 1;
}

stock CarregarGZ(playerid)
{
	static controlFile[] = "GangZones.ini";
	if(!DOF2_FileExists(controlFile))
	{
		DOF2_CreateFile(controlFile);
		GuerraBarragem = DOF2_GetInt(controlFile, "DonoBarragem");
		GuerraParabolica = DOF2_GetInt(controlFile, "DonoParabolica");
	}
	GuerraBarragem = DOF2_GetInt(controlFile, "DonoBarragem");
	GuerraParabolica = DOF2_GetInt(controlFile, "DonoParabolica");
	if(GuerraBarragem == 1)
	{
		GangZoneShowForPlayer(playerid,Barragem,0x328fc00);
	}
	else if(GuerraBarragem == 5)
	{
	    GangZoneShowForPlayer(playerid,Barragem,0xfcf00300);
	}
	else if(GuerraBarragem == 6)
	{
	    GangZoneShowForPlayer(playerid,Barragem,0x0398fc00);
	}
	else if(GuerraBarragem == 7)
	{
	    GangZoneShowForPlayer(playerid,Barragem,0xfc030300);
	}
	else if(GuerraBarragem == 8)
	{
	    GangZoneShowForPlayer(playerid,Barragem,0x13fc0300);
	}
	else if(GuerraBarragem == 12)
	{
	    GangZoneShowForPlayer(playerid,Barragem,0xe3a65600);
	}
	else if(GuerraBarragem == 13)
	{
	    GangZoneShowForPlayer(playerid,Barragem,0x59422500);
	}
	if(GuerraParabolica == 1)
	{
		GangZoneShowForPlayer(playerid,Parabolica,0x328fc00);
	}
	else if(GuerraParabolica == 5)
	{
	    GangZoneShowForPlayer(playerid,Parabolica,0xfcf00300);
	}
	else if(GuerraParabolica == 6)
	{
	    GangZoneShowForPlayer(playerid,Parabolica,0x0398fc00);
	}
	else if(GuerraParabolica == 7)
	{
	    GangZoneShowForPlayer(playerid,Parabolica,0xfc030300);
	}
	else if(GuerraParabolica == 8)
	{
	    GangZoneShowForPlayer(playerid,Parabolica,0x13fc0300);
	}
	else if(GuerraParabolica == 12)
	{
	    GangZoneShowForPlayer(playerid,Parabolica,0xe3a65600);
	}
	else if(GuerraParabolica == 13)
	{
	    GangZoneShowForPlayer(playerid,Parabolica,0x59422500);
	}
	return 1;
}

stock SalvarGZ()
{
	static controlFile[] = "GangZones.ini";

	if(!DOF2_FileExists(controlFile))
	{
		DOF2_CreateFile(controlFile);
		DOF2_SetInt(controlFile, "DonoBarragem", GuerraBarragem);
		DOF2_SetInt(controlFile, "DonoParabolica", GuerraParabolica);
	}
	DOF2_SetInt(controlFile, "DonoBarragem", GuerraBarragem);
	DOF2_SetInt(controlFile, "DonoParabolica", GuerraParabolica);
    return 1;
}

stock CreateAurea(textaur[], Float:aurx, Float:aury, Float:aurz)
{
	CreateDynamicPickup(2992, 23, aurx, aury, aurz-0.8);
	Create3DTextLabel(textaur, -1, aurx, aury, aurz, 15.0, 0);
	return 1;
}

stock darxp(playerid, XP, XP_Prox, Float:XP_Porc = 0.0, masganho = _:0.0)
{
    new string[20] = _:0.0; //const string[20] = _:0.0;

	PlayerInfo[playerid][pXP] += masganho;
    if(XP_Porc >= 100)
    {
        SetPlayerScore(playerid,GetPlayerScore(playerid)+1);
		PlayerInfo[playerid][pXP] = 0;
		InfoMsg(playerid, "Voce upou de nivel.");
    }

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

/*    XPTXD[playerid][12] = CreatePlayerTextDraw(playerid, 218.000000, 2.555553, "LD_POOL:ball");
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
    PlayerTextDrawSetShadow(playerid, XPTXD[playerid][15], 0);*/

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

stock checkPasswordAccount(playerid, password[]) {
	new SHA256_password[95],Account[256], returnSucess = 0;

	// Encryptar a senha
	SHA256_PassHash(password, passwordSalt, SHA256_password, sizeof (SHA256_password));
	format(Account, sizeof(Account), PASTA_CONTAS, Name(playerid));
	if(DOF2_FileExists(Account)){
		if (!strcmp(SHA256_password, DOF2_GetString(Account, "pSenha"))) {
	    	returnSucess = 1;
		}
	}
	return returnSucess;
}

stock IsABike(vehicleid)
{
    switch(GetVehicleModel(vehicleid)) {
        case 448, 461..463, 468, 521..523, 581, 586, 481, 509, 510:{ return 1; }
    }
    return 0;
} 

stock IsABoat(vehicleid)
{
    switch(GetVehicleModel(vehicleid)) {
        case 472, 473, 493, 595, 484, 430, 453, 452, 446, 454:{ return 1; }
    }
    return 0;
} 

stock IsValidInput(const ipstr[])
{
    for(new i = 0; ipstr[i] != EOS; ++i)
    {
        switch(ipstr[i])
        {
            case '0'..'9', 'A'..'Z', 'a'..'z', '_', '[', '@', ']', '.':
                continue;
            default:
                return 0;
        }
    }
    return 1;
}

stock GetPlayerIdfixo(playerid) return PlayerInfo[playerid][IDF];
stock GetIdfixo()
{
	static controlFile[] = "IDs/Control.ini";

	if(!DOF2_FileExists(controlFile))
	{
		DOF2_CreateFile(controlFile);
		DOF2_SetInt(controlFile, "Last", 0);
	}

	new currentTag = DOF2_GetInt(controlFile, "Last") + 1;
	DOF2_SetInt(controlFile, "Last", currentTag);

	return currentTag;
}

stock Timers(playerid)
{
	TimerFomebar[playerid] = SetTimerEx("FomeBar", minutos(3), true, "d", playerid);
	TimerSedebar[playerid] = SetTimerEx("SedeBar", minutos(3), true, "d", playerid); 
	TimerColete[playerid] = SetTimerEx("Colete", 150, true, "d", playerid);
	TimerPayDay[playerid] = SetTimerEx("PayDay", minutos(30), false, "d", playerid); 
	TimerAttVeh[playerid] = SetTimerEx("AttVeh", 5000, true, "d", playerid);
	TimerHacker[playerid] = SetTimerEx("TimerHack", 1000, false, "d", playerid);
}

stock HeadshotCheck(playerid, &Float:x, &Float:y, &Float:z)
{
	new Float:fx,Float:fy,Float:fz;
	GetPlayerCameraFrontVector(playerid, fx, fy, fz);

 	new Float:cx,Float:cy,Float:cz;
 	GetPlayerCameraPos(playerid, cx, cy, cz);

	for(new Float:i = 0.0; i < 50; i = i + 0.5)
	{
 		x = fx * i + cx;
		y = fy * i + cy;
		z = fz * i + cz;

		#if defined SHOWPATH
		CreatePickup(1239, 4, x, y, z, -1);
		#endif

		for(new player = 0; player < MAX_PLAYERS; player ++)
		{
		    if(IsPlayerConnected(playerid))
		    {
		    	if(player != playerid)
				{
		    		if(GetPlayerSpecialAction(player) == SPECIAL_ACTION_DUCK) //CROUCHING
					{
		        		if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z))
		        		{
		            		GameTextForPlayer(playerid, "~r~HEADSHOT!", 2000, 6);
		            		GameTextForPlayer(player, "~r~HEADSHOT!", 2000, 6);

		            		SetPlayerHealth(player, 0.0);
		            		CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
		        		}
					}
					else //NOT CROUCHING
					{
		    			if(IsPlayerInRangeOfPoint(player, 0.3, x, y, z - 0.7))
						{
							GameTextForPlayer(playerid, "~r~HEADSHOT!", 2000, 6);
							GameTextForPlayer(player, "~r~HEADSHOT!", 2000, 6);

							SetPlayerHealth(player, 0.0);
							CallRemoteFunction("OnPlayerDeath", "ddd", player, playerid, 34);
						}
					}
				}
			}
		}
	}
	return 1;
}

stock VaiProHospital(playerid)
{
	new sphp = randomEx(0,1);
    SetTimerEx("ParaDeBugaPoraaaDk", 100, 1, "i", playerid);
    PlayerMorto[playerid][pMinMorto] = 0;
    PlayerMorto[playerid][pSegMorto] = 0;
    SetPlayerHealth(playerid, 100);
	PlayerInfo[playerid][pDinheiro] = 0;
	FomePlayer[playerid] = 100;
	SedePlayer[playerid] = 100;
	RetirarItem(playerid, 1212);
	RetirarItem(playerid, 902);
	RetirarItem(playerid, 19630);
	RetirarItem(playerid, 1599);
	RetirarItem(playerid, 1600);
	RetirarItem(playerid, 1603);
	RetirarItem(playerid, 1604);
	RetirarItem(playerid, 1608);
	RetirarItem(playerid, 1576);
	RetirarItem(playerid, 1654);
	RetirarItem(playerid, 2218);
	RetirarItem(playerid, 2355);
	RetirarItem(playerid, 2219);
	RetirarItem(playerid, 2220);
	RetirarItem(playerid, 1484);
	RetirarItem(playerid, 1644);
	RetirarItem(playerid, 1546);
	RetirarItem(playerid, 2601);
	RetirarItem(playerid, 3520);
	RetirarItem(playerid, 11746);
	RetirarItem(playerid, 19921);
	RetirarItem(playerid, 1010);
	RetirarItem(playerid, 18870);
	RetirarItem(playerid, 11736);
	RetirarItem(playerid, 18632);
	RetirarItem(playerid, 18645);
	RetirarItem(playerid, 18644);

	if(sphp == 0)
	{
    	SetPlayerPos(playerid, 1629.030639, -1123.190185, 24.769485);
		SetPlayerFacingAngle(playerid, 175.770599);
	}
	if(sphp == 1)
	{
    	SetPlayerPos(playerid, 1628.926025, -1139.238525, 24.769485);
		SetPlayerFacingAngle(playerid, 353.194946);
	}
	TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    for(new idx=0; idx<9; idx++){
    TextDrawHideForPlayer(playerid,TDmorte[idx]); }
	PlayerTextDrawHide(playerid, TDmorte_p[playerid][0]);
	CancelSelectTextDraw(playerid);
	InfoMsg(playerid, "Morreu e perdeu todo seu dinheiro e alguns itens do seu inventario.");
	return 1;
}

stock ParaDeBugaPoraaaDk(playerid)
{
	KillTimer(TimerMorto[playerid]);
	return 1;
}

stock PastaNomeX(playerid)
{
	new File[40];
	format(File,  sizeof(File),  PASTA_MORTOS,  Name(playerid));
	return File;
}

stock SalvarMortos(playerid)
{
    DOF2_SetFloat(PastaNomeX(playerid), "Pos_x", PlayerMorto[playerid][pPosMt1]);
	DOF2_SetFloat(PastaNomeX(playerid), "Pos_y", PlayerMorto[playerid][pPosMt2]);
	DOF2_SetFloat(PastaNomeX(playerid), "Pos_z", PlayerMorto[playerid][pPosMt3]);
    DOF2_SetInt(PastaNomeX(playerid),"Interior",PlayerMorto[playerid][pInteriorMxxx]);
	DOF2_SetInt(PastaNomeX(playerid),"VW",PlayerMorto[playerid][pVirtual]);
	DOF2_SetInt(PastaNomeX(playerid),"EstaMorto", PlayerMorto[playerid][pEstaMorto]);
	DOF2_SetInt(PastaNomeX(playerid),"pSegMorto",PlayerMorto[playerid][pSegMorto]);
	DOF2_SetInt(PastaNomeX(playerid),"pMinMorto", PlayerMorto[playerid][pMinMorto]);
    DOF2_SaveFile();
    return 1;
}

stock CarregarMortos(playerid)
{
	if(DOF2_FileExists(PastaNomeX(playerid)))
	{
	    PlayerMorto[playerid][pPosMt1] = DOF2_GetFloat(PastaNomeX(playerid), "Pos_x");
		PlayerMorto[playerid][pPosMt2] = DOF2_GetFloat(PastaNomeX(playerid), "Pos_y");
		PlayerMorto[playerid][pPosMt3] = DOF2_GetFloat(PastaNomeX(playerid), "Pos_z");
		PlayerMorto[playerid][pInteriorMxxx] = DOF2_GetInt(PastaNomeX(playerid), "Interior");
		PlayerMorto[playerid][pVirtual] = DOF2_GetInt(PastaNomeX(playerid), "VW");
		PlayerMorto[playerid][pEstaMorto] = DOF2_GetInt(PastaNomeX(playerid), "EstaMorto");
		PlayerMorto[playerid][pSegMorto] = DOF2_GetInt(PastaNomeX(playerid), "pSegMorto");
		PlayerMorto[playerid][pMinMorto] = DOF2_GetInt(PastaNomeX(playerid), "pMinMorto");
	}
	return 1;
}

stock todastextdraw(playerid)
{
	Registration_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 269.6997, 149.4332, "LD_SPAC:white"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][0], 99.0000, 158.8589);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][0], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][0], 0);

	Registration_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 262.3834, 146.2775, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][1], 16.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][1], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][1], 0);

	Registration_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 360.4683, 146.7776, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][2], 16.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][2], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][2], 0);

	Registration_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 261.9351, 288.4777, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][3], 19.0000, 24.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][3], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][3], 0);

	Registration_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 358.0848, 288.4038, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][4], 19.0000, 24.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][4], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][4], 0);

	Registration_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 264.9833, 155.5185, "LD_SPAC:white"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][5], 109.0000, 145.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][5], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][5], 0);

	Registration_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 304.5830, 160.7037, "ld_pool:ball"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][6], 26.0000, 31.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][6], -65281);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][6], 0);

	Registration_PTD[playerid][7] = CreatePlayerTextDraw(playerid, 312.4002, 167.3332, "ld_pool:ball"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][7], 23.0000, 29.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][7], -65281);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][7], 0);

	Registration_PTD[playerid][8] = CreatePlayerTextDraw(playerid, 299.7514, 154.6260, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][8], 42.0000, 48.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][8], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][8], 0);

	Registration_PTD[playerid][9] = CreatePlayerTextDraw(playerid, 299.1665, 206.5925, "CONECTANDO.."); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][9], 0.1508, 0.9881);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][9], 0);

	Registration_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 308.2330, 172.3703, "BAIXADA"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][10], 0.1508, 0.9881);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][10], 0);

	Registration_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 288.9169, 248.3787, "LD_SPAC:white"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][11], 63.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][11], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][11], 0);

	Registration_PTD[playerid][12] = CreatePlayerTextDraw(playerid, 281.5332, 245.5828, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][12], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][12], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][12], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][12], 0);

	Registration_PTD[playerid][13] = CreatePlayerTextDraw(playerid, 345.4332, 245.5828, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][13], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][13], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][13], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][13], 0);

	Registration_PTD[playerid][14] = CreatePlayerTextDraw(playerid, 305.8001, 282.1371, "LD_SPAC:white"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][14], 30.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][14], 916987903);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][14], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][14], 0);

	Registration_PTD[playerid][15] = CreatePlayerTextDraw(playerid, 298.4165, 279.3412, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][15], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][15], 916987903);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][15], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][15], 0);

	Registration_PTD[playerid][16] = CreatePlayerTextDraw(playerid, 329.4663, 279.3412, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][16], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][16], 916987903);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][16], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][16], 0);

	Registration_PTD[playerid][17] = CreatePlayerTextDraw(playerid, 288.7169, 227.1774, "LD_SPAC:white"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][17], 63.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][17], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][17], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][17], 0);

	Registration_PTD[playerid][18] = CreatePlayerTextDraw(playerid, 281.3332, 224.3815, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][18], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][18], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][18], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][18], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][18], 0);

	Registration_PTD[playerid][19] = CreatePlayerTextDraw(playerid, 345.2332, 224.3815, "LD_BEAT:chit"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][19], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][19], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][19], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][19], 0);

	Registration_PTD[playerid][20] = CreatePlayerTextDraw(playerid, 294.1000, 228.8889, "NOME_SOBRENOME"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][20], 0.1500, 0.7859);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][20], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][20], 0);

	Registration_PTD[playerid][21] = CreatePlayerTextDraw(playerid, 296.4002, 250.0902, "DIGITE_SENHA"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][21], 0.1500, 0.7859);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][21], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][21], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][21], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid,Registration_PTD[playerid][21], true);

	Registration_PTD[playerid][22] = CreatePlayerTextDraw(playerid, 311.1177, 283.8107, "LOGAR"); // Ã¯Ã³Ã±Ã²Ã®
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][22], 0.1500, 0.7859);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][22], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][22], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][22], 0);

	//Loadscreen strings e progressbar
	Loadsc_p[playerid][0] = CreatePlayerTextDraw(playerid, 438.000000, 271.000000, "0%");
	PlayerTextDrawFont(playerid, Loadsc_p[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Loadsc_p[playerid][0], 0.208333, 1.300000);
	PlayerTextDrawTextSize(playerid, Loadsc_p[playerid][0], 474.000000, -88.500000);
	PlayerTextDrawSetOutline(playerid, Loadsc_p[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Loadsc_p[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Loadsc_p[playerid][0], 2);
	PlayerTextDrawColor(playerid, Loadsc_p[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Loadsc_p[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Loadsc_p[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Loadsc_p[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Loadsc_p[playerid][0], 1);
	Loadsc_b[playerid][0] = CreatePlayerProgressBar(playerid, 224.000000, 284.000000, 200.000000, -13.000000, -65281, 100.000000, 0);
	SetPlayerProgressBarValue(playerid, Loadsc_b[playerid][0], 0);

	//VELOCIMETRO STRINGS
	VeloC[playerid][0] = CreatePlayerTextDraw(playerid, 603.909484, 385.416656, "box");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][0], -0.001398, -0.649218);
	PlayerTextDrawTextSize(playerid, VeloC[playerid][0], 604.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][0], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, VeloC[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, VeloC[playerid][0], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][0], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][0], 1);

	VeloC[playerid][1] = CreatePlayerTextDraw(playerid, 603.909484, 390.083312, "box");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][1], -0.003279, -0.649218);
	PlayerTextDrawTextSize(playerid, VeloC[playerid][1], 604.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][1], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, VeloC[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, VeloC[playerid][1], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][1], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][1], 1);

	VeloC[playerid][2] = CreatePlayerTextDraw(playerid, 603.909484, 394.749969, "box");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][2], -0.003279, -0.649218);
	PlayerTextDrawTextSize(playerid, VeloC[playerid][2], 604.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][2], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][2], -1);
	PlayerTextDrawUseBox(playerid, VeloC[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid, VeloC[playerid][2], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][2], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][2], 1);

	VeloC[playerid][3] = CreatePlayerTextDraw(playerid, 603.909362, 399.416656, "box");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][3], -0.003279, -0.649218);
	PlayerTextDrawTextSize(playerid, VeloC[playerid][3], 604.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][3], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][3], -1);
	PlayerTextDrawUseBox(playerid, VeloC[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid, VeloC[playerid][3], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][3], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][3], 1);

	VeloC[playerid][4] = CreatePlayerTextDraw(playerid, 603.909362, 404.083312, "box");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][4], -0.003279, -0.649218);
	PlayerTextDrawTextSize(playerid, VeloC[playerid][4], 604.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][4], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][4], -16776961);
	PlayerTextDrawUseBox(playerid, VeloC[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid, VeloC[playerid][4], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][4], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][4], 1);

	VeloC[playerid][5] = CreatePlayerTextDraw(playerid, 583.126403, 368.499847, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, VeloC[playerid][5], 5.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][5], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][5], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][5], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][5], 0);

	VeloC[playerid][6] = CreatePlayerTextDraw(playerid, 582.657958, 385.999847, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, VeloC[playerid][6], 5.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][6], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][6], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][6], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][6], 0);

	VeloC[playerid][7] = CreatePlayerTextDraw(playerid, 583.126403, 402.333190, "LD_BEAT:chit");
	PlayerTextDrawTextSize(playerid, VeloC[playerid][7], 5.000000, 7.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][7], 1);
	PlayerTextDrawColor(playerid, VeloC[playerid][7], -16776961);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][7], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][7], 0);

	VeloC[playerid][8] = CreatePlayerTextDraw(playerid, 563.616821, 374.333282, "00~w~0");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][8], 0.327378, 1.039999);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][8], 3);
	PlayerTextDrawColor(playerid, VeloC[playerid][8], -128);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][8], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][8], 2);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][8], 1);

	VeloC[playerid][9] = CreatePlayerTextDraw(playerid, 549.561157, 363.833282, "N");
	PlayerTextDrawLetterSize(playerid, VeloC[playerid][9], 0.242107, 0.946665);
	PlayerTextDrawTextSize(playerid, VeloC[playerid][9], 0.000000, -6.000000);
	PlayerTextDrawAlignment(playerid, VeloC[playerid][9], 2);
	PlayerTextDrawColor(playerid, VeloC[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, VeloC[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, VeloC[playerid][9], 255);
	PlayerTextDrawFont(playerid, VeloC[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, VeloC[playerid][9], 1);

		//STRINGS VELOMOB
	Velomob_p[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 399.000000, "000");
	PlayerTextDrawFont(playerid, Velomob_p[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, Velomob_p[playerid][0], 0.174999, 1.449998);
	PlayerTextDrawTextSize(playerid, Velomob_p[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Velomob_p[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Velomob_p[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, Velomob_p[playerid][0], 2);
	PlayerTextDrawColor(playerid, Velomob_p[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, Velomob_p[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, Velomob_p[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, Velomob_p[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, Velomob_p[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, Velomob_p[playerid][0], 0);

	Velomob_p[playerid][1] = CreatePlayerTextDraw(playerid, 320.000000, 389.000000, "N");
	PlayerTextDrawFont(playerid, Velomob_p[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, Velomob_p[playerid][1], 0.224998, 1.100000);
	PlayerTextDrawTextSize(playerid, Velomob_p[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, Velomob_p[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, Velomob_p[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, Velomob_p[playerid][1], 2);
	PlayerTextDrawColor(playerid, Velomob_p[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, Velomob_p[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, Velomob_p[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, Velomob_p[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, Velomob_p[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, Velomob_p[playerid][1], 0);

	Velomob_p[playerid][2] = CreatePlayerTextDraw(playerid, 320.000000, 417.000000, "~r~F:~w~ 100%");
	PlayerTextDrawFont(playerid, Velomob_p[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, Velomob_p[playerid][2], 0.150000, 1.049999);
	PlayerTextDrawTextSize(playerid, Velomob_p[playerid][2], 400.000000, 62.500000);
	PlayerTextDrawSetOutline(playerid, Velomob_p[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, Velomob_p[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, Velomob_p[playerid][2], 2);
	PlayerTextDrawColor(playerid, Velomob_p[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, Velomob_p[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, Velomob_p[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, Velomob_p[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, Velomob_p[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, Velomob_p[playerid][2], 0);


		//STRINGS TD CADASTRO
	TDCadastro_p[playerid][0] = CreatePlayerTextDraw(playerid, 94.000000, 197.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][0], 5);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][0], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][0], 32.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][0], -1094795521);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][0], -741092353);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, TDCadastro_p[playerid][0], 1);
	PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], 1);
	PlayerTextDrawSetPreviewRot(playerid, TDCadastro_p[playerid][0], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDCadastro_p[playerid][0], 1, 1);

	TDCadastro_p[playerid][1] = CreatePlayerTextDraw(playerid, 134.000000, 197.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][1], 32.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][1], -1094795521);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][1], -741092353);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, TDCadastro_p[playerid][1], 1);
	PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], 2);
	PlayerTextDrawSetPreviewRot(playerid, TDCadastro_p[playerid][1], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDCadastro_p[playerid][1], 1, 1);

	TDCadastro_p[playerid][2] = CreatePlayerTextDraw(playerid, 174.000000, 197.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][2], 5);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][2], 32.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][2], -1094795521);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][2], -741092353);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, TDCadastro_p[playerid][2], 1);
	PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], 3);
	PlayerTextDrawSetPreviewRot(playerid, TDCadastro_p[playerid][2], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDCadastro_p[playerid][2], 1, 1);

	TDCadastro_p[playerid][3] = CreatePlayerTextDraw(playerid, 94.000000, 242.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][3], 5);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][3], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][3], 32.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][3], -1094795521);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][3], -741092353);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, TDCadastro_p[playerid][3], 1);
	PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], 4);
	PlayerTextDrawSetPreviewRot(playerid, TDCadastro_p[playerid][3], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDCadastro_p[playerid][3], 1, 1);

	TDCadastro_p[playerid][4] = CreatePlayerTextDraw(playerid, 134.000000, 242.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][4], 5);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][4], 32.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][4], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][4], -1094795521);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][4], -741092353);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, TDCadastro_p[playerid][4], 1);
	PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], 5);
	PlayerTextDrawSetPreviewRot(playerid, TDCadastro_p[playerid][4], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDCadastro_p[playerid][4], 1, 1);

	TDCadastro_p[playerid][5] = CreatePlayerTextDraw(playerid, 174.000000, 242.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][5], 5);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][5], 32.500000, 32.000000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][5], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][5], -1094795521);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][5], -741092353);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, TDCadastro_p[playerid][5], 1);
	PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], 6);
	PlayerTextDrawSetPreviewRot(playerid, TDCadastro_p[playerid][5], -10.000000, 0.000000, -20.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, TDCadastro_p[playerid][5], 1, 1);

	TDCadastro_p[playerid][6] = CreatePlayerTextDraw(playerid, 149.000000, 304.000000, "1/46");
	PlayerTextDrawFont(playerid, TDCadastro_p[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, TDCadastro_p[playerid][6], 0.162499, 1.049978);
	PlayerTextDrawTextSize(playerid, TDCadastro_p[playerid][6], 490.500000, 199.500000);
	PlayerTextDrawSetOutline(playerid, TDCadastro_p[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, TDCadastro_p[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, TDCadastro_p[playerid][6], 2);
	PlayerTextDrawColor(playerid, TDCadastro_p[playerid][6], -1);
	PlayerTextDrawBackgroundColor(playerid, TDCadastro_p[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, TDCadastro_p[playerid][6], 512819199);
	PlayerTextDrawUseBox(playerid, TDCadastro_p[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, TDCadastro_p[playerid][6], 1);

		//NEW HUD SERVER STRINGS
	HudServer_p[playerid][0] = CreatePlayerTextDraw(playerid, 554.000000, 104.000000, "100"); //Batimento cardiaco
	PlayerTextDrawFont(playerid, HudServer_p[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][0], 0.162498, 0.750000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][0], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][0], 2);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][0], 1);

	HudServer_p[playerid][1] = CreatePlayerTextDraw(playerid, 570.000000, 104.000000, "100"); //Colete
	PlayerTextDrawFont(playerid, HudServer_p[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][1], 0.162498, 0.750000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][1], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][1], 2);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][1], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][1], 1);

	HudServer_p[playerid][2] = CreatePlayerTextDraw(playerid, 586.000000, 104.000000, "100"); //Fome
	PlayerTextDrawFont(playerid, HudServer_p[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][2], 0.162498, 0.750000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][2], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][2], 2);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][2], -1);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][2], 1);

	HudServer_p[playerid][3] = CreatePlayerTextDraw(playerid, 601.000000, 104.000000, "100"); //Sede
	PlayerTextDrawFont(playerid, HudServer_p[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][3], 0.162498, 0.750000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][3], 400.000000, 17.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][3], 2);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][3], 1);

	HudServer_p[playerid][4] = CreatePlayerTextDraw(playerid, 559.000000, 119.000000, "ld_beat:chit"); //bolinha voip
	PlayerTextDrawFont(playerid, HudServer_p[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][4], 10.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][4], 1);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][4], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][4], 1);

	HudServer_p[playerid][5] = CreatePlayerTextDraw(playerid, 575.000000, 119.000000, "ld_beat:chit"); //bolinha vermelha voip
	PlayerTextDrawFont(playerid, HudServer_p[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][5], 10.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][5], 1);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][5], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][5], 1);

	HudServer_p[playerid][6] = CreatePlayerTextDraw(playerid, 592.000000, 119.000000, "ld_beat:chit"); //bolinha vermelha voip
	PlayerTextDrawFont(playerid, HudServer_p[playerid][6], 4);
	PlayerTextDrawLetterSize(playerid, HudServer_p[playerid][6], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, HudServer_p[playerid][6], 10.500000, 12.000000);
	PlayerTextDrawSetOutline(playerid, HudServer_p[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, HudServer_p[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, HudServer_p[playerid][6], 1);
	PlayerTextDrawColor(playerid, HudServer_p[playerid][6], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudServer_p[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, HudServer_p[playerid][6], 50);
	PlayerTextDrawUseBox(playerid, HudServer_p[playerid][6], 1);
	PlayerTextDrawSetProportional(playerid, HudServer_p[playerid][6], 1);

	wMenu[0] = CreatePlayerTextDraw(playerid,123.000000, 61.000000+50, "Veiculo:");
	PlayerTextDrawBackgroundColor(playerid,wMenu[0], 255);
	PlayerTextDrawFont(playerid,wMenu[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[0], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[0], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[0], 0);
	PlayerTextDrawSetSelectable(playerid,wMenu[0], 0);

	wMenu[1] = CreatePlayerTextDraw(playerid,512.000000, 61.000000+50, "x");
	PlayerTextDrawBackgroundColor(playerid,wMenu[1], 255);
	PlayerTextDrawFont(playerid,wMenu[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[1], 0);
	PlayerTextDrawUseBox(playerid,wMenu[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[1], 0);
	PlayerTextDrawTextSize(playerid,wMenu[1], 516.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[1], 0);

	wMenu[2] = CreatePlayerTextDraw(playerid,123.000000, 80.000000+50, "Rodas");
	PlayerTextDrawBackgroundColor(playerid,wMenu[2], 255);
	PlayerTextDrawFont(playerid,wMenu[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[2], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[2], 0);
	PlayerTextDrawUseBox(playerid,wMenu[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[2], 0);
	PlayerTextDrawTextSize(playerid,wMenu[2], 170.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[2], 0);

	wMenu[3] = CreatePlayerTextDraw(playerid,177.000000, 80.000000+50, "Cores");
	PlayerTextDrawBackgroundColor(playerid,wMenu[3], 255);
	PlayerTextDrawFont(playerid,wMenu[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[3], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[3], 0);
	PlayerTextDrawUseBox(playerid,wMenu[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[3], 0);
	PlayerTextDrawTextSize(playerid,wMenu[3], 204.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[3], 0);

	wMenu[4] = CreatePlayerTextDraw(playerid,228.000000, 80.000000+50, "Pinturas");
	PlayerTextDrawBackgroundColor(playerid,wMenu[4], 255);
	PlayerTextDrawFont(playerid,wMenu[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[4], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[4], 0);
	PlayerTextDrawUseBox(playerid,wMenu[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[4], 0);
	PlayerTextDrawTextSize(playerid,wMenu[4], 276.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[4], 0);

	wMenu[5] = CreatePlayerTextDraw(playerid,299.000000, 80.000000+50, "Nitro");
	PlayerTextDrawBackgroundColor(playerid,wMenu[5], 255);
	PlayerTextDrawFont(playerid,wMenu[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[5], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[5], 0);
	PlayerTextDrawUseBox(playerid,wMenu[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[5], 0);
	PlayerTextDrawTextSize(playerid,wMenu[5], 324.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[5], 0);

	wMenu[6] = CreatePlayerTextDraw(playerid,346.000000, 80.000000+50, "Neon");
	PlayerTextDrawBackgroundColor(playerid,wMenu[6], 255);
	PlayerTextDrawFont(playerid,wMenu[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[6], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[6], 0);
	PlayerTextDrawUseBox(playerid,wMenu[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[6], 0);
	PlayerTextDrawTextSize(playerid,wMenu[6], 374.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[6], 0);

	wMenu[7] = CreatePlayerTextDraw(playerid,391.000000, 80.000000+50, "Suspencao");
	PlayerTextDrawBackgroundColor(playerid,wMenu[7], 255);
	PlayerTextDrawFont(playerid,wMenu[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[7], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[7], 0);
	PlayerTextDrawUseBox(playerid,wMenu[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[7], 0);
	PlayerTextDrawTextSize(playerid,wMenu[7], 444.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[7], 0);

	wMenu[8] = CreatePlayerTextDraw(playerid,461.000000, 80.000000+50, "AUTO_TUNAR");
	PlayerTextDrawBackgroundColor(playerid,wMenu[8], 255);
	PlayerTextDrawFont(playerid,wMenu[8], 2);
	PlayerTextDrawLetterSize(playerid,wMenu[8], 0.209999, 1.200000);
	PlayerTextDrawColor(playerid,wMenu[8], -1);
	PlayerTextDrawSetOutline(playerid,wMenu[8], 0);
	PlayerTextDrawSetProportional(playerid,wMenu[8], 1);
	PlayerTextDrawSetShadow(playerid,wMenu[8], 0);
	PlayerTextDrawUseBox(playerid,wMenu[8], 1);
	PlayerTextDrawBoxColor(playerid,wMenu[8], 0);
	PlayerTextDrawTextSize(playerid,wMenu[8], 516.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenu[8], 0);
	for(new i = 1; i < 9; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenu[i], true);
	/*------------------------------------------------------------------*/


	wMenuRodas[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_rodas_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[0], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuRodas[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[0], 0);

	wMenuRodas[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "shadow");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[1], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[1], 0);

	wMenuRodas[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "mega");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[2], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[2], 0);

	wMenuRodas[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "rimshine");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[3], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[3], 0);

	wMenuRodas[4] = CreatePlayerTextDraw(playerid,123.000000, 191.000000+50, "wires");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[4], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[4], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[4], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[4], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[4], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[4], 0);

	wMenuRodas[5] = CreatePlayerTextDraw(playerid,123.000000, 211.000000+50, "classic");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[5], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[5], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[5], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[5], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[5], 282.000000, 10.000000+50);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[5], 0);

	wMenuRodas[6] = CreatePlayerTextDraw(playerid,123.000000, 230.000000+50, "twist");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[6], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[6], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[6], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[6], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[6], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[6], 0);

	wMenuRodas[7] = CreatePlayerTextDraw(playerid,123.000000, 250.000000+50, "cutter");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[7], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[7], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[7], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[7], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[7], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[7], 0);

	wMenuRodas[8] = CreatePlayerTextDraw(playerid,123.000000, 271.000000+50, "doller");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[8], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[8], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[8], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[8], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[8], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[8], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[8], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[8], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[8], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[8], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[8], 0);

	wMenuRodas[9] = CreatePlayerTextDraw(playerid,123.000000, 291.000000+50, "atomic");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[9], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[9], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[9], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[9], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[9], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[9], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[9], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[9], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[9], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[9], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[9], 0);

	wMenuRodas[10] = CreatePlayerTextDraw(playerid,123.000000, 310.000000+50, "virtual");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[10], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[10], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[10], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[10], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[10], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[10], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[10], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[10], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[10], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[10], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[10], 0);
	
    for(new i = 1; i < 11; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuRodas[i], true);

	/*--------------------------------------------------------------------------------------------------------*/
	wMenuCores[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_cores_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[0], 255);
	PlayerTextDrawFont(playerid,wMenuCores[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuCores[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuCores[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[0], 0);

	wMenuCores[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "branco");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[1], 255);
	PlayerTextDrawFont(playerid,wMenuCores[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[1], 0);

	wMenuCores[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "azul");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[2], 255);
	PlayerTextDrawFont(playerid,wMenuCores[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[2], 0);

	wMenuCores[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "amarelo");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[3], 255);
	PlayerTextDrawFont(playerid,wMenuCores[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[3], 0);

	wMenuCores[4] = CreatePlayerTextDraw(playerid,123.000000, 191.000000+50, "Morado");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[4], 255);
	PlayerTextDrawFont(playerid,wMenuCores[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[4], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[4], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[4], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[4], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[4], 0);

	wMenuCores[5] = CreatePlayerTextDraw(playerid,123.000000, 211.000000+50, "verde");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[5], 255);
	PlayerTextDrawFont(playerid,wMenuCores[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[5], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[5], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[5], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[5], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[5], 0);

	wMenuCores[6] = CreatePlayerTextDraw(playerid,123.000000, 230.000000+50, "cinza");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[6], 255);
	PlayerTextDrawFont(playerid,wMenuCores[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[6], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[6], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[6], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[6], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[6], 0);

	wMenuCores[7] = CreatePlayerTextDraw(playerid,123.000000, 250.000000+50, "rosa");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[7], 255);
	PlayerTextDrawFont(playerid,wMenuCores[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[7], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[7], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[7], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[7], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[7], 0);

	wMenuCores[8] = CreatePlayerTextDraw(playerid,123.000000, 271.000000+50, "marrom");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[8], 255);
	PlayerTextDrawFont(playerid,wMenuCores[8], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[8], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[8], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[8], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[8], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[8], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[8], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[8], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[8], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[8], 0);

	wMenuCores[9] = CreatePlayerTextDraw(playerid,123.000000, 291.000000+50, "Vermelho");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[9], 255);
	PlayerTextDrawFont(playerid,wMenuCores[9], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[9], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[9], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[9], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[9], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[9], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[9], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[9], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[9], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[9], 0);

	wMenuCores[10] = CreatePlayerTextDraw(playerid,123.000000, 310.000000+50, "Laranja");
	PlayerTextDrawBackgroundColor(playerid,wMenuCores[10], 255);
	PlayerTextDrawFont(playerid,wMenuCores[10], 2);
	PlayerTextDrawLetterSize(playerid,wMenuCores[10], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuCores[10], -1);
	PlayerTextDrawSetOutline(playerid,wMenuCores[10], 0);
	PlayerTextDrawSetProportional(playerid,wMenuCores[10], 1);
	PlayerTextDrawSetShadow(playerid,wMenuCores[10], 0);
	PlayerTextDrawUseBox(playerid,wMenuCores[10], 1);
	PlayerTextDrawBoxColor(playerid,wMenuCores[10], 0);
	PlayerTextDrawTextSize(playerid,wMenuCores[10], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuCores[10], 0);
	for(new i = 1; i < 11; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuCores[i], true);

	/*------------------------------------------------------------------------*/
	wMenuPaintJobs[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_pinturas_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[0], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[0], 0);

	wMenuPaintJobs[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "pinturas_1");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[1], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[1], 0);

	wMenuPaintJobs[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "pinturas_2");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[2], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[2], 0);

	wMenuPaintJobs[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "pinturas_3");
	PlayerTextDrawBackgroundColor(playerid,wMenuPaintJobs[3], 255);
	PlayerTextDrawFont(playerid,wMenuPaintJobs[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuPaintJobs[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuPaintJobs[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuPaintJobs[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuPaintJobs[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuPaintJobs[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuPaintJobs[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuPaintJobs[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuPaintJobs[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuPaintJobs[3], 0);
	for(new i = 1; i < 4; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuPaintJobs[i], true);

	/*----------------------------------------------------------------------*/
	wMenuNitro[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_nitro_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[0], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuNitro[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[0], 0);

	wMenuNitro[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "nitro_x2");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[1], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuNitro[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[1], 0);

	wMenuNitro[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "nitro_x5");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[2], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuNitro[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[2], 0);

	wMenuNitro[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "nitro_x10");
	PlayerTextDrawBackgroundColor(playerid,wMenuNitro[3], 255);
	PlayerTextDrawFont(playerid,wMenuNitro[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNitro[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNitro[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNitro[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNitro[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNitro[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuNitro[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNitro[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuNitro[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNitro[3], 0);
	for(new i = 1; i < 4; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuNitro[i], true);


	/*-----------------------------------------------------------------------*/
	wMenuNeon[0] = CreatePlayerTextDraw(playerid,118.000000, 101.000000+50, "_______________________]_neon_]");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[0], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[0], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[0], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[0], 255);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[0], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[0], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[0], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[0], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[0], -1);
	PlayerTextDrawTextSize(playerid,wMenuNeon[0], 281.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[0], 0);

	wMenuNeon[1] = CreatePlayerTextDraw(playerid,123.000000, 137.000000+50, "azul");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[1], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[1], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[1], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[1], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[1], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[1], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[1], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[1], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[1], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[1], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[1], 0);

	wMenuNeon[2] = CreatePlayerTextDraw(playerid,123.000000, 155.000000+50, "amarelo");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[2], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[2], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[2], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[2], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[2], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[2], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[2], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[2], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[2], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[2], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[2], 0);

	wMenuNeon[3] = CreatePlayerTextDraw(playerid,123.000000, 172.000000+50, "branco");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[3], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[3], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[3], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[3], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[3], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[3], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[3], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[3], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[3], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[3], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[3], 0);

	wMenuNeon[4] = CreatePlayerTextDraw(playerid,123.000000, 191.000000+50, "Rosa");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[4], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[4], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[4], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[4], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[4], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[4], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[4], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[4], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[4], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[4], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[4], 0);

	wMenuNeon[5] = CreatePlayerTextDraw(playerid,123.000000, 211.000000+50, "verde");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[5], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[5], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[5], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[5], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[5], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[5], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[5], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[5], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[5], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[5], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[5], 0);

	wMenuNeon[6] = CreatePlayerTextDraw(playerid,123.000000, 230.000000+50, "vermelho");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[6], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[6], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[6], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[6], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[6], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[6], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[6], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[6], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[6], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[6], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[6], 0);

	wMenuNeon[7] = CreatePlayerTextDraw(playerid,123.000000, 250.000000+50, "remover_neon");
	PlayerTextDrawBackgroundColor(playerid,wMenuNeon[7], 255);
	PlayerTextDrawFont(playerid,wMenuNeon[7], 2);
	PlayerTextDrawLetterSize(playerid,wMenuNeon[7], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuNeon[7], -1);
	PlayerTextDrawSetOutline(playerid,wMenuNeon[7], 0);
	PlayerTextDrawSetProportional(playerid,wMenuNeon[7], 1);
	PlayerTextDrawSetShadow(playerid,wMenuNeon[7], 0);
	PlayerTextDrawUseBox(playerid,wMenuNeon[7], 1);
	PlayerTextDrawBoxColor(playerid,wMenuNeon[7], 0);
	PlayerTextDrawTextSize(playerid,wMenuNeon[7], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuNeon[7], 0);

	for(new i = 1; i < 8; ++i) PlayerTextDrawSetSelectable(playerid, PlayerText:wMenuNeon[i], true);

	HudCop[playerid][0] = CreatePlayerTextDraw(playerid, 442.000000, 204.000000, "SERVICO");
	PlayerTextDrawFont(playerid, HudCop[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, HudCop[playerid][0], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, HudCop[playerid][0], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, HudCop[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, HudCop[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, HudCop[playerid][0], 2);
	PlayerTextDrawColor(playerid, HudCop[playerid][0], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudCop[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, HudCop[playerid][0], -56);
	PlayerTextDrawUseBox(playerid, HudCop[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, HudCop[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, HudCop[playerid][0], 1);

	HudCop[playerid][1] = CreatePlayerTextDraw(playerid, 442.000000, 227.000000, "ARMAS");
	PlayerTextDrawFont(playerid, HudCop[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, HudCop[playerid][1], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, HudCop[playerid][1], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, HudCop[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, HudCop[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, HudCop[playerid][1], 2);
	PlayerTextDrawColor(playerid, HudCop[playerid][1], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudCop[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, HudCop[playerid][1], -56);
	PlayerTextDrawUseBox(playerid, HudCop[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, HudCop[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, HudCop[playerid][1], 1);

	HudCop[playerid][2] = CreatePlayerTextDraw(playerid, 442.000000, 250.000000, "ROUPAS");
	PlayerTextDrawFont(playerid, HudCop[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, HudCop[playerid][2], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, HudCop[playerid][2], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, HudCop[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, HudCop[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, HudCop[playerid][2], 2);
	PlayerTextDrawColor(playerid, HudCop[playerid][2], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudCop[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, HudCop[playerid][2], -56);
	PlayerTextDrawUseBox(playerid, HudCop[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, HudCop[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, HudCop[playerid][2], 1);

	HudCop[playerid][3] = CreatePlayerTextDraw(playerid, 501.000000, 186.000000, "X");
	PlayerTextDrawFont(playerid, HudCop[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, HudCop[playerid][3], 0.241665, 1.000000);
	PlayerTextDrawTextSize(playerid, HudCop[playerid][3], 16.500000, 9.500000);
	PlayerTextDrawSetOutline(playerid, HudCop[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, HudCop[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, HudCop[playerid][3], 2);
	PlayerTextDrawColor(playerid, HudCop[playerid][3], -16776961);
	PlayerTextDrawBackgroundColor(playerid, HudCop[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, HudCop[playerid][3], -56);
	PlayerTextDrawUseBox(playerid, HudCop[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, HudCop[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, HudCop[playerid][3], 1);
	//
	CopGuns[playerid][0] = CreatePlayerTextDraw(playerid, 278.000000, 240.000000, "9MM");
	PlayerTextDrawFont(playerid, CopGuns[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, CopGuns[playerid][0], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, CopGuns[playerid][0], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, CopGuns[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, CopGuns[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, CopGuns[playerid][0], 2);
	PlayerTextDrawColor(playerid, CopGuns[playerid][0], -16776961);
	PlayerTextDrawBackgroundColor(playerid, CopGuns[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, CopGuns[playerid][0], -56);
	PlayerTextDrawUseBox(playerid, CopGuns[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, CopGuns[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, CopGuns[playerid][0], 1);

	CopGuns[playerid][1] = CreatePlayerTextDraw(playerid, 278.000000, 263.000000, "M4");
	PlayerTextDrawFont(playerid, CopGuns[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid, CopGuns[playerid][1], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, CopGuns[playerid][1], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, CopGuns[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, CopGuns[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, CopGuns[playerid][1], 2);
	PlayerTextDrawColor(playerid, CopGuns[playerid][1], -16776961);
	PlayerTextDrawBackgroundColor(playerid, CopGuns[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, CopGuns[playerid][1], -56);
	PlayerTextDrawUseBox(playerid, CopGuns[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, CopGuns[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, CopGuns[playerid][1], 1);

	CopGuns[playerid][2] = CreatePlayerTextDraw(playerid, 278.000000, 285.000000, "SHOTGUN");
	PlayerTextDrawFont(playerid, CopGuns[playerid][2], 2);
	PlayerTextDrawLetterSize(playerid, CopGuns[playerid][2], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, CopGuns[playerid][2], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, CopGuns[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, CopGuns[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, CopGuns[playerid][2], 2);
	PlayerTextDrawColor(playerid, CopGuns[playerid][2], -16776961);
	PlayerTextDrawBackgroundColor(playerid, CopGuns[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, CopGuns[playerid][2], -56);
	PlayerTextDrawUseBox(playerid, CopGuns[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, CopGuns[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, CopGuns[playerid][2], 1);

	CopGuns[playerid][3] = CreatePlayerTextDraw(playerid, 278.000000, 307.000000, "MP5");
	PlayerTextDrawFont(playerid, CopGuns[playerid][3], 2);
	PlayerTextDrawLetterSize(playerid, CopGuns[playerid][3], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, CopGuns[playerid][3], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, CopGuns[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, CopGuns[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, CopGuns[playerid][3], 2);
	PlayerTextDrawColor(playerid, CopGuns[playerid][3], -16776961);
	PlayerTextDrawBackgroundColor(playerid, CopGuns[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, CopGuns[playerid][3], -56);
	PlayerTextDrawUseBox(playerid, CopGuns[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, CopGuns[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, CopGuns[playerid][3], 1);

	CopGuns[playerid][4] = CreatePlayerTextDraw(playerid, 278.000000, 330.000000, "RIFLE");
	PlayerTextDrawFont(playerid, CopGuns[playerid][4], 2);
	PlayerTextDrawLetterSize(playerid, CopGuns[playerid][4], 0.258332, 1.750000);
	PlayerTextDrawTextSize(playerid, CopGuns[playerid][4], 16.500000, 90.500000);
	PlayerTextDrawSetOutline(playerid, CopGuns[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, CopGuns[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, CopGuns[playerid][4], 2);
	PlayerTextDrawColor(playerid, CopGuns[playerid][4], -16776961);
	PlayerTextDrawBackgroundColor(playerid, CopGuns[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, CopGuns[playerid][4], -56);
	PlayerTextDrawUseBox(playerid, CopGuns[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, CopGuns[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, CopGuns[playerid][4], 1);

	CopGuns[playerid][5] = CreatePlayerTextDraw(playerid, 337.000000, 222.000000, "X");
	PlayerTextDrawFont(playerid, CopGuns[playerid][5], 2);
	PlayerTextDrawLetterSize(playerid, CopGuns[playerid][5], 0.258332, 1.200000);
	PlayerTextDrawTextSize(playerid, CopGuns[playerid][5], 16.500000, 10.000000);
	PlayerTextDrawSetOutline(playerid, CopGuns[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, CopGuns[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, CopGuns[playerid][5], 2);
	PlayerTextDrawColor(playerid, CopGuns[playerid][5], -16776961);
	PlayerTextDrawBackgroundColor(playerid, CopGuns[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, CopGuns[playerid][5], -56);
	PlayerTextDrawUseBox(playerid, CopGuns[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, CopGuns[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, CopGuns[playerid][5], 1);

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

	for(new i = 1; i < 31; ++i)
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

	DrawInv[playerid][37] = CreatePlayerTextDraw(playerid, 503.000000, 197.000000, "DROPAR");
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

	DrawInv[playerid][39] = CreatePlayerTextDraw(playerid, 503.000000, 175.000000, "RETIRAR");
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

	//TD BANCO
	BancoTD[playerid][0] = CreatePlayerTextDraw(playerid, 320.000000, 126.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][0], 0.641664, 22.849971);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][0], 298.500000, 354.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][0], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][0], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][0], 437918432);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][0], 0);

	BancoTD[playerid][1] = CreatePlayerTextDraw(playerid, 148.000000, 130.000000, "ld_beat:chit");
	PlayerTextDrawFont(playerid, BancoTD[playerid][1], 4);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][1], 23.000000, 23.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][1], -71);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][1], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][1], 0);

	BancoTD[playerid][2] = CreatePlayerTextDraw(playerid, 155.300003, 137.000000, "HUD:radar_locosyndicate");
	PlayerTextDrawFont(playerid, BancoTD[playerid][2], 4);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][2], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][2], 8.500000, 8.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][2], 1296911733);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][2], 1296911871);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][2], 1296911666);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][2], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][2], 0);

	BancoTD[playerid][3] = CreatePlayerTextDraw(playerid, 320.000000, 169.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][3], 0.600000, 1.099995);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][3], 307.500000, 290.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][3], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][3], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][3], 640034557);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][3], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][3], 0);

	BancoTD[playerid][4] = CreatePlayerTextDraw(playerid, 161.000000, 160.350006, "ld_beat:chit");
	PlayerTextDrawFont(playerid, BancoTD[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][4], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][4], 21.500000, 27.299999);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][4], 640034559);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][4], 640034559);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][4], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][4], 0);

	BancoTD[playerid][5] = CreatePlayerTextDraw(playerid, 459.000000, 160.350006, "ld_beat:chit");
	PlayerTextDrawFont(playerid, BancoTD[playerid][5], 4);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][5], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][5], 19.000000, 26.799999);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][5], 640034559);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][5], 640034559);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][5], 0);

	BancoTD[playerid][6] = CreatePlayerTextDraw(playerid, 186.000000, 168.600006, "Saques");
	PlayerTextDrawFont(playerid, BancoTD[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][6], 0.183329, 1.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][6], 12.500000, 26.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][6], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][6], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][6], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][6], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][6], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][6], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][6], 1);

	BancoTD[playerid][7] = CreatePlayerTextDraw(playerid, 221.000000, 168.600006, "Depositos");
	PlayerTextDrawFont(playerid, BancoTD[playerid][7], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][7], 0.183329, 1.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][7], 12.500000, 30.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][7], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][7], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][7], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][7], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][7], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][7], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][7], 1);

	BancoTD[playerid][8] = CreatePlayerTextDraw(playerid, 264.000000, 168.600006, "Transferencias");
	PlayerTextDrawFont(playerid, BancoTD[playerid][8], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][8], 0.183329, 1.000000);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][8], 12.500000, 43.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][8], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][8], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][8], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][8], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][8], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][8], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][8], 1);

	BancoTD[playerid][9] = CreatePlayerTextDraw(playerid, 239.000000, 170.899993, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][9], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][9], 0.641664, 0.700034);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][9], 298.500000, -2.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][9], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][9], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][9], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][9], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][9], 437918307);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][9], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][9], 1);

	BancoTD[playerid][10] = CreatePlayerTextDraw(playerid, 201.500000, 170.899993, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][10], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][10], 0.641664, 0.700034);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][10], 298.500000, -2.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][10], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][10], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][10], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][10], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][10], 437918307);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][10], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][10], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][10], 1);

	BancoTD[playerid][11] = CreatePlayerTextDraw(playerid, 384.000000, 194.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][11], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][11], 0.641664, 3.300007);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][11], 298.500000, 133.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][11], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][11], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][11], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][11], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][11], 437918454);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][11], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][11], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][11], 0);

	BancoTD[playerid][12] = CreatePlayerTextDraw(playerid, 195.000000, 136.600006, "Allison_Gomes");
	PlayerTextDrawFont(playerid, BancoTD[playerid][12], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][12], 0.224996, 1.049998);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][12], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][12], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][12], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][12], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][12], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][12], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][12], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][12], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][12], 1);

	BancoTD[playerid][13] = CreatePlayerTextDraw(playerid, 238.000000, 194.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][13], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][13], 0.641664, 3.300007);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][13], 298.500000, 133.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][13], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][13], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][13], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][13], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][13], 437918454);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][13], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][13], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][13], 0);

	BancoTD[playerid][14] = CreatePlayerTextDraw(playerid, 196.000000, 192.600006, "Saldo Carteira");
	PlayerTextDrawFont(playerid, BancoTD[playerid][14], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][14], 0.133331, 0.849999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][14], 17.000000, 56.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][14], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][14], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][14], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][14], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][14], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][14], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][14], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][14], 0);

	BancoTD[playerid][15] = CreatePlayerTextDraw(playerid, 182.000000, 198.600006, "I $");
	PlayerTextDrawFont(playerid, BancoTD[playerid][15], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][15], 0.416666, 2.349997);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][15], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][15], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][15], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][15], 9109666);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][15], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][15], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][15], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][15], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][15], 0);

	BancoTD[playerid][16] = CreatePlayerTextDraw(playerid, 193.000000, 199.600006, "1000");
	PlayerTextDrawFont(playerid, BancoTD[playerid][16], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][16], 0.416666, 2.349997);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][16], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][16], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][16], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][16], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][16], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][16], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][16], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][16], 0);

	BancoTD[playerid][17] = CreatePlayerTextDraw(playerid, 338.000000, 199.600006, "999.999.999");
	PlayerTextDrawFont(playerid, BancoTD[playerid][17], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][17], 0.416666, 2.349997);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][17], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][17], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][17], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][17], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][17], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][17], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][17], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][17], 0);

	BancoTD[playerid][18] = CreatePlayerTextDraw(playerid, 326.799987, 198.600006, "i $");
	PlayerTextDrawFont(playerid, BancoTD[playerid][18], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][18], 0.416666, 2.349997);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][18], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][18], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][18], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][18], 9109666);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][18], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][18], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][18], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][18], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][18], 0);

	BancoTD[playerid][19] = CreatePlayerTextDraw(playerid, 342.000000, 192.600006, "Saldo Bancario");
	PlayerTextDrawFont(playerid, BancoTD[playerid][19], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][19], 0.133331, 0.849999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][19], 17.000000, 56.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][19], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][19], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][19], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][19], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][19], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][19], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][19], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][19], 0);

	BancoTD[playerid][20] = CreatePlayerTextDraw(playerid, 218.000000, 282.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][20], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][20], 0.591664, 4.599995);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][20], 267.500000, 121.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][20], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][20], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][20], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][20], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][20], -2686730);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][20], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][20], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][20], 0);

	BancoTD[playerid][21] = CreatePlayerTextDraw(playerid, 218.000000, 286.000000, "Realizar Transacao");
	PlayerTextDrawFont(playerid, BancoTD[playerid][21], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][21], 0.183329, 1.399999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][21], 13.500000, 116.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][21], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][21], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][21], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][21], -15);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][21], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][21], -65337);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][21], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][21], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][21], 1);

	BancoTD[playerid][22] = CreatePlayerTextDraw(playerid, 218.000000, 308.000000, "CANCELAR");
	PlayerTextDrawFont(playerid, BancoTD[playerid][22], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][22], 0.183329, 1.399999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][22], 13.500000, 116.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][22], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][22], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][22], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][22], -15);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][22], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][22], -65336);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][22], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][22], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][22], 1);

	BancoTD[playerid][23] = CreatePlayerTextDraw(playerid, 318.000000, 133.600006, "BAIXADA");
	PlayerTextDrawFont(playerid, BancoTD[playerid][23], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][23], 0.224996, 1.049998);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][23], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][23], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][23], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][23], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][23], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][23], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][23], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][23], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][23], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][23], 0);

	BancoTD[playerid][24] = CreatePlayerTextDraw(playerid, 318.700012, 138.600006, "Bank");
	PlayerTextDrawFont(playerid, BancoTD[playerid][24], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][24], 0.224996, 1.049998);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][24], 16.500000, 51.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][24], 1);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][24], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][24], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][24], -65281);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][24], 51);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][24], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][24], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][24], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][24], 0);

	BancoTD[playerid][25] = CreatePlayerTextDraw(playerid, 489.000000, 127.000000, "X");
	PlayerTextDrawFont(playerid, BancoTD[playerid][25], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][25], 0.345833, 1.649999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][25], 20.000000, 33.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][25], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][25], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][25], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][25], -111);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][25], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][25], 0);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][25], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][25], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][25], 1);

	BancoTD[playerid][26] = CreatePlayerTextDraw(playerid, 218.000000, 252.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][26], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][26], 0.641664, 1.900007);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][26], 297.500000, 116.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][26], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][26], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][26], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][26], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][26], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][26], 437918454);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][26], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][26], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][26], 0);

	BancoTD[playerid][27] = CreatePlayerTextDraw(playerid, 176.000000, 238.600006, "SACAR");
	PlayerTextDrawFont(playerid, BancoTD[playerid][27], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][27], 0.133331, 0.849999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][27], 17.000000, 56.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][27], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][27], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][27], 3);
	PlayerTextDrawColor(playerid, BancoTD[playerid][27], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][27], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][27], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][27], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][27], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][27], 0);

	BancoTD[playerid][28] = CreatePlayerTextDraw(playerid, 163.000000, 255.600006, "Digite a quantia");
	PlayerTextDrawFont(playerid, BancoTD[playerid][28], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][28], 0.166664, 1.049998);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][28], 223.000000, 6.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][28], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][28], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][28], 1);
	PlayerTextDrawColor(playerid, BancoTD[playerid][28], -214);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][28], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][28], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][28], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][28], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][28], 1);

	BancoTD[playerid][29] = CreatePlayerTextDraw(playerid, 394.000000, 252.000000, "_");
	PlayerTextDrawFont(playerid, BancoTD[playerid][29], 1);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][29], 0.641664, 7.850008);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][29], 297.500000, 174.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][29], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][29], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][29], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][29], -1);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][29], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][29], -2686730);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][29], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][29], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][29], 0);

	BancoTD[playerid][30] = CreatePlayerTextDraw(playerid, 325.000000, 239.600006, "Saque Rapido");
	PlayerTextDrawFont(playerid, BancoTD[playerid][30], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][30], 0.137492, 0.799996);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][30], 17.000000, 56.500000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][30], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][30], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][30], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][30], -94);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][30], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][30], 200);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][30], 0);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][30], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][30], 0);

	BancoTD[playerid][31] = CreatePlayerTextDraw(playerid, 394.299987, 281.000000, "$50.000");
	PlayerTextDrawFont(playerid, BancoTD[playerid][31], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][31], 0.183329, 1.399999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][31], 15.500000, 164.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][31], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][31], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][31], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][31], -15);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][31], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][31], -65337);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][31], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][31], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][31], 1);

	BancoTD[playerid][32] = CreatePlayerTextDraw(playerid, 394.299987, 305.000000, "$100.000");
	PlayerTextDrawFont(playerid, BancoTD[playerid][32], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][32], 0.183329, 1.399999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][32], 15.500000, 164.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][32], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][32], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][32], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][32], -15);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][32], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][32], -65337);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][32], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][32], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][32], 1);

	BancoTD[playerid][33] = CreatePlayerTextDraw(playerid, 394.299987, 257.000000, "$5.000");
	PlayerTextDrawFont(playerid, BancoTD[playerid][33], 2);
	PlayerTextDrawLetterSize(playerid, BancoTD[playerid][33], 0.183329, 1.399999);
	PlayerTextDrawTextSize(playerid, BancoTD[playerid][33], 15.500000, 164.000000);
	PlayerTextDrawSetOutline(playerid, BancoTD[playerid][33], 0);
	PlayerTextDrawSetShadow(playerid, BancoTD[playerid][33], 0);
	PlayerTextDrawAlignment(playerid, BancoTD[playerid][33], 2);
	PlayerTextDrawColor(playerid, BancoTD[playerid][33], -15);
	PlayerTextDrawBackgroundColor(playerid, BancoTD[playerid][33], 255);
	PlayerTextDrawBoxColor(playerid, BancoTD[playerid][33], -65337);
	PlayerTextDrawUseBox(playerid, BancoTD[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, BancoTD[playerid][33], 1);
	PlayerTextDrawSetSelectable(playerid, BancoTD[playerid][33], 1);

    	//TD MORTE STRINGS
	TDmorte_p[playerid][0] = CreatePlayerTextDraw(playerid, 283.000000, 273.000000, "00:00");
	PlayerTextDrawFont(playerid, TDmorte_p[playerid][0], 2);
	PlayerTextDrawLetterSize(playerid, TDmorte_p[playerid][0], 0.774999, 3.199996);
	PlayerTextDrawTextSize(playerid, TDmorte_p[playerid][0], 892.000000, 29.000000);
	PlayerTextDrawSetOutline(playerid, TDmorte_p[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, TDmorte_p[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, TDmorte_p[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDmorte_p[playerid][0], -65281);
	PlayerTextDrawBackgroundColor(playerid, TDmorte_p[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, TDmorte_p[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, TDmorte_p[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, TDmorte_p[playerid][0], 0);

	//TD RG STRINGS
	RG_p[playerid][0] = CreatePlayerTextDraw(playerid, 275.000000, 205.000000, "Guilherme Derrite da Silva");
	PlayerTextDrawFont(playerid, RG_p[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid, RG_p[playerid][0], 0.191666, 1.150000);
	PlayerTextDrawTextSize(playerid, RG_p[playerid][0], 400.000000, 320.500000);
	PlayerTextDrawSetOutline(playerid, RG_p[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, RG_p[playerid][0], 0);
	PlayerTextDrawAlignment(playerid, RG_p[playerid][0], 1);
	PlayerTextDrawColor(playerid, RG_p[playerid][0], 255);
	PlayerTextDrawBackgroundColor(playerid, RG_p[playerid][0], 255);
	PlayerTextDrawBoxColor(playerid, RG_p[playerid][0], 50);
	PlayerTextDrawUseBox(playerid, RG_p[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid, RG_p[playerid][0], 1);
	PlayerTextDrawSetSelectable(playerid, RG_p[playerid][0], 0);

	RG_p[playerid][1] = CreatePlayerTextDraw(playerid, 233.000000, 218.000000, "Preview_Model");
	PlayerTextDrawFont(playerid, RG_p[playerid][1], 5);
	PlayerTextDrawLetterSize(playerid, RG_p[playerid][1], 0.600000, 2.000000);
	PlayerTextDrawTextSize(playerid, RG_p[playerid][1], 51.500000, 66.000000);
	PlayerTextDrawSetOutline(playerid, RG_p[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, RG_p[playerid][1], 0);
	PlayerTextDrawAlignment(playerid, RG_p[playerid][1], 1);
	PlayerTextDrawColor(playerid, RG_p[playerid][1], -1);
	PlayerTextDrawBackgroundColor(playerid, RG_p[playerid][1], -1);
	PlayerTextDrawBoxColor(playerid, RG_p[playerid][1], 255);
	PlayerTextDrawUseBox(playerid, RG_p[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid, RG_p[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, RG_p[playerid][1], 0);
	PlayerTextDrawSetPreviewModel(playerid, RG_p[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, RG_p[playerid][1], -7.000000, 0.000000, -3.000000, 0.890000);
	PlayerTextDrawSetPreviewVehCol(playerid, RG_p[playerid][1], 1, 1);

	RG_p[playerid][2] = CreatePlayerTextDraw(playerid, 288.000000, 226.000000, "Charles Derrite da Silva");
	PlayerTextDrawFont(playerid, RG_p[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid, RG_p[playerid][2], 0.162500, 0.850000);
	PlayerTextDrawTextSize(playerid, RG_p[playerid][2], 400.000000, 320.500000);
	PlayerTextDrawSetOutline(playerid, RG_p[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, RG_p[playerid][2], 0);
	PlayerTextDrawAlignment(playerid, RG_p[playerid][2], 1);
	PlayerTextDrawColor(playerid, RG_p[playerid][2], 255);
	PlayerTextDrawBackgroundColor(playerid, RG_p[playerid][2], 255);
	PlayerTextDrawBoxColor(playerid, RG_p[playerid][2], 50);
	PlayerTextDrawUseBox(playerid, RG_p[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid, RG_p[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, RG_p[playerid][2], 0);

	RG_p[playerid][3] = CreatePlayerTextDraw(playerid, 288.000000, 232.000000, "Creuza Maria da Silva");
	PlayerTextDrawFont(playerid, RG_p[playerid][3], 1);
	PlayerTextDrawLetterSize(playerid, RG_p[playerid][3], 0.162500, 0.850000);
	PlayerTextDrawTextSize(playerid, RG_p[playerid][3], 400.000000, 320.500000);
	PlayerTextDrawSetOutline(playerid, RG_p[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, RG_p[playerid][3], 0);
	PlayerTextDrawAlignment(playerid, RG_p[playerid][3], 1);
	PlayerTextDrawColor(playerid, RG_p[playerid][3], 255);
	PlayerTextDrawBackgroundColor(playerid, RG_p[playerid][3], 255);
	PlayerTextDrawBoxColor(playerid, RG_p[playerid][3], 50);
	PlayerTextDrawUseBox(playerid, RG_p[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid, RG_p[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, RG_p[playerid][3], 0);

	RG_p[playerid][4] = CreatePlayerTextDraw(playerid, 288.000000, 258.000000, "04/03/1996");
	PlayerTextDrawFont(playerid, RG_p[playerid][4], 1);
	PlayerTextDrawLetterSize(playerid, RG_p[playerid][4], 0.162500, 0.850000);
	PlayerTextDrawTextSize(playerid, RG_p[playerid][4], 400.000000, 320.500000);
	PlayerTextDrawSetOutline(playerid, RG_p[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, RG_p[playerid][4], 0);
	PlayerTextDrawAlignment(playerid, RG_p[playerid][4], 1);
	PlayerTextDrawColor(playerid, RG_p[playerid][4], 255);
	PlayerTextDrawBackgroundColor(playerid, RG_p[playerid][4], 255);
	PlayerTextDrawBoxColor(playerid, RG_p[playerid][4], 50);
	PlayerTextDrawUseBox(playerid, RG_p[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid, RG_p[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, RG_p[playerid][4], 0);

	RG_p[playerid][5] = CreatePlayerTextDraw(playerid, 340.000000, 268.000000, "Guilherme Derrite da Silva");
	PlayerTextDrawFont(playerid, RG_p[playerid][5], 0);
	PlayerTextDrawLetterSize(playerid, RG_p[playerid][5], 0.195833, 1.000000);
	PlayerTextDrawTextSize(playerid, RG_p[playerid][5], 481.500000, -248.000000);
	PlayerTextDrawSetOutline(playerid, RG_p[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, RG_p[playerid][5], 0);
	PlayerTextDrawAlignment(playerid, RG_p[playerid][5], 1);
	PlayerTextDrawColor(playerid, RG_p[playerid][5], 255);
	PlayerTextDrawBackgroundColor(playerid, RG_p[playerid][5], 255);
	PlayerTextDrawBoxColor(playerid, RG_p[playerid][5], 50);
	PlayerTextDrawUseBox(playerid, RG_p[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid, RG_p[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, RG_p[playerid][5], 0);


	// Fader (Ultimo sempre)
	new tmp[E_PLAYER_FADE_INFO];
	gPlayerFadeInfo[playerid] = tmp;

	new PlayerText:text = CreatePlayerTextDraw(playerid, -20.0, -20.0, "_");
	gPlayerFaderTextId = text;
	gPlayerFadeInfo[playerid][fadeCurrentAlpha] = MAX_TRANSPARENCY;
	// detalhes
	PlayerTextDrawUseBox(playerid, text, 1);
	PlayerTextDrawBoxColor(playerid, text, 0xFFFFFF00);
	PlayerTextDrawLetterSize(playerid, text, 680.0, 500.0);
	PlayerTextDrawTextSize(playerid, text, 680.0, 500.0);

}
stock CreateTelaLogin(){

	//Loadscreen
	Loadsc[0] = TextDrawCreate(321.000000, -6.000000, "_");
	TextDrawFont(Loadsc[0], 1);
	TextDrawLetterSize(Loadsc[0], 0.662499, 52.049987);
	TextDrawTextSize(Loadsc[0], 298.500000, 751.000000);
	TextDrawSetOutline(Loadsc[0], 1);
	TextDrawSetShadow(Loadsc[0], 0);
	TextDrawAlignment(Loadsc[0], 2);
	TextDrawColor(Loadsc[0], -1);
	TextDrawBackgroundColor(Loadsc[0], 255);
	TextDrawBoxColor(Loadsc[0], 471604479);
	TextDrawUseBox(Loadsc[0], 1);
	TextDrawSetProportional(Loadsc[0], 1);
	TextDrawSetSelectable(Loadsc[0], 0);

	Loadsc[13] = TextDrawCreate(230.000000, 248.000000, "BAIXANDO DADOS DO SERVIDOR, AGUARDE...");
	TextDrawFont(Loadsc[13], 2);
	TextDrawLetterSize(Loadsc[13], 0.208333, 1.300000);
	TextDrawTextSize(Loadsc[13], 474.000000, -88.500000);
	TextDrawSetOutline(Loadsc[13], 0);
	TextDrawSetShadow(Loadsc[13], 0);
	TextDrawAlignment(Loadsc[13], 1);
	TextDrawColor(Loadsc[13], -1);
	TextDrawBackgroundColor(Loadsc[13], 255);
	TextDrawBoxColor(Loadsc[13], 50);
	TextDrawUseBox(Loadsc[13], 0);
	TextDrawSetProportional(Loadsc[13], 1);
	TextDrawSetSelectable(Loadsc[13], 0);
}

stock GetPlayerSerial(playerid)
{
    new serial[512];
    gpci(playerid,serial,sizeof(serial));
    return serial;
}

stock LimparChat(playerid, limit)
{
	for(new i; i < limit; i++)
	{
		SendClientMessage(playerid, -1, "");
	}
	return 1;
}

stock MsgFrequencia(freq, color, msg[])
{
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
			if(FrequenciaConectada[i] > 0 && FrequenciaConectada[i] == freq)
			{
				SendClientMessage(i, color, msg);
			}
		}
	}
	return 1;
}

stock PlayerName(playerid)
{
	new pName[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pName, MAX_PLAYER_NAME);
	return pName;
}

stock IsPlayerSpawned(playerid)
{
	switch(GetPlayerState(playerid))
	{
		case 1,2,3: return 1;
	}
	return 0;
}

stock IsMeleeWeapon(weaponid)
{
	switch(weaponid)
	{
		case 2 .. 15, 40, 44 .. 46: return 1;
	}
	return 0;
}

stock IsBicycle(vehicleid)
{
	switch(GetVehicleModel(vehicleid))
	{
		case 481,509,510: return 1;
	}
	return 0;
}

stock PlayerToPlayer(playerid, targetid, Float:dist)
{
	new Float:pos[3];
	GetPlayerPos(targetid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}

stock PlayerToVehicle(playerid, vehicleid, Float:dist)
{
	new Float:pos[3];
	GetVehiclePos(vehicleid, pos[0], pos[1], pos[2]);
	return IsPlayerInRangeOfPoint(playerid, dist, pos[0], pos[1], pos[2]);
}

stock GetClosestVehicle(playerid)
{
	new Float:x, Float:y, Float:z;
	new Float:dist, Float:closedist=9999, closeveh;
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(GetVehiclePos(i, x, y, z))
		{
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if(dist < closedist)
			{
				closedist = dist;
				closeveh = i;
			}
		}
	}
	return closeveh;
}

stock ToggleEngine(vehicleid, toggle)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, toggle, lights, alarm, doors, bonnet, boot, objective);
}

stock ToggleAlarm(vehicleid, toggle)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, toggle, doors, bonnet, boot, objective);
}

stock ToggleDoors(vehicleid, toggle)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, toggle, bonnet, boot, objective);
}

stock ToggleBoot(vehicleid, toggle)
{
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, toggle, objective);
}

stock StripNL(str[]) // credits to Y_Less for y_utils.inc
{
	new
		i = strlen(str);
	while (i-- && str[i] <= ' ') str[i] = '\0';
}

stock GetVehicleModelIDFromName(const vname[])
{
	for(new i=0; i < sizeof(VehicleNames); i++)
	{
		if(strfind(VehicleNames[i], vname, true) != -1) return i + 400;
	}
	return -1;
}

stock GetPlayer2DZone(playerid)
{
	new zone[32] = "San Andreas";
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	for(new i = 0; i < sizeof(SanAndreasZones); i++)
	{
		if(x >= SanAndreasZones[i][Zone_Area][0] && x <= SanAndreasZones[i][Zone_Area][3]
		&& y >= SanAndreasZones[i][Zone_Area][1] && y <= SanAndreasZones[i][Zone_Area][4])
		{
			strmid(zone, SanAndreasZones[i][Zone_Name], 0, 28);
			return zone;
		}
	}
	return zone;
}

stock GetPlayer3DZone(playerid)
{
	new zone[32] = "San Andreas";
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	for(new i = 0; i < sizeof(SanAndreasZones); i++)
	{
		if(x >= SanAndreasZones[i][Zone_Area][0] && x <= SanAndreasZones[i][Zone_Area][3]
		&& y >= SanAndreasZones[i][Zone_Area][1] && y <= SanAndreasZones[i][Zone_Area][4]
		&& z >= SanAndreasZones[i][Zone_Area][2] && z <= SanAndreasZones[i][Zone_Area][5])
		{
			strmid(zone, SanAndreasZones[i][Zone_Name], 0, 28);
			return zone;
		}
	}
	return zone;
}

stock CriarRadares()
{
	new Account[255];
	for(new i; i < MAX_RADAR; i++)
	{
		format(Account, sizeof(Account), PASTA_RADAR, i);
		if(DOF2_FileExists(Account))
		{
			RadarInfo[i][RadarID] = DOF2_GetInt(Account, "RadarID");
			RadarInfo[i][RadarVelocidade] = DOF2_GetInt(Account, "RadarVelocidade");

			RadarInfo[i][RadarPosX] = DOF2_GetFloat(Account, "RadarPosX");
			RadarInfo[i][RadarPosY] = DOF2_GetFloat(Account, "RadarPosY");
			RadarInfo[i][RadarPosZ] = DOF2_GetFloat(Account, "RadarPosZ");
			RadarInfo[i][RadarPosR] = DOF2_GetFloat(Account, "RadarPosR");
			IniciarRadares ++;
			ObjetoRadar[i] = CreateDynamicObject(18880, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]-1.5, 0.0, 0.0, RadarInfo[i][RadarPosR]);
			ObjetoRadar2[i] = CreateDynamicObject(18880, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]-1.5, 0.0, 0.0, RadarInfo[i][RadarPosR] + 180.0);

			new string[5000];
			format(string, sizeof(string), "{FFFFFF}RADAR ID:{00FF00}%d{FFFFFF}\nVelocidade Maxima: {FF2400}%d KM/H{FFFFFF}", RadarInfo[i][RadarID], RadarInfo[i][RadarVelocidade]);
			TextoRadar[i] = CreateDynamic3DTextLabel(string, -1, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]+4, 50.0);
		}
	}
	return printf("=> Radares       		: %d Carregados", IniciarRadares);
}

stock Checarveiculo(Float:radi, playerid, vehicleid)
{
	new Float:x, Float:y, Float:z;
	GetVehiclePos(vehicleid, x, y, z);
	if(IsPlayerInRangeOfPoint(playerid, radi, x, y, z))
		return 1;
	return 0;
}

stock CriarCasas()
{
	new File[255];
	for(new i = 0; i < MAX_CASAS; i++)
	{
		format(File, sizeof(File), PASTA_CASAS, i);
		if(DOF2_FileExists(File))
		{
			format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
			format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));
			CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
			CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
			CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
			CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
			CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
			CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

			CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
			CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
			CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

			CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
			CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
			CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");
			IniciarCasas ++;

			if(!strcmp(CasaInfo[i][CasaDono], "Nenhum", true))
			{
				PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
				MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
			}
			else
			{
				PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
				MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
			}
			new string[5000];
			format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
			TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
		}
	}
	return printf("=> Casas       		: %d Carregados", IniciarCasas);
}

stock GetName( playerid ) {
	new playerName[ MAX_PLAYER_NAME ];
	GetPlayerName( playerid, playerName, sizeof( playerName ) );
	return playerName;
}

static s_AnimationLibraries[][] = {
		!"AIRPORT",    !"ATTRACTORS",   !"BAR",                 !"BASEBALL",
		!"BD_FIRE",    !"BEACH",            !"BENCHPRESS",  !"BF_INJECTION",
		!"BIKED",          !"BIKEH",        !"BIKELEAP",        !"BIKES",
		!"BIKEV",          !"BIKE_DBZ",     !"BMX",             !"BOMBER",
		!"BOX",            !"BSKTBALL",     !"BUDDY",           !"BUS",
		!"CAMERA",         !"CAR",          !"CARRY",           !"CAR_CHAT",
		!"CASINO",         !"CHAINSAW",     !"CHOPPA",          !"CLOTHES",
		!"COACH",          !"COLT45",       !"COP_AMBIENT", !"COP_DVBYZ",
		!"CRACK",          !"CRIB",         !"DAM_JUMP",         !"DANCING",
		!"DEALER",         !"DILDO",        !"DODGE",            !"DOZER",
		!"DRIVEBYS",   !"FAT",          !"FIGHT_B",      !"FIGHT_C",
		!"FIGHT_D",    !"FIGHT_E",      !"FINALE",               !"FINALE2",
		!"FLAME",      !"FLOWERS",      !"FOOD",                 !"FREEWEIGHTS",
		!"GANGS",      !"GHANDS",       !"GHETTO_DB",    !"GOGGLES",
		!"GRAFFITI",   !"GRAVEYARD",    !"GRENADE",      !"GYMNASIUM",
		!"HAIRCUTS",   !"HEIST9",       !"INT_HOUSE",    !"INT_OFFICE",
		!"INT_SHOP",   !"JST_BUISNESS", !"KART",                 !"KISSING",
		!"KNIFE",      !"LAPDAN1",              !"LAPDAN2",      !"LAPDAN3",
		!"LOWRIDER",   !"MD_CHASE",     !"MD_END",               !"MEDIC",
		!"MISC",       !"MTB",                  !"MUSCULAR",     !"NEVADA",
		!"ON_LOOKERS", !"OTB",                  !"PARACHUTE",    !"PARK",
		!"PAULNMAC",   !"PED",                  !"PLAYER_DVBYS", !"PLAYIDLES",
		!"POLICE",     !"POOL",                 !"POOR",                 !"PYTHON",
		!"QUAD",       !"QUAD_DBZ",     !"RAPPING",      !"RIFLE",
		!"RIOT",       !"ROB_BANK",     !"ROCKET",               !"RUSTLER",
		!"RYDER",      !"SCRATCHING",   !"SHAMAL",               !"SHOP",
		!"SHOTGUN",    !"SILENCED",     !"SKATE",                !"SMOKING",
		!"SNIPER",     !"SPRAYCAN",     !"STRIP",                !"SUNBATHE",
		!"SWAT",       !"SWEET",                !"SWIM",                 !"SWORD",
		!"TANK",       !"TATTOOS",              !"TEC",                  !"TRAIN",
		!"TRUCK",      !"UZI",                  !"VAN",                  !"VENDING",
		!"VORTEX",     !"WAYFARER",     !"WEAPONS",      !"WUZI",
		!"WOP",        !"GFUNK",                !"RUNNINGMAN"
};

stock static PreloadActorAnimations(actorid)
{
		for(new i = 0; i < sizeof(s_AnimationLibraries); i ++)
		{
			ApplyActorAnimation(actorid, s_AnimationLibraries[i], "null", 0.0, 0, 0, 0, 0, 0);
		}
}

stock GetPlayerOrg(playerid)
{
	new org;
	if(PlayerInfo[playerid][Org] > 0)
	{
		org = PlayerInfo[playerid][Org];
		return org;
	}
	return 0;
}

static stock DepositarGranaOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Dinheiro];
	CofreOrg[org][Dinheiro] = antes+valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Dinheiro",CofreOrg[org][Dinheiro]);
	DOF2_SaveFile();
	return true;
}
static stock SacarGranaOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Dinheiro];
	CofreOrg[org][Dinheiro] = antes-valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Dinheiro",CofreOrg[org][Dinheiro]);
	DOF2_SaveFile();
	return true;
}

static stock DepositarMaconhaOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Maconha];
	CofreOrg[org][Maconha] = antes+valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Maconha",CofreOrg[org][Maconha]);
	DOF2_SaveFile();
	return true;
}

static stock SacarMaconhaOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Maconha];
	CofreOrg[org][Maconha] = antes-valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Maconha",CofreOrg[org][Maconha]);
	DOF2_SaveFile();
	return true;
}

static stock DepositarCocainaOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Cocaina];
	CofreOrg[org][Cocaina] = antes+valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Cocaina",CofreOrg[org][Cocaina]);
	DOF2_SaveFile();
	return true;
}

static stock SacarCocainaOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Cocaina];
	CofreOrg[org][Cocaina] = antes-valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Cocaina",CofreOrg[org][Cocaina]);
	DOF2_SaveFile();
	return true;
}

static stock DepositarCrackOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Crack];
	CofreOrg[org][Crack] = antes+valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Crack",CofreOrg[org][Crack]);
	DOF2_SaveFile();
	return true;
}

static stock SacarCrackOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Crack];
	CofreOrg[org][Crack] = antes-valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Crack",CofreOrg[org][Crack]);
	DOF2_SaveFile();
	return true;
}

static stock DiminuirEquiparOrg(org,valor)
{
	new File[255];
	new antes = CofreOrg[org][Equipar];
	CofreOrg[org][Equipar] = antes-valor;
	format(File, sizeof(File), PASTA_COFREORG,org);
	DOF2_SetInt(File,"Equipar",CofreOrg[org][Equipar]);
	DOF2_SaveFile();
	return true;
}

stock IsPerto(playerid,id){
	new Float:x,Float:y,Float:z;
	GetPlayerPos(id,x,y,z);
	if(IsPlayerInRangeOfPoint(playerid,30,x,y,z)){
		return 1;
	}
	return 0;
}

stock addlider(playerid, idorg)
{
	new String[500];
	format(String, sizeof(String), PASTA_ORGS, idorg);
	if(!DOF2_FileExists(String))return true;

	if(!strcmp(DOF2_GetString(String,VagasORG[0]),"Nenhum",true))
	{
		DOF2_SetString(String,VagasORG[0], Name(playerid));
		DOF2_SaveFile();
	}
	return true;
}
stock tirarlider(playerid, idorg)
{
	format(String, sizeof(String), PASTA_ORGS, idorg);
	if(!DOF2_FileExists(String))return true;
	if(!strcmp(DOF2_GetString(String,VagasORG[0]),"Nenhum",true))return ErrorMsg(playerid, "Nao tem um lider nessa org.");
	DOF2_SetString(String,VagasORG[0], "Nenhum");
	return true;
}
stock convidarmembro(playerid, idorg)
{
	new String[500];
	format(String, sizeof(String), PASTA_ORGS, idorg);
	if(!DOF2_FileExists(String))return true;
	for(new i=1; i< sizeof VagasORG; i++)
	{
		if(!strcmp(DOF2_GetString(String,VagasORG[i]), "Nenhum",true))
		{
			DOF2_SetString(String, VagasORG[i], Name(playerid));
			DOF2_SaveFile();
			return true;
		}
	}
	return true;
}
stock expulsarmembro(playerid, idorg)
{
	new String[500];
	format(String, sizeof(String), PASTA_ORGS, idorg);
	if(!DOF2_FileExists(String))return true;
	for(new i=1; i< sizeof VagasORG; i++)
	{
		if(!strcmp(DOF2_GetString(String,VagasORG[i]), Name(playerid),true))
		{
			DOF2_SetString(String, VagasORG[i], "Nenhum");
			DOF2_SaveFile();
			return true;
		}
	}
	return true;
}
stock ChecarOrg(playerid)
{
	new String[500];
	new orgid = PlayerInfo[playerid][Org];
	format(String, sizeof(String), PASTA_ORGS, orgid);
	if(strcmp(DOF2_GetString(String,VagasORG[0]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[1]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[2]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[3]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[4]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[5]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[6]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[7]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[8]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[9]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[10]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[11]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[12]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[13]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[14]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[15]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[16]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[17]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[18]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[19]),Name(playerid), true) == 0) return 1;
	if(strcmp(DOF2_GetString(String,VagasORG[20]),Name(playerid), true) == 0) return 1;
	PlayerInfo[playerid][Org] = 0;
	PlayerInfo[playerid][Cargo] = 0;
	InfoMsg(playerid, "Foi expulsado.");
	SpawnPlayer(playerid);
	return 0;
}

stock membrosorg(playerid, idorg)
{
	new String[500];
	new corda[1500], wiki[950];
	format(String, sizeof(String), PASTA_ORGS, idorg);
	for(new i=0; i< sizeof VagasORG; i++)
	{
	   format(wiki, sizeof wiki,"{FFFFFF}%s: %s (%s)\n",VagasORG[i], DOF2_GetString(String,VagasORG[i]), NomeCargoOff(DOF2_GetString(String,VagasORG[i])));
	   strcat(corda, wiki);
	}
	ShowPlayerDialog(playerid, DIALOG_MEMBROSORG, DIALOG_STYLE_MSGBOX, "Membros ORG", corda,"X", #);
	return true;
}
stock NomeCargoOff(Nome[])
{
	new CARGO[40],Crogo,strings[150];
	format(strings, sizeof(strings), PASTA_CONTAS, Nome);
	Crogo = DOF2_GetInt(strings, "pCargo");
	if(Crogo == 1)
	{
		CARGO = "Membro";
	}
	if(Crogo == 2)
	{
		CARGO = "SubLider";
	}
	if(Crogo == 3)
	{
		CARGO = "Lider";
	}
	return CARGO;
}

stock NomeCargo(playerid)
{
	new CARGO[40];
	if(PlayerInfo[playerid][Org] > 0)
	{
		if(PlayerInfo[playerid][Cargo] == 0)
		{
			CARGO = "Nenhum";
		}
		if(PlayerInfo[playerid][Cargo] == 1)
		{
			CARGO = "Membro";
		}
		if(PlayerInfo[playerid][Cargo] == 2)
		{
			CARGO = "SubLider";
		}
		if(PlayerInfo[playerid][Cargo] == 3)
		{
			CARGO = "Lider";
		}
	}
	return CARGO;
}
stock NomeOrg(playerid)
{	
	new orG[35],org;
	org = PlayerInfo[playerid][Org];
	if(org == 0)
	{
		orG = "Civil";
	}
	if(org == 1)
	{
		orG = "Policia Militar";
	}
	if(org == 2)
	{
		orG = "Policia Rodoviaria";
	}
	if(org == 3)
	{
		orG = "Rota";
	}
	if(org == 4)
	{
		orG = "Baep";
	}
	if(org == 5)
	{
		orG = "Tropa dos Amarelos";
	}
	if(org == 6)
	{
		orG = "Tropa dos Azuis";
	}
	if(org == 7)
	{
		orG = "Tropa dos Vermelhos";
	}
	if(org == 8)
	{
		orG = "Tropa dos Verde";
	}
	if(org == 9)
	{
		orG = "Medicos";
	}
	if(org == 10)
	{
		orG = "Mecanicos";
	}
	if(org == 11)
	{
		orG = "Reportagem";
	}
	if(org == 12)
	{
		orG = "Mafia Russa";
	}
	if(org == 13)
	{
		orG = "Moto Clube";
	}
	return orG;
}

stock GetPlayer2DZone2(playerid, zone[], len)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);
	for(new i = 0; i != sizeof(gSAZones); i++)
	{
		if(x >= gSAZones[i][SAZONE_AREA][0] && x <= gSAZones[i][SAZONE_AREA][3] && y >= gSAZones[i][SAZONE_AREA][1] && y <= gSAZones[i][SAZONE_AREA][4])
		{
			return format(zone, len, gSAZones[i][SAZONE_NAME], 0);
		}
	}
	return 0;
}

stock GetPlayerCaixa(playerid)
{
	new Float:px, Float:py, Float:pz;

	for(new caixa = 1; caixa < MAX_CAIXAS; caixa++)
	{
		GetDynamicObjectPos(CaixaInfo[caixa][Caixa_Object], px, py, pz);
		if(IsPlayerInRangeOfPoint(playerid, 5.0, px, py, pz))
			return caixa;
	}
	return 0;
}

stock CreateCaixa(objectid, Float:x, Float:y, Float:z, Float:rotx, Float:roty, Float:rotz)
{
	if(caixaid >= MAX_CAIXAS)return 0;

    CaixaInfo[caixaid][Caixa_Object] = CreateDynamicObject(objectid, x, y, z, rotx, roty, rotz);
    CaixaInfo[caixaid][Caixa_Dinheiro] = 0;
    CaixaInfo[caixaid][Caixa_Roubada] = false;

   	new Float:pX, Float:pY, Float:pZ;

	GetDynamicObjectPos(CaixaInfo[caixaid][Caixa_Object], pX, pY, pZ);
	GetXYInFrontOfCaixa(CaixaInfo[caixaid][Caixa_Object], pX, pY, 1.0);
	CaixaInfo[caixaid][Caixa_Pickup] = CreatePickup(1274 , 1, pX,pY,pZ);
	CaixaInfo[caixaid][Caixa_Text] = Create3DTextLabel("{FFFFFF}Caixa Registradora\n{FFFFFF}Aperte '{FFFF00}F{FFFFFF}' para acessar", 0x33FFFF88, pX, pY, pZ, 15.0, 0);

    caixaid ++;
	return 0;
}

stock GranaRoubo(playerid, caixa_id)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(playerid, x, y, z);

	SetPVarFloat(playerid, "RouboX", x);
	SetPVarFloat(playerid, "RouboY", y);
	SetPVarFloat(playerid, "RouboZ", z);

	RoubandoCaixa[playerid] = true;
	ApplyAnimation(playerid,"ROB_BANK","CAT_Safe_Rob",4.1,1,0,0,0,0);

	SetTimerEx(#ApplyAnim, 500, 0, "i", playerid);
	SetTimerEx("PegarMoney", 10000, 0, "id", playerid, caixa_id);
	return 0;
}

stock ConvertTimeX(number)
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
		format(string, 100, "%02d", secs);
	}
	return string;
}

stock AdminCargo(playerid)
{
	new LipeStrondaAdmin[64];
	if(PlayerInfo[playerid][pAdmin] == 0) { LipeStrondaAdmin = "  "; }
	else if(PlayerInfo[playerid][pAdmin] == 1) { LipeStrondaAdmin = "Estagiario"; }
	else if(PlayerInfo[playerid][pAdmin] == 2) { LipeStrondaAdmin = "Administrador"; }
	else if(PlayerInfo[playerid][pAdmin] == 3) { LipeStrondaAdmin = "Administrador Geral"; }
	else if(PlayerInfo[playerid][pAdmin] == 4) { LipeStrondaAdmin = "Supervisor"; }
	else if(PlayerInfo[playerid][pAdmin] == 5) { LipeStrondaAdmin = "Diretor"; }
	else if(PlayerInfo[playerid][pAdmin] == 6) { LipeStrondaAdmin = "Fundador"; }
	else if(PlayerInfo[playerid][pAdmin] == 7) { LipeStrondaAdmin = "Desenvolvedor"; }
	return LipeStrondaAdmin;
}

stock Profs(playerid)
{
	new LipeStrondaProfs[64];
	if(PlayerInfo[playerid][pProfissao] == 0) { LipeStrondaProfs = "Desempregado"; }
	else if(PlayerInfo[playerid][pProfissao] == 1) { LipeStrondaProfs = "Pescador"; }
	else if(PlayerInfo[playerid][pProfissao] == 2) { LipeStrondaProfs = "Minerador"; }
	else if(PlayerInfo[playerid][pProfissao] == 3) { LipeStrondaProfs = "Acougueiro"; }
	else if(PlayerInfo[playerid][pProfissao] == 4) { LipeStrondaProfs = "Caminhoneiro"; }
	else if(PlayerInfo[playerid][pProfissao] == 5) { LipeStrondaProfs = "Cozinheiro"; }
	else if(PlayerInfo[playerid][pProfissao] == 6) { LipeStrondaProfs = "Coletor"; }
	else if(PlayerInfo[playerid][pProfissao] == 7) { LipeStrondaProfs = "Empacotador"; }
	else if(PlayerInfo[playerid][pProfissao] == 8) { LipeStrondaProfs = "Correios"; }
	return LipeStrondaProfs;
}

stock temlicenca(playerid)
{
	new LipeStrongLicenca[64];
	if(PlayerInfo[playerid][LicencaConduzir] == 0) { LipeStrongLicenca = "Sem Licenca"; }
	else if(PlayerInfo[playerid][LicencaConduzir] == 1) { LipeStrongLicenca = "Tem Licenca"; }
	return LipeStrongLicenca;
}
stock VIP(playerid)
{
	new LipeStrondaVIP[64];
	if(PlayerInfo[playerid][pVIP] != 0) { LipeStrondaVIP = " "; }
	if(PlayerInfo[playerid][pVIP] == 1) { LipeStrondaVIP = "VIP CLASSIC"; }
	else if(PlayerInfo[playerid][pVIP] == 2) { LipeStrondaVIP = "VIP ADVANCED"; }
	else if(PlayerInfo[playerid][pVIP] == 3) { LipeStrondaVIP = "VIP PREMIUM"; }
	return LipeStrondaVIP;
}

stock ConvertDays(dias) 
{ 

	new 
		valueday = 86400*dias, 
		daysconvert, 
		gtime = gettime() 
	; 

	#emit LOAD.S.PRI gtime 
	#emit LOAD.S.ALT valueday 
	#emit ADD 
	#emit STOR.S.PRI daysconvert 

	return daysconvert; 
} 

stock convertNumber(n) 
{ 
	new dia, hr, mn, seg, resto; 

	resto = n; 
	seg = resto % 60; 
	resto /= 60; 
	mn = resto % 60; 
	resto /= 60; 
	hr = resto % 24; 
	resto /= 24; 
	dia = resto; 

	new str[50]; 
	format(str, sizeof(str), "%ddias, %02dh %02dm %02ds", dia, hr, mn, seg); 
	return str; 
} 

stock CarregarVIP(playerid) 
{ 
	new string[80]; 
	format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
	if(DOF2_FileExists(string)) 
	{ 
		PlayerInfo[playerid][ExpiraVIP] = DOF2_GetInt(string,"VipExpira"); 
		if(gettime() > PlayerInfo[playerid][ExpiraVIP]) 
		{ 
			DOF2_RemoveFile(string); 
			PlayerInfo[playerid][ExpiraVIP] = 0; 
			PlayerInfo[playerid][pVIP] = 0;
			InfoMsg(playerid, "Seu beneficio expirou.");
		} 
		else 
		{ 
			format(string, sizeof(string), "Seu beneficio expira em %s.", convertNumber(PlayerInfo[playerid][ExpiraVIP]-gettime())); 
			InfoMsg(playerid, string);
			SetPlayerColor(playerid, 0xfcba03ff);
		} 
	} 
	return 1; 
} 
stock PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0);
}

stock randomEx(minnum = cellmin, maxnum = cellmax)
	return random(maxnum - minnum + 1) + minnum;// by Y_Less

stock NpcText()
{
	new Actor[30+1],Text3D:label[30+1];

	Actor[0] = CreateActor(227, 1689.325073, -2326.446777, 13.546875, 146.990203); 
	label[0] = Create3DTextLabel("{FFFFFF}Ola, eu sou o {FFFF00}Allison_Gomes!\n{FFFFFF}Use {FFFF00}/ajuda {FFFFFF}para \nconhecer os comandos.", 0x008080FF, 1689.325073, -2326.446777, 13.546875, 15.0, 0);
	Attach3DTextLabelToPlayer(label[0], Actor[0], 0.0, 0.0, 0.7);

	Actor[1] = CreateActor(35, 154.188613, -1945.949584, 4.972961, 352.308258);  
	label[1] = Create3DTextLabel("{FFFF00}Pescador\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o trampo.", 0x008080FF, 154.188613, -1945.949584, 4.972961, 15.0, 0);
	Attach3DTextLabelToPlayer(label[1], Actor[1], 0.0, 0.0, 0.7);
 
	CreateAurea("{FFFF00}Loja de Pescados\n{FFFFFF}Use o {FFFF00}Inventario{FFFFFF}' para vender.", 163.968444, -1941.403564, 3.773437);

	Actor[3] = CreateActor(34, 584.859375, 877.046569, -42.497318, 266.847808);  
	label[3] = Create3DTextLabel("{FFFF00}Empresa: {FFFFFF}Mineradora LathMor\n{00FF00}Vaga:{FFFFFF} Minerador\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 584.859375, 877.046569, -42.497318, 15.0, 0);
	Attach3DTextLabelToPlayer(label[3], Actor[3], 0.0, 0.0, 0.7);

	Actor[4] = CreateActor(133, 960.607055, 2097.604003, 1011.023010, 358.121734);  
	label[4] = Create3DTextLabel("{FFFF00}Empresa: {FFFFFF}FriBoi\n{00FF00}Vaga:{FFFFFF} Acougueiro\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 960.607055, 2097.604003, 1011.023010, 15.0, 0);
	Attach3DTextLabelToPlayer(label[4], Actor[4], 0.0, 0.0, 0.7);

	Actor[5] = CreateActor(78, -504.495117, -517.457763, 25.523437, 258.582305);  
	label[5] = Create3DTextLabel("{FFFF00}Empresa: {FFFFFF}FedeX\n{00FF00}Vaga:{FFFFFF}Caminhoneiro\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, -504.495117, -517.457763, 25.523437, 15.0, 0);
	Attach3DTextLabelToPlayer(label[5], Actor[5], 0.0, 0.0, 0.7);

	Actor[6] = CreateActor(79, -28.763319, 1363.971313, 9.171875, 37.998077);  
	label[6] = Create3DTextLabel("{FFFF00}Empresa: {FFFFFF}Prefeitura da Baixada\n{00FF00}Vaga:{FFFFFF} Coletor de Lixo\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, -28.763319, 1363.971313, 9.171875, 15.0, 0);
	Attach3DTextLabelToPlayer(label[6], Actor[6], 0.0, 0.0, 0.7);

	Actor[7] = CreateActor(188, 1682.130737, -2326.373291, 13.546875, 211.057678);  
	label[7] = Create3DTextLabel("{FFFFFF}Ola, eu sou o {FFFF00}Luan_Rosa!\n{FFFFFF}Aprenda como jogar no servidor \nUse '{FFFF00}F{FFFFFF}' para se informar", 0x008080FF, 1682.130737, -2326.373291, 13.546875, 15.0, 0);
	Attach3DTextLabelToPlayer(label[7], Actor[7], 0.0, 0.0, 0.7);

	Actor[8] = CreateActor(71, 939.6504,1733.2004,8.8516,-87.4139);  
	label[8] = Create3DTextLabel("{FFFF00}Empresa: {FFFFFF}SedeX\n{00FF00}Vaga:{FFFFFF} Correios\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 939.6504,1733.2004,8.8516, 15.0, 0);
	Attach3DTextLabelToPlayer(label[8], Actor[8], 0.0, 0.0, 0.7);

	CreateAurea("{FFFF00}Prefeitura\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", -501.146118, 294.354156, 2001.094970);
	CreateAurea("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1246.485839, -1651.083862, 17.028537);
	CreateAurea("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1246.481445, -1657.370727, 17.028537);
	CreateAurea("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1246.481811, -1662.939331, 17.028537);
	CreateAurea("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1246.484497, -1669.351562, 17.028537);
	CreateAurea("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1246.486816, -1675.575683, 17.028537);
	CreateAurea("{FFFF00}Cafeteria\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1317.508422, -1116.722290, 24.960447);
	CreateAurea("{FFFF00}Loja de Utilidades\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1649.4332,-1889.2966,13.5878);
	CreateAurea("{FFFF00}Loja de Utilidades\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 2064.6821,-1868.5961,13.5892);
	CreateAurea("{FFFF00}Loja de Utilidades\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 382.9478,-1909.8621,7.8625);
	CreateAurea("{FFFF00}Loja de Utilidades\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1325.4236,-867.3035,39.6159);
	CreateAurea("{FFFF00}Loja de Utilidades\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 1345.2196,-1763.8044,13.5702);

	CreateAurea("{FFFF00}Centro de Licenca\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 617.717346, -3.359961, 1000.990295);
	CreateAurea("{FFFF00}Loja Ilegal\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 514.712341, -2333.011474, 508.693756);

	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nprocessar a peca de carne.", 942.577758, 2117.902099, 1011.030273);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar uma embalagem.", 938.006469, 2144.264892, 1011.023437);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncolocar a carne na caixa.",942.416259, 2137.294921, 1011.023437);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nrevisar a caixa.", 942.421325, 2153.745849, 1011.023437);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar a caixa.", 942.288391, 2173.139404, 1011.023437);
	CreateAurea("Ponto de entrega.", 964.872192, 2159.816406, 1011.030273);
	
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir menu da mecanica.", -2064.961181, 1434.810058, 7.101562);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir menu da mecanica.", -2064.800048, 1426.759521, 7.101562);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir menu da mecanica.", -2064.942382, 1417.446289, 7.101562);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir menu da mecanica.", -2064.715820, 1408.081909, 7.101562);
	CreateAurea("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \nabrir menu da mecanica.", -2064.961425, 1399.184448, 7.101562);

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncarregar seu caminhao.", -1, -520.421813, -504.999450, 24.635631, 25.0); // Carregamento Caminhoneiro
	CreateDynamicPickup(1220, 23, -520.421813, -504.999450, 24.635631); //Carregamento Caminhoneiro
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncarregar seu caminhao.", -1, -529.748168, -504.937561, 24.640802, 25.0); // Carregamento Caminhoneiro
	CreateDynamicPickup(1220, 23, -529.748168, -504.937561, 24.640802); //Carregamento Caminhoneiro
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \ncarregar seu caminhao.", -1, -557.552368, -505.473480, 24.596021, 25.0); // Carregamento Caminhoneiro
	CreateDynamicPickup(1220, 23, -557.552368, -505.473480, 24.596021); //Carregamento Caminhoneiro

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}' para \npegar uma camera.", -1, -5467.627441, -4536.831054, 4046.774902, 25.0); // Camera
	CreateDynamicPickup(1275, 23, -5467.627441, -4536.831054, 4046.774902);//Camera

	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}/uniforme{FFFFFF}' para \npegar seu uniforme e bater ponto.", -1, 956.8282,1754.7942,8.6484, 25.0); // Uniforme correios
	CreateDynamicPickup(1275, 23, 956.8282,1754.7942,8.6484);//Uniforme correios

	CreateDynamic3DTextLabel("{FFFFFF}Garagem {FFFF00}SedeX\n{FFFFFF}Use '{FFFF00}/garagememp{FFFFFF}' para \npegar um veiculo da empresa.", -1, 981.7181,1733.6261,8.6484, 25.0); // garagem correios
	CreateDynamicPickup(19131, 23, 981.7181,1733.6261,8.6484);//garagem correios

	CreateDynamicPickup(19606,23,-1606.267578, 733.912414, -5.234413,0);
	CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}/prender{FFFFFF}'para \nprender o jogador.",-1,-1606.267578, 733.912414, -5.234413,15);

	CreateAurea("{FFFF00}Rota de Maconha\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", -1143.184814, 2227.874511, 97.219261);
	CreateAurea("{FFFF00}Rota de Cocaina\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", -248.257873, 1506.404418, 75.562500);

	CreateAurea("{FFFF00}Loja Utilidades 1\n{FFFFFF}Use '{FFFF00}H{FFFFFF}' para para iniciar o roubo.", 393.256561, -1895.308471, 7.844118);
	CreateAurea("{FFFF00}Loja Utilidades 2\n{FFFFFF}Use '{FFFF00}H{FFFFFF}' para para iniciar o roubo.", 1359.771850, -1774.149291, 13.551797);
	CreateAurea("{FFFF00}Loja Utilidades 3\n{FFFFFF}Use '{FFFF00}H{FFFFFF}' para para iniciar o roubo.", 1663.899047, -1899.635009, 13.569333);
	CreateAurea("{FFFF00}Loja Utilidades 4\n{FFFFFF}Use '{FFFF00}H{FFFFFF}' para para iniciar o roubo.", 2054.312255, -1883.058105, 13.570812);
	CreateAurea("{FFFF00}Loja Utilidades 5\n{FFFFFF}Use '{FFFF00}H{FFFFFF}' para para iniciar o roubo.", 1310.963256, -856.883911, 39.597454);
	CreateAurea("{FFFF00}Cafeteria\n{FFFFFF}Use '{FFFF00}H{FFFFFF}' para para iniciar o roubo.", 1316.121826, -1113.496704, 24.960447);
	printf("=> Textos       		: Carregados");
	return 1;
}

stock GetPlayerID(Nome[])
{
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i))
		{
			if(!strcmp(Name(i), Nome, true, 24)) return i;
		}
	}
	return -1;
}

stock BanirPlayer(playerid, administrador, Motivo1[])
{
	new File[255];
	new Data[24], Dia, Mes, Ano, Hora, Minuto;
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
	format(File, sizeof(File), PASTA_BANIDOS, Name(playerid));
	DOF2_CreateFile(File);
	DOF2_SetString(File, "Administrador", Name(administrador));
	DOF2_SetString(File, "Motivo", Motivo1);
	DOF2_SetString(File, "Data", Data);
	DOF2_SetString(File, "Desban", "Nunca");
	DOF2_SetInt(File, "DDesban", gettime() + 60 * 60 * 24 * 999);
	DOF2_SaveFile();
	foreach(Player, i)
	{
		format(Str, sizeof(Str), "O Administrador %s(%d) baniu o jogador %s(%d). Motivo: %s", Name(playerid),PlayerInfo[playerid][IDF], Name(administrador),PlayerInfo[administrador][IDF], Motivo1);
		WarningMsg(i, Str);
	}
	
	Log("Logs/Banir.ini", Str);
	Kick(playerid);
	return 1;
}

stock AgendarBan(playerid[], administrador, Motivo1[], Dias)
{
	new File[255];
	new Data[24], Dia, Mes, Ano, Hora, Minuto;
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
	format(File, sizeof(File), PASTA_BANIDOS, playerid);
	DOF2_CreateFile(File);
	DOF2_SetString(File, "Administrador", Name(administrador));
	DOF2_SetString(File, "Motivo", Motivo1);
	DOF2_SetString(File, "Data", Data);
	if(Dias == 999)
	{
		DOF2_SetString(File, "Desban", "Nunca");
		DOF2_SetInt(File, "DDesban", gettime() + 60 * 60 * 24 * 999); // 999 DIAS
	}
	else
	{
		getdate(Ano, Mes, Dia);
		Dia += Dias;
		if(Mes == 1 || Mes == 3 || Mes == 5 || Mes == 7 || Mes == 8 || Mes == 10 || Mes == 12)
		{
			if(Dia > 31)
			{
				Dia -= 31;
				Mes++;
				if(Mes > 12) Mes = 1;
			}
		}
		if(Mes == 4 || Mes == 6 || Mes == 9 || Mes == 11)
		{
			if(Dia > 30)
			{
				Dia -= 30;
				Mes++;
			}
		}
		if(Mes == 2)
		{
			if(Dia > 28)
			{
				Dia-=28;
				Mes++;
			}
		}
		gettime(Hora, Minuto);
		format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
		//
		DOF2_SetString(File, "Desban", Data);
		DOF2_SetInt(File, "DDesban", gettime() + 60 * 60 * 24 * Dias);
	}
	DOF2_SaveFile();
	return 1;
}

stock AgendarCadeia(playerid[], tempo, administrador, Motivo1[])
{
	new File[255];
	if(tempo < 0)
	{
		format(File, 56, PASTA_CONTAS, playerid);
		new TempoAtual = DOF2_GetInt(File, "pCadeia");
		if(tempo * -1 >= TempoAtual / 60)
		{
			DOF2_SetInt(File, "pCadeia", 0);
			DOF2_SaveFile();
			format(File, 56, PASTA_AGENDADOS, playerid);
			if(DOF2_FileExists(File)) DOF2_RemoveFile(File);
			return 0;
		}
		else
		{
			new tempo1 = tempo * -1 * 60;
			TempoAtual -= tempo1;
			DOF2_SetInt(File, "pCadeia", TempoAtual);
			DOF2_SaveFile();
			format(File, 56, PASTA_AGENDADOS, playerid);
			if(DOF2_FileExists(File)) DOF2_SetInt(File, "Tempo", DOF2_GetInt(File, "Tempo") - tempo * -1), DOF2_SaveFile();
			return 0;
		}
	}
	if(tempo > 0)
	{
		format(File, 56, PASTA_CONTAS, playerid);
		if(DOF2_GetInt(File, "pCadeia") > 0)
		{
			new Tempo9;
			Tempo9 = tempo * 60;
			DOF2_SetInt(File, "pCadeia", DOF2_GetInt(File, "pCadeia") + Tempo9);
			DOF2_SaveFile();
		}
		else
		{
			DOF2_SetInt(File, "pCadeia", tempo * 60);
			DOF2_SaveFile();
		}
		format(File, 56, PASTA_AGENDADOS, playerid);
		if(!DOF2_FileExists(File))
		{
			DOF2_CreateFile(File);
			DOF2_SetInt(File, "Tempo", tempo);
			DOF2_SetString(File, "Administrador", Name(administrador));
			DOF2_SetString(File, "Motivo", Motivo1);
			DOF2_SaveFile();
		}
		else
		{
			new ADM[24], Motivo2[56], Tempo1;
			format(ADM, 24, DOF2_GetString(File, "Administrador"));
			format(Motivo2, 56, DOF2_GetString(File, "Motivo"));
			Tempo1 = DOF2_GetInt(File, "Tempo");
			format(Str, sizeof(Str), "%s | %s", ADM, Name(administrador));
			DOF2_SetString(File, "Administrador", Str);
			format(Str, sizeof(Str), "%s | %s", Motivo2, Motivo1);
			DOF2_SetString(File, "Motivo", Str);
			DOF2_SetInt(File, "Tempo", tempo + Tempo1);
			DOF2_SaveFile();
		}
	}
	return 1;
}

stock BanirIP(playerid, administrador, Motivo1[])
{
	new File[255];
	new Data[24], Dia, Mes, Ano, Hora, Minuto;
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
	format(File, sizeof(File), PASTA_BANIDOSIP, GetPlayerIpEx(playerid));
	DOF2_CreateFile(File);
	DOF2_SetString(File, "Administrador", Name(administrador));
	DOF2_SetString(File, "Motivo", Motivo1);
	DOF2_SetString(File, "Data", Data);
	DOF2_SaveFile();
	foreach(Player, i)
	{
		format(Str, sizeof(Str), "O Administrador %s(%d) baniu o jogador %s(%d). Motivo: %s", Name(playerid),PlayerInfo[playerid][IDF], Name(administrador),PlayerInfo[administrador][IDF], Motivo1);
		WarningMsg(i, Str);
	}
	
	Log("Logs/BanirIP.ini", Str);
	Kick(playerid);
	return 1;
}

stock ZerarDados(playerid)
{
	RotaMaconha[playerid] = false;
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pDinheiro] = 0;
	PlayerInfo[playerid][pBanco] = 0;
	PlayerInfo[playerid][pIdade] = 0;
	PlayerInfo[playerid][pSegundosJogados] = 0;
	PlayerInfo[playerid][pAvisos] = 0;
	PlayerInfo[playerid][pRG] = 0;
	PlayerInfo[playerid][pNome] = 0;
	PlayerInfo[playerid][pNascimento] = 0;
	PlayerInfo[playerid][pPai] = 0;
	PlayerInfo[playerid][pMae] = 0;
	PlayerInfo[playerid][pCadeia] = 0;
	PlayerInfo[playerid][pAdmin] = 0;
	PlayerInfo[playerid][pInterior] = 0;
	PlayerInfo[playerid][pPosX] = 0;
	PlayerInfo[playerid][pPosY] = 0;
	PlayerInfo[playerid][pPosZ] = 0;
	PlayerInfo[playerid][pPosA] = 0;
	PlayerInfo[playerid][pCamX] = 0;
	PlayerInfo[playerid][pCamY] = 0;
	PlayerInfo[playerid][pCamZ] = 0;
	PlayerInfo[playerid][pCongelado] = false;
	PlayerInfo[playerid][pCalado] = false;
	PlayerInfo[playerid][pVIP] = 0;
	PlayerInfo[playerid][ExpiraVIP] = 0;
	PlayerInfo[playerid][vKey] = 0;
	PlayerInfo[playerid][vCoins] = 0;
	PlayerInfo[playerid][pProfissao] = 0;
	PlayerInfo[playerid][Org] = 0;
	PlayerInfo[playerid][Cargo] = 0;
	PlayerInfo[playerid][convite] = 0;
	PlayerInfo[playerid][pProcurado] = 0;
	PlayerInfo[playerid][pMultas] = 0;
	PlayerInfo[playerid][Casa] = 0;
	PlayerInfo[playerid][Entrada] = 0;
	PlayerInfo[playerid][pAvaliacao] = 0;

	ModoTransacao[playerid] = 0;
	TiempoAnuncio[playerid] = 0;
	LavouMao[playerid] = false;
	PegouVehProf[playerid] = false;
	CaixaMao[playerid] = false;
	CaixasSdx[playerid] = 0;
	carID[playerid] = 0;
	EtapasMinerador[playerid] = 0;
	TemMinerio[playerid] = 0;
	Desossando[playerid] = 0;
	BigEar[playerid] = 0;
	VehAlugado[playerid] = 0;
	Localizando[playerid] = 0;
	Carregou[playerid] = 0;
	MotorOn[playerid] = 0;
	InventarioAberto[playerid] = 0;
	EquipouCasco[playerid] = 0;
	CargoTumba[playerid] = 0;
	cova[playerid] = 0;
	ocupadodemais[playerid] = 0;
	GPS[playerid] = false;
	RefuelTime[playerid] = 0;
	TrackCar[playerid] = 0;
	FrequenciaConectada[playerid] = 0;
	UltimaFala[playerid] = 0;
	FomePlayer[playerid] = 0;
	SedePlayer[playerid] = 0;
	PassouRadar[playerid] = 0;
	Page[playerid] = 0;
	TemCinto[playerid] = false;
	Susurrando[playerid] = false;
	Falando[playerid] = false;
	Gritando[playerid] = false;
	MostrandoMenu[playerid] = false;
	Falou[playerid] = false;
	Susurrou[playerid] = false;
	Gritou[playerid] = false;
	PlantandoMaconha[playerid] = false;
	RoubandoCaixa[playerid] = false;
	Moved[playerid] = false;
	FirstLogin[playerid] = false;
	pJogando[playerid] = false;
	pLogado[playerid] = false;
	IsAssistindo[playerid] = false;
	UsouCMD[playerid] = false;
	Patrulha[playerid] = false;
	PegouMaterial[playerid] = false;
	TimerFomebar[playerid] = 0;
	TimerSedebar[playerid] = 0;
	TimerColete[playerid] = 0;
	TimerUpdate[playerid] = 0;
	TimerPBugar[playerid] = 0;
	TimerPayDay[playerid] = 0;
	TimerAttVeh[playerid] = 0;
	TimerLocalizar[playerid] = 0;
	TimerTesteAerea[playerid] = 0;
	TimerTesteCaminhao[playerid] = 0;
	TimerTesteVeiculo[playerid] = 0;
	TimerTesteMoto[playerid] = 0;
	TimerHacker[playerid] = 0;
	Assistindo[playerid] = -1;
	Erro[playerid] = 0;
	Cargase[playerid] = false;
	MostrandoRG[playerid] = false;
	Carregou[playerid] = 0;
	ocupadodemais[playerid] = 0;
	RepairCar[playerid] = 0;
	CarregandoTelaLogin[playerid] = 0;
	TimerLogin[playerid] = 0;
	CheckpointPontosMoto[playerid] = 0;
	CheckpointPontosVeiculo[playerid] = 0;
	CheckpointPontosCaminhao[playerid] = 0;
	IniciouTesteHabilitacaoA[playerid] = 0;
	AutoEscolaMoto[playerid] = 0;
	IniciouTesteHabilitacaoB[playerid] = 0;
	AutoEscolaVeiculo[playerid] = 0;
	IniciouTesteHabilitacaoC[playerid] = 0;
	AutoEscolaCaminhao[playerid] = 0;
	IniciouTesteHabilitacaoD[playerid] = 0;
	RotaHabilitacaoMoto[playerid] = 0;
	RotaHabilitacaoVeiculo[playerid] = 0;
	RotaHabilitacaoCaminhao[playerid] = 0;
	RotaHabilitacaoAerea[playerid] = 0;	
	CheckpointPontosAerea[playerid] = 0;	
	AutoEscolaAerea[playerid] = 0;	
	VeiculoCivil[playerid] = 0;
	Covaconcerto[playerid] = false;
	Podecmd[playerid] = true;
	ltumba[playerid] = false;
	EmServico[playerid] = false;
	PegandoCaixas[playerid] = false;
	RecentlyShot[playerid] = 0;
	InventarioAberto[playerid] = 0;
	SetPlayerColor(playerid, 0xFFFFFFFF);
	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,200);
    SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,200);
	for(new i=0;i<6;i++){
		Preview[playerid][i] = 0;
	}
	EntregaSdx[playerid] = false;
	return 1;
}

stock SalvarDados(playerid)
{
	new File[255];
	new Data[24], Email[25], Dia, Mes, Ano, Hora, Minuto, Float:A, Float:X, Float:Y, Float:Z;
	GetPlayerCameraPos(playerid, X, Y, Z);
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, A);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
	format(Email, 24, "%s", PlayerInfo[playerid][pEmail]);

	format(File, sizeof(File), PASTA_CONTAS, Name(playerid));
	if(DOF2_FileExists(File))
	{
		DOF2_SaveFile();
		DOF2_SetInt(File, "IDF", PlayerInfo[playerid][IDF]);
		DOF2_SetString(File,"pEmail", Email);
		DOF2_SetInt(File, "pDinheiro", PlayerInfo[playerid][pDinheiro]);
		DOF2_SetInt(File,"pSexo", PlayerInfo[playerid][pSexo]);
		DOF2_SetInt(File, "pBanco", PlayerInfo[playerid][pBanco]);
		DOF2_SetInt(File, "pIdade", PlayerInfo[playerid][pIdade]);
		DOF2_SetInt(File, "pSegundosJogados", PlayerInfo[playerid][pSegundosJogados]);
		DOF2_SetInt(File, "pAvisos", PlayerInfo[playerid][pAvisos]);
		DOF2_SetInt(File, "pCadeia", PlayerInfo[playerid][pCadeia]);
		DOF2_SetInt(File, "pAdmin", PlayerInfo[playerid][pAdmin]);
		DOF2_SetString(File, "pLastLogin", Data);
		DOF2_SetInt(File, "pInterior", GetPlayerInterior(playerid));
		DOF2_SetFloat(File, "pPosX", Pos[0]);
		DOF2_SetFloat(File, "pPosY", Pos[1]);
		DOF2_SetFloat(File, "pPosZ", Pos[2]);
		DOF2_SetFloat(File, "pPosA", A);
		DOF2_SetFloat(File, "pCamX", X);
		DOF2_SetFloat(File, "pCamY", Y);
		DOF2_SetFloat(File, "pCamZ", Z);
		DOF2_SetBool(File, "pCongelado", PlayerInfo[playerid][pCongelado]);
		DOF2_SetBool(File, "pCalado", PlayerInfo[playerid][pCalado]);
		DOF2_SetInt(File, "pFome", FomePlayer[playerid]);
		DOF2_SetInt(File, "pSede", SedePlayer[playerid]);
		DOF2_SetInt(File, "pVIP", PlayerInfo[playerid][pVIP]);
		DOF2_SetInt(File, "pCoins", PlayerInfo[playerid][pCoins]);
		DOF2_SetInt(File, "pProfissao", PlayerInfo[playerid][pProfissao]);
		DOF2_SetInt(File, "pOrg", PlayerInfo[playerid][Org]);
		DOF2_SetInt(File, "pCargo", PlayerInfo[playerid][Cargo]);
		DOF2_SetInt(File, "pProcurado", GetPlayerWantedLevel(playerid));
		DOF2_SetInt(File, "pMultas", PlayerInfo[playerid][pMultas]);
		DOF2_SetInt(File, "pCasa", PlayerInfo[playerid][Casa]);
		DOF2_SetInt(File, "pLevel", GetPlayerScore(playerid));
		DOF2_SetInt(File, "pXP", PlayerInfo[playerid][pXP]);
		DOF2_SetInt(File, "LicencaConduzir", PlayerInfo[playerid][LicencaConduzir]);
		DOF2_SetString(File, "pNome", PlayerInfo[playerid][pNome]);
		DOF2_SetString(File, "pNascimento", PlayerInfo[playerid][pNascimento]);
		DOF2_SetString(File, "pPai", PlayerInfo[playerid][pPai]);
		DOF2_SetString(File, "pMae", PlayerInfo[playerid][pMae]);
		DOF2_SetInt(File, "pRG", PlayerInfo[playerid][pRG]);
		DOF2_SetInt(File, "pCarteiraT", PlayerInfo[playerid][pCarteiraT]);
		DOF2_SetInt(File, "Pecas", PlayerInfo[playerid][PecasArma]);
		DOF2_SaveFile();
	}
	return 1;
}

stock SalvarDadosSkin(playerid)
{
	new File[255];
	new Data[24], Email[25], Dia, Mes, Ano, Hora, Minuto, Float:A, Float:X, Float:Y, Float:Z;
	GetPlayerCameraPos(playerid, X, Y, Z);
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, A);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
	format(Email, 24, "%s", PlayerInfo[playerid][pEmail]);

	format(File, sizeof(File), PASTA_CONTAS, Name(playerid));
	if(DOF2_FileExists(File))
	{
		DOF2_SaveFile();
		DOF2_SetInt(File, "IDF", PlayerInfo[playerid][IDF]);
		DOF2_SetString(File,"pEmail", Email);
		DOF2_SetInt(File, "pSkin", GetPlayerSkin(playerid));
		DOF2_SetInt(File, "pDinheiro", PlayerInfo[playerid][pDinheiro]);
		DOF2_SetInt(File,"pSexo", PlayerInfo[playerid][pSexo]);
		DOF2_SetInt(File, "pBanco", PlayerInfo[playerid][pBanco]);
		DOF2_SetInt(File, "pIdade", PlayerInfo[playerid][pIdade]);
		DOF2_SetInt(File, "pSegundosJogados", PlayerInfo[playerid][pSegundosJogados]);
		DOF2_SetInt(File, "pAvisos", PlayerInfo[playerid][pAvisos]);
		DOF2_SetInt(File, "pCadeia", PlayerInfo[playerid][pCadeia]);
		DOF2_SetInt(File, "pAdmin", PlayerInfo[playerid][pAdmin]);
		DOF2_SetString(File, "pLastLogin", Data);
		DOF2_SetInt(File, "pInterior", GetPlayerInterior(playerid));
		DOF2_SetFloat(File, "pPosX", Pos[0]);
		DOF2_SetFloat(File, "pPosY", Pos[1]);
		DOF2_SetFloat(File, "pPosZ", Pos[2]);
		DOF2_SetFloat(File, "pPosA", A);
		DOF2_SetFloat(File, "pCamX", X);
		DOF2_SetFloat(File, "pCamY", Y);
		DOF2_SetFloat(File, "pCamZ", Z);
		DOF2_SetBool(File, "pCongelado", PlayerInfo[playerid][pCongelado]);
		DOF2_SetBool(File, "pCalado", PlayerInfo[playerid][pCalado]);
		DOF2_SetInt(File, "pFome", FomePlayer[playerid]);
		DOF2_SetInt(File, "pSede", SedePlayer[playerid]);
		DOF2_SetInt(File, "pVIP", PlayerInfo[playerid][pVIP]);
		DOF2_SetInt(File, "pCoins", PlayerInfo[playerid][pCoins]);
		DOF2_SetInt(File, "pProfissao", PlayerInfo[playerid][pProfissao]);
		DOF2_SetInt(File, "pOrg", PlayerInfo[playerid][Org]);
		DOF2_SetInt(File, "pCargo", PlayerInfo[playerid][Cargo]);
		DOF2_SetInt(File, "pProcurado", GetPlayerWantedLevel(playerid));
		DOF2_SetInt(File, "pMultas", PlayerInfo[playerid][pMultas]);
		DOF2_SetInt(File, "pCasa", PlayerInfo[playerid][Casa]);
		DOF2_SetInt(File, "pLevel", GetPlayerScore(playerid));
		DOF2_SetInt(File, "pXP", PlayerInfo[playerid][pXP]);
		DOF2_SetInt(File, "LicencaConduzir", PlayerInfo[playerid][LicencaConduzir]);
		DOF2_SetString(File, "pNome", PlayerInfo[playerid][pNome]);
		DOF2_SetString(File, "pNascimento", PlayerInfo[playerid][pNascimento]);
		DOF2_SetString(File, "pPai", PlayerInfo[playerid][pPai]);
		DOF2_SetString(File, "pMae", PlayerInfo[playerid][pMae]);
		DOF2_SetInt(File, "pRG", PlayerInfo[playerid][pRG]);
		DOF2_SetInt(File, "pCarteiraT", PlayerInfo[playerid][pCarteiraT]);
		DOF2_SetInt(File, "Pecas", PlayerInfo[playerid][PecasArma]);
		DOF2_SaveFile();
	}
	return 1;
}

stock SalvarMissoes(playerid)
{
	new File[50];
	format(File, sizeof(File), PASTA_MISSOES, Name(playerid));
	if(!DOF2_FileExists(File)) DOF2_CreateFile(File);
	//
	DOF2_SetInt(File, "Missao1", MissaoPlayer[playerid][MISSAO1]);
	DOF2_SetInt(File, "Missao2", MissaoPlayer[playerid][MISSAO2]);
	DOF2_SetInt(File, "Missao3", MissaoPlayer[playerid][MISSAO3]);
	DOF2_SetInt(File, "Missao4", MissaoPlayer[playerid][MISSAO4]);
	DOF2_SetInt(File, "Missao5", MissaoPlayer[playerid][MISSAO5]);
	DOF2_SetInt(File, "Missao6", MissaoPlayer[playerid][MISSAO6]);
	DOF2_SetInt(File, "Missao7", MissaoPlayer[playerid][MISSAO7]);
	DOF2_SetInt(File, "Missao8", MissaoPlayer[playerid][MISSAO8]);
	DOF2_SetInt(File, "Missao9", MissaoPlayer[playerid][MISSAO9]);
	DOF2_SetInt(File, "Missao10", MissaoPlayer[playerid][MISSAO10]);
	DOF2_SetInt(File, "Missao11", MissaoPlayer[playerid][MISSAO11]);
	DOF2_SetInt(File, "Missao12", MissaoPlayer[playerid][MISSAO12]);
	DOF2_SetInt(File, "Missao13", MissaoPlayer[playerid][MISSAO13]);

	DOF2_SetInt(File, "CMissao1", MissaoPlayer[playerid][CMISSAO1]);
	DOF2_SetInt(File, "CMissao2", MissaoPlayer[playerid][CMISSAO2]);
	DOF2_SetInt(File, "CMissao3", MissaoPlayer[playerid][CMISSAO3]);
	DOF2_SetInt(File, "CMissao4", MissaoPlayer[playerid][CMISSAO4]);
	DOF2_SetInt(File, "CMissao5", MissaoPlayer[playerid][CMISSAO5]);
	DOF2_SetInt(File, "CMissao6", MissaoPlayer[playerid][CMISSAO6]);
	DOF2_SetInt(File, "CMissao7", MissaoPlayer[playerid][CMISSAO7]);
	DOF2_SetInt(File, "CMissao8", MissaoPlayer[playerid][CMISSAO8]);
	DOF2_SetInt(File, "CMissao9", MissaoPlayer[playerid][CMISSAO9]);
	DOF2_SetInt(File, "CMissao10", MissaoPlayer[playerid][CMISSAO10]);
	DOF2_SetInt(File, "CMissao11", MissaoPlayer[playerid][CMISSAO11]);
	DOF2_SetInt(File, "CMissao12", MissaoPlayer[playerid][CMISSAO10]);
	DOF2_SetInt(File, "CMissao13", MissaoPlayer[playerid][CMISSAO11]);
	DOF2_SaveFile();
	return 1;
}

stock CarregarMissoes(playerid)
{
	new File[50];
	format(File, sizeof(File), PASTA_MISSOES, Name(playerid));
	if(DOF2_FileExists(File))
	//
	MissaoPlayer[playerid][MISSAO1] = DOF2_GetInt(File, "Missao1");
	MissaoPlayer[playerid][MISSAO2] = DOF2_GetInt(File, "Missao2");
	MissaoPlayer[playerid][MISSAO3] = DOF2_GetInt(File, "Missao3");
	MissaoPlayer[playerid][MISSAO4] = DOF2_GetInt(File, "Missao4");
	MissaoPlayer[playerid][MISSAO5] = DOF2_GetInt(File, "Missao5");
	MissaoPlayer[playerid][MISSAO6] = DOF2_GetInt(File, "Missao6");
	MissaoPlayer[playerid][MISSAO7] = DOF2_GetInt(File, "Missao7");
	MissaoPlayer[playerid][MISSAO8] = DOF2_GetInt(File, "Missao8");
	MissaoPlayer[playerid][MISSAO9] = DOF2_GetInt(File, "Missao9");
	MissaoPlayer[playerid][MISSAO10] = DOF2_GetInt(File, "Missao10");
	MissaoPlayer[playerid][MISSAO11] = DOF2_GetInt(File, "Missao11");
	MissaoPlayer[playerid][MISSAO12] = DOF2_GetInt(File, "Missao12");
	MissaoPlayer[playerid][MISSAO13] = DOF2_GetInt(File, "Missao13");

	MissaoPlayer[playerid][CMISSAO1] = DOF2_GetInt(File, "CMissao1");
	MissaoPlayer[playerid][CMISSAO2] = DOF2_GetInt(File, "CMissao2");
	MissaoPlayer[playerid][CMISSAO3] = DOF2_GetInt(File, "CMissao3");
	MissaoPlayer[playerid][CMISSAO4] = DOF2_GetInt(File, "CMissao4");
	MissaoPlayer[playerid][CMISSAO5] = DOF2_GetInt(File, "CMissao5");
	MissaoPlayer[playerid][CMISSAO6] = DOF2_GetInt(File, "CMissao6");
	MissaoPlayer[playerid][CMISSAO7] = DOF2_GetInt(File, "CMissao7");
	MissaoPlayer[playerid][CMISSAO8] = DOF2_GetInt(File, "CMissao8");
	MissaoPlayer[playerid][CMISSAO9] = DOF2_GetInt(File, "CMissao9");
	MissaoPlayer[playerid][CMISSAO10] = DOF2_GetInt(File, "CMissao10");
	MissaoPlayer[playerid][CMISSAO11] = DOF2_GetInt(File, "CMissao11");
	MissaoPlayer[playerid][CMISSAO12] = DOF2_GetInt(File, "CMissao12");
	MissaoPlayer[playerid][CMISSAO13] = DOF2_GetInt(File, "CMissao13");
	return 1;
}

stock SalvarAvaliacao(playerid)
{
	new File[50];
	if(PlayerInfo[playerid][pAdmin] > 0)
	{
		format(File, sizeof(File), PASTA_AVALIACAO, Name(playerid));
		if(!DOF2_FileExists(File)) DOF2_CreateFile(File);
		//
		DOF2_SetInt(File, "Avaliacao", PlayerInfo[playerid][pAvaliacao]);
		DOF2_SaveFile();
	}
	return 1;
}

stock CarregarAvaliacao(playerid)
{
	new File[50];
	if(PlayerInfo[playerid][pAdmin] > 0)
	{
		format(File, sizeof(File), PASTA_AVALIACAO, Name(playerid));
		if(DOF2_FileExists(File))
		//
		PlayerInfo[playerid][pAvaliacao] = DOF2_GetInt(File, "Avaliacao");
	}
	return 1;
}

stock GetPlayerIpEx(playerid)
{
	new pIP[36];
	GetPlayerIp(playerid, pIP, 36);
	return pIP;
}

stock Log(Account[], string[])
{
	if(!DOF2_FileExists(Account))
	{
		DOF2_CreateFile(Account);
	}
	new dia, mes, ano, hora, minuto, segundo, Data[24];
	gettime(hora, minuto, segundo);
	getdate(ano, mes, dia);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d:%02d", dia, mes, ano, hora, minuto, segundo);
	DOF2_SetString(Account, Data, string);
	DOF2_SaveFile();
}

stock DeletarLog(const File1[])
{
	if(!fexist(File1))
	{
		printf(" Este arquivo nao existe, use Log(\"Account\"");
		return 0;
	}
	fremove(File1);
	return 1;
}

stock SendAdminMessage(Cor, Mensagem[])
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pAdmin] > 0)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
	}
	return 1;
}

stock SendRadioMessage(Cor, Mensagem[])
{
	foreach(new i: Player)
	{
		if(IsPolicial(i))
		{
			SendClientMessage(i, Cor, Mensagem);
		}
	}
	return 1;
}

stock SendGangMessage(Cor, Mensagem[])
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][Org] == 5)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
		if(PlayerInfo[i][Org] == 6)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
		if(PlayerInfo[i][Org] == 7)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
		if(PlayerInfo[i][Org] == 8)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
		if(PlayerInfo[i][Org] == 12)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
		if(PlayerInfo[i][Org] == 13)
		{
			SendClientMessage(i, Cor, Mensagem);
		}
	}
	return 1;
}
stock SetPlayerMoney(ID1, Quantia)
{
	ResetPlayerMoney(ID1);
	PlayerInfo[ID1][pDinheiro] = Quantia; 
	return 1;
}

stock GetVehicleDriver(vehicleid)
{
  foreach(new i: Player)
  {
	if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 2) return i;
  }
  return -1;
}

stock GetVehiclePassenger(vehicleid)
{
  foreach(new i: Player)
  {
	if(IsPlayerInVehicle(i, vehicleid) && GetPlayerState(i) == 3) return i;
  }
  return -1;
}

stock Name(playerid)
{
	new pNameVar[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pNameVar, 24);
	return pNameVar;
}
stock VelocidadeDoVeiculo(vehicleid)
{
	new Float:xPos[3];
	GetVehicleVelocity(vehicleid, xPos[0], xPos[1], xPos[2]);
	return floatround(floatsqroot(xPos[0] * xPos[0] + xPos[1] * xPos[1] + xPos[2] * xPos[2]) * 170.00);
}

stock MaconhaPronta(playerid)
{
	new pronta = 0;
	for(new maconhaid = 0; maconhaid < MAX_MACONHA; maconhaid ++)
	{
		if(MaconhaInfo[maconhaid][PodeUsar] == false && MaconhaInfo[maconhaid][Crescida] >= Max_Crescida)
		{
			if(strcmp(MaconhaInfo[maconhaid][Dono], Name(playerid), true) == 0)
			{
				pronta++;
			}
		}
	}
	if(pronta > 0){
		new string[128];
		if(pronta == 1)format(string, sizeof string, "%d suas plantacoes podem ser colhidas, Use /cmaconha",pronta);
		else format(string, sizeof string, "Pode colher %d plantacoes, Use /maconhas",pronta);
		return InfoMsg(playerid, string);
	}
	return true;
}

stock CheckSlot()
{
	for(new slot = 0; slot < MAX_MACONHA; slot++)
	{
		if(MaconhaInfo[slot][PodeUsar] == true)
		{
			MaconhaInfo[slot][PodeUsar] = false;
			return slot;
		}
	}
	return -1;
}

stock CountPlantacao(playerid)
{
	new count = 0;

	for(new maconhaid=0;maconhaid < MAX_MACONHA;maconhaid++)
	{
		if(MaconhaInfo[maconhaid][PodeUsar] == false && strcmp(MaconhaInfo[maconhaid][Dono], Name(playerid), true)==0)
		{
			count++;
		}
	}

	return count;
}
stock PertoMaconha(playerid)
{
	new count = 0;

	for(new mac = 0; mac < MAX_MACONHA; mac++)
	{
		if(!MaconhaInfo[mac][PodeUsar] && IsPlayerInRangeOfPoint(playerid, 200.0, MaconhaInfo[mac][mX],MaconhaInfo[mac][mY],MaconhaInfo[mac][mZ]))
		{
			count++;
		}
	}

	return count;
}

stock GetXYInFrontOfCaixa(objectid, &Float:q, &Float:w, Float:distance)
{
	new Float:a, Float:rotx, Float:roty;
	GetDynamicObjectPos(objectid, q, w, a);

	GetDynamicObjectRot(objectid, rotx, roty, a);

	q -= (distance * floatsin(-a, degrees));
	w -= (distance * floatcos(-a, degrees));
	return 1;
}
#include 		"../modulos/mapserver.inc" 
#include 		"../modulos/mapicons.inc" 
#include 		"../modulos/caixas.inc"
#include 		"../modulos/txdglobal.inc"

public OnGameModeInit()
{
	SetGameModeText(VERSAOSERVER);
    SendRconCommand("language Portugues Brasil");
	SendRconCommand("ackslimit 5000");
 	SendRconCommand("connseedtime 3000");
 	SendRconCommand("minconnectiontime 1000");
 	SendRconCommand(SERVERFORUM);
 	//SendRconCommand("password 123654");
	SendRconCommand("rcon 0");
	SendRconCommand("stream_distance 500.0");
	SendRconCommand("stream_rate 1000");
	print("=======================================================================");
	print("= Carregando: Baixada Roleplay v1.0");
	print("=======================================================================");
	printf(" ");
	AntiDeAMX();
	DisableCrashDetectLongCall();
	NpcText();
	ORGCarrega();
	CarregarMapIcons();
	CarregarCaixas();
	CarregarTxdGlobal();
	LoadVehicles();
	LoadDealerships();
	LoadFuelStations();
	CarregarMapas(); 
	CriarCasas();
	CriarRadares();
	LoadCofreOrg();
	CarregarGZ2();
	CarregarPlantacao();	
	CarregarDinRoubos();
	CreateTelaLogin();
	TextDrawBase();
	Chat = DCC_FindChannelById("1145712079861452850");
	Dinn = DCC_FindChannelById("1145712172794642442");
	EntradaeSaida = DCC_FindChannelById("1145712303124254743");
	Reports = DCC_FindChannelById("1145712239614107760");
	AtivarCoins = DCC_FindChannelById("1149056591711174797");
	ChatAdm = DCC_FindChannelById("1145558205775233044");
	VIPAtivado = DCC_FindChannelById("1149056733105369242");
	Sets = DCC_FindChannelById("1145712207049527407");
	IDNAME = DCC_FindChannelById("1156091090605195317");
	MAILLOG = DCC_FindChannelById("1156093705304932362");
	Punicoes = DCC_FindChannelById("1158781620250226799");
	ComandosIG = DCC_FindChannelById("1150771820069408829");
	printf("=> Canais DC       		: Carregados");
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
    printf(" ");
	new Dia, Mes, Ano, Hora, Minuto;
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
    printf("=======================================================================");
	printf("Servidor Ligado: [%02d/%02d/%d %02d:%02d]", Dia, Mes, Ano, Hora, Minuto);
    printf("=======================================================================");	
	// CONFI

	ShowPlayerMarkers(0);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	UsePlayerPedAnims();
	ShowNameTags(0);
	SetNameTagDrawDistance(30.0);
	AllowInteriorWeapons(1);
	ManualVehicleEngineAndLights();
	
	gServerTextdraws = TextDrawCreate(576.998962, 16.244453, "16:04");
	TextDrawLetterSize(gServerTextdraws, 0.363750, 1.496297);
	TextDrawTextSize(gServerTextdraws, 1280.000000, 1280.000000);
	TextDrawAlignment(gServerTextdraws, 2);
	TextDrawColor(gServerTextdraws, 0xFFFFFFFF);
	TextDrawUseBox(gServerTextdraws, 0);
	TextDrawBoxColor(gServerTextdraws, 0x80808080);
	TextDrawSetShadow(gServerTextdraws, 0);
	TextDrawSetOutline(gServerTextdraws, 1);
	TextDrawBackgroundColor(gServerTextdraws, 0x00000020);
	TextDrawFont(gServerTextdraws, 3);
	TextDrawSetProportional(gServerTextdraws, 1);
	TextDrawSetSelectable(gServerTextdraws, 0);

	Parabolica = GangZoneCreate( -460.22906494140625, 1281.9999694824219, -140.22906494140625, 1643.9999694824219);
    Barragem = GangZoneCreate( -1434.2429809570312, 1902.6701049804688, -987.2429809570312, 2672.6701049804688);

	for(new j; j < MAX_ORGS; j++)
	{
	    CarregarCofre(j);
	}
	gstream = SvCreateGStream(0xFF0000FF, "[]");
	for(new i = 0; i < MAX_FREQUENCIAS; i++)
	{
		Frequencia[i] = SvCreateGStream(0xFF5800FF, "Radio");
	}
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		UpdateVehicle(i, 0);
	}
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		UpdateDealership(i, 0);
	}
	for(new i=1; i < MAX_FUEL_STATIONS; i++)
	{
		UpdateFuelStation(i, 0);
	}
	for(new slot = 0; slot < MAX_MACONHA; slot++)MaconhaInfo[slot][PodeUsar] = true;
	for(new i; i < 9; i++)
	{
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}H{FFFFFF}'para \npegar um veiculo.", -1, PosVeiculos[i][0], PosVeiculos[i][1], PosVeiculos[i][2], 10.0);
		CreateDynamicPickup(1083, 23, PosVeiculos[i][0], PosVeiculos[i][1], PosVeiculos[i][2]); // Veh Spawn
	}
	for(new i; i < 4; i++)
	{
		CreateDynamicPickup(1275, 23, PosEquipar[i][0], PosEquipar[i][1], PosEquipar[i][2]);
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \npegar os equipamentos.",-1,PosEquipar[i][0], PosEquipar[i][1], PosEquipar[i][2],15);
	}
	for(new i; i < 6; i++)
	{
		CreateDynamicPickup(1314, 23, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]);
		//CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \nabrir o menu da organizacao.",-1,PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2],15);
	}
	for(new i; i < 13; i++)
	{
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para\ncomecar a pescar.", -1, PosPesca[i][0], PosPesca[i][1], PosPesca[i][2], 15.0);
	}
	for(new i; i < 8; i++)
	{
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}F{FFFFFF}'para \niniciar o desossamento.", -1, PosDesossa[i][0], PosDesossa[i][1], PosDesossa[i][2], 15.0);
	}
	for(new i; i < 5; i++)
	{
		CreateDynamicPickup(19606,23,Entradas[i][0],Entradas[i][1],Entradas[i][2],0);
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}Y{FFFFFF}'para \nentrar no interior.",-1,Entradas[i][0],Entradas[i][1],Entradas[i][2],15);
	}
	for(new i; i > CountDynamicObjects(); i++)
	{
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT , i, E_STREAMER_STREAM_DISTANCE, 500.0);
		Streamer_SetFloatData(STREAMER_TYPE_OBJECT , i, E_STREAMER_DRAW_DISTANCE, 350.0);
	} 

	TimerRelogio = SetTimer("Relogio",1000,true);
	TimerCadeia = SetTimer("CheckCadeia", 2000, true);
	TimerAfk = SetTimer("AntiAway", minutos(10), true);
	TimerMaconha = SetTimer("UpdateDrogas", minutos(15), true);
	TimerMensagemAuto = SetTimer("SendMSG", minutos(10), true);
	TimerMensagemAutoBot = SetTimer("SendMSGBot", segundos(10), true);
	maintimer = SetTimer("MainTimer", 1000, true);
	savetimer = SetTimer("SaveTimer", 2222, true);
	SetTimer("TimerAn", 1000, true);
	return 1;
}

public OnGameModeExit()
{
	SalvarPlantacao();
	SalvarDinRoubos();
	SalvarGZ();
	IniciarCasas = 0;
	IniciarRadares = 0;
	foreach(Player, i)
	{
		if(pLogado[i] == true) 
		{
			SalvarDados(i);
			SalvarMortos(i);
			SalvarMissoes(i);
			SalvarInventario(i);
			SalvarArmas(i);
			SalvarAvaliacao(i);
		}
	}
	for(new i2; i2 < MAX_ORGS; i2++)
	{
	    SalvarCofre(i2);
	}
	for(new i = 0; i < MAX_FREQUENCIAS; i++)
	{
		SvDeleteStream(Frequencia[i]);
	}
	for(new i = 0; i < MAX_VEHICLES; i++)
	{
		if(FoiCriado[i] == true) DestroyVehicle(i);
	}
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i])
		{
			DestroyVehicle(VehicleID[i]);
			if(VehicleCreated[i] == VEHICLE_DEALERSHIP)
			{
				Delete3DTextLabel(VehicleLabel[i]);
			}
		}
	}
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		if(DealershipCreated[i])
		{
			Delete3DTextLabel(DealershipLabel[i]);
		}
	}
	for(new i=1; i < MAX_FUEL_STATIONS; i++)
	{
		if(FuelStationCreated[i])
		{
			Delete3DTextLabel(FuelStationLabel[i]);
		}
	}
	KillTimer(maintimer);
	KillTimer(savetimer);
	KillTimer(TimerRelogio);
	KillTimer(TimerCadeia);
	KillTimer(TimerAfk);
	KillTimer(TimerMaconha);
	KillTimer(TimerMensagemAuto);
	KillTimer(TimerMensagemAutoBot);
	printf(" ");
	new Dia, Mes, Ano, Hora, Minuto;
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
    printf("=======================================================================");
	printf("Servidor Desligado: [%02d/%02d/%d %02d:%02d]", Dia, Mes, Ano, Hora, Minuto);
    printf("=======================================================================");
	DOF2_Exit();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	ZerarDados(playerid);
	PlayAudioStreamForPlayer(playerid, "http://k.top4top.io/m_2685nhtv30.mp3");
	for(new t=0;t<17;t++){
		TextDrawShowForPlayer(playerid, Loadsc[t]);
	}
	PlayerTextDrawShow(playerid, Loadsc_p[playerid][0]);
	ShowPlayerProgressBar(playerid, Loadsc_b[playerid][0]);
    TogglePlayerSpectating(playerid, true);
    TimerLogin[playerid] = SetTimerEx("mostrarTelaLogin", 50, false, "d", playerid);
 	PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0);
	LimparChat(playerid, 10);
	Page[playerid] = 1;
	if(Page[playerid] == 1){
		Preview[playerid][0] = 1;
		Preview[playerid][1] = 2;
		Preview[playerid][2] = 3;
		Preview[playerid][3] = 4;
		Preview[playerid][4] = 5;
		Preview[playerid][5] = 6;
		PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][0], Preview[playerid][0]);
		PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][1], Preview[playerid][1]);
		PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][2], Preview[playerid][2]);
		PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][3], Preview[playerid][3]);
		PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][4], Preview[playerid][4]);
		PlayerTextDrawSetPreviewModel(playerid, TDCadastro_p[playerid][5], Preview[playerid][5]);
	}
	Falando[playerid] = true;
	if(Susurrando[playerid] == true){
		Susurrando[playerid] = false;
	}
	if(Gritando[playerid] == true){
		Gritando[playerid] = false;
	}
	return 0;
}


public OnPlayerConnect(playerid)
{	
	LockText[0] = CreatePlayerTextDraw(playerid, 320.0, 360.0, "_"), PlayerTextDrawUseBox(playerid, LockText[0], 1);
	PlayerTextDrawLetterSize(playerid, LockText[0], 0.5, 5.599999), PlayerTextDrawTextSize(playerid, LockText[0], 20.0, 240.0);
	PlayerTextDrawFont(playerid, LockText[0], 1), PlayerTextDrawSetProportional(playerid, LockText[0], 1), PlayerTextDrawAlignment(playerid, LockText[0], 2);
	PlayerTextDrawBackgroundColor(playerid, LockText[0], -65281), PlayerTextDrawBoxColor(playerid, LockText[0], 150);

	LockText[1] = CreatePlayerTextDraw(playerid, 205.0, 365.0, "NECESSARIOS: 5"), PlayerTextDrawSetShadow(playerid, LockText[1], 0);
	PlayerTextDrawBackgroundColor(playerid, LockText[1], 255), PlayerTextDrawLetterSize(playerid, LockText[1], 0.2, 1.2);
	PlayerTextDrawFont(playerid, LockText[1], 2), PlayerTextDrawSetProportional(playerid, LockText[1], 1);

	LockText[2] = CreatePlayerTextDraw(playerid, 361.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[2], 1);
	PlayerTextDrawFont(playerid, LockText[2], 4), PlayerTextDrawSetProportional(playerid, LockText[2], 1);
	PlayerTextDrawLetterSize(playerid, LockText[2], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[2], 15.0, 15.0);

	LockText[3] = CreatePlayerTextDraw(playerid, 375.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[3], 1);
	PlayerTextDrawFont(playerid, LockText[3], 4), PlayerTextDrawSetProportional(playerid, LockText[3], 1);
	PlayerTextDrawLetterSize(playerid, LockText[3], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[3], 15.0, 15.0);

	LockText[4] = CreatePlayerTextDraw(playerid, 389.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[4], 1);
	PlayerTextDrawFont(playerid, LockText[4], 4), PlayerTextDrawSetProportional(playerid, LockText[4], 1);
	PlayerTextDrawLetterSize(playerid, LockText[4], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[4], 15.0, 15.0);

	LockText[5] = CreatePlayerTextDraw(playerid, 403.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[5], 1);
	PlayerTextDrawFont(playerid, LockText[5], 4), PlayerTextDrawSetProportional(playerid, LockText[5], 1);
	PlayerTextDrawLetterSize(playerid, LockText[5], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[5], 15.0, 15.0);

	LockText[6] = CreatePlayerTextDraw(playerid, 417.0, 364.0, "LD_BEAT:CHIT"), PlayerTextDrawUseBox(playerid, LockText[6], 1);
	PlayerTextDrawFont(playerid, LockText[6], 4), PlayerTextDrawSetProportional(playerid, LockText[6], 1);
	PlayerTextDrawLetterSize(playerid, LockText[6], 0.4, -2.0), PlayerTextDrawTextSize(playerid, LockText[6], 15.0, 15.0);

	LockText[7] = CreatePlayerTextDraw(playerid, 318.0, 385.0, "_"), PlayerTextDrawUseBox(playerid, LockText[7], 1);
	PlayerTextDrawLetterSize(playerid, LockText[7], 0.5, 1.4), PlayerTextDrawTextSize(playerid, LockText[7], 0.0, -229.0);
	PlayerTextDrawFont(playerid, LockText[7], 1), PlayerTextDrawSetProportional(playerid, LockText[7], 1), PlayerTextDrawAlignment(playerid, LockText[7], 2);
	PlayerTextDrawBackgroundColor(playerid, LockText[7], 255), PlayerTextDrawBoxColor(playerid, LockText[7], 1768516095);

	LockText[11] = CreatePlayerTextDraw(playerid, 320.0, 414.0, "_"), PlayerTextDrawUseBox(playerid, LockText[11], 1);
	PlayerTextDrawLetterSize(playerid, LockText[11], 0.5, -0.1), PlayerTextDrawTextSize(playerid, LockText[11], 20.0, 240.0);
	PlayerTextDrawFont(playerid, LockText[11], 1), PlayerTextDrawSetProportional(playerid, LockText[11], 1), PlayerTextDrawAlignment(playerid, LockText[11], 2);
	PlayerTextDrawBackgroundColor(playerid, LockText[11], -65281), PlayerTextDrawBoxColor(playerid, LockText[11], -5963521);
	SetPlayerCameraPos(playerid, 1981.038940, 1191.061401, 27.828259); 
	SetPlayerCameraLookAt(playerid, 1985.139648, 1195.111572, 27.636171);
	todastextdraw(playerid);
	if(!SvGetVersion(playerid))
	{

	}
	else if(!SvHasMicro(playerid))
	{

	}
	else
	{
 		lstream[playerid] = SvCreateDLStreamAtPlayer(15.0, SV_INFINITY, playerid, 0xff0000ff, "L");
		Susurrandos[playerid] = SvCreateDLStreamAtPlayer(5.0, SV_INFINITY, playerid, 0xff0000ff, "L");
		Gritandos[playerid] = SvCreateDLStreamAtPlayer(30.0, SV_INFINITY, playerid, 0xff0000ff, "L");
		if (gstream) SvAttachListenerToStream(gstream, playerid);
		SvAddKey(playerid, 0x42);//Z
		SvAddKey(playerid, 0x5A);//B
	}
	timerloginname[playerid] = SetTimerEx("attloginname", 40, false, "d", playerid);
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(pLogado[playerid] == true)
	{
		new hora, minuto;
		gettime(hora, minuto);
		jogadoreson--;
		new string[255];
		new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
		format(string,sizeof(string),"O jogador %04d saiu do servidor!\n\nJogadores **%d**/500\nHorario: %02d:%02d", PlayerInfo[playerid][IDF], jogadoreson, hora, minuto);
		DCC_SetEmbedColor(embed, 0xFFFF00);
		DCC_SetEmbedDescription(embed, string);
		DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
		DCC_SendChannelEmbedMessage(EntradaeSaida, embed);
		SalvarDados(playerid);
		SalvarMortos(playerid);
		SalvarMissoes(playerid);
		SalvarInventario(playerid);
		SalvarAvaliacao(playerid);
		DestroyVehicle(VeiculoCivil[playerid]);
		KillTimer(TimerFomebar[playerid]);
		KillTimer(TimerSedebar[playerid]);
		KillTimer(TimerUpdate[playerid]);
		KillTimer(TimerColete[playerid]);
		KillTimer(TimerPBugar[playerid]);
		KillTimer(TimerLocalizar[playerid]);
		KillTimer(TimerPayDay[playerid]);
		KillTimer(TimerAttVeh[playerid]);
		KillTimer(TimerHacker[playerid]);
		if(PegouVehProf[playerid] == true){
			if(PlayerInfo[playerid][pProfissao] == 8){
				for(new o=0;o<10;o++){
					DestroyDynamicObject(sdxobj[o]); 
				}
				DestroyVehicle(carID[playerid]);
			}
		}
		if(Patrulha[playerid] == true) 
		{
			policiaon --;
		}
		else
		{
			SalvarArmas(playerid);
		}
		new arquivofila[64];
		format(arquivofila, sizeof(arquivofila), Pasta_Relatorios,playerid);
		if(DOF2_FileExists(arquivofila))
		{
			DOF2_RemoveFile(arquivofila);
		}
	}
	if(IniciouTesteHabilitacaoA[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaMoto[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaMoto[playerid]);

			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosMoto[playerid] = 0;
			KillTimer(TimerTesteMoto[playerid]);

			IniciouTesteHabilitacaoA[playerid] = 0;
		}
	}
	else if(IniciouTesteHabilitacaoB[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaVeiculo[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaVeiculo[playerid]);

			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosVeiculo[playerid] = 0;
			KillTimer(TimerTesteVeiculo[playerid]);

			IniciouTesteHabilitacaoB[playerid] = 0;
		}
	}
	else if(IniciouTesteHabilitacaoC[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaCaminhao[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaCaminhao[playerid]);

			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosCaminhao[playerid] = 0;
			KillTimer(TimerTesteCaminhao[playerid]);

			IniciouTesteHabilitacaoC[playerid] = 0;
		}
	}
	else if(IniciouTesteHabilitacaoD[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaAerea[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaAerea[playerid]);

			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosAerea[playerid] = 0;
			KillTimer(TimerTesteAerea[playerid]);

			IniciouTesteHabilitacaoD[playerid] = 0;
		}
	}
	else if(lstream[playerid])
	{
		SvDeleteStream(lstream[playerid]);
		lstream[playerid] = SV_NULL;
	}
	else if(Susurrandos[playerid])
	{
		SvDeleteStream(Susurrandos[playerid]);
		Susurrandos[playerid] = SV_NULL;
	}
	else if(Gritandos[playerid])
	{
		SvDeleteStream(Gritandos[playerid]);
		Gritandos[playerid] = SV_NULL;
	}
	for(new t; t < 60; t++)
	{
	    PlayerTextDrawDestroy(playerid, VeloC[playerid][t]);
	}
	for(new i = 0; i < 7; i ++)
	{
		PlayerTextDrawDestroy(playerid, HudServer_p[playerid][i]);
	}
	for(new i = 0; i < 17; i ++)
	{
		TextDrawHideForPlayer(playerid, HudServer[i]);
	}
	PlayerTextDrawDestroy(playerid, Textdraw2[playerid]);
	ZerarDados(playerid);
	new gstring[255];
	switch(reason) {
     	case 0: format(gstring, sizeof(gstring), "{FF2400}* O ID:[{FFFFFF}%04d{FF2400}] {FFFFFF}desconectou do servidor pelo motivo: ({FF2400}Conexao ou crash{FFFFFF})", PlayerInfo[playerid][IDF]);
     	case 1: format(gstring, sizeof(gstring), "{FF2400}* O ID:[{FFFFFF}%04d{FF2400}] {FFFFFF}desconectou do servidor pelo motivo: ({FF2400}Quitou - /q{FFFFFF})", PlayerInfo[playerid][IDF]);
     	case 2: format(gstring, sizeof(gstring), "{FF2400}* O ID:[{FFFFFF}%04d{FF2400}] {FFFFFF}desconectou do servidor pelo motivo: ({FF2400}Kickado ou Banido{FFFFFF})", PlayerInfo[playerid][IDF]);
  	}
  	ProxDetector(30.0, playerid, gstring,-1,-1,-1,-1,-1);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
	SetTimerEx("Attplayer",1000,true,"i",playerid);
	for(new idx=0; idx<9; idx++)
	{
    	TextDrawHideForPlayer(playerid,TDmorte[idx]); 
	}
	PlayerTextDrawHide(playerid, TDmorte_p[playerid][0]);
    if(PlayerMorto[playerid][pEstaMorto] == 1)
    {
        if(PlayerMorto[playerid][pSegMorto] <= 0)
        {
            PlayerMorto[playerid][pSegMorto] = 60;
        }
        SalvarMortos(playerid);
        for(new idx=0; idx<9; idx++)
        {
       	 	TextDrawShowForPlayer(playerid,TDmorte[idx]);
    	}
		PlayerTextDrawShow(playerid, TDmorte_p[playerid][0]);
		SelectTextDraw(playerid, 0xFF0000FF);
        TimerMorto[playerid] = SetTimerEx("mortoxx", 1000, true, "i", playerid);
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 0, 13000, 1);
    }
	new File[255];
	format(File, 56, PASTA_AGENDADOS, Name(playerid));
	if(DOF2_FileExists(File))
	{
		format(Str, sizeof(Str), "O Administrador %s te deu %i minuto(s) de cadeia. Motivo(s): %s", DOF2_GetString(File, "Administrador"), DOF2_GetInt(File, "Tempo"), DOF2_GetString(File, "Motivo"));
		InfoMsg(playerid, Str);
		DOF2_RemoveFile(File);
	}
	if(PlayerInfo[playerid][pCongelado] == true) TogglePlayerControllable(playerid, false);
	if(PlayerInfo[playerid][ExpiraVIP] > 0) 
	{ 
		if(gettime() > PlayerInfo[playerid][ExpiraVIP]) 
		{ 
			new string[40]; 
			format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
			DOF2_RemoveFile(string); 
			PlayerInfo[playerid][ExpiraVIP] = 0;  
			PlayerInfo[playerid][pVIP] = 0;
			InfoMsg(playerid, "Seu beneficio expirou.");
		} 
	} 
	if(PlayerInfo[playerid][Org] != 0) 
	{
		ChecarOrg(playerid);
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	if(PlayerMorto[playerid][pEstaMorto] == 0)
    {
        PlayerMorto[playerid][pMinMorto] = 5;
        PlayerMorto[playerid][pSegMorto] = 60;
	    PlayerMorto[playerid][pPosMt1] = VarPlayerOldPos[playerid][0];
	    PlayerMorto[playerid][pPosMt2] = VarPlayerOldPos[playerid][1];
	    PlayerMorto[playerid][pPosMt3] = VarPlayerOldPos[playerid][2];
	    PlayerMorto[playerid][pEstaMorto] = 1;
	}
	SpawnPlayer(playerid);
	return 1;
}

public OnPlayerGiveDamage(playerid, damagedid, Float:amount, weaponid, bodypart)
{
	return 0;
}

public OnVehicleSpawn(vehicleid)
{
	VehicleSecurity[vehicleid] = 0;
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle1(id))
	{
		if(VehicleColor[id][0] >= 0 && VehicleColor[id][1] >= 0)
			ChangeVehicleColor(vehicleid, VehicleColor[id][0], VehicleColor[id][1]);
		LinkVehicleToInterior(vehicleid, VehicleInterior[id]);
		SetVehicleVirtualWorld(vehicleid, VehicleWorld[id]);
		for(new i=0; i < sizeof(VehicleMods[]); i++)
		{
			AddVehicleComponent(vehicleid, VehicleMods[id][i]);
		}
		ChangeVehiclePaintjob(vehicleid, VehiclePaintjob[id]);
		if(VehicleLock[id]) ToggleDoors(vehicleid, VEHICLE_PARAMS_ON);
		if(VehicleAlarm[id]) VehicleSecurity[vehicleid] = 1;
	}
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnVehicleDamageStatusUpdate(vehicleid, playerid){
	new Float:hp;
    new carid = GetPlayerVehicleID(playerid);
    GetVehicleHealth(carid, hp);
    if (hp <= 300)
    {
        SetVehicleHealth(carid, 290.0);// Veiculos nao explodir
    }
	if(TemCinto[playerid] == false && !IsABike(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid))){
		new Float:PosP[4], Float:HV,damageveh[MAX_PLAYERS];
		GetPlayerPos(playerid, PosP[0], PosP[1], PosP[2]);
		GetPlayerFacingAngle(playerid, PosP[3]);
		GetVehicleHealth(vehicleid,HV);
		format(damageveh[playerid],128,"%s",HV/10);
		if(damageveh[playerid] >= 30){
			SetPlayerHealth(playerid,HV/10);
			SetPlayerPos(playerid,PosP[0]+2,PosP[1]+2,PosP[2]+1);
			SetPlayerFacingAngle(playerid, PosP[3]);
			RemovePlayerFromVehicle(playerid);
			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
			GameTextForPlayer(playerid, "~r~DESMAIOU...", 14900, 4);
			fadeOut(playerid, 15000);
			SetTimerEx("CANIM",15200,false,"i",playerid);
			for(new x=0;x<5;x++){
				TextDrawHideForPlayer(playerid, Tdcinto[x]);
			}
		}
    }
	return 1;
}

public OnPlayerFadeIn(playerid){
	if(pLogado[playerid] == true) {
		// Retirar fade
		PlayerTextDrawHide(playerid, gPlayerFaderTextId);
	}
	return 1;
}

public OnPlayerFadeOut(playerid){
	return 1;
}

public OnPlayerText(playerid, text[])
{
	new string[255];
	if(gettime() < UltimaFala[playerid] + MAX_SEGUNDOSFALAR)
	{
		Erro[playerid]++;
		format(Str, sizeof(Str), "Esta falando muito rapido (AVISO %i/10)", Erro[playerid]);
		InfoMsg(playerid,Str);
		if(Erro[playerid] == 10) Kick(playerid);
		return 0;
	}
	if(ChatAtendimento[playerid] == 1)
	{
 		format(string, sizeof(string), "{F65FC5}[Atendimento][{FFFFFF}Jogador{F65FC5}]%04d: %s", PlayerInfo[playerid][IDF],text);
        AChatAtendimento(-1,string,NumeroChatAtendimento[playerid]);
		return 0;
	}
	else if(ChatAtendimento[playerid] == 2)
	{
 		format(string, sizeof(string), "{F65FC5}[Atendimento][{ff3399}Admin{F65FC5}]%04d: %s", PlayerInfo[playerid][IDF],text);
		AChatAtendimento(-1,string,NumeroChatAtendimento[playerid]);
		return 0;
	}
	if(ChatLigado == false)
	{
		ErrorMsg(playerid, "O chat esta desativado.");
		return 0;
	}
	if(PlayerInfo[playerid][pCalado] == true)
	{
		ErrorMsg(playerid, "Esta calado e nao podera falar.");
		return 0;
	}
	Moved[playerid] = true;
	//
	UltimaFala[playerid] = gettime();
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Nao esta conectado");
	{
		format(string, sizeof string, "{FFFF00}%04d {FFFFFF}disse {FFFF00}%s", PlayerInfo[playerid][IDF], text);
		ProxDetector(30.0, playerid, string, -1,-1,-1,-1,-1);

		format(string,sizeof(string),"%04d falou %s", PlayerInfo[playerid][IDF],text);
		DCC_SendChannelMessage(Chat, string);
		return 0;
	}
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	if(!ispassenger)
	{
		new id = GetVehicleID(vehicleid);
		if(IsValidVehicle1(id) && VehicleCreated[id] == VEHICLE_PLAYER)
		{
			new msg[128];
			format(msg, sizeof(msg), "Este veiculo pertence %s", VehicleOwner[id]);
			InfoMsg(playerid, msg);
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(IniciouTesteHabilitacaoA[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaMoto[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaMoto[playerid]);

			PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosMoto[playerid] = 0;
			KillTimer(TimerTesteMoto[playerid]);

			SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
			SetPlayerInterior(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
			IniciouTesteHabilitacaoA[playerid] = 0;
			GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);
			SetPlayerVirtualWorld(playerid, 0);

			InfoMsg(playerid, "Reprovou pos saiu do veiculo.");
		}
	}
	else if(IniciouTesteHabilitacaoB[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaVeiculo[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaVeiculo[playerid]);

			PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosVeiculo[playerid] = 0;
			KillTimer(TimerTesteVeiculo[playerid]);

			SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
			SetPlayerInterior(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
			IniciouTesteHabilitacaoB[playerid] = 0;
			GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);
			SetPlayerVirtualWorld(playerid, 0);

			InfoMsg(playerid, "Reprovou pos saiu do veiculo.");
		}
	}
	else if(IniciouTesteHabilitacaoC[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaCaminhao[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaCaminhao[playerid]);

			PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosCaminhao[playerid] = 0;
			KillTimer(TimerTesteCaminhao[playerid]);

			SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
			SetPlayerInterior(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
			IniciouTesteHabilitacaoC[playerid] = 0;
			GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);
			SetPlayerVirtualWorld(playerid, 0);

			InfoMsg(playerid, "Reprovou pos saiu do veiculo.");

		}
	}
	else if(IniciouTesteHabilitacaoD[playerid] == 1)
	{
		if(IsPlayerInVehicle(playerid, AutoEscolaAerea[playerid]))
		{
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(AutoEscolaAerea[playerid]);

			PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
			DisablePlayerRaceCheckpoint(playerid);
			CheckpointPontosAerea[playerid] = 0;
			KillTimer(TimerTesteAerea[playerid]);

			SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
			SetPlayerInterior(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
			IniciouTesteHabilitacaoD[playerid] = 0;
			GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);
			SetPlayerVirtualWorld(playerid, 0);

			InfoMsg(playerid, "Reprovou pos saiu do veiculo.");
		}
	}
	if(TemCinto[playerid] == true)
	{
		TemCinto[playerid] = false;
		SuccesMsg(playerid, "Cinto de seguranca removido");
	
	}
	else
	{
		for(new x=0;x<5;x++)
		{
			TextDrawHideForPlayer(playerid, Tdcinto[x]); 
		}
	}
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Voce nao esta logado.");
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)return ErrorMsg(playerid, "Comando desconhecido");
	return 0x01;
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)//O jogador entrou no veiculo como motorista
    {
		if(IsPlayerMobile(playerid)){
			if(mostrandovelo[playerid] == 0){
				for(new t=0;t<4;t++){
					TextDrawShowForPlayer(playerid,Velomob[t]);
				}
				for(new t=0;t<3;t++){
					PlayerTextDrawShow(playerid,Velomob_p[playerid][t]);
				}
				mostrandovelo[playerid] = 1;
			}
		}else{
			if(mostrandovelo[playerid] == 0){
				for(new t=0;t<52;t++){
					TextDrawShowForPlayer(playerid,VeloC_G[t]);
				}
				for(new t=0;t<10;t++){
					PlayerTextDrawShow(playerid,VeloC[playerid][t]);
				}
				mostrandovelo[playerid] = 1;
			}

		}
		
		TimerVelo[playerid] = SetTimerEx("VelocimetroEx", 250, true, "d", playerid);
    }
	if(IsPlayerInAnyVehicle(playerid) && !IsBicycle(GetPlayerVehicleID(playerid)))
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		if(VehicleSecurity[vehicleid] == 1)
		{
			ToggleAlarm(vehicleid, VEHICLE_PARAMS_ON);
			SetTimerEx("StopAlarm", TEMPO_SOM_ALARME, false, "d", vehicleid);
		}
	}
	else
	{
		//
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new vehicleid = GetPlayerVehicleID(playerid);
		new id = GetVehicleID(vehicleid);
		if(IsValidVehicle1(id))
		{
			if(VehicleCreated[id] == VEHICLE_DEALERSHIP)
			{
				SetPVarInt(playerid, "DialogValue1", id);
				ShowDialog(playerid, DIALOG_VEHICLE_BUY);
				return 1;
			}
		}
		if(IsBicycle(vehicleid))
		{
			ToggleEngine(vehicleid, VEHICLE_PARAMS_ON);
		}
		if(Fuel[vehicleid] <= 0)
		{
			ToggleEngine(vehicleid, VEHICLE_PARAMS_OFF);
		}
	}
	if(newstate == PLAYER_STATE_DRIVER || newstate == PLAYER_STATE_PASSENGER)
	{
		if(PlayerInfo[playerid][pAdmin] > 0)
		{
			format(Str, sizeof(Str), "Veiculo ID: %i", GetPlayerVehicleID(playerid));
			InfoMsg(playerid, Str);
		}
		if(TemCinto[playerid] == false && !IsABike(GetPlayerVehicleID(playerid)) && !IsABoat(GetPlayerVehicleID(playerid))){
			for(new x=0;x<5;x++){
				TextDrawShowForPlayer(playerid, Tdcinto[x]);
			}
		}
		foreach(new i: Player)
		{
			if(IsPlayerConnected(i) && Assistindo[i] == playerid && IsAssistindo[i] == true)
			{
				TogglePlayerSpectating(i, 1);
				PlayerSpectateVehicle(i, GetPlayerVehicleID(playerid));
			}
		}
	}
	if(oldstate == PLAYER_STATE_DRIVER || oldstate == PLAYER_STATE_PASSENGER)
	{
		foreach(new i: Player)
		{
			if(IsPlayerConnected(i) && Assistindo[i] == playerid && IsAssistindo[i] == true)
			{
				TogglePlayerSpectating(i, 1);
				PlayerSpectatePlayer(i, playerid);
			}
		}
		if(TemCinto[playerid] == false){
			for(new x=0;x<5;x++){
				TextDrawHideForPlayer(playerid, Tdcinto[x]);
			}
		}else{
			TemCinto[playerid] = false;
		}
	}
	if(newstate == PLAYER_STATE_DRIVER)
	{
		new IdVeiculo = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(IdVeiculo) != 481 && GetVehicleModel(IdVeiculo) != 510 && GetVehicleModel(IdVeiculo) != 509)
		{
			new vid = GetPlayerVehicleID(playerid);
			new motor, luzes, alarmev, portas, capo, mala, objective;
			GetVehicleParamsEx(vid, motor, luzes, alarmev, portas, capo, mala, objective);
			SetVehicleParamsEx(vid, false, luzes,alarmev, portas, capo, mala, objective);
			MotorOn[playerid] = 0;
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(RotaMaconha[playerid] == true) 
	{ 
		InfoMsg(playerid, "Utilize a maconha no seu inventario para fazer a entrega.");
	}
	if(GPS[playerid] == true) 
	{ 
		DisablePlayerCheckpoint(playerid);
		GPS[playerid] = false;
	}
	if(EntregaSdx[playerid] == true){
		if(IsPlayerInAnyVehicle(playerid)){
			ErrorMsg(playerid, "Voce deve estar fora do veiculo.");
		}else{
			DisablePlayerCheckpoint(playerid);
			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BUDDY", "BUDDY_CROUCHRELOAD", 4.1, 1, 0, 0, 0, 0, 1);
			CreateProgress(playerid,"PegandoCaixasP","Pegando caixa...", 80);
			EntregaSdx[playerid] = false;
		}
	}
	if(CaixaMao[playerid] == true){
		DisablePlayerCheckpoint(playerid); 
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BUDDY", "BUDDY_CROUCHRELOAD", 4.1, 1, 0, 0, 0, 0, 1);
		CreateProgress(playerid, "ColocandoCaixa","Colocando caixa...", 60);
		CaixaMao[playerid] = false;
	}
	if(Covaconcerto[playerid] == true) 
	{ 
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.1, 1, 0, 0, 0, 0, 1);
		DisablePlayerCheckpoint(playerid); 
		CreateProgress(playerid, "Cova","Coletando lixo...", 130);
	}
	if(PegouLixo[playerid] == true) 
	{ 
		DisablePlayerCheckpoint(playerid); 
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BUDDY", "BUDDY_CROUCHRELOAD", 4.1, 1, 0, 0, 0, 0, 1);
		CreateProgress(playerid, "BotouBau","Colocando lixo...", 100);
	}
	if(ltumba[playerid] == true)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 1173.5168,-1308.6056,13.6994))
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 442)
			{
				DisablePlayerCheckpoint(playerid); 
				TogglePlayerControllable(playerid, 0);
				CreateProgress(playerid, "RotaCova1","Colocando cadaver...", 100);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 1609.8369,1823.2799,10.5249))
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 442)
			{
				DisablePlayerCheckpoint(playerid); 
				TogglePlayerControllable(playerid, 0);
				CreateProgress(playerid, "RotaCova2","Colocando cadaver...", 100);
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, -2590.4451,643.4471,14.1566))
		{
			if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 442)
			{
				DisablePlayerCheckpoint(playerid); 
				TogglePlayerControllable(playerid, 0);
				CreateProgress(playerid, "RotaCova3","Colocando cadaver...", 100);
			}
		}
	}
	if(CargoTumba[playerid] == 1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 934.1115,-1103.3857,24.3118))
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 442)
		{
			DisablePlayerCheckpoint(playerid);
			CargoTumba[playerid] = 0;
			ltumba[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 600;
				SuccesMsg(playerid, "Terminou o trabalho e ganhou R$600."); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 600*2;
				SuccesMsg(playerid, "Terminou o trabalho e ganhou R$1200."); 
			}
		}
	}
	if(CargoTumba[playerid] == 2)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 934.1115,-1103.3857,24.3118))
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 442)
		{
			DisablePlayerCheckpoint(playerid);
			CargoTumba[playerid] = 0;
			ltumba[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 1200;
				SuccesMsg(playerid, "Terminou o trabalho e ganhou R$1200."); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 1200*2;
				SuccesMsg(playerid, "Terminou o trabalho e ganhou R$2400."); 
			}
		}

	}
	if(CargoTumba[playerid] == 3)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, 934.1115,-1103.3857,24.3118))
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 442)
		{
			DisablePlayerCheckpoint(playerid);
			CargoTumba[playerid] = 0;
			ltumba[playerid] = false;
			if(PlayerInfo[playerid][pVIP] == 0)
			{
				PlayerInfo[playerid][pDinheiro] += 2000;
				SuccesMsg(playerid, "Terminou o trabalho e ganhou R$2000."); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2000*2;
				SuccesMsg(playerid, "Terminou o trabalho e ganhou R$4000."); 
			}
		}
	}
	if(PegouMaterial[playerid] == true)
	{
		new dinmateriale = randomEx(0, 100);
		new constrstr[500];
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 1, 0, 1, 0, 1);
		SetTimerEx("AnimyTogle", 3000, false, "i", playerid);
		RemovePlayerAttachedObject(playerid, 6);
		if(PlayerInfo[playerid][pVIP] == 0)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale;
			format(constrstr,sizeof(constrstr),"Ganhou %i com este material.", dinmateriale);
			SuccesMsg(playerid, constrstr); 
		}   
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale*2;
			format(constrstr,sizeof(constrstr),"Ganhou %i com este material.", dinmateriale*2);
			SuccesMsg(playerid, constrstr); 
		}
		DisablePlayerCheckpoint(playerid);
		PegouMaterial[playerid] = false;
	} 
	if(EtapasMinerador[playerid] == 2)
	{
		new constrstr[500];
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 1, 0, 1, 0, 1);
		SetTimerEx("AnimyTogle", 3000, false, "i", playerid);
		RemovePlayerAttachedObject(playerid, 1);
		ClearAnimations(playerid);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		new dinmateriale = randomEx(50, 200);
		if(PlayerInfo[playerid][pVIP] == 0)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale;
			format(constrstr,sizeof(constrstr),"Ganhou %i com esta rocha.", dinmateriale);
			SuccesMsg(playerid, constrstr); 
		}   
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale*2;
			format(constrstr,sizeof(constrstr),"Ganhou %i com esta rocha.", dinmateriale*2);
			SuccesMsg(playerid, constrstr); 
		}
		EtapasMinerador[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
	} 
	if(Desossando[playerid] == 6)
	{
		new dinmateriale = randomEx(50, 200);
		new constrstr[500];
		ClearAnimations(playerid);
		SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
		RemovePlayerAttachedObject(playerid, 1);
		if(PlayerInfo[playerid][pVIP] == 0)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale;
			format(constrstr,sizeof(constrstr),"Ganhou %i com esta caixa.", dinmateriale);
			SuccesMsg(playerid, constrstr); 
		}   
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale*2;
			format(constrstr,sizeof(constrstr),"Ganhou %i com esta caixa.", dinmateriale*2);
			SuccesMsg(playerid, constrstr); 
		}
		DisablePlayerCheckpoint(playerid);
		Desossando[playerid] = 0;
	} 
	if(EtapasMinerador[playerid] == 1)
	{
		if(PlayerInfo[playerid][pProfissao] != 2) 	return ErrorMsg(playerid, "Nao possui permissao.");

		TogglePlayerControllable(playerid, 0);
		DisablePlayerCheckpoint(playerid);
		CreateProgress(playerid, "Minerar","Coletando Rocha...", 80);
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle1(id))
	{
		VehicleMods[id][GetVehicleComponentType(componentid)] = componentid;
		SaveVehicle(id);
	}
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle1(id))
	{
		VehiclePaintjob[id] = paintjobid;
		SaveVehicle(id);
	}
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	new id = GetVehicleID(vehicleid);
	if(IsValidVehicle1(id))
	{
		VehicleColor[id][0] = color1;
		VehicleColor[id][1] = color2;
		SaveVehicle(id);
	}
	return 1;
}
public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ )
{
	new Damage;
	switch(weaponid)
	{
		case 22: Damage = 25; // 9MM
		case 23: Damage = 40; // SILENCED 9MM (9MM SILENCIADA)
		case 24: Damage = 70; // DESERT EAGLE
		case 25: Damage = 60; // SHOTGUN
		case 26: Damage = 70; // SAWNOFF (CANO SERRADO)
		case 27: Damage = 40; // COMBAT SHOTGUN (SHOTGUN DE COMBATE)
		case 28: Damage = 10; // MICRO SMG/UZI
		case 29: Damage = 10; // MP5
		case 30: Damage = 50; // AK-47
		case 31: Damage = 50; // M4
		case 32: Damage = 10; // TEC-9
		case 33: Damage = 100; // COUNTRY RIFLE
		case 34: Damage = 150; // SNIPER
		case 38: Damage = 400; // MINUGUN
	}
	if(hittype == BULLET_HIT_TYPE_VEHICLE)
	{
		new Float:Health;
		GetVehicleHealth(hitid, Health);
		SetVehicleHealth(hitid, Health - Damage);
		if(Damage == 0) SetVehicleHealth(hitid, 7);
	}
	return 1;
}

stock terminouteste(playerid)
{
	SetPlayerPos(playerid, 616.849304, -9.415119, 1000.990295);
	SetPlayerInterior(playerid, 0);
	return 1;
}
public OnPlayerEnterRaceCheckpoint(playerid)
{
	switch(CheckpointPontosMoto[playerid])
	{
		case 1:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[1][0], AutoEscolaPosicao[1][1], AutoEscolaPosicao[1][2],AutoEscolaPosicao[2][0], AutoEscolaPosicao[2][1], AutoEscolaPosicao[2][2], 7);
					GameTextForPlayer(playerid,"~s~01/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 2;
				}
			}
		}
		case 2:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[2][0], AutoEscolaPosicao[2][1], AutoEscolaPosicao[2][2], AutoEscolaPosicao[3][0], AutoEscolaPosicao[3][1], AutoEscolaPosicao[3][2], 7);
					GameTextForPlayer(playerid,"~s~02/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 3;
				}
			}
		}
		case 3:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[3][0], AutoEscolaPosicao[3][1], AutoEscolaPosicao[3][2], AutoEscolaPosicao[4][0], AutoEscolaPosicao[4][1], AutoEscolaPosicao[4][2], 7);
					GameTextForPlayer(playerid,"~s~03/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 4;
				}
			}
		}
		case 4:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[4][0], AutoEscolaPosicao[4][1], AutoEscolaPosicao[4][2], AutoEscolaPosicao[5][0], AutoEscolaPosicao[5][1], AutoEscolaPosicao[5][2], 7);
					GameTextForPlayer(playerid,"~s~04/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 5;
				}
			}
		}
		case 5:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[5][0], AutoEscolaPosicao[5][1], AutoEscolaPosicao[5][2], AutoEscolaPosicao[6][0], AutoEscolaPosicao[6][1], AutoEscolaPosicao[6][2], 7);
					GameTextForPlayer(playerid,"~s~05/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 6;
				}
			}
		}
		case 6:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[6][0], AutoEscolaPosicao[6][1], AutoEscolaPosicao[6][2], AutoEscolaPosicao[7][0], AutoEscolaPosicao[7][1], AutoEscolaPosicao[7][2], 7);
					GameTextForPlayer(playerid,"~s~06/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 7;
				}
			}
		}
		case 7:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[7][0], AutoEscolaPosicao[7][1], AutoEscolaPosicao[7][2], AutoEscolaPosicao[8][0], AutoEscolaPosicao[8][1], AutoEscolaPosicao[8][2], 7);
					GameTextForPlayer(playerid,"~s~07/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 8;
				}
			}
		}
		case 8:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[8][0], AutoEscolaPosicao[8][1], AutoEscolaPosicao[8][2], AutoEscolaPosicao[9][0], AutoEscolaPosicao[9][1], AutoEscolaPosicao[9][2], 7);
					GameTextForPlayer(playerid,"~s~08/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 9;
				}
			}
		}
		case 9:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[9][0], AutoEscolaPosicao[9][1], AutoEscolaPosicao[9][2], AutoEscolaPosicao[10][0], AutoEscolaPosicao[10][1], AutoEscolaPosicao[10][2], 7);
					GameTextForPlayer(playerid,"~s~09/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 10;
				}
			}
		}
		case 10:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[10][0], AutoEscolaPosicao[10][1], AutoEscolaPosicao[10][2], AutoEscolaPosicao[11][0], AutoEscolaPosicao[11][1], AutoEscolaPosicao[11][2], 7);
					GameTextForPlayer(playerid,"~s~10/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 11;
				}
			}
		}
		case 11:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[11][0], AutoEscolaPosicao[11][1], AutoEscolaPosicao[11][2], AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], 7);
					GameTextForPlayer(playerid,"~s~11/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 12;
				}
			}
		}
		case 12:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], 7);
					GameTextForPlayer(playerid,"~s~12/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosMoto[playerid] = 13;
				}
			}
		}
		case 13:
		{
			if(IniciouTesteHabilitacaoA[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					new Float:Vida2;
					GetVehicleHealth(AutoEscolaMoto[playerid], Float:Vida2);
					if(Vida2 < 995) // Reprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaMoto[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosMoto[playerid] = 0;
						KillTimer(TimerTesteMoto[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoA[playerid] = 0;
						GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);

						InfoMsg(playerid, "Reprovou no teste de licenca.");
						GameTextForPlayer(playerid, "~w~Reprovado!", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
					else if(Vida2 > 995) // Aprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaMoto[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosMoto[playerid] = 0;
						KillTimer(TimerTesteMoto[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoA[playerid] = 0;

						InfoMsg(playerid, "Aprovado no teste de licenca.");
						GanharItem(playerid, 1853, 1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~Aprovado!", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
				}
			}
		}
	}
	switch(CheckpointPontosVeiculo[playerid])
	{
		case 1:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[1][0], AutoEscolaPosicao[1][1], AutoEscolaPosicao[1][2],AutoEscolaPosicao[2][0], AutoEscolaPosicao[2][1], AutoEscolaPosicao[2][2], 7);
					GameTextForPlayer(playerid,"~s~01/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 2;
				}
			}
		}
		case 2:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[2][0], AutoEscolaPosicao[2][1], AutoEscolaPosicao[2][2], AutoEscolaPosicao[3][0], AutoEscolaPosicao[3][1], AutoEscolaPosicao[3][2], 7);
					GameTextForPlayer(playerid,"~s~02/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 3;
				}
			}
		}
		case 3:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[3][0], AutoEscolaPosicao[3][1], AutoEscolaPosicao[3][2], AutoEscolaPosicao[4][0], AutoEscolaPosicao[4][1], AutoEscolaPosicao[4][2], 7);
					GameTextForPlayer(playerid,"~s~03/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 4;
				}
			}
		}
		case 4:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[4][0], AutoEscolaPosicao[4][1], AutoEscolaPosicao[4][2], AutoEscolaPosicao[5][0], AutoEscolaPosicao[5][1], AutoEscolaPosicao[5][2], 7);
					GameTextForPlayer(playerid,"~s~04/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 5;
				}
			}
		}
		case 5:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[5][0], AutoEscolaPosicao[5][1], AutoEscolaPosicao[5][2], AutoEscolaPosicao[6][0], AutoEscolaPosicao[6][1], AutoEscolaPosicao[6][2], 7);
					GameTextForPlayer(playerid,"~s~05/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 6;
				}
			}
		}
		case 6:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[6][0], AutoEscolaPosicao[6][1], AutoEscolaPosicao[6][2], AutoEscolaPosicao[7][0], AutoEscolaPosicao[7][1], AutoEscolaPosicao[7][2], 7);
					GameTextForPlayer(playerid,"~s~06/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 7;
				}
			}
		}
		case 7:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[7][0], AutoEscolaPosicao[7][1], AutoEscolaPosicao[7][2], AutoEscolaPosicao[8][0], AutoEscolaPosicao[8][1], AutoEscolaPosicao[8][2], 7);
					GameTextForPlayer(playerid,"~s~07/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 8;
				}
			}
		}
		case 8:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[8][0], AutoEscolaPosicao[8][1], AutoEscolaPosicao[8][2], AutoEscolaPosicao[9][0], AutoEscolaPosicao[9][1], AutoEscolaPosicao[9][2], 7);
					GameTextForPlayer(playerid,"~s~08/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 9;
				}
			}
		}
		case 9:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[9][0], AutoEscolaPosicao[9][1], AutoEscolaPosicao[9][2], AutoEscolaPosicao[10][0], AutoEscolaPosicao[10][1], AutoEscolaPosicao[10][2], 7);
					GameTextForPlayer(playerid,"~s~09/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 10;
				}
			}
		}
		case 10:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[10][0], AutoEscolaPosicao[10][1], AutoEscolaPosicao[10][2], AutoEscolaPosicao[11][0], AutoEscolaPosicao[11][1], AutoEscolaPosicao[11][2], 7);
					GameTextForPlayer(playerid,"~s~10/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 11;
				}
			}
		}
		case 11:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[11][0], AutoEscolaPosicao[11][1], AutoEscolaPosicao[11][2], AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], 7);
					GameTextForPlayer(playerid,"~s~11/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 12;
				}
			}
		}
		case 12:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], 7);
					GameTextForPlayer(playerid,"~s~12/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosVeiculo[playerid] = 13;
				}
			}
		}
		case 13:
		{
			if(IniciouTesteHabilitacaoB[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					new Float:Vida2;
					GetVehicleHealth(AutoEscolaVeiculo[playerid], Float:Vida2);
					if(Vida2 < 995) // Reprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaVeiculo[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosVeiculo[playerid] = 0;
						KillTimer(TimerTesteVeiculo[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoB[playerid] = 0;
						GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);

						InfoMsg(playerid, "Reprovou no teste de licenca.");
						GameTextForPlayer(playerid, "~w~Reprovado", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
					else if(Vida2 > 995) // Aprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaVeiculo[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosVeiculo[playerid] = 0;
						KillTimer(TimerTesteVeiculo[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoB[playerid] = 0;

						InfoMsg(playerid, "Aprovado no teste de licenca.");
						PlayerInfo[playerid][LicencaConduzir] = 1;
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~Aprovado!", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
				}
			}
		}
	}
	switch(CheckpointPontosCaminhao[playerid])
	{
		case 1:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[1][0], AutoEscolaPosicao[1][1], AutoEscolaPosicao[1][2],AutoEscolaPosicao[2][0], AutoEscolaPosicao[2][1], AutoEscolaPosicao[2][2], 7);
					GameTextForPlayer(playerid,"~s~01/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 2;
				}
			}
		}
		case 2:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[2][0], AutoEscolaPosicao[2][1], AutoEscolaPosicao[2][2], AutoEscolaPosicao[3][0], AutoEscolaPosicao[3][1], AutoEscolaPosicao[3][2], 7);
					GameTextForPlayer(playerid,"~s~02/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 3;
				}
			}
		}
		case 3:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[3][0], AutoEscolaPosicao[3][1], AutoEscolaPosicao[3][2], AutoEscolaPosicao[4][0], AutoEscolaPosicao[4][1], AutoEscolaPosicao[4][2], 7);
					GameTextForPlayer(playerid,"~s~03/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 4;
				}
			}
		}
		case 4:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[4][0], AutoEscolaPosicao[4][1], AutoEscolaPosicao[4][2], AutoEscolaPosicao[5][0], AutoEscolaPosicao[5][1], AutoEscolaPosicao[5][2], 7);
					GameTextForPlayer(playerid,"~s~04/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 5;
				}
			}
		}
		case 5:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[5][0], AutoEscolaPosicao[5][1], AutoEscolaPosicao[5][2], AutoEscolaPosicao[6][0], AutoEscolaPosicao[6][1], AutoEscolaPosicao[6][2], 7);
					GameTextForPlayer(playerid,"~s~05/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 6;
				}
			}
		}
		case 6:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[6][0], AutoEscolaPosicao[6][1], AutoEscolaPosicao[6][2], AutoEscolaPosicao[7][0], AutoEscolaPosicao[7][1], AutoEscolaPosicao[7][2], 7);
					GameTextForPlayer(playerid,"~s~06/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 7;
				}
			}
		}
		case 7:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[7][0], AutoEscolaPosicao[7][1], AutoEscolaPosicao[7][2], AutoEscolaPosicao[8][0], AutoEscolaPosicao[8][1], AutoEscolaPosicao[8][2], 7);
					GameTextForPlayer(playerid,"~s~07/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 8;
				}
			}
		}
		case 8:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[8][0], AutoEscolaPosicao[8][1], AutoEscolaPosicao[8][2], AutoEscolaPosicao[9][0], AutoEscolaPosicao[9][1], AutoEscolaPosicao[9][2], 7);
					GameTextForPlayer(playerid,"~s~08/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 9;
				}
			}
		}
		case 9:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[9][0], AutoEscolaPosicao[9][1], AutoEscolaPosicao[9][2], AutoEscolaPosicao[10][0], AutoEscolaPosicao[10][1], AutoEscolaPosicao[10][2], 7);
					GameTextForPlayer(playerid,"~s~09/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 10;
				}
			}
		}
		case 10:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[10][0], AutoEscolaPosicao[10][1], AutoEscolaPosicao[10][2], AutoEscolaPosicao[11][0], AutoEscolaPosicao[11][1], AutoEscolaPosicao[11][2], 7);
					GameTextForPlayer(playerid,"~s~10/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 11;
				}
			}
		}
		case 11:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[11][0], AutoEscolaPosicao[11][1], AutoEscolaPosicao[11][2], AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], 7);
					GameTextForPlayer(playerid,"~s~11/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 12;
				}
			}
		}
		case 12:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], AutoEscolaPosicao[12][0], AutoEscolaPosicao[12][1], AutoEscolaPosicao[12][2], 7);
					GameTextForPlayer(playerid,"~s~12/13", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosCaminhao[playerid] = 13;
				}
			}
		}
		case 13:
		{
			if(IniciouTesteHabilitacaoC[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					new Float:Vida2;
					GetVehicleHealth(AutoEscolaCaminhao[playerid], Float:Vida2);
					if(Vida2 < 995) // Reprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaCaminhao[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosCaminhao[playerid] = 0;
						KillTimer(TimerTesteCaminhao[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoC[playerid] = 0;

						InfoMsg(playerid, "Reprovou no teste de licenca.");
						GameTextForPlayer(playerid, "~w~Reprovou!", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
					else if(Vida2 > 995) // Aprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaCaminhao[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosCaminhao[playerid] = 0;
						KillTimer(TimerTesteCaminhao[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoC[playerid] = 0;

						InfoMsg(playerid, "Aprovado no teste de licenca.");
						GanharItem(playerid, 1855, 1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~Aprovado", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);


					}
				}
			}
		}
	}
	switch(CheckpointPontosAerea[playerid])
	{
		case 1:
		{
			if(IniciouTesteHabilitacaoD[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicaoAerea[1][0], AutoEscolaPosicaoAerea[1][1], AutoEscolaPosicaoAerea[1][2],AutoEscolaPosicaoAerea[2][0], AutoEscolaPosicaoAerea[2][1], AutoEscolaPosicaoAerea[2][2], 7);
					GameTextForPlayer(playerid,"~s~01/3", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosAerea[playerid] = 2;
				}
			}
		}
		case 2:
		{
			if(IniciouTesteHabilitacaoD[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
					DisablePlayerRaceCheckpoint(playerid);
					SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicaoAerea[2][0], AutoEscolaPosicaoAerea[2][1], AutoEscolaPosicaoAerea[2][2], AutoEscolaPosicaoAerea[2][0], AutoEscolaPosicaoAerea[2][1], AutoEscolaPosicaoAerea[2][2], 7);
					GameTextForPlayer(playerid,"~s~02/3", 2000, 1);
					InfoMsg(playerid, "Va ate o proximo ponto");
					GameTextForPlayer(playerid, "~w~Proximo!", 2000, 4);
					CheckpointPontosAerea[playerid] = 3;
				}
			}
		}
		case 3:
		{
			if(IniciouTesteHabilitacaoD[playerid] == 1)
			{
				new playerState = GetPlayerState(playerid);
				if(playerState == PLAYER_STATE_DRIVER)
				{
					new Float:Vida2;
					GetVehicleHealth(AutoEscolaAerea[playerid], Float:Vida2);
					if(Vida2 < 700) // Reprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaAerea[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosAerea[playerid] = 0;
						KillTimer(TimerTesteAerea[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoD[playerid] = 0;

						InfoMsg(playerid, "Reprovou no teste de licenca.");
						GameTextForPlayer(playerid, "~w~Reprovou!", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
					else if(Vida2 >= 700) // Aprovado
					{
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(AutoEscolaAerea[playerid]);

						PlayerPlaySound(playerid,1137,0.0,0.0,0.0);
						DisablePlayerRaceCheckpoint(playerid);
						CheckpointPontosAerea[playerid] = 0;
						KillTimer(TimerTesteAerea[playerid]);

						terminouteste(playerid);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoD[playerid] = 0;

						InfoMsg(playerid, "Aprovado no teste de licenca.");
						GanharItem(playerid, 1856,1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~Aprovado", 5000, 0);
						SetPlayerVirtualWorld(playerid, 0);

					}
				}
			}
		}
	}
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	if(strcmp(cmd, "gmx", true, 10) == 0)
	{
		foreach(new i: Player)
		{
			if(IsPlayerConnected(i) && pLogado[i] == true) Kick(i);
		}
	}
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	return 1;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	if(!RoubandoCaixa[playerid])
	{
		for(new i; i < MAX_CAIXAS; i++)
		{
			if(!CaixaInfo[i][Caixa_Roubada])continue;
			for(new p; p < MAX_PICKUPS_ROUBO; p++)
			{
				if(pickupid == Pickups_Roubo[i][p])
				{
					new keys, ud, lr;
					GetPlayerKeys(playerid, keys, ud, lr);
						GranaRoubo(playerid, i);
						DestroyPickup(pickupid);
						Pickups_Roubo[i][p] = -1;
				}
			}
		}
	}
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && Assistindo[i] == playerid)
		{
			SetPlayerInterior(i, newinteriorid);
		}
	}
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(newkeys & KEY_SPRINT && newkeys & KEY_JUMP) 
	{
		if(pulou2vezes[playerid] == true)
		{
			ApplyAnimation(playerid, "PED", "GETUP_FRONT", 4.0, 0, 1, 1, 0, 0, 1);
		}
		else
		{
			pulou2vezes[playerid] = true;
			SetTimerEx("ResetarPulo", 1500, false, "d",playerid);
		}
	}
	if(newkeys == KEY_SPRINT)
    {
        if(LockUse[playerid] == true)
        {
            if(LockProgress < LockLocation[playerid]-(LockSize[playerid]+1) || LockProgress > LockLocation[playerid]+(LockSize[playerid]+2))
			{
			    PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0xFF0000AA);
				if(LockCount[playerid] < 4) return DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
                if(LockCount[playerid] == 4)
				{
					PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);
					if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], 1, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), InfoMsg(playerid, "VocÃª nÃ£o conseguiu acertar a lockpick e acionou o alarme!");
					if(DoorsLockPick[playerid] == 0) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 1, Bonnet[playerid], Boot[playerid], Objective[playerid]), InfoMsg(playerid,  "O veiculo foi trancado!");
					SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 0, Bonnet[playerid], Boot[playerid], Objective[playerid]), SuccesMsg(playerid, "O veiculo foi aberto!");
				}
			}
			else
			{
				PlayerTextDrawColor(playerid, LockText[LockCount[playerid]+2], 0x00FF00AA), Correct[playerid]++;
                if(LockCount[playerid] < 4) return DestroyLockPick(playerid), KillTimer(LockTimer[playerid]), LockCount[playerid]++, LockProgress = 207.0, CreateLocPick(playerid);
                if(LockCount[playerid] == 4)
				{
					PlayerTextDrawShow(playerid, LockText[LockCount[playerid]+2]), SetTimerEx("DestroyLockPick", 2000, false, "i", playerid), KillTimer(LockTimer[playerid]);
					if(Correct[playerid] != 5) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], 1, DoorsLockPick[playerid], Bonnet[playerid], Boot[playerid], Objective[playerid]), InfoMsg(playerid,  "VocÃª nÃ£o conseguiu acertar a lockpick e acionou o alarme!");
					if(DoorsLockPick[playerid] == 0) return SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 1, Bonnet[playerid], Boot[playerid], Objective[playerid]), InfoMsg(playerid,  "O veiculo foi trancado!");
					SetVehicleParamsEx(VehicleLockedID[playerid], Engine[playerid], Lights[playerid], Alarm[playerid], 0, Bonnet[playerid], Boot[playerid], Objective[playerid]), SuccesMsg(playerid,  "O veiculo foi aberto!");
				}
			}
		}
	}
	if(newkeys & KEY_FIRE && newkeys & KEY_HANDBRAKE) 
	{
	    if(RecentlyShot[playerid] == 0) 
	    {
	        RecentlyShot[playerid] = 1;
	        SetTimerEx("AntiSpam", 1000, false, "d", playerid);
			if(GetPlayerWeapon(playerid) == 34) 
			{
		        new Float:blahx, Float:blahy, Float:blahz;
				HeadshotCheck(playerid, blahx, blahy, blahz);
		        return 1;
		    }
			return 1;
		}
		return 1;
 	}
	if(newkeys == KEY_CTRL_BACK)
	{
		cmd_roubar(playerid);
		new Inv[5000], Nick[5000], orgid = GetPlayerOrg(playerid);
		if(IsPlayerInRangeOfPoint(playerid, 10.0, CofreInfo[orgid][CofrePosX], CofreInfo[orgid][CofrePosY], CofreInfo[orgid][CofrePosZ]))
		{
            if(IsBandido(playerid))
            {
				for(new ii = 0; ii != 20; ii++)
				{
					GetWeaponName(CofreArma[ii][orgid], Nick, 20);
					strcat(Inv, CofreArma[ii][orgid] > 0 ? (CofreArma[ii][orgid] == 18 ? ("{FFDC33}Cocktail Molotov") : (Nick)) : ("{FFDC33}(Vazio)"));
					strcat(Inv, "\n");
				}
				strcat(Inv, "Guardar Arma");
				ShowPlayerDialog(playerid, DIALOG_ARMAS2, DIALOG_STYLE_LIST, "Menu da Org {FFDC33}[Bau]", Inv, "Selecionar", "X");
				return 1;
			}
            else
            {
                ErrorMsg(playerid, "Voce nao e um Criminoso");
                return 1;
            }
		}
		if(PlayerToPoint(3.0, playerid, 1683.301391, -2311.982910, 13.546875))
		{
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(462, 1683.301391, -2311.982910, 13.546875, 90, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
				MissaoPlayer[playerid][MISSAO12] = 1;
				
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
		}
		else if(PlayerToPoint(3.0, playerid, 1179.630615, -1339.028686, 13.838010))
		{
			if(PlayerInfo[playerid][pProfissao] != 3)    		return ErrorMsg(playerid, "Nao possui permissao.");
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(416, 1179.630615, -1339.028686, 13.838010, 272.896881, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
		}
		else if(PlayerToPoint(3.0, playerid, 590.086975, 871.486694, -42.734603))
		{
			if(PlayerInfo[playerid][pProfissao] != 2)    		return ErrorMsg(playerid, "Nao possui permissao.");
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(530, 590.086975, 871.486694, -42.734603, 180.0, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
		}
		else if(PlayerToPoint(3.0, playerid, -478.623901, -506.406524, 25.517845))
		{
			if(PlayerInfo[playerid][pProfissao] != 4)    		return ErrorMsg(playerid, "Nao possui permissao.");
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(456, -478.623901, -506.406524, 25.517845, 273.778228, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
		}
		else if(PlayerToPoint(3.0, playerid, 926.562072, -1075.043457, 23.885242))
		{
			if(PlayerInfo[playerid][pProfissao] != 5)    		return ErrorMsg(playerid, "Nao possui permissao.");
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(442, 926.562072, -1075.043457, 23.885242, 273.778228, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
		}
		else if(PlayerToPoint(3.0, playerid, -2074.854492, 1428.281982, 7.101562))
		{
			if(PlayerInfo[playerid][Org] != 10)    		return ErrorMsg(playerid, "Nao possui permissao.");
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(525, -2074.854492, 1428.281982, 7.101562, 170.0, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
			}
			else
			{
				InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
			}
		}
		else if(PlayerToPoint(3.0, playerid, -2033.141479, -988.619567, 32.212158))
		{
			if(PlayerInfo[playerid][Org] != 1)    		return ErrorMsg(playerid, "Nao possui permissao.");
			ShowPlayerDialog(playerid, DIALOG_VEHCORP1, DIALOG_STYLE_LIST, "Selecionar um veiculo.", "{FF0000}- {FFFFFF}CopCarla\t{FF0000}597\n{FF0000}- {FFFFFF}SwatVan\t{FF0000}601\n{FF0000}- {FFFFFF}CopBike\t{FF0000}523", "Selecionar", "X");
		}
		else if(PlayerToPoint(3.0, playerid, 1662.606811, -285.948333, 39.627510))
		{
			if(PlayerInfo[playerid][Org] != 2)    		return ErrorMsg(playerid, "Nao possui permissao.");
			ShowPlayerDialog(playerid, DIALOG_VEHCORP2, DIALOG_STYLE_LIST, "Selecionar um veiculo.", "{FF0000}- {FFFFFF}FBI Rrancher\t{FF0000}490\n{FF0000}- {FFFFFF}CopBike\t{FF0000}523", "Selecionar", "X");
		}
		else if(PlayerToPoint(3.0, playerid, -2441.137939, 522.140869, 29.486917))
		{
			if(PlayerInfo[playerid][Org] != 3)    		return ErrorMsg(playerid, "Nao possui permissao.");
			ShowPlayerDialog(playerid, DIALOG_VEHCORP3, DIALOG_STYLE_LIST, "Selecionar um veiculo.", "{FF0000}- {FFFFFF}CopCarla\t{FF0000}597\n{FF0000}- {FFFFFF}FBI Rancher\t{FF0000}490", "Selecionar", "X");
		}
		else if(PlayerToPoint(3.0, playerid, -1278.216552, 2711.282714, 50.132141))
		{
			if(PlayerInfo[playerid][Org] != 4)    		return ErrorMsg(playerid, "Nao possui permissao.");
			ShowPlayerDialog(playerid, DIALOG_VEHCORP4, DIALOG_STYLE_LIST, "Selecionar um veiculo.", "{FF0000}- {FFFFFF}CopCarla\t{FF0000}597\n{FF0000}- {FFFFFF}FBI Rancher\t{FF0000}490", "Selecionar", "X");
		}
	}
	if(newkeys == KEY_YES)
	{
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(IsBicycle(vehicleid)) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
			new id = GetVehicleID(vehicleid);
			if(GetPlayerVehicleAccess(playerid, id) < 1)
				return ErrorMsg(playerid, "Nao possui a chave do veiculo!");
			SetPVarInt(playerid, "DialogValue1", id);
			ShowDialog(playerid, DIALOG_VEHICLE);
		}
		else
		{
			//
		}
		//ESTACIONAMENTO ENTRADA
		if(IsPlayerInRangeOfPoint(playerid,2.0, 330.382019, 1843.160156, 2241.584960))
		{
			SetPlayerPos(playerid,  -1594.212402, 716.171325, -4.906250);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//ESTACIONAMENTO SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,-1594.212402, 716.171325, -4.906250))
		{
			SetPlayerPos(playerid, 330.382019, 1843.160156, 2241.584960);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//SAN NEWS ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 649.302062, -1357.399658, 13.567605))
		{
			SetPlayerPos(playerid, -5465.766113, -4536.025878, 4051.079589);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//SAN NEWS SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,-5465.766113, -4536.025878, 4051.079589))
		{
			SetPlayerPos(playerid, 649.302062, -1357.399658, 13.567605);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//PREFEITURA ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 1481.094482, -1772.313720, 18.795755))
		{
			SetPlayerPos(playerid,  -501.1714,286.6785,2001.0950);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//PREFEITURA SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,-501.1714,286.6785,2001.0950))
		{
			SetPlayerPos(playerid, 1481.094482, -1772.313720, 18.795755);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//LICENCAS ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 1081.261840, -1696.785888, 13.546875))
		{
			SetPlayerPos(playerid,  617.5486,-25.6596,1000.9903);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//LICENCAS SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,617.5486,-25.6596,1000.9903))
		{
			SetPlayerPos(playerid, 1081.261840, -1696.785888, 13.546875);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//POLICIA DE PATRULLA ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, -1605.569213, 710.272521, 13.867187))
		{
			SetPlayerPos(playerid, 350.7115,1834.2186,2241.5850);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//POLICIA DE PATRULLA SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,350.7115,1834.2186,2241.5850))
		{
			SetPlayerPos(playerid, -1605.569213, 710.272521, 13.867187);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//MERCADO NEGRO ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 2447.910644, -1962.689453, 13.546875))
		{
			SetPlayerPos(playerid,  504.942962, -2317.662597, 512.790771);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//MERCADO NEGRO SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,504.942962, -2317.662597, 512.790771))
		{
			SetPlayerPos(playerid, 2447.910644, -1962.689453, 13.546875);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//AÇOUGUE  ENTRADA
		if(IsPlayerInRangeOfPoint(playerid,2.0, 2501.888916, -1494.696533, 24.000000))
		{
			SetPlayerPos(playerid,  963.418762,2108.292480,1011.030273	);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//AÇOUGUE  SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,963.418762,2108.292480,1011.030273	))
		{
			SetPlayerPos(playerid, 2501.888916, -1494.696533, 24.000000);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		for(new c; c < MAX_CASAS; c++)
		{
			new gstring[255];
			if(IsPlayerInRangeOfPoint(playerid, 2.0, CasaInfo[c][CasaX], CasaInfo[c][CasaY], CasaInfo[c][CasaZ]))
			{
				if(!strcmp(CasaInfo[c][CasaDono], "Nenhum", true))
				{
					new stg[1100];
					format(gstring, sizeof(gstring), "{8B008B}Casa N:{FFFFFF} %d\n\n", CasaInfo[c][CasaId]);
					strcat(stg, gstring);
					format(gstring, sizeof(gstring), "{8B008B}Dono:{FFFFFF} %s\n", CasaInfo[c][CasaDono]);
					strcat(stg, gstring);
					format(gstring, sizeof(gstring), "{8B008B}Valor:{00FF00} R$%s\n\n", ConvertMoney(CasaInfo[c][CasaValor]));
					strcat(stg, gstring);
					strcat(stg, "{8B008B}01. {FFFFFF}Entrar Casa\n");
					strcat(stg, "{8B008B}02. {FFFFFF}Comprar Casa\n");
					ShowPlayerDialog(playerid, DIALOG_CASAS, DIALOG_STYLE_INPUT, "Escolher uma opcao", stg, "Selecionar", "X");
					return 1;
				}
				else
				{
					new stg[1100];
					format(gstring, sizeof(gstring), "{8B008B}Casa N:{FFFFFF} %d\n\n", CasaInfo[c][CasaId]);
					strcat(stg, gstring);
					format(gstring, sizeof(gstring), "{8B008B}Dono:{FFFFFF} %s\n", CasaInfo[c][CasaDono]);
					strcat(stg, gstring);
					format(gstring, sizeof(gstring), "{8B008B}Status:{00FF00} Aberta\n\n");
					strcat(stg, gstring);
					strcat(stg, "{8B008B}01. {FFFFFF}Entrar Casa\n");
					strcat(stg, "{8B008B}02. {FFFFFF}Comprar Casa\n");
					ShowPlayerDialog(playerid, DIALOG_CASAS, DIALOG_STYLE_INPUT, "Escolher uma opcao", stg, "Selecionar", "X");
					return 1;
				}
			}
			if(IsPlayerInRangeOfPoint(playerid, 2.0, CasaInfo[c][CasaInteriorX], CasaInfo[c][CasaInteriorY], CasaInfo[c][CasaInteriorZ]))
			{
				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);
				SetPlayerPos(playerid, CasaInfo[PlayerInfo[playerid][Entrada]][CasaX], CasaInfo[PlayerInfo[playerid][Entrada]][CasaY], CasaInfo[PlayerInfo[playerid][Entrada]][CasaZ]);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				return 1;
			} 
		}
	}
	if(newkeys == KEY_NO)
	{
		cmd_inventario(playerid);
	}
	if(newkeys == KEY_SECONDARY_ATTACK)
	{
		if(MostrandoMenu[playerid] == true)
		{
			TextDrawHideForPlayer(playerid, TDCadastro[2]);
			TextDrawHideForPlayer(playerid, TDCadastro[3]);
			for(new i=0;i<7;i++){
				PlayerTextDrawHide(playerid, TDCadastro_p[playerid][i]);
			}
			MostrandoMenu[playerid] = false;
			SalvarDadosSkin(playerid);
			CancelSelectTextDraw(playerid);
		}
		cmd_pegaritem(playerid);
		if(IsPlayerInRangeOfPoint(playerid, 2.0, -1143.184814, 2227.874511, 97.219261))
		{
			if(!CheckInventario2(playerid, 1576)) 	return ErrorMsg(playerid, "Nao possui maconha em seu inventario..");
			cmd_iniciarrotamaconha(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid, 2.0, -248.257873, 1506.404418, 75.562500))
		{
			if(!CheckInventario2(playerid, 1575)) 	return ErrorMsg(playerid, "Nao possui cocaina em seu inventario..");
			cmd_iniciarrotacocaina(playerid);
		}
		for(new i; i < 13; i++)
		if(IsPlayerInRangeOfPoint(playerid, 2.0, PosPesca[i][0], PosPesca[i][1], PosPesca[i][2])){
			cmd_pescar(playerid);
		}
		for(new i; i < 8; i++)
		if(IsPlayerInRangeOfPoint(playerid, 1, PosDesossa[i][0], PosDesossa[i][1], PosDesossa[i][2])){
			cmd_desossar(playerid);
		}
		if(PlayerToPoint(3.0, playerid, -520.421813, -504.999450, 24.635631) || PlayerToPoint(3.0, playerid, -529.748168, -504.937561, 24.640802) || PlayerToPoint(3.0, playerid, -557.552368, -505.473480, 24.596021))
		{
			cmd_carregar(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.577758, 2117.902099, 1011.030273)){
			cmd_deixarcarne(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid, 1, 1682.130737, -2326.373291, 13.546875)){
			MEGAString[0] = EOS;
			format(stringZCMD, sizeof(stringZCMD), "1* Começou agora e está perdido e não sabe o que fazer?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n2* Como faço para encontrar locais?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n3* Como faço para conseguir um emprego?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n4* Como faço para subir de level?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n5* Como faço para obter minhas licencas?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n6* Como faço para ingressar em uma organizacao?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n7* Entrei em um emprego, nao sei o que fazer!");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n8* Travo com frequencia, o que pode ser?");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n9* Estao me matando sem motivo e eu nao sei o que fazer!");
			strcat(MEGAString,stringZCMD);
			format(stringZCMD, sizeof(stringZCMD), "\n10* Fiz uma doacao e estou perdido, o que faco?");
			strcat(MEGAString,stringZCMD);
			ShowPlayerDialog(playerid,DIALOG_FAQ,DIALOG_STYLE_LIST, "FAQ", MEGAString, "Confirmar", "X");
		}
		if(IsPlayerInRangeOfPoint(playerid, 1, 938.006469, 2144.264892, 1011.023437)){
			cmd_pegarcaixa(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.416259, 2137.294921, 1011.023437)){
			cmd_empacotarcarne(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.421325, 2153.745849, 1011.023437)){
			cmd_deixarcaixa(playerid);
		}
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.288391, 2173.139404, 1011.023437)){
			cmd_pegarcaixa2(playerid);
		}
		if(PlayerToPoint(3.0, playerid, 934.1115,-1103.3857,24.3118)){
			cmd_ltumba(playerid);
		}
		if(PlayerToPoint(3.0, playerid, -5467.627441, -4536.831054, 4046.774902))
		{
			if(PlayerInfo[playerid][Org] != 11) 		return ErrorMsg(playerid, "Nao possui permissao.");
			GivePlayerWeapon(playerid, 43, 20);
		}
		if(PlayerToPoint(3.0, playerid, -2064.961181, 1434.810058, 7.101562) || PlayerToPoint(3.0, playerid, -2064.800048, 1426.759521, 7.101562) || PlayerToPoint(3.0, playerid, -2064.942382, 1417.446289, 7.101562) || PlayerToPoint(3.0, playerid, -2064.715820, 1408.081909, 7.101562) || PlayerToPoint(3.0, playerid, -2064.961425, 1399.184448, 7.101562))
		{
			if(PlayerInfo[playerid][Org] != 10) 		return ErrorMsg(playerid, "Nao possui permissao.");
			ShowPlayerDialog(playerid, DIALOG_ARMARIOMEC, DIALOG_STYLE_LIST,"Menu Mecanico", "{FFFF00}- {FFFFFF}Caixa de Ferramientas\t{32CD32}R$1200\n{FFFF00}- {FFFFFF}Ferramentas de Tunagem\t{32CD32}R$15000", "Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, -501.146118, 294.354156, 2001.094970))
		{
			ShowPlayerDialog(playerid, DIALOG_PREFEITURA, DIALOG_STYLE_LIST,"Prefeitura do Estado", "{FFFF00}- {FFFFFF}Emitir Documentos\n{FFFF00}- {FFFFFF}Emitir Cart. Trabalho", "Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, 514.767089, -2334.465820, 508.693756))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			ShowPlayerDialog(playerid, DIALOG_TIENDAILEGAL, DIALOG_STYLE_LIST,"Loja Ilegal", "{FFFF00}- {FFFFFF}Dinamite\t{32CD32}R$25000\n{FFFF00}- {FFFFFF}Sementes de Maconha\t{32CD32}R$1000\n{FFFF00}- {FFFFFF}LockPick\t{32CD32}R$15000", "Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, 1246.486816, -1675.575683, 17.028537) || PlayerToPoint(3.0, playerid, 1246.484497, -1669.351562, 17.028537) || PlayerToPoint(3.0, playerid,  1246.481811, -1662.939331, 17.028537) || PlayerToPoint(3.0, playerid, 1246.481445, -1657.370727, 17.028537) || PlayerToPoint(3.0, playerid, 1246.485839, -1651.083862, 17.028537))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			for(new i; i < 34; i++)
			{
				PlayerTextDrawShow(playerid, BancoTD[playerid][i]);
			}
			SelectTextDraw(playerid, 0xFF0000FF);
		}
		if(PlayerToPoint(3.0, playerid, 376.4162, -117.2733, 1001.4922))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			ShowPlayerDialog(playerid, DIALOG_CATLANCHE, DIALOG_STYLE_LIST, "Pizzeria", "{FFFF00}- {FFFFFF}Alimentos\n{FFFF00}- {FFFFFF}Refrescos", "Selecionar", "X");
		}
		if(PlayerToPoint(2.0, playerid, 617.928100, -1.965069, 1001.040832))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pDinheiro] < 4000)	return ErrorMsg(playerid, "Dinheiro insuficiente (R$4000).");
			if(PlayerInfo[playerid][LicencaConduzir] == 1) return ErrorMsg(playerid, "Ja possui licenca");
			new StrHab[15000];
			strcat(StrHab,  "{FFFF00}x{FFFFFF} Voce esta prestes a iniciar seu teste de conducao\n");
			strcat(StrHab,  "{FFFF00}x{FFFFFF} Para iniciar o teste, clique em {FFFFFF}'{FFFF00}COMECAR{FFFFFF}'\n");
			strcat(StrHab,  "{FFFF00}x{FFFFFF} Lembrando! Apos clicar no botao, o teste sera iniciado automaticamente.\n");
			strcat(StrHab,  "{FFFF00}x{FFFFFF} A cobrancaa sera feita assim que o teste comecar.\n");
			strcat(StrHab,  "{FFFF00}x{FFFFFF} Siga a rota sem bater ou danificar o veiculo.\n");
			ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA2, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "COMECAR","X");
		}
		if(PlayerToPoint(3.0, playerid, 1649.4332,-1889.2966,13.5878) || PlayerToPoint(3.0, playerid, 2064.6821,-1868.5961,13.5892) || PlayerToPoint(3.0, playerid, 382.9478,-1909.8621,7.8625) || PlayerToPoint(3.0, playerid, 1325.4236,-867.3035,39.6159) || PlayerToPoint(3.0, playerid, 1345.2196,-1763.8044,13.5702))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			ShowPlayerDialog(playerid, DIALOG_LOJA247, DIALOG_STYLE_LIST,"Loja de Utilidades", "{FFFF00}- {FFFFFF}Celular\t{32CD32}R$1500\n{FFFF00}- {FFFFFF}Bandagem\t{32CD32}R$200\n{FFFF00}- {FFFFFF}Vara de Pescar\t{32CD32}R$300\n{FFFF00}- {FFFFFF}Capacete\t{32CD32}R$500\n{FFFF00}- {FFFFFF}Chaira\t{32CD32}R$150", "Selecionar","X");
		}
		for(new i; i < 4; i++)
		if(PlayerToPoint(3.0, playerid, PosEquipar[i][0], PosEquipar[i][1], PosEquipar[i][2]))
		{
			if(IsPolicial(playerid))	
			{
				PlayerTextDrawShow(playerid, HudCop[playerid][0]);
				PlayerTextDrawShow(playerid, HudCop[playerid][1]);
				PlayerTextDrawShow(playerid, HudCop[playerid][2]);
				PlayerTextDrawShow(playerid, HudCop[playerid][3]);
				SelectTextDraw(playerid, 0xFF0000FF);
				return 1;
			}
			else
			{
				ErrorMsg(playerid, "Nao possui permissao.");
			}
		}
		if(GetPlayerCaixa(playerid))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			for(new i; i < 34; i++)
			{
				PlayerTextDrawShow(playerid, BancoTD[playerid][i]);
			}
			SelectTextDraw(playerid, 0xFF0000FF);
		}
		if(PlayerToPoint(3.0, playerid, 1277.651367, -1301.349487, 13.336478))
		{
			if(PlayerInfo[playerid][pProfissao] != 6) 	return ErrorMsg(playerid, "Nao possui permissao.");
			if(PegouMaterial[playerid] == true) 	return ErrorMsg(playerid, "Ja pegou um material."); 
			
			ApplyAnimation(playerid, "CARRY", "CRRY_PRTIAL", 4.1, 0, 0, 0, 1, 1, 1);
			SetPlayerCheckpoint(playerid, 1258.313720, -1263.115478, 17.821365, 1);
			SetPlayerAttachedObject(playerid, 6, 3502, 1, 0.2779, 0.4348, 0.0000, -95.3000, 0.0000, 0.0000, 0.1209, 0.0740, 0.1028);
			PegouMaterial[playerid] = true;
		}
		if(PlayerToPoint(3.0, playerid, 154.188613, -1945.949584, 4.972961))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");
			else
			{
				PlayerInfo[playerid][pProfissao] = 1;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		}
		if(PlayerToPoint(3.0, playerid, 584.859375, 877.046569, -42.497318))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");
			else
			{
				PlayerInfo[playerid][pProfissao] = 2;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 960.607055, 2097.604003, 1011.023010))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");
			else
			{
				PlayerInfo[playerid][pProfissao] = 3;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO2] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, -504.495117, -517.457763, 25.523437))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");    		
			else
			{
				if(PlayerInfo[playerid][LicencaConduzir] == 0) return ErrorMsg(playerid, "Nao possui licenca");
				if(!CheckInventario2(playerid, 19792)) 	return ErrorMsg(playerid, "Nao possui carteira de trabalho.");
				PlayerInfo[playerid][pProfissao] = 4;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO2] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 380.100067, -72.050025, 1001.507812))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");    		
			else
			{
				PlayerInfo[playerid][pProfissao] = 5;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		}
		if(PlayerToPoint(3.0, playerid, -28.763319, 1363.971313, 9.171875))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");
			else
			{
				PlayerInfo[playerid][pProfissao] = 6;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 1974.8153, -1779.7526, 13.5432))
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");
			else
			{
				if(PlayerInfo[playerid][LicencaConduzir] == 0) return ErrorMsg(playerid, "Nao possui licenca");
				PlayerInfo[playerid][pProfissao] = 7;
				SuccesMsg(playerid, "Aceitou em emprego novo.");
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 939.6504,1733.2004,8.8516)) //correios
		{
			if(PlayerInfo[playerid][pRG] == 0) 	return InfoMsg(playerid, "Nao possui RG.");
			if(PlayerInfo[playerid][pProfissao] != 0)    		return InfoMsg(playerid, "Ja possui um emprego /sairemprego.");
			else
			{
				PlayerInfo[playerid][pProfissao] = 8;
				SuccesMsg(playerid, "Voce foi contratado pela SedeX como Correios.");
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		}
	}
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	new Account[255];
	new File[255];
	format(Account, sizeof(Account), PASTA_CONTAS, Name(playerid));
	switch(dialogid)
	{		
		case DIALOG_REGISTRO:
		{
			if(!strlen(inputtext))
			{
				ErrorMsg(playerid, "Nao introduziu nada.");
				format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
				ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Eres nuevo aca.", Str, "Crear", "X");
				return 1;
			}
			if(!response)
			{
				InfoMsg(playerid, "Decidiu nao fazer Login.");
				Kick(playerid);
				return 1;
			}
			else
			{
				format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Voce e novo.", Str, "Criar", "X");
				if(strlen(inputtext) < 4 || strlen(inputtext) > 20)
				{
					ErrorMsg(playerid, "Sua senha deve ter de 4 a 20 caracteres.");
					format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
					return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Voce e novo.", Str, "Criar", "X");
				}
				new SHA256_password[85];
				format(PlayerInfo[playerid][pSenha], 20, inputtext);
				SHA256_PassHash(PlayerInfo[playerid][pSenha], passwordSalt, SHA256_password, sizeof (SHA256_password));

				new uid = GetIdfixo();
				if(!DOF2_FileExists(Account))
				{
					DOF2_CreateFile(Account); 
					DOF2_SaveFile();
					DOF2_SetString(Account, "pSenha", SHA256_password);
					DOF2_SetString(Account, "pEmail", "");
					DOF2_SetInt(Account, "IDF", uid);
					PlayerInfo[playerid][IDF] = uid;
					DOF2_SetInt(Account, "pSexo", 0);
					DOF2_SetInt(Account, "pSkin", 0);
					DOF2_SetInt(Account, "pDinheiro", 0);
					PlayerInfo[playerid][pDinheiro] = 500;
					DOF2_SetInt(Account, "pBanco", 0);
					PlayerInfo[playerid][pBanco] = 0;
					DOF2_SetInt(Account, "pIdade", 0);
					DOF2_SetInt(Account, "pSegundosJogados", 0);
					DOF2_SetInt(Account, "pAvisos", 0);
					DOF2_SetInt(Account, "pCadeia", 0);
					DOF2_SetInt(Account, "pAdmin", 0);
					DOF2_SetInt(Account, "pLastLogin", 0);
					DOF2_SetInt(Account, "pInterior", 0);
					DOF2_SetFloat(Account, "pPosX", 0);
					DOF2_SetFloat(Account, "pPosY", 0);
					DOF2_SetFloat(Account, "pPosZ", 0);
					DOF2_SetFloat(Account, "pPosA", 0);
					DOF2_SetFloat(Account, "pCamX", 0);
					DOF2_SetFloat(Account, "pCamY", 0);
					DOF2_SetFloat(Account, "pCamZ", 0);
					DOF2_SetBool(Account, "pCongelado", false);
					DOF2_SetBool(Account, "pCalado", false);
					DOF2_SetInt(Account, "pFome", 0);
					FomePlayer[playerid] = 100;
					DOF2_SetInt(Account, "pSede", 0);
					SedePlayer[playerid] = 100;
					DOF2_SetInt(Account, "pVIP", 0);
					DOF2_SetInt(Account, "pCoins", 0);
					DOF2_SetInt(Account, "pProfissao", 0);
					DOF2_SetInt(Account, "pOrg", 0);
					DOF2_SetInt(Account, "pCargo", 0);
					DOF2_SetInt(Account, "pProcurado", 0);
					DOF2_SetInt(Account, "pMultas", 0);
					DOF2_SetInt(Account, "pCasa", -1);
					DOF2_SetInt(Account, "pLevel", 0);
					DOF2_SetInt(Account, "pXP", 0);
					DOF2_SetInt(Account, "LicencaConduzir", 0);
					DOF2_SetString(Account,"pNome","");
					DOF2_SetString(Account,"pNascimento","");
					DOF2_SetString(Account,"pPai","");
					DOF2_SetString(Account,"pMae","");
					DOF2_SetInt(Account, "pRG", 0);
					DOF2_SetInt(Account, "pCarteiraT", 0);
					DOF2_SetInt(Account, "Pecas", 0);

					PlayerInfo[playerid][Casa] = -1;
					DOF2_SaveFile();
				}
				for(new i = 0; i < 23; ++i)
				{
					PlayerTextDrawHide(playerid, Registration_PTD[playerid][i]);
				}
				new tarquivo[64];
				format(tarquivo, sizeof(tarquivo), "IDs/%04d.ini",uid);
				if(!DOF2_FileExists(tarquivo))
				{
					DOF2_CreateFile(tarquivo);
					DOF2_SetString(tarquivo,"IDF de:", Name(playerid));

				}
				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### NOVO ID GERADO\n\nID: %04d\nPertence: %s", PlayerInfo[playerid][IDF],Name(playerid));
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(IDNAME, embed);
				ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "{FFFFFF}Email", "\n{FFFFFF}Digite seu email para seguir para o proximo passo do cadastro\n{FF0000}Voce deve colocar o email corretamente.", "Validar", "");
			}
		}
		case D_VOIP:{
			if(response){
				switch(listitem){
					case 0:{
						Falando[playerid] = true;
						if(Susurrando[playerid] == true){
							Susurrando[playerid] = false;
						}
						if(Gritando[playerid] == true){
							Gritando[playerid] = false;
						}
						SuccesMsg(playerid, "Voce mudou o modo do seu voip para (Falando)");
					}
					case 1:{
						Susurrando[playerid] = true;
						if(Falando[playerid] == true){
							Falando[playerid] = false;
						}
						if(Gritando[playerid] == true){
							Gritando[playerid] = false;
						}
						SuccesMsg(playerid, "Voce mudou o modo do seu voip para (Susurrando)");
					}
					case 2:{
						Gritando[playerid] = true;
						if(Falando[playerid] == true){
							Falando[playerid] = false;
						}
						if(Susurrando[playerid] == true){
							Susurrando[playerid] = false;
						}
						SuccesMsg(playerid, "Voce mudou o modo do seu voip para (Gritando)");
					}
				}
			}
		}
		case DIALOG_LOGIN:
		{
			if(!strlen(inputtext))
			{
				InfoMsg(playerid, "Introduza senha para entrar.");
				format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Confirmar", "X");
				return 1;
			}
			if(!response)
			{
				InfoMsg(playerid, "Decidiu nao fazer login.");
				Kick(playerid);
				return 1;
			}
			else
			{
				if(!checkPasswordAccount(playerid, inputtext))
				{
					format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
					ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Ingresar", "X");
					Erro[playerid]++;
					if(Erro[playerid] == 3)
					{
						InfoMsg(playerid, "Senha errada");
						Kick(playerid);
						return 1;
					}
					return 1;
				}
				else
				{
					if(DOF2_FileExists(Account))
    	            {
						format(PlayerInfo[playerid][pLastLogin], 24, DOF2_GetString(Account, "pLastLogin"));
						format(PlayerInfo[playerid][pEmail],64,DOF2_GetString(Account,"pEmail"));
						PlayerInfo[playerid][IDF] = DOF2_GetInt(Account, "IDF");
						PlayerInfo[playerid][pSkin] = DOF2_GetInt(Account, "pSkin");
						PlayerInfo[playerid][pSexo] = DOF2_GetInt(Account, "pSexo");
						SetPlayerSkin(playerid, DOF2_GetInt(Account, "pSkin"));
						PlayerInfo[playerid][pDinheiro] = DOF2_GetInt(Account, "pDinheiro");
						PlayerInfo[playerid][pBanco] = DOF2_GetInt(Account, "pBanco");
						PlayerInfo[playerid][pIdade] = DOF2_GetInt(Account, "pIdade");
						PlayerInfo[playerid][pSegundosJogados] = DOF2_GetInt(Account, "pSegundosJogados");
						PlayerInfo[playerid][pAvisos] = DOF2_GetInt(Account, "pAvisos");
						PlayerInfo[playerid][pCadeia] = DOF2_GetInt(Account, "pCadeia");
						PlayerInfo[playerid][pAdmin] = DOF2_GetInt(Account, "pAdmin");
						PlayerInfo[playerid][pInterior] = DOF2_GetInt(Account, "pInterior");
						PlayerInfo[playerid][pPosX] = DOF2_GetFloat(Account, "pPosX");
						PlayerInfo[playerid][pPosY] = DOF2_GetFloat(Account, "pPosY");
						PlayerInfo[playerid][pPosZ] = DOF2_GetFloat(Account, "pPosZ");
						PlayerInfo[playerid][pPosA] = DOF2_GetFloat(Account, "pPosA");
						PlayerInfo[playerid][pCamX] = DOF2_GetFloat(Account, "pCamX");
						PlayerInfo[playerid][pCamY] = DOF2_GetFloat(Account, "pCamY");
						PlayerInfo[playerid][pCamZ] = DOF2_GetFloat(Account, "pCamZ");
						PlayerInfo[playerid][pCongelado] = DOF2_GetBool(Account, "pCongelado");
						PlayerInfo[playerid][pCalado] = DOF2_GetBool(Account, "pCalado");
						FomePlayer[playerid] = DOF2_GetInt(Account, "pFome");
						SedePlayer[playerid] = DOF2_GetInt(Account, "pSede");
						PlayerInfo[playerid][pVIP] = DOF2_GetInt(Account, "pVIP");
						PlayerInfo[playerid][pCoins] = DOF2_GetInt(Account, "pCoins");
						PlayerInfo[playerid][pProfissao] = DOF2_GetInt(Account, "pProfissao");
						PlayerInfo[playerid][Org] = DOF2_GetInt(Account, "pOrg");
						PlayerInfo[playerid][Cargo] = DOF2_GetInt(Account, "pCargo");
						PlayerInfo[playerid][pProcurado] = DOF2_GetInt(Account, "pProcurado");
						SetPlayerWantedLevel(playerid, DOF2_GetInt(Account, "pProcurado"));
						PlayerInfo[playerid][pMultas] = DOF2_GetInt(Account, "pMultas");
						PlayerInfo[playerid][Casa] = DOF2_GetInt(Account, "pCasa");
						SetPlayerScore(playerid, DOF2_GetInt(Account, "pLevel"));
						PlayerInfo[playerid][pXP] = DOF2_GetInt(Account, "pXP");
						PlayerInfo[playerid][LicencaConduzir] = DOF2_GetInt(Account, "LicencaConduzir");
						format(PlayerInfo[playerid][pNome],80,DOF2_GetString(Account,"pNome"));
						format(PlayerInfo[playerid][pNascimento],30,DOF2_GetString(Account,"pNascimento"));
						format(PlayerInfo[playerid][pPai],80,DOF2_GetString(Account,"pPai"));
						format(PlayerInfo[playerid][pMae],80,DOF2_GetString(Account,"pMae"));
						PlayerInfo[playerid][pRG] = DOF2_GetInt(Account, "pRG");
						PlayerInfo[playerid][pCarteiraT] = DOF2_GetInt(Account, "pCarteiraT");
						PlayerInfo[playerid][PecasArma] = DOF2_GetInt(Account, "Pecas");
						DOF2_SaveFile();
						//
					}
					if(FirstLogin[playerid] == false)
					{
						ShowPlayerDialog(playerid, DIALOG_POS, DIALOG_STYLE_MSGBOX, "Voce gostaria...", "Voce gostaria de voltar a sua ultima posicao?", "Sim", "Nao");
						format(Str, sizeof(Str), "Bem vindo %04d. Seu ultimo login foi em %s.", GetPlayerIdfixo(playerid), PlayerInfo[playerid][pLastLogin]);
						InfoMsg(playerid, Str);
						if(IsPlayerMobile(playerid)){
							InfoMsg(playerid, "Voce esta conectado pelo Celular");
						}else{
							InfoMsg(playerid, "Voce esta conectado pelo Computador");
						}
					}
					else
					{ 
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 1685.698608, -2334.948730, 13.546875, 0.269069, 0, 0, 0, 0, 0, 0);
						SpawnPlayer(playerid);
						FirstLogin[playerid] = false;
					}	
					TextDrawShowForPlayer(playerid, gServerTextdraws);
					CancelSelectTextDraw(playerid);
					Timers(playerid);
					CarregarAvaliacao(playerid);
					CarregarVIP(playerid);
					MapRemocao(playerid);
					CarregarAnims(playerid);
					CriarInventario(playerid);	
					CarregarMissoes(playerid);
					CarregarArmas(playerid);
					CarregarMortos(playerid);
					CarregarGZ(playerid);
					SetPlayerVirtualWorld(playerid, 0);
					SetTimerEx("TxdLogin", 2000, false, "d",playerid);
					pLogado[playerid] = true; 
					pJogando[playerid] = true;
					Erro[playerid] = 0;
					StopAudioStreamForPlayer(playerid);
					GangZoneShowForPlayer(playerid, Parabolica, 0xFFFFFF80);
    				GangZoneShowForPlayer(playerid, Barragem, 0xFFFFFF80);
					new hora, minuto;
					gettime(hora, minuto);
					jogadoreson++;

					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"O jogador %04d entrou no servidor!\n\nJogadores **%d**/500\nHorario: %02d:%02d", PlayerInfo[playerid][IDF],jogadoreson, hora, minuto);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
					DCC_SendChannelEmbedMessage(EntradaeSaida, embed);
					new Account2[255];
					format(Account2, sizeof(Account2), "IDCONTAS/%d", GetPlayerIdfixo(playerid));
					if(!DOF2_FileExists(Account2))
					{
						DOF2_CreateFile(Account2); 
						DOF2_SaveFile();
					}
				}
			}
		}
		case DIALOG_EMAIL:
		{
			if(response)
			{
				if(strlen(inputtext) >= 13 && strlen(inputtext) <= 40)
				{
					if(strfind(inputtext,"@gmail.com",true) != -1 || strfind(inputtext,"@hotmail.com",true) != -1 || strfind(inputtext,"@outlook.com",true) != -1 || strfind(inputtext,"@yahoo.com.br",true) != -1)
					{
						if(IsValidInput(inputtext))
						{
							format(PlayerInfo[playerid][pEmail], 40, inputtext);
							actorcad[playerid] = CreateActor(0, 1984.0140,1194.2424,26.8835,135.6409);
							SetPlayerCameraPos(playerid, 1981.038940, 1191.061401, 27.828259); 
							SetPlayerCameraLookAt(playerid, 1985.139648, 1195.111572, 27.636171);
							for(new i=0;i<18;i++){
								TextDrawShowForPlayer(playerid, TDCadastro[i]);
							}
							for(new i=0;i<7;i++){
								PlayerTextDrawShow(playerid, TDCadastro_p[playerid][i]);
							}
							MostrandoMenu[playerid] = true;
							SelectTextDraw(playerid, 0xFF0000FF);
							new string[255];
							new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
							format(string,sizeof(string),"### NOVO EMAIL CADASTRADO\n\nID: %04d\nPertence: %s\nEmail: %s", PlayerInfo[playerid][IDF],Name(playerid), inputtext);
							DCC_SetEmbedColor(embed, 0xFFFF00);
							DCC_SetEmbedDescription(embed, string);
							DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
							DCC_SendChannelEmbedMessage(MAILLOG, embed);
						}
					}else{
						ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "{FFFFFF}Email", "\n{FFFFFF}Digite seu email para seguir para o proximo passo do cadastro\n{FF0000}Voce deve colocar o email corretamente.", "Validar", "");
						ErrorMsg(playerid, "Voce deve colocar um email valido");
					}
				}else{
					ErrorMsg(playerid, "Voce deve colocar um email valido");
					ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "{FFFFFF}Email", "\n{FFFFFF}Digite seu email para seguir para o proximo passo do cadastro\n{FF0000}Voce deve colocar o email corretamente.", "Validar", "");
				}
			}else{
				ShowPlayerDialog(playerid, DIALOG_EMAIL, DIALOG_STYLE_INPUT, "{FFFFFF}Email", "\n{FFFFFF}Digite seu email para seguir para o proximo passo do cadastro\n{FF0000}Voce deve colocar o email corretamente.", "Validar", "");
			}
		}
		case DIALOG_BANIDO: Kick(playerid);
		case DIALOG_POS:
		{
			if(!response)
			{
				if(PlayerInfo[playerid][Casa] >= 0)
				{
					PlayerInfo[playerid][Entrada] = PlayerInfo[playerid][Casa];
					SetPlayerPos(playerid, CasaInfo[PlayerInfo[playerid][Casa]][CasaInteriorX], CasaInfo[PlayerInfo[playerid][Casa]][CasaInteriorY], CasaInfo[PlayerInfo[playerid][Casa]][CasaInteriorZ]);
					SetPlayerInterior(playerid, CasaInfo[PlayerInfo[playerid][Casa]][CasaInterior]);
					SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][Casa]);
				}
				else if(PlayerInfo[playerid][Org] == 0)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 1685.698608, -2334.948730, 13.546875, 0.269069, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 1)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -2033.067504, -988.365112, 32.212158, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 2)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -2440.856445, 522.686523, 29.914293, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 3)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -1278.104248, 2711.379150, 50.132141, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 4)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin],  1662.559692, -285.732208, 39.607868, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 5)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin],  -789.252563, 1622.004394, 27.117187, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 6)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -2087.006591, -2544.948974, 30.625000, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 7)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 188.515975, -106.426063, 2.023437, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 8)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -96.821380, 1041.751953, 19.664335, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 9)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -2653.636474, 640.163085, 14.45312, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 10)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -2064.956787, 1389.049560, 7.101562, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 11)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 649.302062, -1357.399658, 13.567605, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 12)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], -688.271423, 938.216918, 13.632812, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				else if(PlayerInfo[playerid][Org] == 13)
				{
					SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 698.636657, 1964.867065, 5.539062, 90.036911, 0, 0, 0, 0, 0, 0);
					SpawnPlayer(playerid);
				}
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
			}
			else
			{
				SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ], PlayerInfo[playerid][pPosA], 0, 0, 0, 0, 0, 0);
				SetPlayerCameraPos(playerid, PlayerInfo[playerid][pCamX], PlayerInfo[playerid][pCamY], PlayerInfo[playerid][pCamZ]);
				SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
				SpawnPlayer(playerid);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid); 
			}
		}
		case DIALOG_BANCO4:
		{
			if(response)
			{
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				new id;
				id = strval(inputtext);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				if(!IsNumeric(inputtext)) return ErrorMsg(playerid, "Somente numeros");
				if(strlen(inputtext) > 3) return ErrorMsg(playerid, "Valor invalido.");
				foreach(Player,i)
			  	{
					if(pLogado[i] == true)
					{
						if(PlayerInfo[i][IDF] == id)
						{
							if(i == GetPlayerIdfixo(playerid)) return ErrorMsg(playerid, "Nao pode transferir para voce.");
							format(Str, sizeof(Str),"Saldo Bancario: {FFFFFF}R${32CD32}%i\n\n{FFFFFF}Transferir dinheiro a{00C2EC}%04d\n\n{FFFFFF}Quanto quer transferir?",PlayerInfo[playerid][pBanco],GetPlayerIdfixo(i));
							ShowPlayerDialog(playerid,DIALOG_BANCO5,1,"Transferir", Str, "Selecionar","Voltar");
							SetPVarInt(playerid, "IdTransferiu", i);
						}
					}
			  	}
			  	ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
		case DIALOG_BANCO5:
		{
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
			if(!IsNumeric(inputtext)) return ErrorMsg(playerid, "Somente numeros");
			if(strlen(inputtext) > 3) return ErrorMsg(playerid, "Valor invalido.");
			if(PlayerInfo[playerid][pBanco] < strval(inputtext)) return ErrorMsg(playerid, "No puede hacer tranferencia mas do que no tienes.");
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

			PlayerInfo[playerid][pBanco] -= strval(inputtext);
			PlayerInfo[PlayerInfo[GetPVarInt(playerid, "IdTransferiu")][IDF]][pBanco] += strval(inputtext);
			format(Str,sizeof(Str), "Voce recebeu R$%i, em sua conta bancaria %04d",strval(inputtext),GetPlayerIdfixo(playerid));
			InfoMsg(GetPVarInt(playerid, "IdTransferiu"), Str);
			DeletePVar(playerid, "IdTransferiu");
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
		}
		case DIALOG_SEDEX:{
			if(response){
				if(PegouVehProf[playerid] == false){
					carID[playerid] = CreateVehicle(413,981.7181,1733.6261,8.6484,-271.9456,6,16,-1,0);

					sdxobj[0] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[0], 0, "3", 60, "Webdings", 22, 0, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[0], carID[playerid], -0.965, -0.107, 0.740, 0.000, 0.000, 177.199);
					sdxobj[1] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[1], 0, "3", 60, "Webdings", 22, 0, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[1], carID[playerid], -0.968, -0.240, 0.610, 0.000, 0.000, 0.000);
					sdxobj[2] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[2], 0, "3", 60, "Webdings", 22, 0, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[2], carID[playerid], 0.992, -0.240, 0.610, 0.000, 0.000, 0.000);
					sdxobj[3] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[3], 0, "4", 60, "Webdings", 22, 0, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[3], carID[playerid], 1.006, -0.007, 0.740, 0.000, 0.000, 0.000);
					sdxobj[4] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[4], 0, "4", 60, "Webdings", 22, 0, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[4], carID[playerid], -0.144, 2.236, 0.347, -0.099, -67.499, 88.999);
					sdxobj[5] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[5], 0, "4", 60, "Webdings", 22, 0, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[5], carID[playerid], 0.082, 2.159, 0.426, -15.899, 89.599, 27.899);
					sdxobj[6] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[6], 0, "CORREIOS", 120, "Ariel", 30, 1, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[6], carID[playerid], -0.965, -1.287, 0.669, 0.199, -1.899, 179.500);
					sdxobj[7] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[7], 0, "CORREIOS", 120, "Ariel", 30, 1, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[7], carID[playerid], 0.945, -1.287, 0.662, 0.000, -7.599, 0.000);
					sdxobj[8] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[8], 0, "EMPRESA 100% BRASILEIRA", 140, "Ariel", 15, 1, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[8], carID[playerid], 1.036, -1.017, 0.338, 0.000, 0.000, 0.000);
					sdxobj[8] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[8], 0, "EMPRESA 100% BRASILEIRA", 140, "Ariel", 15, 1, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[8], carID[playerid], -1.005, -1.016, 0.338, 0.000, 0.000, -179.899);
					sdxobj[9] = CreateDynamicObject(19482,0.0,0.0,-1000.0,0.0,0.0,0.0,-1,-1,-1,300.0,300.0);
					SetDynamicObjectMaterialText(sdxobj[9], 0, "CORREIOS", 140, "Ariel", 15, 1, -16759757, 0, 1);
					AttachDynamicObjectToVehicle(sdxobj[9], carID[playerid], -0.029, 2.472, 0.343, 0.000, -71.699, 90.199);

					PutPlayerInVehicle(playerid, carID[playerid], 0);

					PegouVehProf[playerid] = true;

					SuccesMsg(playerid, "Voce pegou uma van da SedeX na garagem.");
				}else{
					for(new o=0;o<10;o++){
						DestroyDynamicObject(sdxobj[o]);
					}
					DestroyVehicle(carID[playerid]);
					PegouVehProf[playerid] = false;
					SuccesMsg(playerid, "Voce entregou uma van da SedeX na garagem.");
				}
			}
		}
		case DIALOG_SELTRABALHO:
		{
			if(response)
			{
				if(listitem == 0)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1174.452636, -1312.022338, -44.283576, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 1)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -504.495117, -517.457763, 25.523437, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 2)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 818.8176,-1106.7904,25.7940, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 3)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 376.6558,-2056.4216,8.0156, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 4)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 937.6857,-1085.2791,24.2891, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 5)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1282.408813, -1296.472167, 13.368761, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 6)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1974.8153, -1779.7526, 13.5432, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
				if(listitem == 7) //correios
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1004.1582,1755.0336,10.7734, 3.0);
					SuccesMsg(playerid, "Foi marcado no seu mapa.");
				}
			}
		}
		case DIALOG_RG1:{
			if(response){
				format(PlayerInfo[playerid][pNome],80,inputtext);
				SuccesMsg(playerid,"Voce deu seu nome para a criacao do RG");
				ShowPlayerDialog(playerid, DIALOG_RG2, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga sua data de nascimento:\nEx: 06/02/1998", "Confirmar", "Voltar");
			}
		}
		case DIALOG_RG2:{
			if(response){
				format(PlayerInfo[playerid][pNascimento],30,inputtext);
				SuccesMsg(playerid,"Voce deu sua data de nascimento para a criacao do RG");
				ShowPlayerDialog(playerid, DIALOG_RG3, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga o nome do seu pai:\nEx: Jose Ribeiro da Silva", "Confirmar", "Voltar");
			}else{
				ShowPlayerDialog(playerid, DIALOG_RG1, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga seu nome:\nEx: Marcos Junior dos Santos", "Confirmar", "X");
			}
		}
		case DIALOG_RG3:{
			if(response){
				format(PlayerInfo[playerid][pPai],80,inputtext);
				SuccesMsg(playerid,"Voce deu o nome do seu pai para a criacao do RG");
				ShowPlayerDialog(playerid, DIALOG_RG4, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga o nome da sua mae:\nEx: Maria Jose de Barros", "Confirmar", "Voltar");
			}else{
				ShowPlayerDialog(playerid, DIALOG_RG2, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga sua data de nascimento:\nEx: 06/02/1998", "Confirmar", "Voltar");
			}
		}
		case DIALOG_RG4:{
			if(response){
				format(PlayerInfo[playerid][pMae],80,inputtext);
				SuccesMsg(playerid,"Voce deu o nome da sua mae para a criacao do RG");
				SuccesMsg(playerid, "Seu RG esta sendo emitido aguarde...");
				SetTimerEx("criandorg", 7000, false, "i", playerid);
				
			}else{
				ShowPlayerDialog(playerid, DIALOG_RG3, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga o nome do seu pai:\nEx: Jose Ribeiro da Silva", "Confirmar", "Voltar");
			}
		}
		case DIALOG_CATLANCHE:
		{
			if(response)
			{
				if(listitem == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_ALIMENTOS, DIALOG_STYLE_LIST, "Alimentos", "{FFFF00}- {FFFFFF}Pizza N1\t{32CD32}R$10\n{FFFF00}- {FFFFFF}Pizza N2\t{32CD32}R$18\n{FFFF00}- {FFFFFF}Pizza N3\t{32CD32}R$25\n{FFFF00}- {FFFFFF}Pizza N4\t{32CD32}R$50", "Selecionar", #);
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_REFRECOS, DIALOG_STYLE_LIST, "Refrecos", "{FFFF00}- {FFFFFF}Agua\t{32CD32}R$2\n{FFFF00}- {FFFFFF}Suco\t{32CD32}R$5\n{FFFF00}- {FFFFFF}Sprite\t{32CD32}R$8\n{FFFF00}- {FFFFFF}Sprunk\t{32CD32}R$10", "Selecionar", #);
				}
			}
		}
		case DIALOG_ALIMENTOS:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pDinheiro] < 10) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Pizza N1.");
					PlayerInfo[playerid][pDinheiro] -= 10;
					GanharItem(playerid, 2218, 1);
					CofreRestaurante += 10;
					SalvarDinRoubos();
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 18) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Pizza N2.");
					PlayerInfo[playerid][pDinheiro] -= 18;
					GanharItem(playerid, 2355, 1);
					CofreRestaurante += 18;
					SalvarDinRoubos();
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pDinheiro] < 25) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Pizza N3.");
					PlayerInfo[playerid][pDinheiro] -= 25;
					GanharItem(playerid, 2219, 1);
					CofreRestaurante += 25;
					SalvarDinRoubos();
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pDinheiro] < 50) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Pizzza N4.");
					PlayerInfo[playerid][pDinheiro] -= 50;
					GanharItem(playerid, 2220, 1);
					CofreRestaurante += 50;
					SalvarDinRoubos();
				}
			}
		}
		case DIALOG_REFRECOS:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pDinheiro] < 2) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Agua.");
					PlayerInfo[playerid][pDinheiro] -= 2;
					GanharItem(playerid, 1484, 1);
					CofreRestaurante += 2;
					SalvarDinRoubos();
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 5) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Suco.");
					PlayerInfo[playerid][pDinheiro] -= 5;
					GanharItem(playerid, 1644, 1);
					CofreRestaurante += 5;
					SalvarDinRoubos();
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pDinheiro] < 8) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Sprite.");
					PlayerInfo[playerid][pDinheiro] -= 8;
					GanharItem(playerid, 1546, 1);
					CofreRestaurante += 8;
					SalvarDinRoubos();
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pDinheiro] < 10) 	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Voce comprou Sprunk.");
					PlayerInfo[playerid][pDinheiro] -= 10;
					GanharItem(playerid, 2601, 1);
					CofreRestaurante += 10;
					SalvarDinRoubos();
				}
			}
		}
		case DIALOG_AJUDA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					MEGAString[0] = EOS;
					format(stringZCMD, sizeof(stringZCMD), "1* Começou agora e está perdido e não sabe o que fazer?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n2* Como faço para encontrar locais?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n3* Como faço para conseguir um emprego?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n4* Como faço para subir de level?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n5* Como faço para obter minhas licencas?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n6* Como faço para ingressar em uma organizacao?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n7* Entrei em um emprego, nao sei o que fazer!");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n8* Travo com frequencia, o que pode ser?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n9* Estao me matando sem motivo e eu nao sei o que fazer!");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n10* Fiz uma doacao e estou perdido, o que faco?");
					strcat(MEGAString,stringZCMD);
					ShowPlayerDialog(playerid,DIALOG_FAQ,DIALOG_STYLE_LIST, "FAQ", MEGAString, "Confirmar", "X");
				}
				if(listitem == 1)
				{
					new stg[15000];
					strcat(stg, "{FFFF00}/report{FFFFFF} Para denunciar um jogador.\n");
					strcat(stg, "{FFFF00}/atendimento{FFFFFF} Para denunciar um jogador.\n");
					strcat(stg, "{FFFF00}/duvida{FFFFFF} Para falar no chat de duvida.\n");
					strcat(stg, "{FFFF00}/lojavip{FFFFFF} Para verificar menu de coins.\n");
					strcat(stg, "{FFFF00}/sairemprego{FFFFFF} deixar seu emprego.\n");
					strcat(stg, "{FFFF00}/pedircontas{FFFFFF} Sair de sua org.\n");
					strcat(stg, "{FFFF00}/pagar{FFFFFF} Envia dinheiro a um jogador.\n");
					strcat(stg, "{FFFF00}/maconhas{FFFFFF} Verificar plantacoes.\n");
					strcat(stg, "{FFFF00}/cmaconha{FFFFFF} Colher plantacoes.\n");
					strcat(stg, "{FFFF00}/orgs{FFFFFF} Verificar orgs.\n");
					strcat(stg, "{FFFF00}/menuanim{FFFFFF} Menu de animacoes.\n");
					strcat(stg, "{FFFF00}/missoes{FFFFFF} Menu de missoes.\n");
					strcat(stg, "{FFFF00}/minhaconta{FFFFFF} Informacoes da sua conta.\n");
					strcat(stg, "{FFFF00}/rg{FFFFFF} Ver seu registro geral.\n");
					strcat(stg, "{FFFF00}/mostrarrg{FFFFFF} Mostrar seu rg a outro jogador.\n");
					strcat(stg, "{FFFF00}/mvoip{FFFFFF} Configurar seu voip.\n");
					strcat(stg, "{FFFF00}/limparchat{FFFFFF} Limpar o seu chat.\n");
					strcat(stg, "{FFFF00}/admins{FFFFFF} Verifica admins online.\n");
					strcat(stg, "{FFFF00}/presos{FFFFFF} Verificar os presos do servidor.\n\n");
					strcat(stg, "{FFFFFF} Para cada 30min de jogo voce recebera um PayDay,\ncada PayDay lhe dara bonus nos empregos e caixa PayDay.");
					ShowPlayerDialog(playerid, DIALOG_AJUDACOMANDOS, DIALOG_STYLE_MSGBOX, "Comandos Servidor", stg, "Ok", #);
				}
				if(listitem == 2)
				{
					new Str2[1200];
					if(PlayerInfo[playerid][pProfissao] == 0)
					{
						ErrorMsg(playerid, "Voce nao possui um emprego ainda.");
					}
					if(PlayerInfo[playerid][pProfissao] == 1)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Pescador{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Passo 1:{FFFFFF} Compre uma vara de pescar na 24/7.\n{FFFF00}Passo 2:{FFFFFF} Use proximo do texto para comecar a pescar.\n{FFFF00}Passo 3:{FFFFFF} Venda os peixes na cabana ao lado.");
						ShowPlayerDialog(playerid, DIALOG_EMP1, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 2)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Minerador{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Passo 1:{FFFFFF} Use /iniciarminerador para comecar o percurso.");
						strcat(Str2, "\n{FFFF00}Passo 2:{FFFFFF} Siga todo o checkpoint ate chegar no processamento.");
						ShowPlayerDialog(playerid, DIALOG_EMP2, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 3)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Acogueiro{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Passo 1:{FFFFFF} Comece desossando a carne pendurada.");
						strcat(Str2, "\n{FFFF00}Passo 2:{FFFFFF} Coloque na maquina.");
						strcat(Str2, "\n{FFFF00}Passo 3:{FFFFFF} Pegue uma caixa.");
						strcat(Str2, "\n{FFFF00}Passo 4:{FFFFFF} Coloque a carne da maquina na caixa.");
						strcat(Str2, "\n{FFFF00}Passo 5:{FFFFFF} Leve a caixa para a outra maquina.");
						strcat(Str2, "\n{FFFF00}Passo 6:{FFFFFF} Pegue a caixa e finalize.");
						ShowPlayerDialog(playerid, DIALOG_EMP3, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 4)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Caminhoneiro{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Passo 1:{FFFFFF} Carregue seu caminhao.");
						strcat(Str2, "\n{FFFF00}Passo 2:{FFFFFF} Apos chegar no local use /descarregar.");
						ShowPlayerDialog(playerid, DIALOG_EMP4, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 6)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Coletor de Lixo{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Passo 1:{FFFFFF} Use /iniciarcoleta para comecar o percurso.");
						strcat(Str2, "\n{FFFF00}Passo 2:{FFFFFF} Colete todos os lixos e jogue nos baus de lixo.");
						ShowPlayerDialog(playerid, DIALOG_EMP2, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 8)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Correios{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Passo 1:{FFFFFF} Use /uniforme para iniciar expediente.");
						strcat(Str2, "\n{FFFF00}Passo 2:{FFFFFF} Use /garagememp para pegar uma van na garagem.");
						strcat(Str2, "\n{FFFF00}Passo 3:{FFFFFF} Use /carregar para carregar a van com os produtos para entrega.");
						//strcat(Str2, "\n{FFFF00}Passo 4:{FFFFFF} Use /iniciarentregas para comecar o percurso.");
						strcat(Str2, "\n{FFFF00}Passo 4:{FFFFFF} Entregue todas as entregas em seu determinado destino.");
						ShowPlayerDialog(playerid, DIALOG_EMP2, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][Cargo] == 2 || PlayerInfo[playerid][Cargo] == 3)
					{
						new stg[1100];
						strcat(stg, "{FFFF00}/infoorg{FFFFFF} Abrir o menu\n");
						strcat(stg, "{FFFF00}/convidar{FFFFFF} Convide um jogador para sua organizacao.\n");
						strcat(stg, "{FFFF00}/limparvagas{FFFFFF} Remova todos os membros da sua organizacao.\n");
						strcat(stg, "{FFFF00}/demitir{FFFFFF} Demitir um membro da organizacao.\n");
						strcat(stg, "{FFFF00}/promover{FFFFFF} Subir cargo de um jogador.\n");
						ShowPlayerDialog(playerid, DIALOG_AJUDAJEFORG, DIALOG_STYLE_MSGBOX, "Comandos Chefes Orgs", stg, "Ok", #);
					}
				}
				if(listitem == 4)
				{
					if(IsPolicial(playerid)) 
					{
						new stg[1100];
						strcat(stg, "{FFFF00}/d{FFFFFF} Central de Policia\n");
						strcat(stg, "{FFFF00}/algemar{FFFFFF} Colocar uma algema em um jogador.\n");
						strcat(stg, "{FFFF00}/desalgemar{FFFFFF} Remove uma algema de um jogador.\n");
						strcat(stg, "{FFFF00}/pveiculo{FFFFFF} Coloque um jogador no veiculo.\n");
						strcat(stg, "{FFFF00}/rveiculo{FFFFFF} Remova um jogador no veiculo.\n");
						strcat(stg, "{FFFF00}/prender{FFFFFF} Acorrentar um jogador.\n");
						strcat(stg, "{FFFF00}/ab{FFFFFF} Anuncia o embarque de um jogador.\n");
						strcat(stg, "{FFFF00}/su{FFFFFF} Coloque nivel de procurado.\n");
						strcat(stg, "{FFFF00}/revistar{FFFFFF} Verificar o inventario de um jogador.\n");
						strcat(stg, "{FFFF00}/rarmas{FFFFFF} Remover armas de um jogador.\n");
						strcat(stg, "{FFFF00}/procurados{FFFFFF} Todos os jogadores pesquisados.\n");
						strcat(stg, "{FFFF00}/multar{FFFFFF} Colocar uma multa em um jogador.\n");
						strcat(stg, "{FFFF00}/qplantacao{FFFFFF} Queimar uma plantacao de maconha.\n");
						strcat(stg, "{FFFF00}/verdocumentos{FFFFFF} Verificar documento de um jogador.\n");
						ShowPlayerDialog(playerid, DIALOG_AJUDAORG, DIALOG_STYLE_MSGBOX, "Comandos Organizacao", stg, "Ok", "");
					}
					if(IsBandido(playerid)) 
					{ 
						new stg[1100];
						strcat(stg, "{FFFF00}/ga{FFFFFF} Radio de gang\n");
						strcat(stg, "{FFFF00}/ab{FFFFFF} Anuncio de abordagem.\n");
						strcat(stg, "{FFFF00}/pveiculo{FFFFFF} Coloque um jogador no veiculo.\n");
						strcat(stg, "{FFFF00}/rveiculo{FFFFFF} Remova um jogador no veiculo.\n");
						strcat(stg, "{FFFF00}/revistar{FFFFFF} Verificar inventario de um jogador.\n");
						strcat(stg, "{FFFF00}/verdocumentos{FFFFFF} Verificar documento de um jogador.\n");
						ShowPlayerDialog(playerid, DIALOG_AJUDAORG, DIALOG_STYLE_MSGBOX, "Comandos Organizacao", stg, "Ok", "");
					}
				}
				if(listitem == 5)
				{
					new stg[1100];
					strcat(stg, "{FFFF00}/mv{FFFFFF} Abre um menu\n");
					strcat(stg, "{FFFF00}/localizarv{FFFFFF} Lozaliza seu veiculo no mapa.\n");
					strcat(stg, "{FFFF00}/trancar{FFFFFF} Tranque seu veiculo.\n");
					strcat(stg, "{FFFF00}/alarmev{FFFFFF} Ligue o alarme do veiculo.\n");
					strcat(stg, "{FFFF00}/mala{FFFFFF} Olhar o porta-malas do veiculo.\n");
					strcat(stg, "{FFFF00}/venderv{FFFFFF} Venda seu veiculo por um jogador.\n");
					strcat(stg, "{FFFF00}/darchaves{FFFFFF} Deixe suas chaves com um jogador.\n");
					strcat(stg, "{FFFF00}/ejetar{FFFFFF} Remova o jogador do seu veiculo.\n");
					strcat(stg, "{FFFF00}/ejetarAll{FFFFFF} Remova todos os jogadores do seu veiculo.\n");
					strcat(stg, "{FFFF00}/limparmods{FFFFFF} Limpar modificaÃ§Ãµes do seu veiculo.\n\n");
					strcat(stg, "{FFFF00}/cinto{FFFFFF} colocar cinto.\n\n");
					strcat(stg, "{FFFFFF} Alguns comandos nao ira funcionar em todos os veiculos,\nPode nao funcionar bem em veiculos que nao sao da concessionaria.");
					ShowPlayerDialog(playerid, DIALOG_AJUDAVEH, DIALOG_STYLE_MSGBOX, "Comandos Veiculo", stg, "Ok", "");
				}
				if(listitem == 6)
				{
					new stg[1100];
					strcat(stg, "{FFFF00}/pegaritem{FFFFFF} pegar um item chao.\n");
					strcat(stg, "{FFFF00}/inventario{FFFFFF} Abra e saia do inventario.\n\n");
					strcat(stg, "{FFFFFF} Voce tambem pode utilizar o F para pegar itens do chao.");
					ShowPlayerDialog(playerid, DIALOG_AJUDAINVENTARIO, DIALOG_STYLE_MSGBOX, "Comandos Inventario", stg, "Ok", "");
				}
				if(listitem == 7)
				{
					new stg[1100];
					strcat(stg, "{8B008B}/comprarcasa{FFFFFF} Compra uma Casa\n");
					strcat(stg, "{8B008B}/vendercasa{FFFFFF} Vende sua Casa\n");
					ShowPlayerDialog(playerid, DIALOG_AJUDA1, DIALOG_STYLE_MSGBOX, "Comandos Casas", stg, "Ok", "");
				}
			}
		}
		case DIALOG_FAQ:
		{
			 if(response)
			 {
				  switch(listitem)
				  {
					   case 0:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Iniciou agora, vocÃª estÃ¡ perdido e nÃ£o sabe o que fazer?","Entre em contato com nossa equipe via /report [texto] ou /duvida [texto] para falar com outras pessoas\nTeremos o maior prazer em ajudÃ¡-lo com qualquer dÃºvida\nNota : Por favor, verifique primeiro se a sua pergunta nÃ£o foi respondida abaixo em nossas Perguntas Frequentes.","Voltar","X");
					   }
					   case 1:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faÃ§o para encontrar locais?","Digite: /gps, ele criarÃ¡ um ponto vermelho no seu mapa, basta ir atÃ© lÃ¡.","Voltar","X");
					   }
					   case 2:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faÃ§o para conseguir um emprego?","Para conseguir um emprego vocÃª terÃ¡ que ir Ã  agÃªncia de empregos\nLÃ¡ vocÃª encontrarÃ¡ o 'Menu Emprego'\nVocÃª terÃ¡ que escolher um emprego e iniciar sua jornada\nNÃ£o sei onde fica a agencia? Use /gps.","Voltar","X");
					   }
					   case 3:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faÃ§o para subir de nÃ­vel?","A cada 30 minutos jogados, vocÃª ganha XP\nAo atingir o XP necessÃ¡rio para completar o prÃ³ximo nÃ­vel\nAparecerÃ¡ na tela para vocÃª comprar o nÃ­vel\nDigite: /uplvl para ver como quanto XP vocÃª precisa.","Voltar","X");
					   }
					   case 4:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faÃ§o para tirar minhas licencas?","VocÃª deve ir ao centro de habilitaÃ§Ã£o (/gps)\nAo chegar lÃ¡, vÃ¡ atÃ© o npc\nPressione F e faÃ§a o teste\nVÃ¡ devagar e nÃ£o bata o veiculo para que vocÃª nÃ£o perca.","Voltar","X");
					   }
					   case 5:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faÃ§o para entrar em alguma organizaÃ§Ã£o?","Para entrar em qualquer organizaÃ§Ã£o Ã© necessÃ¡rio fazer um teste com os lÃ­deres\nEntre no nosso discord e veja as organizaÃ§Ãµes que estÃ£o fazendo testes.","Voltar","X");
					   }
					   case 6:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Entrei em um emprego, nÃ£o sei o que fazer!","VocÃª comeÃ§ou o dia e estÃ¡ perdido? NÃ£o sabe o que fazer?\nUse:/ajuda > emprego para ver seus comandos e boa sorte.","Voltar","X");
					   }
					   case 7:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Travo com frequÃªncia, o que pode ser?","Mods de aparÃªncia de veiculos, armas, skins, podem causar crash\nEvite usÃ¡-los, alguns mods sÃ£o proibidos\nDependendo do mod, vocÃª pode sofrer puniÃ§Ãµes.","Voltar","X");
					   }
					   case 8:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"EstÃ£o me matando sem motivo e nÃ£o sei o que fazer!","Ã‰ considerado DM (Death Match) matar sem motivo\nSe isso acontecer, informe o jogador em nosso discord (discord.gg/ bBT3cT8B4Q)\nO jogador serÃ¡ devidamente punido","Voltar","X");
					   }
					   case 9:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Fiz uma doaÃ§Ã£o e estou perdido, o que faÃ§o?","ApÃ³s fazer sua doaÃ§Ã£o, vocÃª deve confirmÃ¡-la em nosso discord.","Voltar","X");
					   }
				  }
			 }
		}
		case DIALOG_GPS:
		{
			if(response)
			{
				if(listitem == 0)
				{
					new Float:a = GetPlayerDistanceFromPoint(playerid, 1481.094482, -1772.313720, 18.795755);
					new Float:b = GetPlayerDistanceFromPoint(playerid, 1284.393920, -1654.818237, 13.544199);
					new Float:c = GetPlayerDistanceFromPoint(playerid, 1638.175415, -1134.294311, 24.051120);
					new Float:d = GetPlayerDistanceFromPoint(playerid, 1649.4332,-1889.2966,13.5878);
					new Float:e = GetPlayerDistanceFromPoint(playerid, 2064.6821,-1868.5961,13.5892);
					new Float:f = GetPlayerDistanceFromPoint(playerid, 382.9478,-1909.8621,7.8625);
					new Float:g = GetPlayerDistanceFromPoint(playerid, 1081.261840, -1696.785888, 13.546875);
					new Float:h = GetPlayerDistanceFromPoint(playerid, 1317.508422, -1116.722290, 24.960447);
					new Float:i = GetPlayerDistanceFromPoint(playerid, -1973.108276, 288.896331, 35.171875);
					new Float:m = GetPlayerDistanceFromPoint(playerid, 2447.910644, -1962.689453, 13.546875);
					new Float:n = GetPlayerDistanceFromPoint(playerid, 1325.4236,-867.3035,39.6159);
					new Float:o = GetPlayerDistanceFromPoint(playerid, 1345.2196,-1763.8044,13.5702);
					MEGAString[0] = EOS;
					new string[800];
					strcat(MEGAString, "Local\tDistancia\n");
					format(string, 128, "{FFFFFF} Prefeitura \t{FFFF00} %.0f KM\n", a);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Banco Central \t{FFFF00} %.0f KM\n", b);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Hospital \t{FFFF00} %.0f KM\n", c);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Loja de Utilidades 1 \t{FFFF00} %.0f KM\n", d);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Loja de Utilidades 2 \t{FFFF00} %.0f KM\n", e);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Loja de Utilidades 3 \t{FFFF00} %.0f KM\n", f);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Loja de Utilidades 4 \t{FFFF00} %.0f KM\n", n);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Loja de Utilidades 5 \t{FFFF00} %.0f KM\n", o);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Centro de Licencas \t{FFFF00} %.0f KM\n", g);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Pizzaria \t{FFFF00} %.0f KM\n", h);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Concessionaria \t{FFFF00} %.0f KM\n", i);
					strcat(MEGAString,string);
					if(IsBandido(playerid))
					{
						format(string, 128, "{00FFFF} Navio de materiais \t{FFFF00} %.0f KM\n", m);
						strcat(MEGAString,string);
					}
					ShowPlayerDialog(playerid, DIALOG_GPS1, DIALOG_STYLE_TABLIST_HEADERS, "Locais Importantes", MEGAString, "Localizar","X");
				}
				if(listitem == 1)
				{
					new Float:a = GetPlayerDistanceFromPoint(playerid, 154.188613, -1945.949584, 4.972961);
					new Float:b = GetPlayerDistanceFromPoint(playerid, 2501.888916, -1494.696533, 24.000000);
					new Float:c = GetPlayerDistanceFromPoint(playerid, -28.763319, 1363.971313, 9.171875);
					new Float:d = GetPlayerDistanceFromPoint(playerid, 590.086975, 871.486694, -42.734603);
					new Float:e = GetPlayerDistanceFromPoint(playerid, -504.495117, -517.457763, 25.523437);
					new Float:f = GetPlayerDistanceFromPoint(playerid, 1004.1582,1755.0336,10.7734);
					MEGAString[0] = EOS;
					new string[800];
					strcat(MEGAString, "Local\tDistancia\n");
					format(string, 128, "{FFFFFF} Pescador \t{FFFF00} %.0f KM\n", a);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Acogueiro \t{FFFF00} %.0f KM\n", b);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Coletor \t{FFFF00} %.0f KM\n", c);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Minerador \t{FFFF00} %.0f KM\n", d);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Caminhoneiro \t{FFFF00} %.0f KM\n", e);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Correios \t{FFFF00} %.0f KM\n", f);
					strcat(MEGAString,string);
					ShowPlayerDialog(playerid, DIALOG_GPS2, DIALOG_STYLE_TABLIST_HEADERS, "Locais Empregos", MEGAString, "Localizar","X");
				}
				if(listitem == 2)
				{
					new Float:a = GetPlayerDistanceFromPoint(playerid, -2033.067504, -988.365112, 32.212158);
					new Float:b = GetPlayerDistanceFromPoint(playerid, -2440.856445, 522.686523, 29.914293);
					new Float:c = GetPlayerDistanceFromPoint(playerid, -1278.104248, 2711.379150, 50.132141);
					new Float:d = GetPlayerDistanceFromPoint(playerid, 1662.559692, -285.732208, 39.607868);
					new Float:e = GetPlayerDistanceFromPoint(playerid, -789.252563, 1622.004394, 27.117187);
					new Float:f = GetPlayerDistanceFromPoint(playerid, -2087.006591, -2544.948974, 30.625000);
					new Float:g = GetPlayerDistanceFromPoint(playerid, 188.515975, -106.426063, 2.023437);
					new Float:h = GetPlayerDistanceFromPoint(playerid, -96.821380, 1041.751953, 19.664335);
					new Float:i = GetPlayerDistanceFromPoint(playerid, -2653.636474, 640.163085, 14.45312);
					new Float:j = GetPlayerDistanceFromPoint(playerid, -2064.956787, 1389.049560, 7.101562);
					new Float:k = GetPlayerDistanceFromPoint(playerid, 649.302062, -1357.399658, 13.567605);
					new Float:l = GetPlayerDistanceFromPoint(playerid, -688.271423, 938.216918, 13.632812);
					new Float:m = GetPlayerDistanceFromPoint(playerid, 698.636657, 1964.867065, 5.539062);
					MEGAString[0] = EOS;
					new string[800];
					strcat(MEGAString, "Local\tDistancia\n");
					format(string, 128, "{FFFFFF} Policia Militar \t{FFFF00} %.0f KM\n", a);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Rota \t{FFFF00} %.0f KM\n", b);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Baep \t{FFFF00} %.0f KM\n", c);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} PRF \t{FFFF00} %.0f KM\n", d);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Tropa dos Azul \t{FFFF00} %.0f KM\n", e);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Tropa dos Vermelhos \t{FFFF00} %.0f KM\n", f);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Tropa dos Amarelos \t{FFFF00} %.0f KM\n", g);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Tropa dos Verdes \t{FFFF00} %.0f KM\n", h);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Medicos \t{FFFF00} %.0f KM\n", i);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Mecanico \t{FFFF00} %.0f KM\n", j);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Reportagem \t{FFFF00} %.0f KM\n", k);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Mafia Russa \t{FFFF00} %.0f KM\n", l);
					strcat(MEGAString,string);
					format(string, 128, "{FFFFFF} Moto Clube \t{FFFF00} %.0f KM\n", m);
					strcat(MEGAString,string);
					ShowPlayerDialog(playerid, DIALOG_GPS3, DIALOG_STYLE_TABLIST_HEADERS, "Locais Organizações", MEGAString, "Localizar","X");
				}
				if(listitem == 3)
				{
					ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
				}
			}
		}
		case DIALOG_GPS3:
		{
			if(response)
			{
				if(listitem == 0)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -2033.067504, -988.365112, 32.212158, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 1)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid,-2440.856445, 522.686523, 29.914293, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 2)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -1278.104248, 2711.379150, 50.132141, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 3)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1662.559692, -285.732208, 39.607868, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 4)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -789.252563, 1622.004394, 27.117187, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 5)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -2087.006591, -2544.948974, 30.625000, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 6)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 188.515975, -106.426063, 2.023437, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 7)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -96.821380, 1041.751953, 19.664335, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 8)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -2653.636474, 640.163085, 14.45312, 8.0);
					
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 9)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -2064.956787, 1389.049560, 7.101562, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 10)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 649.302062, -1357.399658, 13.567605, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 11)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -688.271423, 938.216918, 13.632812, 8.0);
					
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 12)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 698.636657, 1964.867065, 5.539062, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
			}
		}
		case DIALOG_GPS1:
		{
			if(response)
			{
				if(listitem == 0)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1481.094482, -1772.313720, 18.795755, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 1)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid,1284.393920, -1654.818237, 13.544199, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 2)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1638.175415, -1134.294311, 24.051120, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 3)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1649.4332,-1889.2966,13.5878, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 4)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 2064.6821,-1868.5961,13.5892, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 5)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 382.9478,-1909.8621,7.8625, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 6)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1325.4236,-867.3035,39.6159, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 7)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1345.2196,-1763.8044,13.5702, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 8)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1081.261840, -1696.785888, 13.546875, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 9)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1317.508422, -1116.722290, 24.960447, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 10)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -1973.108276, 288.896331, 35.171875, 8.0);
					
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 11)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 2447.910644, -1962.689453, 13.546875, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
			}
		}
		case DIALOG_GPS2:
		{
			if(response)
			{
				if(listitem == 0)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 154.188613, -1945.949584, 4.972961, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 1)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid,2501.888916, -1494.696533, 24.000000, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 2)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -28.763319, 1363.971313, 9.171875, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 3)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 590.086975, 871.486694, -42.734603, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 4)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -504.495117, -517.457763, 25.523437, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
				if(listitem == 5)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1004.1582,1755.0336,10.7734, 8.0);
					InfoMsg(playerid, "Ponto marcado no mapa.");
				}
			}
		}
		case DIALOG_LOCALIZARCASA:
		{
			if(response)
			{
				if(strlen(inputtext))
				{
					if(IsNumeric(inputtext))
					{
						new i = strval(inputtext);

						format(File, sizeof(File), PASTA_CASAS, i);
						if(DOF2_FileExists(File))
						{
							SetPlayerRaceCheckpoint(playerid, 2, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 5.0);

							new string[1200];
							format(string, sizeof(string), "Foi marcado um ponto em seu mapa a casa id: %d.", i);
							InfoMsg(playerid, string);
						}
						else
						{	
							ErrorMsg(playerid, "Este ID nao existe.");
							ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
						}
					}
					else
					{
						ErrorMsg(playerid, "Introduza somente numeros");
						ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
					}
				}
				else
				{
					ErrorMsg(playerid, "Introduza o ID para localizar.");
					ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
				}
			}
		}
		case DIALOG_CATCOINS:
		{
			if(response)
			{
				if(listitem == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_CATVIPS, DIALOG_STYLE_LIST, "CATALOGO VIP's", "{FFFF00}- {FFFFFF}VIP BASICO{32CD32}\tBC$10,000\n{FFFF00}- {FFFFFF}VIP PREMIUM{32CD32}\tBC$25,000", "Selecionar", "X");	
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_CATVEHINV, DIALOG_STYLE_LIST, "CATALOGO VEH INV", "{FFFF00}- {FFFFFF}Sultan{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}HotKnife{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}RC Bandit{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}RC Baron{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}RC Raider{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}Hotring{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}RC Goblin{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}Monster{FFFF00}\tBC$5,000", "Selecionar", "X");	
				}
				if(listitem == 2)
				{
					ShowPlayerDialog(playerid, DIALOG_CATITENS, DIALOG_STYLE_LIST, "CATALOGO ITEMS", "{FFFF00}- {FFFFFF}JetPack{FFFF00}\tBC$15,000\n{FFFF00}- {FFFFFF}Caixa Basica{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}Caixa Media{FFFF00}\tBC$10,000\n{FFFF00}- {FFFFFF}Caixa Avançada{FFFF00}\tBC$20,000\n{FFFF00}- {FFFFFF}+1 Slot Inv{FFFF00}\tBC$15,000\n{FFFF00}- {FFFFFF}Remover Advertencia{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}Titulo Personalizado{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}Troca de Skin{FFFF00}\tBC$5,000", "Selecionar", "X");	
				}
				if(listitem == 3)
				{
					new strsociogo[2500];
					strcat(strsociogo, "{fef33c}____________________________| BENEFÍCIOS VIPS |____________________________\n\n");
					strcat(strsociogo, "{2fce3c}Ao ativar (VIP BASICO):\n\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Cargo/Cor Destaque No Discord\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Previlegios no Discord\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Salario Payday\t{6d6a6d}(Valor: R$1.500)\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Veiculo de Inventario\t{6d6a6d}(Solicitar no Ticket Dsicord)\n");

					strcat(strsociogo, "\n{2fce3c}Ao ativar (VIP PREMIUM):\n\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Cargo/Cor Destaque No Discord\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Previlegios no Discord\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Salario Payday\t{6d6a6d}(Valor: R$3000)\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Veiculo de Inventario\t{6d6a6d}(Solicitar no Ticket Dsicord)\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Dobro de Dinheiro Nos Empregos\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Acesso ao /acessorios\n");
					strcat(strsociogo, "{fcfcfc}• Ficará Impune a Multas Nos Radares\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Acesso ao /mudarskin\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Acesso ao /tunagemvip\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Acesso ao /repararvip\n");
					strcat(strsociogo, "{fcfcfc}• Receberá Acesso ao /vip\n");
					strcat(strsociogo, "{fcfcfc}• Ao Morrer Não Perderar Seus Itens Valiosos\n");
					strcat(strsociogo, "{fef33c}____________________________________________________________________________");
					ShowPlayerDialog(playerid, DIALOG_BENEVIP, DIALOG_STYLE_MSGBOX, "Beneficios VIP/Sócio", strsociogo, "Voltar", "");
				}
				if(listitem == 4)
				{
					ShowPlayerDialog(playerid, DIALOG_ATIVARCOINS, DIALOG_STYLE_INPUT, "Ativação de Coins", "Insira o codigo fornecido pela administração.", "Confirmar", "X");
				}
			}
		}
		case DIALOG_CATITENS:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pCoins] < 15000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 15000;
					GanharItem(playerid, 370, 1);
					SuccesMsg(playerid, "Comprou um JetPack de Inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um JetPack\nValor: 15000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://files.prineside.com/gtasa_samp_model_id/white/370_w_s.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 3016, 1);
					SuccesMsg(playerid, "Comprou um Caixa Basica.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar uma Caixa Basica\nValor: 5000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://files.prineside.com/gtasa_samp_model_id/white/3016_w_s.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pCoins] < 10000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 10000;
					GanharItem(playerid, 3013, 1);
					SuccesMsg(playerid, "Comprou uma Caixa Media.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar uma Caixa Media\nValor: 10000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://files.prineside.com/gtasa_samp_model_id/white/3013_w_s.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pCoins] < 20000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 20000;
					GanharItem(playerid, 19056, 1);
					SuccesMsg(playerid, "Comprou uma Caixa Avancada.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar uma Caixa Avancada\nValor: 20000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://files.prineside.com/gtasa_samp_model_id/white/19056_w_s.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 4)
				{
					InfoMsg(playerid, "Item ainda nao finalizado.");
				}
				if(listitem == 5)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					PlayerInfo[playerid][pAvisos]++;
					SuccesMsg(playerid, "Comprou uma remocao de avisos.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar uma remocao de avisos\nValor: 5000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQHA21FENsrv8B6m57O1aRLc0jsOKQTkqY5Lg&usqp=CAU");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 6)
				{
					InfoMsg(playerid, "Item ainda nao finalizado.");
				}
				if(listitem == 7)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					cmd_mudarskin2(playerid);
					SuccesMsg(playerid, "Comprou uma mudanca de skin.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar uma mudanca de skins\nValor: 5000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, " ");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
			}
		}
		case DIALOG_ATIVARCOINS:
		{
			if(response)
			{
				cmd_ativarkey(playerid, inputtext);
			}
		}
		case DIALOG_CATVEHINV:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 560, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: Sultan", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_560.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 434, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: HotKnife", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_434.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 441, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 2000\nNome Veh: RC Bandit", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_441.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 464, 1);
					SuccesMsg(playerid, "Comprou um vip e recebeu seus beneficios.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 2000\nNome Veh: RC Baron", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_464.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 4)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 465, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 2000\nNome Veh: RC Raider", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_465.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 5)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 502, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: Hotring", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_502.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 6)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 501, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 2000\nNome Veh: Goblin", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_501.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 7)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 556, 1);
					SuccesMsg(playerid, "Comprou um veiculo de inventario.");
					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar um veiculo de inventario\nValor: 5000\nNome Veh: Monster", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedThumbnail(embed, "https://assets.open.mp/assets/images/vehiclePictures/Vehicle_556.jpg");
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
			}
		}
		case DIALOG_CATVIPS:
		{
			if(response)
			{
				new string[255];
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pCoins] < 10000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pCoins] -= 10000;
					PlayerInfo[playerid][ExpiraVIP] = ConvertDays(30); 
					PlayerInfo[playerid][pVIP] = 1;
					format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
					DOF2_CreateFile(string); 
					DOF2_SetInt(string,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
					DOF2_SaveFile(); 
					SuccesMsg(playerid, "Comprou um vip e recebeu seus beneficios.");
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP BASICO\nValor: 10000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pCoins] < 25000) 	return ErrorMsg(playerid, "Coins insuficiente.");
					PlayerInfo[playerid][pBanco] += 23000;
					PlayerInfo[playerid][pCoins] -= 25000;
					PlayerInfo[playerid][ExpiraVIP] = ConvertDays(30); 
					PlayerInfo[playerid][pVIP] = 2;
					format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
					DOF2_CreateFile(string); 
					DOF2_SetInt(string,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
					DOF2_SaveFile(); 
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### LOJA VIP\n\nO jogador %04d acaba de comprar VIP PREMIUM\nValor: 25000", PlayerInfo[playerid][IDF]);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SendChannelEmbedMessage(VIPAtivado, embed);
				}
			}
		}
		case DIALOG_AUTO_ESCOLA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pDinheiro] < 2000)	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					if(CheckInventario2(playerid,1853)) return ErrorMsg(playerid, "Ja possui essa licenca");
					new StrHab[15000];
					strcat(StrHab,  "{FFFF00}x{FFFFFF} VocÃª estÃ¡ prestes a iniciar um test drive\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Lembrando! ApÃ³s clicar no botÃ£o, o teste serÃ¡ iniciado automaticamente.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} A cobranÃ§a serÃ¡ feita assim que o teste comeÃ§ar.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA1, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 2500)	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					if(CheckInventario2(playerid,1854)) return ErrorMsg(playerid, "Ja possui essa licenca");
					new StrHab[15000];
					strcat(StrHab,  "{FFFF00}x{FFFFFF} VocÃª estÃ¡ prestes a iniciar um test drive\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Lembrando! ApÃ³s clicar no botÃ£o, o teste serÃ¡ iniciado automaticamente.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} A cobranÃ§a serÃ¡ feita assim que o teste comeÃ§ar.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA2, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pDinheiro] < 5000)	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					if(CheckInventario2(playerid,1855)) return ErrorMsg(playerid, "Ja possui essa licenca");
					new StrHab[15000];
					strcat(StrHab,  "{FFFF00}x{FFFFFF} VocÃª estÃ¡ prestes a iniciar um test drive\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Lembrando! ApÃ³s clicar no botÃ£o, o teste serÃ¡ iniciado automaticamente.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} A cobranÃ§a serÃ¡ feita assim que o teste comeÃ§ar.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA3, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pDinheiro] < 50000)	return ErrorMsg(playerid, "Dinheiro insuficiente.");
					if(CheckInventario2(playerid,1856)) return ErrorMsg(playerid, "Ja possui essa licenca");
					new StrHab[15000];
					strcat(StrHab,  "{FFFF00}x{FFFFFF} VocÃª estÃ¡ prestes a iniciar um test drive\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Lembrando! ApÃ³s clicar no botÃ£o, o teste serÃ¡ iniciado automaticamente.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} A cobranÃ§a serÃ¡ feita assim que o teste comeÃ§ar.\n");
					strcat(StrHab,  "{FFFF00}x{FFFFFF} Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA4, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
			}
		}
		case DIALOG_CONFIRMA_ESCOLA1:
		{
			if(response)
			{
				DisablePlayerRaceCheckpoint(playerid);
				DisablePlayerCheckpoint(playerid);
				PlayerInfo[playerid][pDinheiro] -= 2000;
				IniciouTesteHabilitacaoA[playerid] = 1;
				RotaHabilitacaoMoto[playerid] = 1;
				CheckpointPontosMoto[playerid] = 1;

				TimerTesteMoto[playerid] = SetTimerEx("VerificarTeste", 1000, true, "i", playerid);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				new indx2 = random(sizeof(SpawnAT));
				AutoEscolaMoto[playerid] = CreateVehicle(461, SpawnAT[indx2][0], SpawnAT[indx2][1], SpawnAT[indx2][2], SpawnAT[indx2][3], 6, 6, 2400000);
				SetVehicleVirtualWorld(AutoEscolaMoto[playerid], 0);
				PutPlayerInVehicle(playerid, AutoEscolaMoto[playerid], 0);

				SuccesMsg(playerid, "Va ate o ponto em seu mapa");
				GameTextForPlayer(playerid, "~w~Teste Iniciado", 5000, 0);

				SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[0][0], AutoEscolaPosicao[0][1], AutoEscolaPosicao[0][2], AutoEscolaPosicao[1][0], AutoEscolaPosicao[1][1], AutoEscolaPosicao[1][2], 7);
			}
			else
			{
				new string[1000], mercada[1000];
				strcat(string, "Habilitacion\tValor\n");
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria A\t{00FF00}R$2.000\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria B\t{00FF00}R$2.500\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria C\t{00FF00}R$5.000\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria Aerea\t{00FF00}R$50.000");
				strcat(string, mercada);

				return ShowPlayerDialog(playerid, DIALOG_AUTO_ESCOLA, DIALOG_STYLE_TABLIST_HEADERS, "Testes de {FF2400}Habilitacoes", string, "Fazer", "X");
			}
		}
		case DIALOG_CONFIRMA_ESCOLA2:
		{
			if(response)
			{
				DisablePlayerRaceCheckpoint(playerid);
				DisablePlayerCheckpoint(playerid);
				PlayerInfo[playerid][pDinheiro] -= 2500;
				IniciouTesteHabilitacaoB[playerid] = 1;
				RotaHabilitacaoVeiculo[playerid] = 1;
				CheckpointPontosVeiculo[playerid] = 1;

				TimerTesteVeiculo[playerid] = SetTimerEx("VerificarTeste", 1000, true, "i", playerid);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				new indx2 = random(sizeof(SpawnAT));
				AutoEscolaVeiculo[playerid] = CreateVehicle(410, SpawnAT[indx2][0], SpawnAT[indx2][1], SpawnAT[indx2][2], SpawnAT[indx2][3], 6, 6, 2400000);
				SetVehicleVirtualWorld(AutoEscolaVeiculo[playerid], 0);
				PutPlayerInVehicle(playerid, AutoEscolaVeiculo[playerid], 0);

				SuccesMsg(playerid, "Va ate o ponto em seu mapa");
				GameTextForPlayer(playerid, "~w~Teste Iniciado", 5000, 0);

				SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[0][0], AutoEscolaPosicao[0][1], AutoEscolaPosicao[0][2], AutoEscolaPosicao[1][0], AutoEscolaPosicao[1][1], AutoEscolaPosicao[1][2], 7);
			}
		}
		case DIALOG_CONFIRMA_ESCOLA3:
		{
			if(response)
			{
				DisablePlayerRaceCheckpoint(playerid);
				DisablePlayerCheckpoint(playerid);
				PlayerInfo[playerid][pDinheiro] -= 5000;
				IniciouTesteHabilitacaoC[playerid] = 1;
				RotaHabilitacaoCaminhao[playerid] = 1;
				CheckpointPontosCaminhao[playerid] = 1;

				TimerTesteCaminhao[playerid] = SetTimerEx("VerificarTeste", 1000, true, "i", playerid);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				new indx2 = random(sizeof(SpawnAT));
				AutoEscolaCaminhao[playerid] = CreateVehicle(456, SpawnAT[indx2][0], SpawnAT[indx2][1], SpawnAT[indx2][2], SpawnAT[indx2][3], 6, 6, 2400000);
				SetVehicleVirtualWorld(AutoEscolaCaminhao[playerid], 0);
				PutPlayerInVehicle(playerid, AutoEscolaCaminhao[playerid], 0);

				SuccesMsg(playerid, "Va ate o ponto em seu mapa");
				GameTextForPlayer(playerid, "~w~Teste Iniciado", 5000, 0);

				SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicao[0][0], AutoEscolaPosicao[0][1], AutoEscolaPosicao[0][2], AutoEscolaPosicao[1][0], AutoEscolaPosicao[1][1], AutoEscolaPosicao[1][2], 7);
			}
			else
			{
				new string[1000], mercada[1000];
				strcat(string, "Habilitacion\tValor\n");
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria A\t{00FF00}R$2.000\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria B\t{00FF00}R$2.500\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria C\t{00FF00}R$5.000\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria Aerea\t{00FF00}R$50.000");
				strcat(string, mercada);

				return ShowPlayerDialog(playerid, DIALOG_AUTO_ESCOLA, DIALOG_STYLE_TABLIST_HEADERS, "Testes de {FF2400}Habilitacoes", string, "Fazer", "X");
			}
		}
		case DIALOG_CONFIRMA_ESCOLA4:
		{
			if(response)
			{
				DisablePlayerRaceCheckpoint(playerid);
				DisablePlayerCheckpoint(playerid);
				PlayerInfo[playerid][pDinheiro] -= 50000;
				IniciouTesteHabilitacaoD[playerid] = 1;
				RotaHabilitacaoAerea[playerid] = 1;
				CheckpointPontosAerea[playerid] = 1;

				TimerTesteAerea[playerid] = SetTimerEx("VerificarTeste", 1000, true, "i", playerid);

				SetPlayerInterior(playerid, 0);
				SetPlayerVirtualWorld(playerid, 0);

				AutoEscolaAerea[playerid] = CreateVehicle(519, 2041.3486,-2593.3042,14.4689,89.1870, 6, 6, 2400000);
				SetPlayerVirtualWorld(playerid, 0);

				SuccesMsg(playerid, "Va ate o ponto em seu mapa");
				GameTextForPlayer(playerid, "~w~Teste Iniciado", 5000, 0);
				PutPlayerInVehicle(playerid, AutoEscolaAerea[playerid], 0);

				SetPlayerRaceCheckpoint(playerid, 0, AutoEscolaPosicaoAerea[0][0], AutoEscolaPosicaoAerea[0][1], AutoEscolaPosicaoAerea[0][2], AutoEscolaPosicaoAerea[1][0], AutoEscolaPosicaoAerea[1][1], AutoEscolaPosicaoAerea[1][2], 7);
			}
			else
			{
				new string[1000], mercada[1000];
				strcat(string, "Habilitacion\tValor\n");
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria A\t{00FF00}R$2.000\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria B\t{00FF00}R$2.500\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria C\t{00FF00}R$5.000\n");
				strcat(string, mercada);
				format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria Aerea\t{00FF00}R$50.000");
				strcat(string, mercada);

				return ShowPlayerDialog(playerid, DIALOG_AUTO_ESCOLA, DIALOG_STYLE_TABLIST_HEADERS, "Testes de {FF2400}Habilitacoes", string, "Fazer", "X");
			}
		}
		case DIALOG_CELULAR:
		{
			if(response)
			{
				if(listitem == 0)
				{
					format(Str, sizeof(Str),"Introduza o ID do jogador que queira transferir o dinheiro",PlayerInfo[playerid][pBanco]);
					ShowPlayerDialog(playerid,DIALOG_BANCO4,1,"Transferir", Str, "Selecionar","X");
				}
				if(listitem == 1)
				{
					format(Str, sizeof(Str),"Oque voce deseja anunciar? Seu anuncio deve conter\n74 caracteres ou nao sera enviado.");
					ShowPlayerDialog(playerid,DIALOG_ANUNCIOOLX,1,"Transferir", Str, "Selecionar","X");
				}
			}
		}
		case DIALOG_REANIMAR:
		{
			if(response)
			{
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				new id;
				id = strval(inputtext);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				if(!IsNumeric(inputtext)) return ErrorMsg(playerid, "Valor invalido.");
				foreach(Player,i)
				{
					if(pLogado[i] == true)
					{
						if(PlayerInfo[i][IDF] == id)
						{
							if(i == playerid) return ErrorMsg(playerid, "Voce nao pode se autoreanimar.");
							if (ProxDetectorS(1.5, playerid,i))
							{
								if(PlayerMorto[i][pSegMorto] == 0)
								{
									if(PlayerMorto[i][pMinMorto] == 0)
									{
										ErrorMsg(playerid, "Esse jogador nao esta inconsciente!");
										return 1;
									}
								}
								SetTimerEx("ParaDeBugaPoraaaDk", 100, 1, "i", i);
								PlayerMorto[i][pEstaMorto] = 0;
								KillTimer(TimerMorto[id]);
								SetPlayerHealth(i, 50);
								PlayerMorto[i][pMinMorto] = 0;
								PlayerMorto[i][pSegMorto] = 0;
								for(new idx=0; idx<9; idx++)
								{
									TextDrawHideForPlayer(i,TDmorte[idx]); 
								}
								PlayerTextDrawHide(i, TDmorte_p[i][0]);
								CancelSelectTextDraw(playerid);
								ClearAnimations(i, 1);
								ClearAnimations(i);
								SetPlayerPos(i, PlayerMorto[i][pPosMt1], PlayerMorto[i][pPosMt2], PlayerMorto[i][pPosMt3]);
								return 1;
							}
							ErrorMsg(playerid, "Voce nao esta proximo a um jogador!");
						}
					}
					else
					{
						ErrorMsg(playerid, "Jogador nao conectado.");
					}
				}
			}
		}
		case DIALOG_CARGA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SuccesMsg(playerid, "Seu caminhao foi carregado para Ind. Solarin!");
					SuccesMsg(playerid, "Foi marcado um ponto para descarregar.");
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -1823.9757,54.3441,15.1228, 10.0);
				}
				if(listitem == 1)
				{
					SuccesMsg(playerid, "Seu caminhao foi carregado para Michelin Pneus!");
					SuccesMsg(playerid, "Foi marcado um ponto para descarregar.");
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1635.2142,2192.1284,11.4099, 10.0);
				}
				if(listitem == 2)
				{
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					SuccesMsg(playerid, "Seu caminhao foi carregado para Sprunk!");
					SuccesMsg(playerid, "Foi marcado um ponto para descarregar.");
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1338.3881,286.8327,20.1563, 10.0);
				}
				if(listitem == 3)
				{
					SuccesMsg(playerid, "Seu caminhao foi carregado para Xoomer!");
					SuccesMsg(playerid, "Foi marcado um ponto para descarregar.");
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 219.3734,9.5520,3.1495, 10.0);
				}
				if(listitem == 4)
			   {
					SuccesMsg(playerid, "Seu caminhao foi carregado para FlaischBerg!");
					SuccesMsg(playerid, "Foi marcado um ponto para descarregar.");
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -225.2885,-209.2343,2.0181, 10.0);
				}
			}
			else
			{
				ErrorMsg(playerid, "VocÃª tem entregas nÃ£o selecionadas.");
			}
		}
		case DIALOG_CONVITE:
		{
			new String[258];
			if(response)
			{
				PlayerInfo[playerid][Org] = PlayerInfo[playerid][convite];
				PlayerInfo[playerid][Cargo] = 1;
				format(String,sizeof(String),"Acaba de entrar na organizacao{FFFF00} (%s)",NomeOrg(playerid));
				InfoMsg(playerid, String);
				format(String,sizeof(String),"%04d acaba de entrar na sua organizaccao (%s)",PlayerInfo[playerid][IDF],NomeOrg(playerid));
				InfoMsg(PlayerInfo[playerid][convite],String);
				PlayerInfo[playerid][convite] = 0;
				convidarmembro(playerid, PlayerInfo[playerid][Org]);
				MissaoPlayer[playerid][MISSAO13] = 1;
			}
			if(!response)
			{
				format(String,sizeof(String),"%04d Recusou o convite para org (%s)",PlayerInfo[playerid][IDF],NomeOrg(playerid));
				InfoMsg(PlayerInfo[playerid][convite], String);
				format(String,sizeof(String),"Recusou o convite para sua organizacao (%s)",NomeOrg(playerid));
				InfoMsg(playerid, String);
				PlayerInfo[playerid][convite] = 0;
			}
		}
		case DIALOG_LTAGS:
		{
			new string[128], StringContas[500];
			format(StringContas, sizeof(StringContas), PASTA_CONTAS,inputtext);
			if(response == 1)
			{
				if(DOF2_FileExists(StringContas))
				{
					format(string,sizeof(string),"Membro %s cargo foi removido!..", inputtext);
					InfoMsg(playerid, string);
					DOF2_SetInt(StringContas, "pOrg", 0);
					DOF2_SaveFile();
				}
				else
				{
					format(string,sizeof(string),"Conta: %s nao encontrada!", inputtext);
					InfoMsg(playerid, string);
				}
			}
		}
		case DIALOG_ROPACOP:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SetPlayerSkin(playerid, 265);
				}
				if(listitem == 1)
				{
					SetPlayerSkin(playerid, 266);
				}
				if(listitem == 2)
				{
					SetPlayerSkin(playerid, 267);
				}
				if(listitem == 3)
				{
					SetPlayerSkin(playerid, 280);
				}
				if(listitem == 4)
				{
					SetPlayerSkin(playerid, 281);
				}
				if(listitem == 5)
				{
					SetPlayerSkin(playerid, 282);
				}
				if(listitem == 6)
				{
					SetPlayerSkin(playerid, 283);
				}
				if(listitem == 7)
				{
					SetPlayerSkin(playerid, 284);
				}
				if(listitem == 8)
				{
					SetPlayerSkin(playerid, 285);
				}
				if(listitem == 9)
				{
					SetPlayerSkin(playerid, 288);
				}
				if(listitem == 10)
				{
					SetPlayerSkin(playerid, 300);
				}
				if(listitem == 11)
				{
					SetPlayerSkin(playerid, 301);
				}
				if(listitem == 12)
				{
					SetPlayerSkin(playerid, 302);
				}
				if(listitem == 13)
				{
					SetPlayerSkin(playerid, 306);
				}
				if(listitem == 14)
				{
					SetPlayerSkin(playerid, 307);
				}
				if(listitem == 15)
				{
					SetPlayerSkin(playerid, 309);
				}
				if(listitem == 16)
				{
					SetPlayerSkin(playerid, 310);
				}
				if(listitem == 17)
				{
					SetPlayerSkin(playerid, 311);
				}
				if(listitem == 18)
				{
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				}
			}
		}
		case DIALOG_COFREORG:
		{
			if(response)
			{
				if(listitem == 0)
				{
					ShowPlayerDialog(playerid, DIALOG_COFREORG1, DIALOG_STYLE_LIST, "Selecionar una opcion", "{FFFF00}- {FFFFFF}Sacar\n", "Selecionar", "X");
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_COFREORG2, DIALOG_STYLE_LIST, "Selecionar una opcion", "{FFFF00}- {FFFFFF}Sacar\n", "Selecionar", "X");
				}
				if(listitem == 2)
				{
					ShowPlayerDialog(playerid, DIALOG_COFREORG3, DIALOG_STYLE_LIST, "Selecionar una opcion", "{FFFF00}- {FFFFFF}Sacar\n", "Selecionar", "X");
				}
				if(listitem == 3)
				{
					ShowPlayerDialog(playerid, DIALOG_COFREORG4, DIALOG_STYLE_LIST, "Selecionar una opcion", "{FFFF00}- {FFFFFF}Sacar\n", "Selecionar", "X");
				}
			}
		}
		case DIALOG_COFREORG1:
		{
			if(response)
			{
				new string[300];
				new org = GetPlayerOrg(playerid);
				if(listitem == 0)
				{
					format(string,sizeof(string),"Sua org tem %d de dinheiro sujo\nQuantos quer sacar?",CofreOrg[org][Dinheiro]);
					ShowPlayerDialog(playerid, DIALOG_COFREORG12, DIALOG_STYLE_INPUT, "Boveda de organizaciÃ³n", string, "Sacar", "X");
				}
			}
		}
		case DIALOG_COFREORG2:
		{
			if(response)
			{
				new string[300];
				new org = GetPlayerOrg(playerid);
				if(listitem == 0)
				{
					format(string,sizeof(string),"Sua org tem %d de maconha\nQuantos quer sacar?",CofreOrg[org][Maconha]);
					ShowPlayerDialog(playerid, DIALOG_COFREORG22, DIALOG_STYLE_INPUT, "Boveda de organizaciÃ³n", string, "Sacar", "X");
				}
			}
		}
		case DIALOG_COFREORG3:
		{
			if(response)
			{
				new string[300];
				new org = GetPlayerOrg(playerid);
				if(listitem == 0)
				{
					format(string,sizeof(string),"Sua org tem %d de cocaina\nQuantos quer sacar?",CofreOrg[org][Cocaina]);
					ShowPlayerDialog(playerid, DIALOG_COFREORG32, DIALOG_STYLE_INPUT, "Boveda de organizaciÃ³n", string, "Sacar", "X");
				}
			}
		}
		case DIALOG_COFREORG4:
		{
			if(response)
			{
				new string[300];
				new org = GetPlayerOrg(playerid);
				if(listitem == 0)
				{
					format(string,sizeof(string),"Sua org tem %d de crack\nQuantos quer sacar?",CofreOrg[org][Crack]);
					ShowPlayerDialog(playerid, DIALOG_COFREORG42, DIALOG_STYLE_INPUT, "Boveda de organizaciÃ³n", string, "Sacar", "X");
				}
			}
		}
		case DIALOG_COFREORG12:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return ErrorMsg(playerid, "Somente numeros");
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Dinheiro] > sac)
				{
					ErrorMsg(playerid, "Nao possui tudo isso.");
					return true;
				}
				if(sac > 0)
				{
					GanharItem(playerid, 1212, sac);
					SacarGranaOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d dinheiro sujo, o novo balance e %d",sac,CofreOrg[org][Dinheiro]);
					InfoMsg(playerid, string);
					return true;
				}
			}
		}
		case DIALOG_COFREORG22:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return ErrorMsg(playerid, "Somente numeros");
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Maconha] > sac)
				{
					ErrorMsg(playerid, "Nao possui tudo isso.");
					return true;
				}
				if(sac > 0)
				{
					GanharItem(playerid, 3027, sac);
					SacarMaconhaOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d maconha, o novo balance e %d",sac,CofreOrg[org][Maconha]);
					InfoMsg(playerid, string);
					return true;
				}
			}
		}
		case DIALOG_COFREORG32:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return ErrorMsg(playerid, "Somente numeros");
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Cocaina] > sac)
				{
					ErrorMsg(playerid, "Nao possui tudo isso.");
					return true;
				}
				if(sac > 0)
				{

					GanharItem(playerid, 1279, sac);
					SacarCocainaOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d cocaina, o novo balance e %d",sac,CofreOrg[org][Cocaina]);
					InfoMsg(playerid, string);
					return true;
				}
			}
		}
		case DIALOG_COFREORG42:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return ErrorMsg(playerid, "Somente numeros");
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Crack] > sac)
				{
					ErrorMsg(playerid, "Nao possui tudo isso.");
					return true;
				}
				if(sac > 0)
				{
					GanharItem(playerid, 3930, sac);
					SacarCrackOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d crack, o novo balance e %d",sac,CofreOrg[org][Crack]);
					InfoMsg(playerid, string);
					return true;
				}
			}
		}
		case DIALOG_TIENDAILEGAL:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pDinheiro] < 25000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Compro uma Dinamite.");
					PlayerInfo[playerid][pDinheiro] -= 25000;
					GanharItem(playerid, 1654, 1);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 1000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Compro uma semente.");
					PlayerInfo[playerid][pDinheiro] -= 1000;
					GanharItem(playerid, 3520, 1);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 15000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Compro uma lockpick.");
					PlayerInfo[playerid][pDinheiro] -= 15000;
					GanharItem(playerid, 11746, 1);
				}
			}
		}
		case DIALOG_LMARIHUANA:
		{
			if(!response)return true;
			new id = LocalizeMaconha[listitem+1][playerid];
			SetPlayerCheckpoint(playerid, MaconhaInfo[id][mX],MaconhaInfo[id][mY],MaconhaInfo[id][mZ], 5.0);
			SuccesMsg(playerid, "Sua plantacao foi marcada");
			return true;
		}
		case DIALOG_LTUMBA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SuccesMsg(playerid, "Foi marcado um ponto no mapa.");
					ltumba[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1173.5168,-1308.6056,13.6994, 10.0);
				}
				if(listitem == 1)
				{
					SuccesMsg(playerid, "Foi marcado um ponto no mapa.");
					ltumba[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1609.8369,1823.2799,10.5249, 10.0);
				}
				if(listitem == 2)
				{
					SuccesMsg(playerid, "Foi marcado um ponto no mapa.");
					ltumba[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -2590.4451,643.4471,14.1566, 10.0);
				}
			}
		}
		case DIALOG_CASAS:
		{
			if(response)
			{
				if(!strcmp(inputtext, "1", true))
				{
					for(new i; i < MAX_CASAS; i++)
					{
						if(IsPlayerInRangeOfPoint(playerid, 10.0, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]))
						{
							PlayerInfo[playerid][Entrada] = i;
							MissaoPlayer[playerid][MISSAO7] = 1;
							SetPlayerInterior(playerid, CasaInfo[i][CasaInterior]);
							SetPlayerVirtualWorld(playerid, i);
							SetPlayerPos(playerid, CasaInfo[i][CasaInteriorX], CasaInfo[i][CasaInteriorY], CasaInfo[i][CasaInteriorZ]);
							TogglePlayerControllable(playerid, false);
							SetTimerEx("carregarobj", 5000, 0, "i", playerid);
							return 1;
						}
					}
				}
				else if(!strcmp(inputtext, "2", true))
				{
					new gstring[255];
					for(new i = 0; i < MAX_CASAS; i++)
					{
						if(IsPlayerInRangeOfPoint(playerid, 10.0, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]))
						{
							if(!strcmp(CasaInfo[i][CasaDono], Name(playerid), false))
							{
								ErrorMsg(playerid, "Essa casa ja e sua.");
								return 1;
							}
							else if(CasaInfo[i][CasaAVenda] == 0)
							{
								ErrorMsg(playerid, "Casa nao esta a venda.");
								return 1;
							}
							else if(PlayerInfo[playerid][Casa] > -1)
							{
								ErrorMsg(playerid, "Ja possui uma casa");
								return 1;
							}
							else if(PlayerInfo[playerid][pDinheiro] < CasaInfo[i][CasaValor])
							{
								return ErrorMsg(playerid, "Dinheiro insuficiente.");
							}
							else
							{
								new location[MAX_ZONE_NAME];
								GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);

								format(File, sizeof(File), PASTA_CONTAS, CasaInfo[i][CasaDono]);
								format(gstring, sizeof(gstring), "Compro casa id %d e pagou R$%d.", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
								SuccesMsg(playerid, gstring);

								PlayerInfo[playerid][pDinheiro] -= CasaInfo[i][CasaValor];
								PlayerInfo[playerid][Casa] = i;

								format(File, sizeof(File), PASTA_CONTAS, Name(playerid));
								DOF2_SetInt(File, "Casa", i);
								DOF2_SaveFile();

								format(File, sizeof(File), PASTA_CASAS, i);
								if(DOF2_FileExists(File))
								{
									new Float:X, Float:Y, Float:Z;
									GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
									DOF2_CreateFile(File);
									DOF2_SetString(File, "CasaDono", Name(playerid));
									DOF2_SetString(File, "CasaTexto", "Nenhum");
									DOF2_SetInt(File, "CasaAVenda", 0);
									DOF2_SetInt(File, "CasaPickup", 1272);
									DOF2_SetInt(File, "CasaMapIcon", 32);
									DOF2_SetInt(File, "CasaAVenda", 0);
									DOF2_SaveFile();

									format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
									CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
									CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");

									DestroyDynamicPickup(PickupCasa[i]);
									DestroyDynamicMapIcon(MapIconCasa[i]);

									PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
									MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
									new string[5000];
									format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
									TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
									return 1;
								}
							}
						}
					}
				}
			}
		}
		case DIALOG_MENUANIM:
		{
			if(response)
			{
				if(listitem == 0)
				{
					ClearAnimations(playerid);
					SetPlayerSpecialAction(playerid,SPECIAL_ACTION_HANDSUP);
					SuccesMsg(playerid, "Iniciou uma animacao.");
				}
				if(listitem == 1)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.0, 0, 0, 0, 1, 0, 1);
					SuccesMsg(playerid, "Iniciou uma animacao.");
				}
				if(listitem == 2)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "BEACH", "bather", 4.0, 0, 0, 0, 1, 0, 1);
					SuccesMsg(playerid, "Iniciou uma animacao.");
				}
				if(listitem == 3)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "ped", "ARRESTgun", 4.0, 0, 0, 0, 1, 0, 1);
					SuccesMsg(playerid, "Iniciou uma animacao.");
				}
				if(listitem == 4)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "ped", "cower", 4.0, 0, 0, 0, 1, 0, 1);
					SuccesMsg(playerid, "Iniciou uma animacao.");
				}
				if(listitem == 5)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 1, 0, 1);
					SuccesMsg(playerid, "Iniciou uma animacao.");
				}
				if(listitem == 6)
				{
					ClearAnimations(playerid);
					SuccesMsg(playerid, "Parou a animacao.");
				}
			}
		}
		case DIALOG_ARMARIOMEC:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pDinheiro] < 1200) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					PlayerInfo[playerid][pDinheiro] -= 1200;
					GanharItem(playerid, 19921, 1);
					SuccesMsg(playerid, "Comprou uma caixa de ferramientas.");
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 15000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					PlayerInfo[playerid][pDinheiro] -= 15000;
					GanharItem(playerid, 1010, 1);
					SuccesMsg(playerid, "Comprou una kit de tunagem.");
				}
			}
		}
		case DIALOG_MISSOES:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(MissaoPlayer[playerid][MISSAO1] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO1] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO1] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 1)
				{
					if(MissaoPlayer[playerid][MISSAO2] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO2] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO2] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 2)
				{
					if(MissaoPlayer[playerid][MISSAO3] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO3] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO3] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 3)
				{
					if(MissaoPlayer[playerid][MISSAO4] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO4] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500.");
						PlayerInfo[playerid][pDinheiro] = 500;
						MissaoPlayer[playerid][CMISSAO4] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 4)
				{
					if(MissaoPlayer[playerid][MISSAO5] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO5] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO5] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 5)
				{
					if(MissaoPlayer[playerid][MISSAO6] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO6] != 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO6] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 6)
				{
					if(MissaoPlayer[playerid][MISSAO7] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO7] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500.");
						PlayerInfo[playerid][pDinheiro] = 500;
						MissaoPlayer[playerid][CMISSAO7] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 7)
				{
					if(MissaoPlayer[playerid][MISSAO8] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO8] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO8] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 8)
				{
					if(MissaoPlayer[playerid][MISSAO9] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO9] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$15000.");
						PlayerInfo[playerid][pDinheiro] += 15000;
						MissaoPlayer[playerid][CMISSAO9] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 9)
				{
					if(MissaoPlayer[playerid][MISSAO10] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO10] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO10] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 10)
				{
					if(MissaoPlayer[playerid][MISSAO11] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO11] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500 expericencia.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO11] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 11)
				{
					if(MissaoPlayer[playerid][MISSAO12] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO12] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500.");
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO12] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
				if(listitem == 12)
				{
					if(MissaoPlayer[playerid][MISSAO13] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO13] == 1) return ErrorMsg(playerid, "Missao completa");
						SuccesMsg(playerid, "Completou a missao e ganhou R$500.");
						PlayerInfo[playerid][pDinheiro] = 500;
						MissaoPlayer[playerid][CMISSAO13] = 1;
					}
					else
					{
						ErrorMsg(playerid, "Missao ainda nao completada.");
					}
				}
			}
		}
		case DIALOG_ERROR:
		{
			ShowDialog(playerid, DialogReturn[playerid]);
			DialogReturn[playerid] = dialogid;
			return 1;
		}
		case DIALOG_VEHICLE:
		{
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						new vehicle = GetPlayerVehicleID(playerid);
						new Float:vida;
						GetVehicleHealth(vehicle, vida);
						new vehicleid = GetPlayerVehicleID(playerid);
						new engine, lights, alarm, doors, bonnet, boot, objective;
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						if(engine == 0 && Fuel[vehicleid] <= 0)
						{
							ShowErrorDialog(playerid, "Veiculo sem combustivel");
							return 1;
						}
						if(vida < 300.0)
						{
							GetVehicleParamsEx(vehicle,engine,lights,alarm,doors,bonnet,boot,objective);
							SetVehicleParamsEx(vehicle,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
							RepairCar[playerid] = GetPlayerVehicleID(playerid);
							SetVehicleHealth(RepairCar[playerid], 280.0);
							ShowErrorDialog(playerid, "Veiculo quebrado\nchame um mecanico");
							RemovePlayerFromVehicle(playerid);
							return 1;
						}
						if(engine == 1) { engine = 0; lights = 0; }
						else { engine = 1; lights = 1; }
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					}
					case 1:
					{
						new vehicleid = GetPlayerVehicleID(playerid);
						new engine, lights, alarm, doors, bonnet, boot, objective;
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						if(lights == 1) lights = 0; else lights = 1;
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					}
					case 2:
					{
						new vehicleid = GetPlayerVehicleID(playerid);
						new engine, lights, alarm, doors, bonnet, boot, objective;
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						if(bonnet == 1) bonnet = 0; else bonnet = 1;
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					}
					case 3:
					{
						new vehicleid = GetPlayerVehicleID(playerid);
						new engine, lights, alarm, doors, bonnet, boot, objective;
						GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
						if(boot == 1) boot = 0; else boot = 1;
						SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
					}
					case 4:
					{
						if(!GetPVarInt(playerid, "GasCan"))
						{
							ShowErrorDialog(playerid, "Nao possui uma lata de gasolina!");
							return 1;
						}
						new vehicleid = GetPlayerVehicleID(playerid);
						if(Fuel[vehicleid] < 80.0) Fuel[vehicleid] += 20.0;
						else Fuel[vehicleid] = 100.0;
						SetPVarInt(playerid, "GasCan", 0);
						InfoMsg(playerid, "Encheu 20L no seu tanque.");
					}
					case 5:
					{
						new id = GetPVarInt(playerid, "DialogValue1");
						if(GetPlayerVehicleAccess(playerid, id) < 2)
						{
							ShowErrorDialog(playerid, "Voce nao e dono do veiculo.");
							return 1;
						}
						new msg[128];
						VehicleCreated[id] = 0;
						new money = VehicleValue[id]/2;
						PlayerInfo[playerid][pDinheiro] += money;
						format(msg, sizeof(msg), "Vendeu o veiculo por R$%d", money);
						SuccesMsg(playerid, msg);
						RemovePlayerFromVehicle(playerid);
						DestroyVehicle(VehicleID[id]);
						SaveVehicle(id);
					}
					case 6:
					{
						new vehicleid = GetPVarInt(playerid, "DialogValue1");
						if(GetPlayerVehicleAccess(playerid, vehicleid) < 2)
						{
							ShowErrorDialog(playerid, "Voce nao e dono deste veiculo!");
							return 1;
						}
						GetVehiclePos(VehicleID[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1], VehiclePos[vehicleid][2]);
						GetVehicleZAngle(VehicleID[vehicleid], VehiclePos[vehicleid][3]);
						VehicleInterior[vehicleid] = GetPlayerInterior(playerid);
						VehicleWorld[vehicleid] = GetPlayerVirtualWorld(playerid);
						SuccesMsg(playerid, "Veiculo estacionado.");
						UpdateVehicle(vehicleid, 1);
						PutPlayerInVehicle(playerid, VehicleID[vehicleid], 0);
						SaveVehicle(vehicleid);
					}
					case 7:
					{
						ShowDialog(playerid, DIALOG_VEHICLE_PLATE);
					}
				}
			}
			return 1;
		}
		case DIALOG_VEHICLE_BUY:
		{
			if(response)
			{
				if(GetPlayerVehicles(playerid) >= MAX_PLAYER_VEHICLES)
				{
					ShowErrorDialog(playerid, "Nao pode comprar mais veiculo:" #MAX_PLAYER_VEHICLES );
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
				new id = GetPVarInt(playerid, "DialogValue1");
				if(PlayerInfo[playerid][pDinheiro] < VehicleValue[id])
				{
					ShowErrorDialog(playerid, "Dinheiro insuficiente");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
				new freeid = GetFreeVehicleID();
				if(!freeid)
				{
					ShowErrorDialog(playerid, "Veiculos esgotados");
					RemovePlayerFromVehicle(playerid);
					return 1;
				}
				PlayerInfo[playerid][pDinheiro] -= VehicleValue[id];
				new dealerid = strval(VehicleOwner[id]);
				VehicleCreated[freeid] = VEHICLE_PLAYER;
				VehicleModel[freeid] = VehicleModel[id];
				VehiclePos[freeid] = DealershipPos[dealerid];
				VehicleColor[freeid] = VehicleColor[id];
				VehicleInterior[freeid] = VehicleInterior[id];
				VehicleWorld[freeid] = VehicleWorld[id];
				VehicleValue[freeid] = VehicleValue[id];
				GetPlayerName(playerid, VehicleOwner[freeid], sizeof(VehicleOwner[]));
				VehicleNumberPlate[freeid] = PLACA_CONCESSIONARIA;
				for(new d=0; d < sizeof(VehicleTrunk[]); d++)
				{
					VehicleTrunk[freeid][d][0] = 0;
					VehicleTrunk[freeid][d][1] = 0;
				}
				for(new d=0; d < sizeof(VehicleMods[]); d++)
				{
					VehicleMods[freeid][d] = 0;
				}
				VehiclePaintjob[freeid] = 255;
				VehicleLock[freeid] = 0;
				VehicleAlarm[freeid] = 0;
				UpdateVehicle(freeid, 0);
				SaveVehicle(freeid);
				new msg[128];
				format(msg, sizeof(msg), "Voce comprou este veiculo por R$%d", VehicleValue[id]);
				SuccesMsg(playerid, msg);
				RemovePlayerFromVehicle(playerid);
			}
			else
			{
				new id = GetPVarInt(playerid, "DialogValue1");
				if(GetPlayerVehicleAccess(playerid, id) < 1)
				{
					RemovePlayerFromVehicle(playerid);
				}
			}
			return 1;
		}
		case DIALOG_VEHICLE_SELL:
		{
			if(response)
			{
				if(GetPlayerVehicles(playerid) >= MAX_PLAYER_VEHICLES)
				{
					ShowErrorDialog(playerid, "Nao pode comprar mas veiculos! max.:" #MAX_PLAYER_VEHICLES );
					return 1;
				}
				new targetid = GetPVarInt(playerid, "DialogValue1");
				new id = GetPVarInt(playerid, "DialogValue2");
				new price = GetPVarInt(playerid, "DialogValue3");
				if(PlayerInfo[playerid][pDinheiro] < price)
				{
					ShowErrorDialog(playerid, "Dinheiro insuficiente");
					return 1;
				}
				new msg[128];
				GetPlayerName(playerid, VehicleOwner[id], sizeof(VehicleOwner[]));
				PlayerInfo[playerid][pDinheiro] -= price;
				PlayerInfo[targetid][pDinheiro] += price;
				SaveVehicle(id);
				format(msg, sizeof(msg), "Voce comprou o veiculo por R$%d", price);
				SuccesMsg(playerid, msg);
				format(msg, sizeof(msg), "%04d aceitou a oferta", PlayerInfo[playerid][IDF]);
				InfoMsg(targetid, msg);
			}
			else
			{
				new targetid = GetPVarInt(playerid, "DialogValue1");
				new msg[128];
				format(msg, sizeof(msg), " %04d recusou a oferta", PlayerInfo[playerid][IDF]);
				InfoMsg(targetid, msg);
			}
			return 1;
		}
		case DIALOG_FINDVEHICLE:
		{
			if(response)
			{
				new id;
				sscanf(inputtext[4], "d", id);
				if(IsValidVehicle1(id))
				{
					TrackCar[playerid] = VehicleID[id];
					InfoMsg(playerid, "Localizando veiculo.");
				}
			}
			return 1;
		}
		case DIALOG_TRUNK:
		{
			if(response)
			{
				SetPVarInt(playerid, "DialogValue2", listitem);
				ShowDialog(playerid, DIALOG_TRUNK_ACTION);
			}
			else
			{
				new id = GetPVarInt(playerid, "DialogValue1");
				ToggleBoot(VehicleID[id], VEHICLE_PARAMS_OFF);
			}
			return 1;
		}
		case DIALOG_TRUNK_ACTION:
		{
			if(response)
			{
				new id = GetPVarInt(playerid, "DialogValue1");
				new slot = GetPVarInt(playerid, "DialogValue2");
				switch(listitem)
				{
				case 0:
				{
					new weaponid = GetPlayerWeapon(playerid);
					if(weaponid == 0)
					{
						ShowErrorDialog(playerid, "Nao tem uma arma na sua mao!");
						return 1;
					}
					VehicleTrunk[id][slot][0] = weaponid;
					if(IsMeleeWeapon(weaponid)) VehicleTrunk[id][slot][1] = 1;
					else VehicleTrunk[id][slot][1] = GetPlayerAmmo(playerid);
					RemovePlayerWeapon(playerid, weaponid);
					SaveVehicle(id);
				}
				case 1:
				{
					if(VehicleTrunk[id][slot][1] <= 0)
					{
						ShowErrorDialog(playerid, "Este espaco esta vazio!");
						return 1;
					}
					GivePlayerWeapon(playerid, VehicleTrunk[id][slot][0], VehicleTrunk[id][slot][1]);
					VehicleTrunk[id][slot][0] = 0;
					VehicleTrunk[id][slot][1] = 0;
					SaveVehicle(id);
				}
				}
			}
			ShowDialog(playerid, DIALOG_TRUNK);
			return 1;
		}
		case DIALOG_VEHICLE_PLATE:
		{
			if(response)
			{
				if(strlen(inputtext) < 1 || strlen(inputtext) >= sizeof(VehicleNumberPlate[]))
				{
					ShowErrorDialog(playerid, "Comprimento invalido!");
					return 1;
				}
				new id = GetPVarInt(playerid, "DialogValue1");
				new vehicleid = VehicleID[id];
				strmid(VehicleNumberPlate[id], inputtext, 0, sizeof(VehicleNumberPlate[]));
				SaveVehicle(id);
				SetVehicleNumberPlate(vehicleid, inputtext);
				SetVehicleToRespawn(vehicleid);
				new msg[128];
				format(msg, sizeof(msg), "Trocou a placa do veiculo para %s", inputtext);
				SuccesMsg(playerid, msg);
			}
			else ShowDialog(playerid, DIALOG_VEHICLE);
			return 1;
		}
		case DIALOG_FUEL:
		{
			if(response)
			{
				switch(listitem)
				{
				case 0:
				{
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
					{
						ShowErrorDialog(playerid, "Nao esta no veiculo!");
						return 1;
					}
					new vehicleid = GetPlayerVehicleID(playerid);
					if(IsBicycle(vehicleid))
					{
						ShowErrorDialog(playerid, "Este precisa abastecer!");
						return 1;
					}
					if(Fuel[vehicleid] >= 100.0)
					{
						ShowErrorDialog(playerid, "Combustivel cheio");
						return 1;
					}
					if(PlayerInfo[playerid][pDinheiro] < PRECO_GASOLINA)
					{
						ShowErrorDialog(playerid, "Dinheiro insuficiente");
						return 1;
					}
					RefuelTime[playerid] = 5;
					SetPVarFloat(playerid, "Fuel", Fuel[vehicleid]);
					GameTextForPlayer(playerid, "~w~abastecendo...", 2000, 3);
				}
				case 1:
				{
					if(GetPVarInt(playerid, "GasCan"))
					{
						ShowErrorDialog(playerid, "Ja tem um galao de gasolina!");
						return 1;
					}
					if(PlayerInfo[playerid][pDinheiro] < PRECO_GALAO)
					{
						ShowErrorDialog(playerid, "Dinheiro insuficiente");
						return 1;
					}
					PlayerInfo[playerid][pDinheiro] -= PRECO_GALAO;
					SetPVarInt(playerid, "GasCan", 1);
					SuccesMsg(playerid, "Comprou um galao.");
				}
				}
			}
			return 1;
		}
		case DIALOG_EDITVEHICLE:
		{
			if(response)
			{
				new id = GetPVarInt(playerid, "DialogValue1");
				new nr, params[128];
				sscanf(inputtext, "ds", nr, params);
				switch(nr)
				{
					case 1:
					{
						new value = strval(params);
						if(value < 0) value = 0;
						VehicleValue[id] = value;
						UpdateVehicleLabel(id, 1);
						SaveVehicle(id);
						ShowDialog(playerid, DIALOG_EDITVEHICLE);
					}
					case 2:
					{
						new value;
						if(IsNumeric(params)) value = strval(params);
						else value = GetVehicleModelIDFromName(params);
						if(value < 400 || value > 611)
						{
							ShowErrorDialog(playerid, "Modelo de veiculo no valido!");
							return 1;
						}
						VehicleModel[id] = value;
						for(new i=0; i < sizeof(VehicleMods[]); i++)
						{
							VehicleMods[id][i] = 0;
						}
						VehiclePaintjob[id] = 255;
						UpdateVehicle(id, 1);
						SaveVehicle(id);
						ShowDialog(playerid, DIALOG_EDITVEHICLE);
					}
					case 3:
					{
						new color1, color2;
						sscanf(params, "dd", color1, color2);
						VehicleColor[id][0] = color1;
						VehicleColor[id][1] = color2;
						SaveVehicle(id);
						ChangeVehicleColor(VehicleID[id], color1, color2);
						ShowDialog(playerid, DIALOG_EDITVEHICLE);
					}
					case 4:
					{
						if(strlen(params) < 1 || strlen(params) > 8)
						{
							ShowErrorDialog(playerid, "Longitud no valida!");
							return 1;
						}
						strmid(VehicleNumberPlate[id], params, 0, sizeof(params));
						SaveVehicle(id);
						SetVehicleNumberPlate(VehicleID[id], params);
						SetVehicleToRespawn(VehicleID[id]);
						ShowDialog(playerid, DIALOG_EDITVEHICLE);
					}
					case 5:
					{
						DestroyVehicle(VehicleID[id]);
						if(VehicleCreated[id] == VEHICLE_DEALERSHIP)
						{
							Delete3DTextLabel(VehicleLabel[id]);
						}
						VehicleCreated[id] = 0;
						SaveVehicle(id);
						new msg[128];
						format(msg, sizeof(msg), "Ha eliminado el veiculo %d", id);
						SuccesMsg(playerid, msg);
					}
					case 6:
					{
						if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
						{
							ShowErrorDialog(playerid, "Usted no estÃ¡ conduciendo el vehiculo!");
							return 1;
						}
						GetVehiclePos(VehicleID[id], VehiclePos[id][0], VehiclePos[id][1], VehiclePos[id][2]);
						GetVehicleZAngle(VehicleID[id], VehiclePos[id][3]);
						VehicleInterior[id] = GetPlayerInterior(playerid);
						VehicleWorld[id] = GetPlayerVirtualWorld(playerid);
						SuccesMsg(playerid, "Estaciono este veiculo aca.");
						UpdateVehicle(id, 1);
						PutPlayerInVehicle(playerid, VehicleID[id], 0);
						SaveVehicle(id);
						ShowDialog(playerid, DIALOG_EDITVEHICLE);
					}
					case 7:
					{
						new Float:x, Float:y, Float:z;
						GetVehiclePos(VehicleID[id], x, y, z);
						SetPlayerPos(playerid, x, y, z+1);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						new msg[128];
						format(msg, sizeof(msg), "Te has teletransportado a veiculo %d", id);
						SuccesMsg(playerid, msg);
					}
				}
			}
			return 1;
		}
		case DIALOG_AVALIAR:
		{
			if(response)
			{
				PlayerInfo[playerid][pAvaliacao] += 1;
				SuccesMsg(playerid, "Voce decidiu dar ponto de avaliacao para o administrador.");
			}
			else
			{
				SuccesMsg(playerid, "Voce decidiu nao dar ponto de avaliacao para o administrador.");
			}
		}
		case DIALOG_TELEPORTARMAP:
		{
			if(response)
			{
				if(PlayerInfo[playerid][pAdmin] > 0)
				{
					SetPlayerPos(playerid, GetPVarFloat(playerid, "FindX"), GetPVarFloat(playerid, "FindY"), GetPVarFloat(playerid, "FindZ")+4);
				}
			}
			return true;
		}
		case DIALOG_VEHCORP1:
		{
			if(response)
			{
				if(listitem == 0)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(597, X, Y, Z, ROT, 127, 152, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
				if(listitem == 1)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(601, X, Y, Z, ROT, 127, 152, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
				if(listitem == 2)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(523, X, Y, Z, ROT, 127, 152, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
			}
		}
		case DIALOG_VEHCORP2:
		{
			if(response)
			{
				if(listitem == 0)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(490, X, Y, Z, ROT, 6, 152, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
				if(listitem == 1)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(523, X, Y, Z, ROT, 6, 152, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
			}
		}
		case DIALOG_VEHCORP3:
		{
			if(response)
			{
				if(listitem == 0)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(597, X, Y, Z, ROT, 0, 0, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
				if(listitem == 1)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(490, X, Y, Z, ROT, 0, 0, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
			}
		}
		case DIALOG_VEHCORP4:
		{
			if(response)
			{
				if(listitem == 0)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(597, X, Y, Z, ROT, 34, 34, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
				if(listitem == 1)
				{
					new Float:X,Float:Y,Float:Z,Float:ROT;
					GetPlayerPos(playerid,X,Y,Z);
					GetPlayerFacingAngle(playerid,ROT);
					if(VehAlugado[playerid] == 0)
					{
						VehAlugado[playerid] = 1;
						VeiculoCivil[playerid] = CreateVehicle(490, X, Y, Z, ROT, 34, 34, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
					}
					else
					{
						ErrorMsg(playerid, "Ja possui um veiculo use /dveiculo.");
					}
					return 1;
				}
			}
		}
		case DIALOG_ANUNCIOOLX:
		{
			if(response)
			{
				cmd_anuncio(playerid, inputtext);
				
			}
		}
		case DIALOG_VALORTRANSACAO:
		{
			if(response)
			{
				new BankV[255];
				if(!IsNumeric(inputtext)) return ErrorMsg(playerid, "Somente numeros");
				SetPVarInt(playerid, "QtdTransacao", strval(inputtext));
				format(BankV, sizeof(BankV), "%i", GetPVarInt(playerid, "QtdTransacao"));
				PlayerTextDrawSetString(playerid, BancoTD[playerid][28], BankV);
			}
		}
		case DIALOG_ARMAS12:
		{
			new orgid = GetPlayerOrg(playerid);
			if(!response) return 1;
			if(response)
			{
				switch(listitem)
				{
					case 0:
					{
						if(PlayerInfo[playerid][Org] == orgid)
						{
							SuccesMsg(playerid, "Voce pegoua a arma do cofre.");
							GivePlayerWeapon(playerid, CofreArma[ItemOpcao[playerid]][orgid], CofreAmmo[ItemOpcao[playerid]][orgid]);
							CofreArma[ItemOpcao[playerid]][orgid]=0;
							CofreAmmo[ItemOpcao[playerid]][orgid]=0;
							SalvarCofre(orgid);
						}
						else
						{
							ErrorMsg(playerid, "Sem permissao");
						}
					}
					case 1:
					{
						if(PlayerInfo[playerid][Org] == orgid)
						{
							GivePlayerWeapon(playerid, CofreArma[ItemOpcao[playerid]][orgid], CofreAmmo[ItemOpcao[playerid]][orgid]);
							CofreAmmo[ItemOpcao[playerid]][orgid]=0;
							CofreAmmo[ItemOpcao[playerid]][orgid]=0;
							SetTimerEx("TirarArma222", 1000, false, "i", playerid);
							SuccesMsg(playerid, "Voce retiro a arma do cofre.");
							SalvarCofre(orgid);
						}
						else
						{
							ErrorMsg(playerid, "Sem permissao");
						}
					}
				}
				return 1;
			}
		}
		case DIALOG_LOJA247:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pDinheiro] < 1500) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Item comprado.");
					PlayerInfo[playerid][pDinheiro] -= 1500;
					GanharItem(playerid, 18870, 1);
					MissaoPlayer[playerid][MISSAO6] = 1;
					if(PlayerToPoint(10.0, playerid, 393.256561, -1895.308471, 7.844118))
					{
						CofreLoja1 += 1500;
					}
					if(PlayerToPoint(10.0, playerid, 1359.771850, -1774.149291, 13.551797))
					{
						CofreLoja2 += 1500;
					}
					if(PlayerToPoint(10.0, playerid, 1663.899047, -1899.635009, 13.569333))
					{
						CofreLoja3 += 1500;
					}
					if(PlayerToPoint(10.0, playerid, 2054.312255, -1883.058105, 13.570812))
					{
						CofreLoja4 += 1500;
					}
					if(PlayerToPoint(10.0, playerid, 1310.963256, -856.883911, 39.597454))
					{
						CofreLoja5 += 1500;
					}
					SalvarDinRoubos();
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pDinheiro] < 200) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Item comprado.");
					PlayerInfo[playerid][pDinheiro] -= 200;
					GanharItem(playerid, 11736, 1);
					if(PlayerToPoint(10.0, playerid, 393.256561, -1895.308471, 7.844118))
					{
						CofreLoja1 += 200;
					}
					if(PlayerToPoint(10.0, playerid, 1359.771850, -1774.149291, 13.551797))
					{
						CofreLoja2 += 200;
					}
					if(PlayerToPoint(10.0, playerid, 1663.899047, -1899.635009, 13.569333))
					{
						CofreLoja3 += 200;
					}if(PlayerToPoint(10.0, playerid, 2054.312255, -1883.058105, 13.570812))
					{
						CofreLoja4 += 200;
					}
					if(PlayerToPoint(10.0, playerid, 1310.963256, -856.883911, 39.597454))
					{
						CofreLoja5 += 200;
					}

					SalvarDinRoubos();
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pDinheiro] < 300) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Item comprado.");
					PlayerInfo[playerid][pDinheiro] -= 300;
					GanharItem(playerid, 18632, 1);
					if(PlayerToPoint(10.0, playerid, 393.256561, -1895.308471, 7.844118))
					{
						CofreLoja1 += 300;
					}
					if(PlayerToPoint(10.0, playerid, 1359.771850, -1774.149291, 13.551797))
					{
						CofreLoja2 += 300;
					}
					if(PlayerToPoint(10.0, playerid, 1663.899047, -1899.635009, 13.569333))
					{
						CofreLoja3 += 300;
					}
					if(PlayerToPoint(10.0, playerid, 2054.312255, -1883.058105, 13.570812))
					{
						CofreLoja4 += 300;
					}
					if(PlayerToPoint(10.0, playerid, 1310.963256, -856.883911, 39.597454))
					{
						CofreLoja5 += 300;
					}
					SalvarDinRoubos();
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pDinheiro] < 500) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Item comprado.");
					PlayerInfo[playerid][pDinheiro] -= 500;
					GanharItem(playerid, 18645, 1);
					if(PlayerToPoint(10.0, playerid, 393.256561, -1895.308471, 7.844118))
					{
						CofreLoja1 += 500;
					}
					if(PlayerToPoint(10.0, playerid, 1359.771850, -1774.149291, 13.551797))
					{
						CofreLoja2 += 500;
					}
					if(PlayerToPoint(10.0, playerid, 1663.899047, -1899.635009, 13.569333))
					{
						CofreLoja3 += 500;
					}
					if(PlayerToPoint(10.0, playerid, 2054.312255, -1883.058105, 13.570812))
					{
						CofreLoja4 += 500;
					}
					if(PlayerToPoint(10.0, playerid, 1310.963256, -856.883911, 39.597454))
					{
						CofreLoja5 += 500;
					}
					SalvarDinRoubos();
				}
				if(listitem == 4)
				{
					if(PlayerInfo[playerid][pDinheiro] < 150) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
					SuccesMsg(playerid, "Item comprado.");
					PlayerInfo[playerid][pDinheiro] -= 150;
					GanharItem(playerid, 18644, 1);
					if(PlayerToPoint(10.0, playerid, 393.256561, -1895.308471, 7.844118))
					{
						CofreLoja1 += 150;
					}
					if(PlayerToPoint(10.0, playerid, 1359.771850, -1774.149291, 13.551797))
					{
						CofreLoja2 += 150;
					}
					if(PlayerToPoint(10.0, playerid, 1663.899047, -1899.635009, 13.569333))
					{
						CofreLoja3 += 150;
					}
					if(PlayerToPoint(10.0, playerid, 2054.312255, -1883.058105, 13.570812))
					{
						CofreLoja4 += 150;
					}
					if(PlayerToPoint(10.0, playerid, 1310.963256, -856.883911, 39.597454))
					{
						CofreLoja5 += 150;
					}
					SalvarDinRoubos();
				}
			}
		}
		case DIALOG_PREFEITURA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pRG] == 0)
					{
						ShowPlayerDialog(playerid, DIALOG_RG1, DIALOG_STYLE_INPUT, "EMITIR RG", "Diga seu nome completo:\nEx: Joao Paulo Viera da Silva", "Confirmar", "X");
					}
					else
					{
						ErrorMsg(playerid, "Voce ja possui documento");
					}
				}
				if(listitem == 1)
				{
					if(CheckInventario2(playerid, 19792)) return ErrorMsg(playerid, "Ja possui carteira de trabalho");
					SuccesMsg(playerid, "Fez a carteira de trabalho agora podera trabalhar em empregos que necessita disso e receber salario a cada PayDay.");
					GanharItem(playerid, 19792, 1);
					MissaoPlayer[playerid][MISSAO4] = 1;
				}
			}
		}
		case 8726:
		{
			if(!response)
			{
				ErrorMsg(playerid,  "Você cancelou seu relatório!");
				return 1;
			}
			ShowPlayerDialog(playerid, 4547, DIALOG_STYLE_TABLIST_HEADERS, "Solicitar Atendimento", "Prioridade\tDescrição\nPrioridade {FFFF00}BAIXA{FFFFFF}\tAssunto de pouca importância\nPrioridade {FF0000}ALTA{FFFFFF}\tAssunto de MUITA importância\n{FFFF00}Relatório{FFFFFF}\tEnviar um relatório para os admins", "Solicitar", "Fechar");
		}
		case 5409:
		{
			if(response)
			{
				foreach(new i: Player)
				{
					if(strfind(inputtext,Name(i), true) != -1)
					{
						Armazenar[playerid] = i;
					}
				}
				chosenpid = Armazenar[playerid];
				new arquivo[64];
				new string[255];
				format(arquivo, sizeof(arquivo), Pasta_Relatorios,chosenpid);
				if(DOF2_FileExists(arquivo))
				{
					new NomeFila[MAX_PLAYER_NAME];
					new AssuntoFila[64];
					strmid(NomeFila, DOF2_GetString(arquivo,"Jogador"), 0, strlen(DOF2_GetString(arquivo,"Jogador")), 255);
					strmid(AssuntoFila, DOF2_GetString(arquivo,"Assunto"), 0, strlen(DOF2_GetString(arquivo,"Assunto")), 255);
					DOF2_CreateFile(arquivo);
					DOF2_GetString(arquivo, "Jogador");
					DOF2_GetString(arquivo, "Assunto");
					format(string, 128, "%s iniciou um atendimento ao player %04d!",Name(playerid), GetPlayerIdfixo(chosenpid));
					SendAdminMessage(-1, string);
					format(string, sizeof(string), "O Administrador %s está lhe atendendo, assunto: [%s].", Name(playerid),AssuntoFila);
					InfoMsg(chosenpid, string);
					InfoMsg(chosenpid,  "Fale alguma coisa no chat. Quando quiser encerrar o atendimento digite: /terminar atendimento.");
					ChatAtendimento[chosenpid] = 1;
					ChatAtendimento[playerid] = 2;
					InviteAtt[chosenpid] = playerid;
					InviteAtt[playerid] = chosenpid;
					NumeroChatAtendimento[chosenpid] = chosenpid;
					NumeroChatAtendimento[playerid] = chosenpid;
					DOF2_RemoveFile(arquivo);
				}
				else ErrorMsg(playerid,  "ID inválido.");
			}
			return 1;
		}
		case 4547:
		{
			if(!response)
			{
				InfoMsg(playerid,  "Você cancelou seu relatório!");
				return 1;
			}
			if(listitem == 1)
			{
				if(!response)
				{
					InfoMsg(playerid,  "Você cancelou seu relatório!");
					return 1;
				}
				if (strlen(ArmazenarString[playerid]) > 30) //Strlen = Tamanho de uma string :)
				{
					ErrorMsg(playerid,  "Digite no máximo 30 Caracteres!");
					return 1;
				}
				new arquivo[64];
				new string[255];
				format(arquivo, sizeof(arquivo), Pasta_Relatorios,playerid);
				if(!DOF2_FileExists(arquivo))
				{
					DOF2_CreateFile(arquivo);
					DOF2_SetString(arquivo, "Jogador", Name(playerid));
					DOF2_SetString(arquivo, "Assunto", ArmazenarString[playerid]);
					DOF2_SetInt(arquivo, "Prioridade", 2);
					DOF2_SaveFile();
					format(string, 128, "%04d entrou na fila de atendimento, digite /fila para atende-lo !",GetPlayerIdfixo(playerid), playerid);
					SendAdminMessage(-1, string);
					SuccesMsg(playerid,  "Você enviou um atendimento e agora está na fila, aguarde um pouco até que os admin lhe atendam.");
					return 1;
				}
				else
				{
					InfoMsg(playerid,  "Você já enviou um atendimento, aguarde e logo será atendido!");
					return 1;
				}
			}
			if(listitem == 0)
			{
				if(!response)
				{
					InfoMsg(playerid,  "Você cancelou seu relatório!");
					return 1;
				}
				if (strlen(ArmazenarString[playerid]) > 30) //Strlen = Tamanho de uma string :)
				{
					ErrorMsg(playerid,  "Digite no máximo 30 Caracteres!");
					return 1;
				}
				new arquivo[64];
				new string[255];
				format(arquivo, sizeof(arquivo), Pasta_Relatorios,playerid);
				if(!DOF2_FileExists(arquivo))
				{
					DOF2_CreateFile(arquivo);
					DOF2_SetString(arquivo, "Jogador", Name(playerid));
					DOF2_SetString(arquivo, "Assunto", ArmazenarString[playerid]);
					DOF2_SetInt(arquivo, "Prioridade", 1);
					DOF2_SaveFile();
					format(string, 128, "%04d entrou na fila de atendimento, digite /fila para atendelo !",GetPlayerIdfixo(playerid), playerid);
					SendAdminMessage(-1, string);
					SuccesMsg(playerid,  "Você enviou um atendimento e agora está na fila, aguarde um pouco até que os admin lhe atendam.");
					return 1;
				}
				else
				{
					InfoMsg(playerid,  "Você já enviou um atendimento, aguarde e logo será atendido!");
					return 1;
				}
			}
			if(listitem == 2)
			{
				ShowPlayerDialog(playerid, 4550, DIALOG_STYLE_INPUT, "{FFFF00}Particular", "Digite seu Relato", "Enviar", "Cancelar");
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	if(pLogado[clickedplayerid] == true)
	{
		if(PlayerInfo[playerid][pAdmin] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
		new megastrings[500], String2[500];
		format(String2,sizeof(String2), "{FFFFFF}Nome: {FFFF00}%s{FFFFFF}({FFFF00}%d{FFFFFF})\n{FFFFFF}VIP: {FFFF00}%s\n{FFFFFF}Dinheiro: {FFFF00}%s\n{FFFFFF}Banco: {FFFF00}%s\n", Name(clickedplayerid),PlayerInfo[clickedplayerid][IDF], VIP(clickedplayerid),ConvertMoney(PlayerInfo[clickedplayerid][pDinheiro]),ConvertMoney(PlayerInfo[clickedplayerid][pBanco]));
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Profissao:{FFFF00} %s\n{FFFFFF}Org:{FFFF00} %s\n{FFFFFF}Cargo:{FFFF00} %s\n", Profs(clickedplayerid), NomeOrg(clickedplayerid), NomeCargo(clickedplayerid));
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Multas:{FFFF00} %d\n{FFFFFF}N°Casa:{FFFF00} %d\n", PlayerInfo[clickedplayerid][pMultas], PlayerInfo[clickedplayerid][Casa]);
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Tempo Jogados:{FFFF00} %s\n{FFFFFF}Expira VIP:{FFFF00} %s\n{FFFFFF}Licenca Conduzir: {FFFF00}%s", convertNumber(PlayerInfo[clickedplayerid][pSegundosJogados]), convertNumber(PlayerInfo[clickedplayerid][ExpiraVIP]-gettime()), temlicenca(clickedplayerid));
		strcat(megastrings, String2);
		ShowPlayerDialog(playerid, DIALOG_CMDRG,DIALOG_STYLE_MSGBOX,"Seu Documento",megastrings,"X",#);
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
	    SetPVarFloat(playerid, "FindX", fX);
	    SetPVarFloat(playerid, "FindY", fY);
	    SetPVarFloat(playerid, "FindZ", fZ);
		ShowPlayerDialog(playerid, DIALOG_TELEPORTARMAP, DIALOG_STYLE_MSGBOX, "Teleporte Mapa", "Voce deseja ir ao local que voce marcou no mapa?", #Sim, #Nao);
	}
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText: playertextid)
{
	new str[64], File[255];
	new wVeiculo = GetPlayerVehicleID(playerid);
	if(playertextid == BancoTD[playerid][8])
	{
		format(Str, sizeof(Str),"Introduza o IDF para transferir o dinheiro",PlayerInfo[playerid][pBanco]);
		ShowPlayerDialog(playerid,DIALOG_BANCO4,1,"Transferir", Str, "Selecionar","X");
	}
	if(playertextid == BancoTD[playerid][25])
	{
		for(new i; i < 34; i++)
		{
			PlayerTextDrawHide(playerid, BancoTD[playerid][i]);
		}
		CancelSelectTextDraw(playerid);
		new BankV[255];
		SetPVarInt(playerid, "QtdTransacao", 0);
		ModoTransacao[playerid] = 0;
		format(BankV, sizeof(BankV), "DIGITE A QUANTIA");
		PlayerTextDrawSetString(playerid, BancoTD[playerid][28], BankV);
	}
	if(playertextid == BancoTD[playerid][6])
	{
		ModoTransacao[playerid] = 1;
		InfoMsg(playerid, "Voce selecionou a opcao de saque.");
	}
	if(playertextid == BancoTD[playerid][7])
	{
		ModoTransacao[playerid] = 2;
		InfoMsg(playerid, "Voce selecionou a opcao de deposito.");
	}
	if(playertextid == BancoTD[playerid][21])
	{
		if(ModoTransacao[playerid] == 0) 			return ErrorMsg(playerid, "Voce precisa selecionar a operacao.");
		if(ModoTransacao[playerid] == 1)
		{
			if(PlayerInfo[playerid][pBanco] < GetPVarInt(playerid, "QtdTransacao")) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
			PlayerInfo[playerid][pDinheiro] += GetPVarInt(playerid, "QtdTransacao");
			PlayerInfo[playerid][pBanco] -= GetPVarInt(playerid, "QtdTransacao");
			CofreBanco -= GetPVarInt(playerid, "QtdTransacao");
			SuccesMsg(playerid, "Transacao realizada.");
			SalvarDinRoubos();
		}
		if(ModoTransacao[playerid] == 2)
		{
			if(PlayerInfo[playerid][pDinheiro] < GetPVarInt(playerid, "QtdTransacao")) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
			PlayerInfo[playerid][pDinheiro] -= GetPVarInt(playerid, "QtdTransacao");
			PlayerInfo[playerid][pBanco] += GetPVarInt(playerid, "QtdTransacao");
			CofreBanco += GetPVarInt(playerid, "QtdTransacao");
			SuccesMsg(playerid, "Transacao realizada.");
			SalvarDinRoubos();
		}
	}
	if(playertextid == BancoTD[playerid][31])
	{
		if(PlayerInfo[playerid][pBanco] < 50000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
		PlayerInfo[playerid][pDinheiro] += 50000;
		PlayerInfo[playerid][pBanco] -= 50000;
		CofreBanco -= 50000;
		SuccesMsg(playerid, "Saque realizada.");
		SalvarDinRoubos();
	}
	if(playertextid == BancoTD[playerid][32])
	{
		if(PlayerInfo[playerid][pBanco] < 100000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
		PlayerInfo[playerid][pDinheiro] += 100000;
		PlayerInfo[playerid][pBanco] -= 100000;
		CofreBanco -= 100000;
		SuccesMsg(playerid, "Saque realizada.");
		SalvarDinRoubos();
	}
	if(playertextid == BancoTD[playerid][33])
	{
		if(PlayerInfo[playerid][pBanco] < 5000) 			return ErrorMsg(playerid, "Dinheiro insuficiente.");
		PlayerInfo[playerid][pDinheiro] += 5000;
		PlayerInfo[playerid][pBanco] -= 5000;
		CofreBanco -= 5000;
		SuccesMsg(playerid, "Saque realizada.");
		SalvarDinRoubos();
	}
	if(playertextid == BancoTD[playerid][28])
	{
		if(ModoTransacao[playerid] == 0) 			return ErrorMsg(playerid, "Voce precisa selecionar a operacao.");
		ShowPlayerDialog(playerid, DIALOG_VALORTRANSACAO, DIALOG_STYLE_INPUT, "Digite a quantia", "Digite o valor para fazer a operacao selecionada.", "Confirmar", "X");
	}
	if(playertextid == BancoTD[playerid][22])
	{
		new BankV[255];
		SetPVarInt(playerid, "QtdTransacao", 0);
		ModoTransacao[playerid] = 0;
		format(BankV, sizeof(BankV), "DIGITE A QUANTIA");
		PlayerTextDrawSetString(playerid, BancoTD[playerid][28], BankV);
	}
	if(playertextid == TDCadastro_p[playerid][0]){
		PlayerInfo[playerid][pSkin] = Preview[playerid][0];
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		format(str,sizeof(str),"Voce escolheu a aparencia de id %d.",Preview[playerid][0]);
		InfoMsg(playerid,  str);
		DestroyActor(actorcad[playerid]);
		actorcad[playerid] = CreateActor(Preview[playerid][0], 1984.0140,1194.2424,26.8835,135.6409);
		SetActorInvulnerable(actorcad[playerid], true);
	}
	if(playertextid == TDCadastro_p[playerid][1]){
		PlayerInfo[playerid][pSkin] = Preview[playerid][1];
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		format(str,sizeof(str),"Voce escolheu a aparencia de id %d.",Preview[playerid][1]);
		InfoMsg(playerid, str);
		DestroyActor(actorcad[playerid]);
		actorcad[playerid] = CreateActor(Preview[playerid][1], 1984.0140,1194.2424,26.8835,135.6409);
		SetActorInvulnerable(actorcad[playerid], true);
	}
	if(playertextid == TDCadastro_p[playerid][2]){
		PlayerInfo[playerid][pSkin] = Preview[playerid][2];
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		format(str,sizeof(str),"Voce escolheu a aparencia de id %d.",Preview[playerid][2]);
		InfoMsg(playerid, str);
		DestroyActor(actorcad[playerid]);
		actorcad[playerid] = CreateActor(Preview[playerid][2], 1984.0140,1194.2424,26.8835,135.6409);
		SetActorInvulnerable(actorcad[playerid], true);
	}
	if(playertextid == TDCadastro_p[playerid][3]){
		PlayerInfo[playerid][pSkin] = Preview[playerid][3];
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		format(str,sizeof(str),"Voce escolheu a aparencia de id %d.",Preview[playerid][3]);
		InfoMsg(playerid, str);
		DestroyActor(actorcad[playerid]);
		actorcad[playerid] = CreateActor(Preview[playerid][3], 1984.0140,1194.2424,26.8835,135.6409);
		SetActorInvulnerable(actorcad[playerid], true);
	}
	if(playertextid == TDCadastro_p[playerid][4]){
		PlayerInfo[playerid][pSkin] = Preview[playerid][4];
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		format(str,sizeof(str),"Voce escolheu a aparencia de id %d.",Preview[playerid][4]);
		InfoMsg(playerid, str);
		DestroyActor(actorcad[playerid]);
		actorcad[playerid] = CreateActor(Preview[playerid][4], 1984.0140,1194.2424,26.8835,135.6409);
		SetActorInvulnerable(actorcad[playerid], true);
	}
	if(playertextid == TDCadastro_p[playerid][5]){
		PlayerInfo[playerid][pSkin] = Preview[playerid][5];
		SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
		format(str,sizeof(str),"Voce escolheu a aparencia de id %d.",Preview[playerid][5]);
		InfoMsg(playerid, str);
		DestroyActor(actorcad[playerid]);
		actorcad[playerid] = CreateActor(Preview[playerid][5], 1984.0140,1194.2424,26.8835,135.6409);
		SetActorInvulnerable(actorcad[playerid], true);
	}
	if(playertextid == Registration_PTD[playerid][21])
	{
		format(File, sizeof(File), PASTA_CONTAS, Name(playerid));
		if(DOF2_FileExists(File))
		{
			FirstLogin[playerid] = false;
			format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Ingressar", "X");
			return 0;
		}
		else
		{
			FirstLogin[playerid] = true;
			format(Str, sizeof(Str), "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
			ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Bem vindo", Str, "Criar", "X");
			return 0;
		}
	}
	for(new i = 1; i < 31; ++i)
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
	if(playertextid == DrawInv[playerid][39]) return RetirarItem(playerid, GetPVarInt(playerid, #VarSlotInv));
	if(playertextid == HudCop[playerid][3])
	{
		PlayerTextDrawHide(playerid, CopGuns[playerid][0]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][1]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][2]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][3]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][4]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][5]);
		PlayerTextDrawHide(playerid, HudCop[playerid][0]);
		PlayerTextDrawHide(playerid, HudCop[playerid][1]);
		PlayerTextDrawHide(playerid, HudCop[playerid][2]);
		PlayerTextDrawHide(playerid, HudCop[playerid][3]);
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == CopGuns[playerid][5])
	{
		PlayerTextDrawHide(playerid, CopGuns[playerid][0]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][1]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][2]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][3]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][4]);
		PlayerTextDrawHide(playerid, CopGuns[playerid][5]);
		PlayerTextDrawHide(playerid, HudCop[playerid][0]);
		PlayerTextDrawHide(playerid, HudCop[playerid][1]);
		PlayerTextDrawHide(playerid, HudCop[playerid][2]);
		PlayerTextDrawHide(playerid, HudCop[playerid][3]);
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == HudCop[playerid][0])
	{
		if(Patrulha[playerid] == false)
		{
			Patrulha[playerid] = true;
			SuccesMsg(playerid, "Voce comecou seu servico como policial");
			SalvarArmas(playerid);
			ResetPlayerWeapons(playerid);
			policiaon ++;
			SetPlayerColor(playerid, 0x0012FFFF);
			SetPlayerHealth(playerid, 100);
		}
		else
		{
			Patrulha[playerid] = false;
			policiaon --;
			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 0);
			ResetPlayerWeapons(playerid);
			CarregarArmas(playerid);
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);	
			SuccesMsg(playerid, "Voce deixou seu servico como policial");   
			SetPlayerColor(playerid, 0xFFFFFFFF);
			SetPlayerHealth(playerid, 100);
		}
		return 1;
	}
	if(playertextid == HudCop[playerid][1])
	{
		if(Patrulha[playerid] == false) 		return InfoMsg(playerid, "Nao esta em servico");
		PlayerTextDrawShow(playerid, CopGuns[playerid][0]);
		PlayerTextDrawShow(playerid, CopGuns[playerid][1]);
		PlayerTextDrawShow(playerid, CopGuns[playerid][2]);
		PlayerTextDrawShow(playerid, CopGuns[playerid][3]);
		PlayerTextDrawShow(playerid, CopGuns[playerid][4]);
		PlayerTextDrawShow(playerid, CopGuns[playerid][5]);
		SelectTextDraw(playerid, 0xFF0000FF);
	}
	if(playertextid == CopGuns[playerid][0])
	{
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		GivePlayerWeapon(playerid, 22, 32);
	}
	if(playertextid == CopGuns[playerid][1])
	{
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		RemovePlayerWeapon(playerid, 25);
		RemovePlayerWeapon(playerid, 29);
		RemovePlayerWeapon(playerid, 31);
		GivePlayerWeapon(playerid, 31, 150);
	}
	if(playertextid == CopGuns[playerid][2])
	{
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		RemovePlayerWeapon(playerid, 29);
		RemovePlayerWeapon(playerid, 31);
		RemovePlayerWeapon(playerid, 25);
		GivePlayerWeapon(playerid, 25, 10);
	}
	if(playertextid == CopGuns[playerid][3])
	{
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		RemovePlayerWeapon(playerid, 25);
		RemovePlayerWeapon(playerid, 31);
		RemovePlayerWeapon(playerid, 29);
		GivePlayerWeapon(playerid, 29, 100);
	}
	if(playertextid == CopGuns[playerid][4])
	{
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 29);
		RemovePlayerWeapon(playerid, 25);
		RemovePlayerWeapon(playerid, 31);
		RemovePlayerWeapon(playerid, 34);
		GivePlayerWeapon(playerid, 34, 10);
	}
	if(playertextid == HudCop[playerid][2])
	{
		new Ropa[800];
		if(Patrulha[playerid] == false) 		return InfoMsg(playerid, "Nao esta em servico");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Militar 1\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Militar 2\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Militar 3\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Militar 4\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Militar 5\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Rodoviaria 1\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Rodoviaria 2\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Batedores\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Operações Especiais 1\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Policia Rodoviaria 3\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}ROTA 1\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}ROTA 2\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}BAEP 1\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}FEMININA 1\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}FEMININA 2\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}FEMININA 3\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}BAEP 2\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}BAEP 3\n");
		strcat(Ropa, "{FFFFFF}- {FFFF00}Retirar Uniforme\n");
		ShowPlayerDialog(playerid, DIALOG_ROPACOP, DIALOG_STYLE_LIST, "Fardamentos", Ropa, "Selecionar", "X");
	}
	if(playertextid == wMenu[1])
	{
	    if(wTuning[playerid] == true)
        {
	        for(new u; u < sizeof(wBase); ++u) { TextDrawHideForPlayer(playerid, Text:wBase[u]); }
		    for(new u; u < sizeof(wMenu); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenu[u]); }
		    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
		    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
		    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
		    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
		    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
		    CancelSelectTextDraw(playerid);
		    wTuning[playerid] = false;
		}
	}

	if(playertextid == wMenu[2])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}

	if(playertextid == wMenu[3])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}

	if(playertextid == wMenu[4])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}

	if(playertextid == wMenu[5])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
	}

	if(playertextid == wMenu[6])
	{
	    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
	    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
	    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
	    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
	    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawShow(playerid, PlayerText:wMenuNeon[u]); }
	}
	

	if(playertextid == wMenu[7]) AddVehicleComponent(wVeiculo,1087);

	if(playertextid == wMenuRodas[1]) AddVehicleComponent(wVeiculo,1073), OnVehicleMod(playerid, wVeiculo, 1073);         // SHADOW
    if(playertextid == wMenuRodas[2]) AddVehicleComponent(wVeiculo, 1074), OnVehicleMod(playerid, wVeiculo, 1074);        // MEGA
    if(playertextid == wMenuRodas[3]) AddVehicleComponent(wVeiculo,1075), OnVehicleMod(playerid, wVeiculo, 1075);         // RINSHIME
    if(playertextid == wMenuRodas[4]) AddVehicleComponent(wVeiculo,1076), OnVehicleMod(playerid, wVeiculo, 1076);         // WIRES
    if(playertextid == wMenuRodas[5]) AddVehicleComponent(wVeiculo,1077), OnVehicleMod(playerid, wVeiculo, 1077);         // CLASSIC
    if(playertextid == wMenuRodas[6]) AddVehicleComponent(wVeiculo,1078), OnVehicleMod(playerid, wVeiculo, 1078);         // TWIST
    if(playertextid == wMenuRodas[7]) AddVehicleComponent(wVeiculo,1079), OnVehicleMod(playerid, wVeiculo, 1079);         // CUTTER
    if(playertextid == wMenuRodas[8]) AddVehicleComponent(wVeiculo,1083), OnVehicleMod(playerid, wVeiculo, 1083);         // DOLLAR
    if(playertextid == wMenuRodas[9]) AddVehicleComponent(wVeiculo,1085), OnVehicleMod(playerid, wVeiculo, 1085);         // ATOMIC
    if(playertextid == wMenuRodas[10]) AddVehicleComponent(wVeiculo,1097), OnVehicleMod(playerid, wVeiculo, 1097);        // VIRTUAL
    //if(playertextid == wMenuRodas[11]) AddVehicleComponent(wVeiculo,1081);        // GROVE
    //if(playertextid == wMenuRodas[12]) AddVehicleComponent(wVeiculo,1080);        // SWIST

    if(playertextid == wMenuCores[1]) ChangeVehicleColor(wVeiculo, 1, 1), OnVehicleRespray(playerid, wVeiculo, 1, 1);         // BRANCO
    if(playertextid == wMenuCores[2]) ChangeVehicleColor(wVeiculo, 79, 79), OnVehicleRespray(playerid, wVeiculo, 79, 79);       // AZUL
    if(playertextid == wMenuCores[3]) ChangeVehicleColor(wVeiculo, 194, 194), OnVehicleRespray(playerid, wVeiculo, 194, 194);     // AMARELO
    if(playertextid == wMenuCores[4]) ChangeVehicleColor(wVeiculo, 211, 211), OnVehicleRespray(playerid, wVeiculo, 211, 211);     // ROXO
    if(playertextid == wMenuCores[5]) ChangeVehicleColor(wVeiculo, 137, 137), OnVehicleRespray(playerid, wVeiculo, 137, 137);     // VERDE
    if(playertextid == wMenuCores[6]) ChangeVehicleColor(wVeiculo, 75, 75), OnVehicleRespray(playerid, wVeiculo, 75, 75);       // CINZA
    if(playertextid == wMenuCores[7]) ChangeVehicleColor(wVeiculo, 136, 136), OnVehicleRespray(playerid, wVeiculo, 136, 136);     // ROSA
    if(playertextid == wMenuCores[8]) ChangeVehicleColor(wVeiculo, 129, 129), OnVehicleRespray(playerid, wVeiculo, 129, 129);     // MARROM
    if(playertextid == wMenuCores[9]) ChangeVehicleColor(wVeiculo, 3, 3), OnVehicleRespray(playerid, wVeiculo, 3, 3);        // VERMELHO
    if(playertextid == wMenuCores[10]) ChangeVehicleColor(wVeiculo, 158, 158), OnVehicleRespray(playerid, wVeiculo, 158, 158);    // LARANJA

    if(playertextid == wMenuPaintJobs[1])  ChangeVehiclePaintjob(wVeiculo, 0), OnVehiclePaintjob(playerid, wVeiculo, 0);    // PAINTJOBS 1
    if(playertextid == wMenuPaintJobs[2])   ChangeVehiclePaintjob(wVeiculo, 1), OnVehiclePaintjob(playerid, wVeiculo, 1);   // PAINTJOBS 2
    if(playertextid == wMenuPaintJobs[3])   ChangeVehiclePaintjob(wVeiculo, 2), OnVehiclePaintjob(playerid, wVeiculo, 2);   // PAINTJOBS 3

    if(playertextid == wMenuNitro[1])      AddVehicleComponent(wVeiculo,1009), OnVehicleMod(playerid, wVeiculo, 1009);    // NITRO 1
    if(playertextid == wMenuNitro[2])      AddVehicleComponent(wVeiculo,1008), OnVehicleMod(playerid, wVeiculo, 1008);    // NITRO 2
    if(playertextid == wMenuNitro[3])      AddVehicleComponent(wVeiculo,1010), OnVehicleMod(playerid, wVeiculo, 1010);    // NITRO 3

    if(playertextid == wMenuNeon[1])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18648, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18648, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }

    if(playertextid == wMenuNeon[2])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18650, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18650, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }

    if(playertextid == wMenuNeon[3])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18652, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18652, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }

    if(playertextid == wMenuNeon[4])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18651, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18651, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }

    if(playertextid == wMenuNeon[5])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18649, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18649, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
	}

    if(playertextid == wMenuNeon[6])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
        neon_add[wVeiculo][NEON_DIREITO] = CreateObject(18647, 0, 0, 0, 0, 0, 0, 0.0);
        neon_add[wVeiculo][NEON_ESQUERDO] = CreateObject(18647, 0, 0, 0, 0, 0, 0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_DIREITO], wVeiculo, 0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
        AttachObjectToVehicle(neon_add[wVeiculo][NEON_ESQUERDO], wVeiculo, -0.8, 0.0, -0.70, 0.0, 0.0, 0.0);
    }

    if(playertextid == wMenuNeon[7])
    {
        DestroyObject(neon_add[wVeiculo][NEON_DIREITO]); DestroyObject(neon_add[wVeiculo][NEON_ESQUERDO]);
    }

    if(playertextid == wMenu[8])
    {
 		switch(GetVehicleModel(wVeiculo))
		{
		    case 483:
		    {
		      	AddVehicleComponent(wVeiculo,1027);
				OnVehicleMod(playerid, wVeiculo, 1027);
	            ChangeVehiclePaintjob(wVeiculo, 0);
				OnVehiclePaintjob(playerid, wVeiculo, 0);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		    }
		    case 562:
		    {
		  		AddVehicleComponent(wVeiculo,1046);
				OnVehicleMod(playerid, wVeiculo, 1046);
	            AddVehicleComponent(wVeiculo,1171);
				OnVehicleMod(playerid, wVeiculo, 1171);
	            AddVehicleComponent(wVeiculo,1149);
				OnVehicleMod(playerid, wVeiculo, 1149);
	            AddVehicleComponent(wVeiculo,1035);
				OnVehicleMod(playerid, wVeiculo, 1035);
	            AddVehicleComponent(wVeiculo,1147);
				OnVehicleMod(playerid, wVeiculo, 1147);
	            AddVehicleComponent(wVeiculo,1036);
				OnVehicleMod(playerid, wVeiculo, 1036);
	            AddVehicleComponent(wVeiculo,1040);
				OnVehicleMod(playerid, wVeiculo, 1040);
	            ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
	            ChangeVehicleColor(wVeiculo, 6, 6);
				OnVehicleRespray(playerid, wVeiculo, 6, 6);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		  	}
		  	case 560:
		  	{
		  	   	AddVehicleComponent(wVeiculo,1028);
				OnVehicleMod(playerid, wVeiculo, 1028);
	            AddVehicleComponent(wVeiculo,1169);
				OnVehicleMod(playerid, wVeiculo, 1169);
	            AddVehicleComponent(wVeiculo,1141);
				OnVehicleMod(playerid, wVeiculo, 1141);
	            AddVehicleComponent(wVeiculo,1032);
				OnVehicleMod(playerid, wVeiculo, 1032);
	            AddVehicleComponent(wVeiculo,1138);
				OnVehicleMod(playerid, wVeiculo, 1138);
	            AddVehicleComponent(wVeiculo,1026);
				OnVehicleMod(playerid, wVeiculo, 1026);
	            AddVehicleComponent(wVeiculo,1027);
				OnVehicleMod(playerid, wVeiculo, 1027);
	            ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		  	}
		  	case 565:
		  	{
		        AddVehicleComponent(wVeiculo,1046);
				OnVehicleMod(playerid, wVeiculo, 1046);
		        AddVehicleComponent(wVeiculo,1153);
				OnVehicleMod(playerid, wVeiculo, 1153);
		        AddVehicleComponent(wVeiculo,1150);
				OnVehicleMod(playerid, wVeiculo, 1150);
		        AddVehicleComponent(wVeiculo,1054);
				OnVehicleMod(playerid, wVeiculo, 1054);
		        AddVehicleComponent(wVeiculo,1049);
				OnVehicleMod(playerid, wVeiculo, 1049);
		        AddVehicleComponent(wVeiculo,1047);
				OnVehicleMod(playerid, wVeiculo, 1047);
		        AddVehicleComponent(wVeiculo,1051);
				OnVehicleMod(playerid, wVeiculo, 1051);
		        AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
		        AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
		        AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		        ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
		  	}
		  	case 559:
		  	{
		  	    AddVehicleComponent(wVeiculo,1065);
				OnVehicleMod(playerid, wVeiculo, 1065);
	            AddVehicleComponent(wVeiculo,1160);
				OnVehicleMod(playerid, wVeiculo, 1160);
	            AddVehicleComponent(wVeiculo,1159);
				OnVehicleMod(playerid, wVeiculo, 1159);
	            AddVehicleComponent(wVeiculo,1067);
				OnVehicleMod(playerid, wVeiculo, 1067);
	            AddVehicleComponent(wVeiculo,1162);
				OnVehicleMod(playerid, wVeiculo, 1162);
	            AddVehicleComponent(wVeiculo,1069);
				OnVehicleMod(playerid, wVeiculo, 1069);
	            AddVehicleComponent(wVeiculo,1071);
				OnVehicleMod(playerid, wVeiculo, 1071);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            ChangeVehiclePaintjob(wVeiculo, 1);
				OnVehiclePaintjob(playerid, wVeiculo, 1);
		  	}
		  	case 561:
		  	{
		        AddVehicleComponent(wVeiculo,1064);
				OnVehicleMod(playerid, wVeiculo, 1064);
		        AddVehicleComponent(wVeiculo,1155);
				OnVehicleMod(playerid, wVeiculo, 1155);
		        AddVehicleComponent(wVeiculo,1154);
				OnVehicleMod(playerid, wVeiculo, 1154);
		        AddVehicleComponent(wVeiculo,1055);
				OnVehicleMod(playerid, wVeiculo, 1055);
		        AddVehicleComponent(wVeiculo,1158);
				OnVehicleMod(playerid, wVeiculo, 1158);
		        AddVehicleComponent(wVeiculo,1056);
				OnVehicleMod(playerid, wVeiculo, 1056);
		        AddVehicleComponent(wVeiculo,1062);
				OnVehicleMod(playerid, wVeiculo, 1062);
		        AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
		        AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
		        AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		        ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
		  	}
		  	case 558:
		  	{
		  	   	AddVehicleComponent(wVeiculo,1089);
				OnVehicleMod(playerid, wVeiculo, 1089);
		        AddVehicleComponent(wVeiculo,1166);
				OnVehicleMod(playerid, wVeiculo, 1166);
		        AddVehicleComponent(wVeiculo,1168);
				OnVehicleMod(playerid, wVeiculo, 1168);
		        AddVehicleComponent(wVeiculo,1088);
				OnVehicleMod(playerid, wVeiculo, 1088);
		        AddVehicleComponent(wVeiculo,1164);
				OnVehicleMod(playerid, wVeiculo, 1164);
		        AddVehicleComponent(wVeiculo,1090);
				OnVehicleMod(playerid, wVeiculo, 1090);
		        AddVehicleComponent(wVeiculo,1094);
				OnVehicleMod(playerid, wVeiculo, 1094);
		        AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
		        AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
		        AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		        ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
		  	}
		  	case 575:
		  	{
		        AddVehicleComponent(wVeiculo,1044);
				OnVehicleMod(playerid, wVeiculo, 1044);
		        AddVehicleComponent(wVeiculo,1174);
				OnVehicleMod(playerid, wVeiculo, 1174);
		        AddVehicleComponent(wVeiculo,1176);
				OnVehicleMod(playerid, wVeiculo, 1176);
		        AddVehicleComponent(wVeiculo,1042);
				OnVehicleMod(playerid, wVeiculo, 1042);
		        AddVehicleComponent(wVeiculo,1099);
				OnVehicleMod(playerid, wVeiculo, 1099);
		        AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
		        AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
		        AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		        ChangeVehiclePaintjob(wVeiculo, 0);
				OnVehiclePaintjob(playerid, wVeiculo, 0);
		  	}
		  	case 534:
		  	{
	            AddVehicleComponent(wVeiculo,1126);
				OnVehicleMod(playerid, wVeiculo, 1126);
	            AddVehicleComponent(wVeiculo,1179);
				OnVehicleMod(playerid, wVeiculo, 1179);
	            AddVehicleComponent(wVeiculo,1180);
				OnVehicleMod(playerid, wVeiculo, 1180);
	            AddVehicleComponent(wVeiculo,1122);
				OnVehicleMod(playerid, wVeiculo, 1122);
	            AddVehicleComponent(wVeiculo,1101);
				OnVehicleMod(playerid, wVeiculo, 1101);
	            AddVehicleComponent(wVeiculo,1125);
				OnVehicleMod(playerid, wVeiculo, 1125);
	            AddVehicleComponent(wVeiculo,1123);
				OnVehicleMod(playerid, wVeiculo, 1123);
	            AddVehicleComponent(wVeiculo,1100);
				OnVehicleMod(playerid, wVeiculo, 1100);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
		  	}
		  	case 536:
		  	{
		        AddVehicleComponent(wVeiculo,1104);
				OnVehicleMod(playerid, wVeiculo, 1104);
		        AddVehicleComponent(wVeiculo,1182);
				OnVehicleMod(playerid, wVeiculo, 1182);
		        AddVehicleComponent(wVeiculo,1184);
				OnVehicleMod(playerid, wVeiculo, 1184);
		        AddVehicleComponent(wVeiculo,1108);
				OnVehicleMod(playerid, wVeiculo, 1108);
		        AddVehicleComponent(wVeiculo,1107);
				OnVehicleMod(playerid, wVeiculo, 1107);
		        AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
		        AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
		        AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
		        ChangeVehiclePaintjob(wVeiculo, 1);
				OnVehiclePaintjob(playerid, wVeiculo, 1);
		  	}
		  	case 567:
		  	{
		  	    AddVehicleComponent(wVeiculo,1129);
				OnVehicleMod(playerid, wVeiculo, 1129);
	            AddVehicleComponent(wVeiculo,1189);
				OnVehicleMod(playerid, wVeiculo, 1189);
	            AddVehicleComponent(wVeiculo,1187);
				OnVehicleMod(playerid, wVeiculo, 1187);
	            AddVehicleComponent(wVeiculo,1102);
				OnVehicleMod(playerid, wVeiculo, 1102);
	            AddVehicleComponent(wVeiculo,1133);
				OnVehicleMod(playerid, wVeiculo, 1133);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            ChangeVehiclePaintjob(wVeiculo, 2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
		  	}
		  	case 420:
		  	{
		  	   	AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1139);
				OnVehicleMod(playerid, wVeiculo, 1139);
		  	}
		  	case 400:
		  	{
		  	    AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            AddVehicleComponent(wVeiculo,1018);
				OnVehicleMod(playerid, wVeiculo, 1018);
	            AddVehicleComponent(wVeiculo,1013);
				OnVehicleMod(playerid, wVeiculo, 1013);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1086);
				OnVehicleMod(playerid, wVeiculo, 1086);
		  	}
		  	case 401:
		  	{
			  	AddVehicleComponent(wVeiculo,1086);
				OnVehicleMod(playerid, wVeiculo, 1086);
	            AddVehicleComponent(wVeiculo,1139);
				OnVehicleMod(playerid, wVeiculo, 1139);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            AddVehicleComponent(wVeiculo,1012);
				OnVehicleMod(playerid, wVeiculo, 1012);
	            AddVehicleComponent(wVeiculo,1013);
				OnVehicleMod(playerid, wVeiculo, 1013);
	            AddVehicleComponent(wVeiculo,1042);
				OnVehicleMod(playerid, wVeiculo, 1042);
	            AddVehicleComponent(wVeiculo,1043);
				OnVehicleMod(playerid, wVeiculo, 1043);
	            AddVehicleComponent(wVeiculo,1018);
				OnVehicleMod(playerid, wVeiculo, 1018);
	            AddVehicleComponent(wVeiculo,1006);
				OnVehicleMod(playerid, wVeiculo, 1006);
	            AddVehicleComponent(wVeiculo,1007);
				OnVehicleMod(playerid, wVeiculo, 1007);
	            AddVehicleComponent(wVeiculo,1017);
				OnVehicleMod(playerid, wVeiculo, 1017);
        	}
        	case 576:
        	{
	        	ChangeVehiclePaintjob(wVeiculo,2);
				OnVehiclePaintjob(playerid, wVeiculo, 2);
	            AddVehicleComponent(wVeiculo,1191);
				OnVehicleMod(playerid, wVeiculo, 1191);
	            AddVehicleComponent(wVeiculo,1193);
				OnVehicleMod(playerid, wVeiculo, 1193);
	            AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1018);
				OnVehicleMod(playerid, wVeiculo, 1018);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
	            AddVehicleComponent(wVeiculo,1134);
				OnVehicleMod(playerid, wVeiculo, 1134);
	            AddVehicleComponent(wVeiculo,1137);
				OnVehicleMod(playerid, wVeiculo, 1137);
        	}
			default:
			{
			 	AddVehicleComponent(wVeiculo,1010);
				OnVehicleMod(playerid, wVeiculo, 1010);
	            AddVehicleComponent(wVeiculo,1079);
				OnVehicleMod(playerid, wVeiculo, 1079);
	            AddVehicleComponent(wVeiculo,1087);
				OnVehicleMod(playerid, wVeiculo, 1087);
			}
		}
    }
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == TD_RG[23]){
		for(new r=0;r<24;r++){
			TextDrawHideForPlayer(playerid, TD_RG[r]);
		}
		for(new r=0;r<6;r++){
			PlayerTextDrawHide(playerid, RG_p[playerid][r]);
		}
		MostrandoRG[playerid] = false;
		CancelSelectTextDraw(playerid);
	}
	if(clickedid == TDmorte[1]){
		VaiProHospital(playerid);
        PlayerMorto[playerid][pEstaMorto] = 0;
	}
	if(clickedid == TDCadastro[2]){
		new str[10];
		if(Page[playerid] < 46){
			Page[playerid]++;
		}
		format(str,sizeof(str),"%d/46",Page[playerid]);
		PlayerTextDrawSetString(playerid, TDCadastro_p[playerid][6], str);
		TimerCad[playerid] = SetTimerEx("AttCad",100,false,"i",playerid);
		for(new i=0;i<7;i++){
			PlayerTextDrawShow(playerid, TDCadastro_p[playerid][i]);
		}
	}
	if(clickedid == TDCadastro[3]){
		new str[10];
		if(Page[playerid] > 1){
			Page[playerid]--;
		}
		format(str,sizeof(str),"%d/46",Page[playerid]);
		PlayerTextDrawSetString(playerid, TDCadastro_p[playerid][6], str);
		TimerCad[playerid] = SetTimerEx("AttCad",100,false,"i",playerid);
		for(new i=0;i<7;i++){
			PlayerTextDrawShow(playerid, TDCadastro_p[playerid][i]);
		}
	}
	if(clickedid == TDCadastro[11]){
		PlayerInfo[playerid][pSexo] = 1;
		InfoMsg(playerid, "Voce selecionou o Genero Masculino.");
	}
	if(clickedid == TDCadastro[12]){
		PlayerInfo[playerid][pSexo] = 2;
		InfoMsg(playerid, "Voce selecionou o Genero Feminino.");
	}
	if(clickedid == TDCadastro[14]){
		if(PlayerInfo[playerid][pSexo] == 0) return ErrorMsg(playerid, "Voce precisa escolher um Genero.");
		if(PlayerInfo[playerid][pSkin] == 0) return ErrorMsg(playerid, "Voce precisa escolher uma aparencia.");
		for(new i=0;i<18;i++){
			TextDrawHideForPlayer(playerid, TDCadastro[i]);
		}
		for(new i=0;i<7;i++){
			PlayerTextDrawDestroy(playerid, TDCadastro_p[playerid][i]);
		}
		DestroyActor(actorcad[playerid]);
		MostrandoMenu[playerid] = false;
		SalvarDadosSkin(playerid);
		SuccesMsg(playerid, "Voce concluiu o cadastro, agora realize o login em sua conta.");
		format(Str, sizeof(Str), "Desejo boas vindas, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Seja bem vindo ao servidor...", Str, "Logar", "Cancelar");
	}
	if(clickedid == Text:INVALID_TEXT_DRAW)
	{
		for(new i = 0; i < 40; ++i)
		{
			PlayerTextDrawHide(playerid, DrawInv[playerid][i]);
		}
		InventarioAberto[playerid] = 0;
		return 1;
	}
	if(clickedid == Text:INVALID_TEXT_DRAW)
    {
        if(wTuning[playerid] == true)
        {
	        for(new u; u < sizeof(wBase); ++u) { TextDrawHideForPlayer(playerid, Text:wBase[u]); }
		    for(new u; u < sizeof(wMenu); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenu[u]); }
		    for(new u; u < sizeof(wMenuRodas); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuRodas[u]); }
		    for(new u; u < sizeof(wMenuCores); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuCores[u]); }
		    for(new u; u < sizeof(wMenuPaintJobs); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuPaintJobs[u]); }
		    for(new u; u < sizeof(wMenuNitro); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNitro[u]); }
		    for(new u; u < sizeof(wMenuNeon); ++u) { PlayerTextDrawHide(playerid, PlayerText:wMenuNeon[u]); }
		    CancelSelectTextDraw(playerid);
            wTuning[playerid] = false;
		}
  	}
	return 0;
}

//                          COMANDOS

CMD:minhaconta(playerid)
{
	new megastrings[500], String2[500];
	format(String2,sizeof(String2), "{FFFFFF}Nome: {FFFF00}%s{FFFFFF}({FFFF00}%d{FFFFFF})\n{FFFFFF}VIP: {FFFF00}%s\n{FFFFFF}Dinheiro: {FFFF00}%s\n{FFFFFF}Banco: {FFFF00}%s\n", Name(playerid),PlayerInfo[playerid][IDF], VIP(playerid),ConvertMoney(PlayerInfo[playerid][pDinheiro]),ConvertMoney(PlayerInfo[playerid][pBanco]));
	strcat(megastrings, String2);
	format(String2,sizeof(String2), "{FFFFFF}Profissao:{FFFF00} %s\n{FFFFFF}Org:{FFFF00} %s\n{FFFFFF}Cargo:{FFFF00} %s\n", Profs(playerid), NomeOrg(playerid), NomeCargo(playerid));
	strcat(megastrings, String2);
	format(String2,sizeof(String2), "{FFFFFF}Multas:{FFFF00} %d\n{FFFFFF}N°Casa:{FFFF00} %d\n", PlayerInfo[playerid][pMultas], PlayerInfo[playerid][Casa]);
	strcat(megastrings, String2);
	format(String2,sizeof(String2), "{FFFFFF}Tempo Jogados:{FFFF00} %s\n{FFFFFF}Expira VIP:{FFFF00} %s\n{FFFFFF}Licenca Conduzir: {FFFF00}%s", convertNumber(PlayerInfo[playerid][pSegundosJogados]), convertNumber(PlayerInfo[playerid][ExpiraVIP]-gettime()), temlicenca(playerid));
	strcat(megastrings, String2);
	ShowPlayerDialog(playerid, DIALOG_CMDRG,DIALOG_STYLE_MSGBOX,"Seu Documento",megastrings,"X",#);
	return 1;
}

CMD:ajuda(playerid)
{
	MEGAString[0] = EOS;
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}FAQ\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Comandos\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Empregos\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Comandos Lideres\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Comandos Organizacao\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Comandos Veiculo\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Comandos Inventario\n");
	strcat(MEGAString, "{FFFF00}Ajuda {FFFFFF}Casa\n");
	ShowPlayerDialog(playerid, DIALOG_AJUDA, DIALOG_STYLE_LIST, "Central de Ajuda", MEGAString, "Confirmar", "X");
	MissaoPlayer[playerid][MISSAO11] = 1;
	return 1;
}
CMD:rg(playerid)
{
	if(PlayerInfo[playerid][pRG] == 1)
	{
		if(MostrandoRG[playerid] == false)
		{
			new str[128];
			PlayerTextDrawSetPreviewModel(playerid, RG_p[playerid][1], PlayerInfo[playerid][pSkin]);
			format(str,sizeof(str),"%s",PlayerInfo[playerid][pNome]);
			PlayerTextDrawSetString(playerid,RG_p[playerid][0],str);
			format(str,sizeof(str),"%s",PlayerInfo[playerid][pPai]);
			PlayerTextDrawSetString(playerid,RG_p[playerid][2],str);
			format(str,sizeof(str),"%s",PlayerInfo[playerid][pMae]);
			PlayerTextDrawSetString(playerid,RG_p[playerid][3],str);
			format(str,sizeof(str),"%s",PlayerInfo[playerid][pNascimento]);
			PlayerTextDrawSetString(playerid,RG_p[playerid][4],str);
			format(str,sizeof(str),"%s",PlayerInfo[playerid][pNome]);
			PlayerTextDrawSetString(playerid,RG_p[playerid][5],str);
			for(new t=0;t<24;t++)
			{
				TextDrawShowForPlayer(playerid, TD_RG[t]);
			}
			for(new t=0;t<6;t++)
			{
				PlayerTextDrawShow(playerid, RG_p[playerid][t]);
			}
			MostrandoRG[playerid] = true;
			SelectTextDraw(playerid, 0xFF0000FF);
		}else{
			ErrorMsg(playerid,"Voce ja esta vendo um RG");
		}
	}
	else
	{
		ErrorMsg(playerid, "Voce nao possui um RG");
	}
	return 1;
}
CMD:mostrarrg(playerid,params[])
{
	new id,str[128];
	if(sscanf(params,"d",id)) return ErrorMsg(playerid, "Voce precisa colocar o id do jogador");
	if(PlayerInfo[playerid][pRG] == 1)
	{
		if(MostrandoRG[playerid] == false)
		{
			foreach(Player,i){
				if(PlayerInfo[i][IDF] == id){
					static Float:XYZ[3];
					GetPlayerPos(i,XYZ[0],XYZ[1],XYZ[2]);
					if(IsPlayerInRangeOfPoint(playerid, 3.0, XYZ[0],XYZ[1],XYZ[2])) return ErrorMsg(playerid, "Voce nao esta proximo do Jogador");
					if(PlayerInfo[i][IDF] == playerid) return ErrorMsg(playerid,"Voce nao pode mostrar o RG a si mesmo, use /rg");
					if(MostrandoRG[i] == false){
						PlayerTextDrawSetPreviewModel(playerid, RG_p[playerid][1], PlayerInfo[playerid][pSkin]);
						format(str,sizeof(str),"%s",PlayerInfo[playerid][pNome]);
						PlayerTextDrawSetString(playerid,RG_p[playerid][0],str);
						format(str,sizeof(str),"%s",PlayerInfo[playerid][pPai]);
						PlayerTextDrawSetString(playerid,RG_p[playerid][2],str);
						format(str,sizeof(str),"%s",PlayerInfo[playerid][pMae]);
						PlayerTextDrawSetString(playerid,RG_p[playerid][3],str);
						format(str,sizeof(str),"%s",PlayerInfo[playerid][pNascimento]);
						PlayerTextDrawSetString(playerid,RG_p[playerid][4],str);
						format(str,sizeof(str),"%s",PlayerInfo[playerid][pNome]);
						PlayerTextDrawSetString(playerid,RG_p[playerid][5],str);
						for(new t=0;t<24;t++)
						{
							TextDrawShowForPlayer(i, TD_RG[t]);
						}	
						for(new t=0;t<6;t++)
						{
							PlayerTextDrawShow(i, RG_p[playerid][t]);
						}
						MostrandoRG[i] = true;
						SelectTextDraw(i, 0xFF0000FF);
						format(str,sizeof(str),"Voce mostrou seu rg para %d",PlayerInfo[i][IDF]);
						SuccesMsg(playerid,str);
						format(str,sizeof(str),"%d mostrou seu rg para voce",PlayerInfo[playerid][IDF]);
						SuccesMsg(i,str);
					}else{
						ErrorMsg(playerid,"O jogador ja esta vendo um RG");
					}
				}else{
					ErrorMsg(playerid,"Jogador nao conectado");
				}
			}
		}else{
			ErrorMsg(playerid, "Voce nao pode mostrar seu RG enquanto o ve");	
		}
	}
	else
	{
		ErrorMsg(playerid, "Voce nao possui um RG");
	}
	return 1;
}

CMD:garagememp(playerid){
	if(PlayerInfo[playerid][pProfissao] == 8){
		if(PlayerToPoint(3.0, playerid, 981.7181,1733.6261,8.6484)){
			if(EmServico[playerid] == false) return ErrorMsg(playerid,"Voce nao esta em servico.");
			if(IsPlayerInAnyVehicle(playerid) && PegouVehProf[playerid] == true){
				ShowPlayerDialog(playerid,DIALOG_SEDEX,DIALOG_STYLE_MSGBOX,"GARAGEM {FFFF00}SEDEX","Voce deseja entregar um {FFFF00}veiculo{FFFFFF} da empresa SedeX?","Sim","Nao");
			}else if(!IsPlayerInAnyVehicle(playerid) && PegouVehProf[playerid] == true){
				PegouVehProf[playerid] = false;
				DestroyVehicle(carID[playerid]);
				carID[playerid] = 0;
				ShowPlayerDialog(playerid,DIALOG_SEDEX,DIALOG_STYLE_MSGBOX,"GARAGEM {FFFF00}SEDEX","Voce deseja pegar um {FFFF00}veiculo{FFFFFF} da empresa SedeX?","Sim","Nao");
			}else if(PegouVehProf[playerid] == false){
				ShowPlayerDialog(playerid,DIALOG_SEDEX,DIALOG_STYLE_MSGBOX,"GARAGEM {FFFF00}SEDEX","Voce deseja pegar um {FFFF00}veiculo{FFFFFF} da empresa SedeX?","Sim","Nao");
			}
		}else{
			ErrorMsg(playerid,"Voce nao esta na Garagem da SedeX.");
		}
	}else{
		ErrorMsg(playerid,"Voce nao faz parte de uma empresa/corporacao/organizacao.");
	}
	return 1;
}

CMD:uniforme(playerid){
	if(PlayerInfo[playerid][pProfissao] == 8){ //Correios
		if(PlayerToPoint(3.0, playerid, 956.8282,1754.7942,8.6484)){
			if(EmServico[playerid] == false){
				EmServico[playerid] = true;
				SetPlayerSkin(playerid, 71);
				SuccesMsg(playerid, "Voce vestiu seu uniforme e iniciou servico.");
			}else{
				EmServico[playerid] = false;
				SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
				SuccesMsg(playerid, "Voce retirou seu uniforme e encerrou servico.");
			}
		}else{
			ErrorMsg(playerid, "Voce nao esta no local correto de colocar sua vestimenta.");
		}
	}else{
		ErrorMsg(playerid, "Voce nao pertence a nenhuma empresa/organizacao/corporacao.");
	}
	return 1;
}

CMD:mvoip(playerid)
{
	ShowPlayerDialog(playerid, D_VOIP, DIALOG_STYLE_LIST, "Config VOIP", "{FFFF00}VOIP{FFFFFF} Falando\n{FFFF00}VOIP{FFFFFF} Susurrando\n\
	{FFFF00}VOIP{FFFFFF} Gritando\n", "Selecionar", "X");
	return 1;
}

CMD:cinto(playerid)
{
	if(!IsPlayerInAnyVehicle(playerid)) return ErrorMsg(playerid, "Voce nao esta em um veiculo!"); 
	if(IsABike(GetPlayerVehicleID(playerid)) || IsABoat(GetPlayerVehicleID(playerid))) return ErrorMsg(playerid, "Voce nao esta em um veiculo que possui cinto de seguranca!"); 
	if(TemCinto[playerid] == false)
	{
		TemCinto[playerid] = true;
		SuccesMsg(playerid, "Cinto de seguranca colocado");
		for(new x=0;x<5;x++)
		{
			TextDrawHideForPlayer(playerid, Tdcinto[x]);
		}
	}
	else
	{
		TemCinto[playerid] = false;
		SuccesMsg(playerid, "Cinto de seguranca removido");
		for(new x=0;x<5;x++)
		{
			TextDrawShowForPlayer(playerid, Tdcinto[x]);
		}
	}
	return true;
}

CMD:gps(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "Onde deseja ir?", "{FFFF00}GPS {FFFFFF}Locais Importantes\n{FFFF00}GPS {FFFFFF}Locais Empregos\n{FFFF00}GPS {FFFFFF}Locais Organização\n{FFFF00}GPS {FFFFFF}Localizar Casas", "Selecionar", "X");
	MissaoPlayer[playerid][MISSAO8] = 1;
	return 1;
}

CMD:pegaritem(playerid)
{
	new Float:x, Float:y, Float:z, str[128];
	for(new i = 0; i < sizeof(DropItemSlot); i++)
	{
		GetDynamicObjectPos(DropItemSlot[i][DropItem], x,y,z);
		if(DropItemSlot[i][DropItem] != 0)
		{
			if(IsPlayerInRangeOfPoint(playerid, 1.5, x,y,z+1) && GetPlayerVirtualWorld(playerid) == DropItemSlot[i][Virtual] && GetPlayerInterior(playerid) == DropItemSlot[i][Interior])
			{
				if(!CheckInventario(playerid, DropItemSlot[i][DropItemID])) return ErrorMsg(playerid, "Seu inventario esta cheio.");
				GanharItem(playerid, DropItemSlot[i][DropItemID], DropItemSlot[i][DropItemUni]);
				format(str, sizeof(str), "Pegou %s do chao %s com unidades.", ItemNomeInv(DropItemSlot[i][DropItemID]), ConvertMoney(DropItemSlot[i][DropItemUni]));
				DestroyDynamicObject(DropItemSlot[i][DropItem]);
				DestroyDynamic3DTextLabel(DropItemSlot[i][LabelItem]);
				DropItemSlot[i][DropItem] = 0;
				DropItemSlot[i][DropItemID] = -1;
				DropItemSlot[i][DropItemUni] = 0;
				DropItemSlot[i][Interior] = 0;
				DropItemSlot[i][Virtual] = 0;
				SuccesMsg(playerid, str);
				ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.1, 0, 0, 0, 0, 0, 1);
				return 1;
			}
		}
	}
	return 1;
}

CMD:daritem(playerid, const params[])
{
	new id, item, quantia;
	if(PlayerInfo[playerid][pAdmin] < 5)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "iii", id, item, quantia)) return ErrorMsg(playerid, "Use: /daritem [ID] [ITEM ID] [UNIDADES].");
	if(quantia < 1) return ErrorMsg(playerid, "Coloque uma quantia.");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == id)
			{
				if(!IsValidItemInv(item)) return ErrorMsg(playerid, "Item indefinido.");
				if(!CheckInventario(i, item)) return ErrorMsg(playerid, "Inventario do jogador esta cheio.");
				GanharItem(i, item, quantia);
				SuccesMsg(playerid, "Item setado para o jogador.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
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
		return 1;
	}
	else
	{
		format(str, sizeof(str), "Inventario: %s(%d)", Name(playerid),PlayerInfo[playerid][IDF]);
		PlayerTextDrawSetString(playerid, DrawInv[playerid][34], str);
		PlayerTextDrawSetString(playerid, DrawInv[playerid][38], "");
		for(new i = 1; i < 31; ++i)
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
	}
	return 1;
}

CMD:report(playerid, params[])
{
	if(sscanf(params, "is[56]", ID, Motivo))					return ErrorMsg(playerid, "USE: /report [ID] [RAZON]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				SuccesMsg(playerid, "Os administradores foram notificados. Bom jogo !");
				format(Str, sizeof(Str), "{FFFFFF}%04d{FFFFFF} report {FFFFFF}%04d{FFFFFF} Motivo: {FFFF00}%s", PlayerInfo[playerid][IDF], PlayerInfo[i][IDF], Motivo);
				SendAdminMessage(-1, Str);
				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### NOVO REPORT\n\nReporte de %04d \nReportou o %04d\nMotivo: %s", PlayerInfo[playerid][IDF], PlayerInfo[i][IDF], Motivo);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(Reports, embed);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	//
	return 1;
}

CMD:duvida(playerid, params[])
{
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Voce nao esta logado.");
	if(sscanf(params, "s[56]", Str))							return ErrorMsg(playerid, "USE: /duvida [TEXTO]");
	//
	format(Str, sizeof(Str), "{3ce86a}(/duvida){FFFF00} %04d{FFFFFF}({FFFF00}%d{FFFFFF}) disse {FFFF00}%s", GetPlayerIdfixo(playerid),PlayerInfo[playerid][IDF], Str);
	SendClientMessageToAll(-1, Str);
	return 1;
}

CMD:presos(playerid)
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pCadeia] > 0)
		{
			format(Str, sizeof(Str), "{FFFF00}%04d - {FFFFFF}Preso por {FFFF00}%d {FFFFFF}segundos [{FFFF00}%d {FFFFFF}minutes]", GetPlayerIdfixo(i), PlayerInfo[i][pCadeia], PlayerInfo[i][pCadeia] / 60);
			ShowPlayerDialog(playerid, DIALOG_PRESOS, DIALOG_STYLE_MSGBOX, "{FF0F0F}Prisioneros", Str, "X", #);
		}
	}
	return 1;
}

CMD:logaradm(playerid)
{
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid, sendername, sizeof(sendername));
	if(!strcmp(sendername,"Luan_Rosa", false))
	{
		PlayerInfo[playerid][pAdmin] = 7;
		SuccesMsg(playerid, "Conectado como Desenvolvedor");
		pJogando[playerid] = false;
	}
	if(!strcmp(sendername,"Maconho_", false))
	{
		PlayerInfo[playerid][pAdmin] = 6;
		SuccesMsg(playerid, "Conectado como Fundador");
		pJogando[playerid] = false;
	}
	if(!strcmp(sendername,"Allison_Gomes", false))
	{
		PlayerInfo[playerid][pAdmin] = 7;
		SuccesMsg(playerid, "Conectado como Desenvolvedor");
		pJogando[playerid] = false;
	}
	return 1;

}

CMD:pos(playerid, params[])
{
	new msg[500];
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "s[56]", msg))return ErrorMsg(playerid,"Use /pos [nomedolocal].");

	static
		Float: x,
		Float: y,
		Float: z,
		Float: a
	;
	GetPlayerPos(playerid, x,y,z);
	GetPlayerFacingAngle(playerid, a);
	static
		string[200]
	;
	string[0] = '\0';
	format(string, 200, "{%f, %f, %f, %f},//%s\n", x,y,z,a,msg);
	{
		static
			File: Account
		;
		Account = fopen("pos.txt", io_append);
		fwrite(Account, string);
		fclose(Account);
	}
	format(string, 200, "%f,%f,%f,%f //%s", x,y,z,a,msg);
	SendClientMessage(playerid, -1, string);
	return true;
}

CMD:a(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "s[56]", Motivo)) 							return ErrorMsg(playerid, "USE: /a [TEXTO]");
	//
	format(Str, sizeof(Str), "{FFFFFF}[{FFFF00}%s{FFFFFF}] {FFFF00}%s{FFFFFF}({FFFF00}%04d{FFFFFF}) disse {FFFF00}%s", AdminCargo(playerid), Name(playerid),PlayerInfo[playerid][IDF], Motivo);
	SendAdminMessage(0xDDA0DDFF, Str);
	//
	new string2[100];
	format(string2,sizeof(string2),"%s disse %s", Name(playerid), Motivo);
	DCC_SendChannelMessage(ChatAdm, string2);
	return 1;
}

CMD:av(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "s[56]", Motivo)) 						return ErrorMsg(playerid, "USE: /av [TEXTO]");
	foreach(Player,i)
	{
		format(Str, sizeof(Str), "%s", Motivo);
		AvMsg(i, Str);
	}
	return 1;
}

CMD:setskin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "di", ID, Numero))						return ErrorMsg(playerid, "USE: /setskin [ID] [SKIN ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				PlayerInfo[i][pSkin] = Numero;
				SetPlayerSkin(i, Numero);
				SalvarDadosSkin(i);
				SuccesMsg(playerid, "Mudou a skin do jogador.");
				InfoMsg(i, "Algum administrador mudou sua skin.");

				format(Str, sizeof(Str), "O Administrador %s deu a %04d skin %d.", Name(playerid), GetPlayerIdfixo(i), Numero);
				DCC_SendChannelMessage(Sets, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:setvida(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "dd", ID, Numero))						return ErrorMsg(playerid,"USE: /setvida [ID] [VIDA]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				SetPlayerHealth(i, Numero);
				SuccesMsg(playerid, "Setou a vida do jogador.");
				InfoMsg(i, "Algum administrador alterou sua vida.");

				format(Str, sizeof(Str), "O Administrador %s deu a %04d, %d de vida.", Name(playerid), GetPlayerIdfixo(i), Numero);
				DCC_SendChannelMessage(Sets, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:setcolete(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "dd", ID, Numero))						return ErrorMsg(playerid,"USE: /setcolete [ID] [COLETE]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				SetPlayerArmour(i, Numero);
				SuccesMsg(playerid, "Setou o colete do jogador.");
				InfoMsg(i, "Algum administrador alterou seu colete.");

				format(Str, sizeof(Str), "O Administrador %s deu a %04d, %d de colete.", Name(playerid), GetPlayerIdfixo(i), Numero);
				DCC_SendChannelMessage(Sets, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:cv(playerid, params[])
{
	//
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)      	return ErrorMsg(playerid, "Nao pode criar um veiculo quando esta em outro.");
	if(sscanf(params, "i", Numero))				return ErrorMsg(playerid, "USE: /cv [ID]");
	if(Numero < 400 || Numero > 611)							return ErrorMsg(playerid, "ID no valido.");
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	if(VehAlugado[playerid] == 0)
	{
		VehAlugado[playerid] = 1;
		VeiculoCivil[playerid] = CreateVehicle(Numero, Pos[0], Pos[1], Pos[2], 90, 5, 5, false);
		PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
		InfoMsg(playerid, "Para devolver seu veiculo use /dveiculo.");
	}
	else
	{
		InfoMsg(playerid, "Ja possui um veiculo use /dveiculo.");
	}
	return 1;
}

CMD:kick(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "ds[56]", ID, Motivo))					return ErrorMsg(playerid,"USE: /kick [ID] [MOTIVO]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				SuccesMsg(playerid, "Deu kick no jogador.");
				InfoMsg(i, "Algum administrador deu kick em voce.");
				format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jogador {FFFF00}%04d {FFFFFF}foi kickado por administrador {FFFF00}%s{FFFFFF}. Motivo: {FFFF00}%s", GetPlayerIdfixo(i), Name(playerid), Motivo);
				SendClientMessageToAll(-1, Str);

				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### KICK\n\nID: %04d\nPertence: %s\nExpulso por: %s\nMotivo: %s", PlayerInfo[i][IDF],Name(i), Name(playerid), Motivo);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(Punicoes, embed);
				Kick(i);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:cadeia(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "iis[56]", ID, Numero, Motivo))			return ErrorMsg(playerid,"USE: /cadeia [ID] [TEMPO EM MINUTOS] [MOTIVO]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				if(Numero != 0)
				{
					PlayerInfo[i][pCadeia] = Numero * 60;
					SetPlayerPos(i,  322.197998,302.497985,999.148437);
					SetPlayerInterior(i, 5);
					SetPlayerVirtualWorld(i, 0);
					TogglePlayerControllable(i, false);
					SetTimerEx("carregarobj", 5000, 0, "i", i);
				}
				else
				{
					PlayerInfo[i][pCadeia] = 1;
				}
				SuccesMsg(playerid, "Deu cadeia no jogador.");
				InfoMsg(i, "Algum administrador te colocou na cadeia.");
				format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}prendeu {FFFF00}%04d {FFFFFF}por {FFFF00}%i {FFFFFF}minutos. Motivo: {FFFF00}%s", Name(playerid), GetPlayerIdfixo(i), Numero, Motivo);
				SendClientMessageToAll(-1, Str);

				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### CADEIA STAFF\n\nID: %04d\nPertence: %s\nPreso por: %s\nTempo: %i minuto(s)\nMotivo: %s", PlayerInfo[i][IDF],Name(i), Name(playerid), Numero, Motivo);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(Punicoes, embed);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:ir(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "d", ID))									return ErrorMsg(playerid,"USE: /ir [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				GetPlayerPos(i, Pos[0], Pos[1], Pos[2]);
				if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
				{
					SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
					TogglePlayerControllable(playerid, false);
					SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				}
				else
				{
					SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
				}
				SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(i));
				SetPlayerInterior(playerid, GetPlayerInterior(i));
				SuccesMsg(playerid, "Voce foi ate o jogador.");
				InfoMsg(i, "Algum administrador foi ate voce.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:trazer(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "u", ID))									return ErrorMsg(playerid,"USE: /trazer [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
				if(GetPlayerState(ID) != PLAYER_STATE_DRIVER)
				{
					SetPlayerPos(ID, Pos[0], Pos[1], Pos[2]);
					TogglePlayerControllable(ID, false);
					SetTimerEx("carregarobj", 5000, 0, "i", ID);
				}
				else
				{
					SetVehiclePos(GetPlayerVehicleID(ID), Pos[0], Pos[1], Pos[2]);
				}
				SetPlayerVirtualWorld(ID, GetPlayerVirtualWorld(playerid));
				SetPlayerInterior(ID, GetPlayerInterior(playerid));
				SuccesMsg(playerid, "Voce trouxe o jogador.");
				InfoMsg(i, "Algum administrador trouxe voce.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:contagem(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "i", ID)) 								return ErrorMsg(playerid,"ERRO: Use /contagem [VALOR INICIAL]");
	if(ID < 1 || ID > 20) 										return ErrorMsg(playerid, "20s e o maximo.");
	if(ContagemIniciada == true)
	{
		ErrorMsg(playerid, "{FFFF00}AVISO{FFFFFF} Ja tem uma contagem rolando");
	}
	else
	{
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador: {FFFF00}%s {FFFFFF}comecou uma contagem {FFFF00}%i {FFFFFF}segundos.", Name(playerid), ID);
		SendClientMessageToAll(-1, Str);
		SetTimerEx("DiminuirTempo", 1000, false, "i", ID);
		ContagemIniciada = true;
		//
		Log("Logs/Contagem.ini", Str);
	}
	return 1;
}

CMD:tv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(IsAssistindo[playerid] == false)
	{
		if(sscanf(params, "i", ID))								return ErrorMsg(playerid,"USE: /tv [ID]");
		foreach(Player,i)
		{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == ID)
				{
					if(!IsPlayerInAnyVehicle(i))
					{
						TogglePlayerSpectating(playerid, 1);
						PlayerSpectatePlayer(playerid, i);
					}
					else
					{
						TogglePlayerSpectating(playerid, 1);
						PlayerSpectateVehicle(playerid, GetPlayerVehicleID(i));

					}
					SetPlayerInterior(playerid, GetPlayerInterior(i));
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(i));
					Assistindo[playerid] = i;
					IsAssistindo[playerid] = true;
				}
			}
			else
			{
				ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
	}
	else
	{
		TogglePlayerSpectating(playerid, 0);
		IsAssistindo[playerid] = false;
		Assistindo[playerid] = -1;
	}
	return 1;
}

CMD:setarma(playerid, params[])
{
	new Municao, Arma;
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "iii", ID, Arma, Municao))				return ErrorMsg(playerid,"USE: /setarma [ID] [ARMA] [MUNIÃ‡ÃƒO]");
	if(Arma<1 || Arma==19 || Arma==20||Arma==21||Arma>46)		return ErrorMsg(playerid, "ID nao valido.");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				GivePlayerWeapon(i, Arma, Municao);
				format(Str, sizeof(Str), "O Administrador %s deu a %04d, arma id %d com %i balas.", Name(playerid), GetPlayerIdfixo(i), Arma, Municao);
				DCC_SendChannelMessage(Sets, Str);
				SuccesMsg(playerid, "Voce setou arma ao jogador.");
				InfoMsg(i, "Algum administrador deu arma a voce.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:desarmar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "d", ID))									return ErrorMsg(playerid,"USE: /desarmar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				ResetPlayerWeapons(i);
        		SuccesMsg(playerid, "Voce removeu as armas do jogador.");
				InfoMsg(i, "Algum administrador removeu suas armas.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:banir(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "is[56]", ID, Motivo)) 					return ErrorMsg(playerid,"ERRO: Use /banir [ID] [MOTIVO]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				SuccesMsg(playerid, "Voce baniu o jogador.");
				InfoMsg(i, "Algum administrador baniu voce.");

				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### BANIMENTO\n\nID: %04d\nPertence: %s\nBanido por: %s\nMotivo: %s", PlayerInfo[i][IDF],Name(i), Name(playerid), Motivo);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(Punicoes, embed);

				BanirPlayer(i, playerid, Motivo);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:tempban(playerid,params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	new Dias;
	if(sscanf(params, "iis[56]", ID, Dias, Motivo)) 			return ErrorMsg(playerid,"ERRO: Use /tempban [ID] [TEMPO] [MOTIVO]");
	if(Dias == 0)                                               return ErrorMsg(playerid, "Nao pode banir alguem durante 0 dias. USA: /ban para banir permanentes.");
	if(Dias >= 360)                                             return ErrorMsg(playerid, "Voce so pode banir alguem por no maximo 360 dias.");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				new Data[24], Dia, Mes, Ano, Hora, Minuto;
				gettime(Hora, Minuto);
				getdate(Ano, Mes, Dia);
				format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
				format(File, sizeof(File), PASTA_BANIDOS, Name(i));
				DOF2_CreateFile(File);
				DOF2_SetString(File, "Administrador", Name(playerid));
				DOF2_SetString(File, "Motivo", Motivo);
				DOF2_SetString(File, "Data", Data);
				Dia += Dias;
				if(Mes == 1 || Mes == 3 || Mes == 5 || Mes == 7 || Mes == 8 || Mes == 10 || Mes == 12)
				{
					if(Dia > 31)
					{
						Dia -= 31;
						Mes++;
						if(Mes > 12) Mes = 1;
					}
				}
				if(Mes == 4 || Mes == 6 || Mes == 9 || Mes == 11)
				{
					if(Dia > 30)
					{
						Dia -= 30;
						Mes++;
					}
				}
				if(Mes == 2)
				{
					if(Dia > 28)
					{
						Dia-=28;
						Mes++;
					}
				}
				format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
				DOF2_SetString(File, "Desban", Data);
				DOF2_SetInt(File, "DDesban", gettime() + 60 * 60 * 24 * Dias);
				DOF2_SaveFile();
				format(Str, sizeof(Str), "{FFFF00}ADMIN{FFFFFF} O jogador {FFFF00}%04d {FFFFFF}foi banido por {FFFF00}%i {FFFFFF}dias pelo administrador {FFFF00}%s{FFFFFF}. Motivo: {FFFF00}%s", GetPlayerIdfixo(i), Dias, Name(playerid), Motivo);
				SendClientMessageToAll(-1, Str);

				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### BANIMENTO\n\nID: %04d\nPertence: %s\nBanido por: %s\nTempo: %i Dia(s)\nMotivo: %s", PlayerInfo[i][IDF],Name(i), Name(playerid), Dias, Motivo);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(Punicoes, embed);
				Kick(i);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:antiafk(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(AntiAFK_Ativado)
	{
		AntiAFK_Ativado = false;
		SuccesMsg(playerid, "Anti-AFK desativado.");
	}
	else
	{
		AntiAFK_Ativado = true;
		SuccesMsg(playerid, "Anti-AFK ativado.");
	}
	return 1;
}

CMD:agendaban(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true)								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	new Nome[24], tempo;
	if(sscanf(params, "s[56]is[56]", Nome, tempo, Motivo))		return ErrorMsg(playerid,"ERRO: Use /agendarban [CONTA] [TEMPO EM DIAS (999 = FOREVER)] [MOTIVO]");
	format(File, sizeof(File), PASTA_CONTAS, Nome);
	if(!DOF2_FileExists(File))              					return ErrorMsg(playerid, "Conta nao existente.");
	format(Str, sizeof(Str), "Agendado - %s", Motivo);
	AgendarBan(Nome, playerid, Str, tempo);
	format(Str, sizeof(Str), "{FFFF00}ADMIN{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}programou a {FFFF00}%s {FFFFFF} um ban. Motivo: {FFFF00}%s", Name(playerid), Nome, Motivo);
	SendClientMessageToAll(-1, Str);

	new string[255];
	new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
	format(string,sizeof(string),"### BANIMENTO\n\nConta: %s\nPreso por: %s\nTempo: %i minuto(s)\nMotivo: %s", Nome, Name(playerid), tempo, Motivo);
	DCC_SetEmbedColor(embed, 0xFFFF00);
	DCC_SetEmbedDescription(embed, string);
	DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
	DCC_SendChannelEmbedMessage(Punicoes, embed);

	SuccesMsg(playerid, "Para cancelar um ban, pede a alguem..");
	return 1;
}

CMD:agendacadeia(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true)								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	new Nome[24];
	if(sscanf(params, "s[56]is[56]", Nome, ID,  Motivo))		return ErrorMsg(playerid,"ERRO: Use /agendarcadeia [CONTA] [TEMPO EM MINUTOS] [MOTIVO]");
	new ID1 = GetPlayerID(Nome);
	if(IsPlayerConnected(ID1))                                  return ErrorMsg(playerid, "Jogador esta online use /cadeia.");
	format(File, sizeof(File), PASTA_CONTAS, Nome);
	if(!DOF2_FileExists(File))              					return ErrorMsg(playerid, "Cuenta no existente.");
	format(Str, sizeof(Str), "AdmCmd: {FFFFFF}O Administrador {FFFF00}%s{FFFFFF} programou {FFFF00}%s {FFFFFF}para cumprir {FFFF00}%i {FFFFFF}minutos de cadeia. Motivo: {FFFF00}%s", Name(playerid), Nome, ID, Motivo);
	SendClientMessageToAll(-1, Str);

	new string[255];
	new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
	format(string,sizeof(string),"### CADEIA STAFF\n\nConta: %s\nPreso por: %s\nTempo: %i minuto(s)\nMotivo: %s", Nome, Name(playerid), ID, Motivo);
	DCC_SetEmbedColor(embed, 0xFFFF00);
	DCC_SetEmbedDescription(embed, string);
	DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
	DCC_SendChannelEmbedMessage(Punicoes, embed);

	AgendarCadeia(Nome, ID, playerid, Motivo);
	if(ID > 0) ErrorMsg(playerid, "DICA: Para cancelar um agendamento de cadeia use valores negativos no Tempo."); 
	return 1;
}

CMD:adv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "is[56]", ID, Motivo)) 					return ErrorMsg(playerid,"ERRO: Use /adv [ID] [MOTIVO]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				PlayerInfo[i][pAvisos]++;
				InfoMsg(i, "Algum administrador lhe deu uma advertencia.");
				SuccesMsg(playerid, "Voce deu advertencia ao jogador.");
				if(PlayerInfo[playerid][pAvisos] == 3)
				{
					format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jogador {FFFF00}%04d {FFFFFF} recebeu uma advertencia do Administrador {FFFF00}%s {FFFFFF}e foi banido. {FFFFFF}Motivo: {FFFF00}%s", GetPlayerIdfixo(i), Name(playerid), Motivo);
					SendClientMessageToAll(-1, Str);
					BanirPlayer(i, playerid, "Superou o limite de advertencia");
				}
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:banirip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 								return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "is[56]", ID, Motivo)) 					return ErrorMsg(playerid,"ERRO: Use /banirip [ID] [MOTIVO]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				SuccesMsg(playerid, "Voce beniu por ip o jogador.");
				InfoMsg(i, "Algum administrador baniu por ip voce.");

				new string[255];
				new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
				format(string,sizeof(string),"### BANIMENTO IP\n\nID: %04d\nPertence: %s\nBanido por: %s\nMotivo: %s", PlayerInfo[i][IDF],Name(i), Name(playerid), Motivo);
				DCC_SetEmbedColor(embed, 0xFFFF00);
				DCC_SetEmbedDescription(embed, string);
				DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
				DCC_SendChannelEmbedMessage(Punicoes, embed);
				BanirIP(i, playerid, Motivo);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:admins(playerid, params[])
{
    if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Voce precisa fazer Login primeiro.");
    SendClientMessage(playerid, 0x4682B4FF, "Administradores Online:");
    //
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		    if(PlayerInfo[i][pAdmin] > 0 && pJogando[i] == false)
		    {
		 		format(Str, 256, "%s [%s]", Name(i), AdminCargo(i));
			    SendClientMessage(playerid, -1, Str);
			}
	}
	return 1;
}

CMD:tra(playerid) return cmd_atrabalhar(playerid);
CMD:atrabalhar(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == false)
	{
		pJogando[playerid] = true;
		SetPlayerColor(playerid, -1);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 0);	
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O administrador {FFFF00}%s{FFFFFF} nao esta mais trabalhando.", Name(playerid));
		SendClientMessageToAll(-1, Str);  
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");  
	}
	else
	{
		pJogando[playerid] = false;
		SetPlayerColor(playerid, 0xff00ccff);
		SetPlayerHealth(playerid, 9999);
		SetPlayerArmour(playerid, 9999);	
		FomePlayer[playerid] = 100;
		SedePlayer[playerid] = 100;
		SetPlayerSkin(playerid, 217);
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O administrador {FFFF00}%s{FFFFFF} esta trabalhando.", Name(playerid));
		SendClientMessageToAll(-1, Str); 
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");	
	}
	return 1;
}

CMD:limparchat(playerid)
{
	for(new i = 0; i < 50; i++)
	{
		SendClientMessage(playerid,-1, "   ");
	}
	return 1;
}

CMD:congelar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "i", ID))					return ErrorMsg(playerid,"USE: /congelar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				TogglePlayerControllable(i, false);
				PlayerInfo[i][pCongelado] = true;
        		SuccesMsg(playerid, "Voce congelou o jogador.");
				InfoMsg(i, "Algum administrador congelou voce.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:descongelar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "i", ID))					return ErrorMsg(playerid,"USE: /descongelar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				TogglePlayerControllable(i, true);
				PlayerInfo[i][pCongelado] = false;
        		SuccesMsg(playerid, "Voce descongelou o jogador.");
				InfoMsg(i, "Algum administrador congelou voce.");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:chat(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(ChatLigado == true)
	{
		SuccesMsg(playerid, "Voce desabilitou o chat.");
		ChatLigado = false;
	}
	else
	{
		SuccesMsg(playerid, "Voce habilitou o chat.");
		ChatLigado = true;
	}
	return 1;
}

CMD:desbanir(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 4)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "s[56]", Motivo)) 		return ErrorMsg(playerid,"ERRO: Use /desbanir [Conta - Nome_Sobrenome (COMPLETO)]");
	format(File, sizeof(File), PASTA_CONTAS, Motivo);
	if(!DOF2_FileExists(File))                  return ErrorMsg(playerid, "Esta conta nao esta no banco de dados.");
	format(File, sizeof(File), PASTA_BANIDOS, Motivo);
	if(!DOF2_FileExists(File))                  return ErrorMsg(playerid, "Esta conta nao esta banida");
	new File1[48];
	format(File1, 48, PASTA_BACKUPBAN, Motivo);
	DOF2_CopyFile(File, File1);
	DOF2_RemoveFile(File);
	return 1;
}

CMD:desbanirip(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 4)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "s[56]", Motivo)) 		return ErrorMsg(playerid,"ERRO: Use /desbanirip [IP]");
	format(File, sizeof(File), PASTA_BANIDOSIP, Motivo);
	if(!DOF2_FileExists(File))                  return ErrorMsg(playerid, "Este IP nao esta banido.");
	new File1[48];
	format(File1, 48, PASTA_BACKUPBANIP, Motivo);
	DOF2_CopyFile(File, File1);
	DOF2_RemoveFile(File);
	//
	SuccesMsg(playerid, "IP desbanido com sucesso.");
	return 1;
}

CMD:dardinheiro(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "dd", ID, Numero))		return ErrorMsg(playerid,"USE: /dardinheiro [ID] [QUANTIA]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				PlayerInfo[i][pDinheiro] += Numero;
        		SuccesMsg(playerid, "Voce deu dinheiro para o jogador.");
				InfoMsg(i, "Algum administrador deu dinheiro a voce.");

				format(Str, sizeof(Str), "O Administrador %s deu %d de dinheiro a %04d", Name(playerid), Numero, GetPlayerIdfixo(i));
				DCC_SendChannelMessage(Sets, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}   

CMD:setadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 7)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(pJogando[playerid] == true) 				return ErrorMsg(playerid, "Nao iniciou trabalho staff");
	if(sscanf(params, "ii", ID, Numero))		return ErrorMsg(playerid,"USE: /setadmin [ID] [LEVEL]");
	if(Numero > 9)				return ErrorMsg(playerid, "O numero deve ser entre 0 a 9");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				PlayerInfo[i][pAdmin] = Numero;
				SuccesMsg(playerid, "Voce deu administrador para o jogador.");
				InfoMsg(i, "Algum administrador setou admin em voce.");
				format(Str, sizeof(Str), "O Administrador %s deu administrador level %i para %04d.", Name(playerid), Numero, GetPlayerIdfixo(i));
				DCC_SendChannelMessage(Sets, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:gmx(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	foreach(new i: Player)
	{
		if(pLogado[i] == true) SalvarDados(i), Kick(i);
		
	}
	format(Str, sizeof(Str), "{FFFF00}ANUNCIO{FFFFFF} Se realizara um reinicio no servidor.");
	SendClientMessageToAll(-1, Str);
	SendRconCommand("exit");
	return 1;
}

CMD:vips(playerid) 
{ 
	new string[85]; 
	new count; 
	SendClientMessage(playerid, 0x33AAFFFF, "** Todos os jogadores VIP:"); 
	foreach(new i: Player)
	{ 
		if(PlayerInfo[i][ExpiraVIP] > 0) 
		{ 
			if(IsPlayerConnected(i)) 
			   { 
				format(string, sizeof(string), "%04d [%s]", GetPlayerIdfixo(i), convertNumber(PlayerInfo[i][ExpiraVIP]-gettime())); 
				SendClientMessage(playerid, 0xE3E3E3FF, string); 
				count++; 
			   } 
		} 
	} 
	if(count == 0) 
		return ErrorMsg(playerid,  "Nao ha jogadores VIP online!"); 

	return true; 
} 

/*CMD:setvip(playerid, params[]) 
{ 
	new id, days, nivel, string[70]; 

	if(PlayerInfo[playerid][pAdmin] < 7)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "udd", id, nivel, days)) 
		return SendClientMessage(playerid, -1, "USE: /setvip [id] [nivel] [dias]"); 

	if(days < 0) 
	{ 
		return ErrorMsg(playerid, "Este jogador nao esta online!");
	} 
	else 
	{ 
		if(!IsPlayerConnected(id)) 
			return ErrorMsg(playerid, "Este jogador nao esta online!");
		else 
		{ 
			PlayerInfo[id][ExpiraVIP] = ConvertDays(days); 
			PlayerInfo[playerid][pVIP] = nivel;
			format(string, sizeof(string), "Deu a {FFFF00}%s{FFFFFF}por {FFFF00}%d {FFFFFF}dias VIP Nivel {FFFF00}%d", days, Name(id)); 
			SendClientMessage(playerid, -1, string); 
			format(string, sizeof(string), "Recebeu o VIP Nivel {FFFF00}%d {FFFFFF}durante {FFFF00}%d {FFFFFF}dias de VIP.", nivel, days); 
			SendClientMessage(playerid, -1, string); 

			format(string, sizeof(string), PASTA_VIPS, Name(id)); 
			DOF2_CreateFile(string); 
			DOF2_SetInt(string,"VipExpira", PlayerInfo[id][ExpiraVIP]); 
			DOF2_SaveFile(); 
		} 
	} 
	return true; 
}*/

CMD:lojavip(playerid)
{
	new StrCash[550],StrCashh[550], String[500];
	format(StrCashh, sizeof(StrCashh), "{FFFF00}LOJA {FFFFFF}VIP's\n");
	strcat(StrCash,StrCashh);
	format(StrCashh, sizeof(StrCashh), "{FFFF00}LOJA {FFFFFF}Veiculos de Inventario\n");
	strcat(StrCash,StrCashh);
	format(StrCashh, sizeof(StrCashh), "{FFFF00}LOJA {FFFFFF}Itens de Utilidades\n");
	strcat(StrCash,StrCashh);
	format(StrCashh, sizeof(StrCashh), "{FFFF00}LOJA {FFFFFF}Verifique os Beneficios\n");
	strcat(StrCash,StrCashh);
	format(StrCashh, sizeof(StrCashh), "{FFFF00}LOJA {FFFFFF}Ativação de Coins\n");
	strcat(StrCash,StrCashh);
	format(String, sizeof(String), "Voce possui{FFFF00}%i {FFFFFF}coins", PlayerInfo[playerid][pCoins]);
	ShowPlayerDialog(playerid, DIALOG_CATCOINS, DIALOG_STYLE_LIST, String , StrCash, "Selecionar", "X");	
	return 1;
}

CMD:dveiculo(playerid)
{
	if(VehAlugado[playerid] == 1)
	{
		VehAlugado[playerid] = 0;
		DestroyVehicle(VeiculoCivil[playerid]);
		SuccesMsg(playerid, "Veiculo destruido.");
	}
	return 1;
}

CMD:iniciarcoleta(playerid) 
{ 
	if(PlayerInfo[playerid][pProfissao] != 6) 	return ErrorMsg(playerid, "Nao possui permissao.");
	if(Covaconcerto[playerid] == true || PegouLixo[playerid] == true) return ErrorMsg(playerid, "Termine esta coleta para iniciar outra.");
	if(Podecmd[playerid] == false) return ErrorMsg(playerid, "Voce podera iniciar outra coleta novamente em 5s..");
	cova[playerid] = random(sizeof(Covas));    
	new index = cova[playerid];    
	SetPlayerCheckpoint(playerid, Covas[index][0], Covas[index][1], Covas[index][2], 2.0);  
	SuccesMsg(playerid, "Faca a coleta no ponto marcado.");
	Covaconcerto[playerid] = true;
	Podecmd[playerid] = false;
	return 1; 
}

CMD:sairemprego(playerid)
{
	PlayerInfo[playerid][pProfissao] = 0;
	SuccesMsg(playerid, "Deixou seu emprego.");
	return 1;
}

CMD:pedircontas(playerid)
{
	if(PlayerInfo[playerid][Cargo] == 3) 	return ErrorMsg(playerid, "Peca a um admin remover sua org, pos voce e o lider dela.");
	PlayerInfo[playerid][Org] = 0;
	PlayerInfo[playerid][Cargo] = 0;
	SuccesMsg(playerid, "Deixou seu emprego.");
	return 1;
}

CMD:lferidos(playerid, params[])
{
	new id;
	if(PlayerInfo[playerid][pProfissao] != 3)
	{
		if(sscanf(params, "u", id)) return ErrorMsg(playerid,  "* Use: /lferidos (id)");
		foreach(Player,i)
		{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == id)
				{
					if(playerid == i) return ErrorMsg(playerid, "Nao pode localizar voce mesmo!.");
					if(Localizando[playerid] == 0)
					{
						Localizando[playerid] = 1;
						SuccesMsg(playerid, "Jogador foi localizado.");
						TimerLocalizar[playerid] = SetTimerEx("LocalizarPlayer", 500, true, "ii", playerid, i);
						return true;
					}
					else 
					{
						DisablePlayerCheckpoint(playerid);
						Localizando[playerid] = 0;
						SuccesMsg(playerid, "Nao esta localizando agora.");
						KillTimer(TimerLocalizar[playerid]);
						return true;
					}
				}
			}
			else
			{
				ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
	}
	else ErrorMsg(playerid, "Nao possui permissao.");
	return true;
}

CMD:carregar(playerid)
{
	if(PlayerInfo[playerid][pProfissao] == 4){
		if(PlayerToPoint(3.0, playerid, -520.421813, -504.999450, 24.635631) || PlayerToPoint(3.0, playerid, -529.748168, -504.937561, 24.640802) || PlayerToPoint(3.0, playerid, -557.552368, -505.473480, 24.596021))
		if(Cargase[playerid] == true) 	return ErrorMsg(playerid, "Seu caminhao ja esta carregado.");
		if(Carregou[playerid] == 1) 	return ErrorMsg(playerid, "Ja tem uma carga.");
		if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 456)  	return ErrorMsg(playerid, "Nao esta no veiculo de trabalho");
		ShowPlayerDialog(playerid, DIALOG_CARGA, DIALOG_STYLE_LIST, "{FFFF00}Cargas Disponiveis.", "{FFFF00}- {FFFFFF}Ind. Solarion SF\t{32CD32}R$2250\n{FFFF00}- {FFFFFF}Michelin Pneus LV\t{32CD32}R$2400\n{FFFF00}- {FFFFFF}Sprunk LS\t{32CD32}R$2150\n{FFFF00}- {FFFFFF}Xoomer LS\t{32CD32}R$2150\n{FFFF00}- {FFFFFF}FlaischBerg LS\t{32CD32}R$2100\n", "Carregar", "");
	}else if(PlayerInfo[playerid][pProfissao] == 8){ //Correios
		if(EmServico[playerid] == false) return ErrorMsg(playerid, "Voce nao iniciou expediente.");
		if(PegouVehProf[playerid] == false) return ErrorMsg(playerid, "Voce nao pegou uma van de servicos dos Correios.");
		SetPlayerCheckpoint(playerid, 954.7924,1707.8540,8.6484,1);
		SuccesMsg(playerid, "Va ate o local marcado.");
		EntregaSdx[playerid] = true;
		CaixasSdxObj[playerid][1] = CreatePlayerObject(playerid,1221, 954.870483, 1706.978149, 8.968443, 0.000000, 0.000000, 0.000000, 300.00); 
		CaixasSdxObj[playerid][2] = CreatePlayerObject(playerid,1221, 954.870483, 1706.978149, 8.078433, 0.000000, 0.000000, 0.000000, 300.00); 
		CaixasSdxObj[playerid][3] = CreatePlayerObject(playerid,1221, 955.930419, 1706.978149, 8.968428, 0.000000, 0.000000, 0.000000, 300.00); 
		CaixasSdxObj[playerid][4] = CreatePlayerObject(playerid,1221, 955.930419, 1706.978149, 8.078433, 0.000000, 0.000000, 0.000000, 300.00); 
		CaixasSdxObj[playerid][5] = CreatePlayerObject(playerid,1221, 956.920593, 1706.978149, 8.988447, 0.000000, 0.000000, 0.000000, 300.00); 
		CaixasSdxObj[playerid][6] = CreatePlayerObject(playerid,1221, 956.920593, 1706.978149, 8.078433, 0.000000, 0.000000, 0.000000, 300.00); 
		CaixasSdxObj[playerid][7] = CreatePlayerObject(playerid,1221, 958.100891, 1707.363525, 8.988439, 0.000000, 0.000000, 15.899997, 300.00); 
		CaixasSdxObj[playerid][8] = CreatePlayerObject(playerid,1221, 958.100891, 1707.363525, 8.078433, 0.000000, 0.000000, 15.899997, 300.00); 
		CaixasSdxObj[playerid][9] = CreatePlayerObject(playerid,1221, 959.064208, 1708.000976, 8.978438, 0.000000, 0.000000, 41.599994, 300.00); 
		CaixasSdxObj[playerid][10] = CreatePlayerObject(playerid,1221, 959.064208, 1708.000976, 8.078433, 0.000000, 0.000000, 41.599994, 300.00); 
	}
	return 1;
}

CMD:var(playerid){ //cmd teste
	new st[40];
	format(st,sizeof(st),"%i",CaixasSdx[playerid]);
	SendClientMessage(playerid, -1, st);
	return true;
}

CMD:descarregar(playerid)
{
	if(PlayerInfo[playerid][pProfissao] != 4) 	return ErrorMsg(playerid, "Nao possui permissao.");
	if(Cargase[playerid] == false) 		return ErrorMsg(playerid, "Seu caminhao nao esta carregar.");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 456) 	return ErrorMsg(playerid, "No estas en veiculo del empleo.");
	if(Cargase[playerid] == true) 

	TogglePlayerControllable(playerid, 0);
	CreateProgress(playerid, "DescarregarCarga","Descarregando caminhao...", 150);
	return 1;
}

CMD:rorgoff(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	ShowPlayerDialog(playerid,DIALOG_LTAGS,DIALOG_STYLE_INPUT,"Remover un Lider","Digite o nome do membro!\n\nSOMENTE O RESPONSAVEL DA ORGANIZACAO PODE!.","Confirmar","X");
	return 1;
}

CMD:infoorg(playerid)
{
	if(PlayerInfo[playerid][Org]==0)return ErrorMsg(playerid, "Nao e de nenhuma organizacao.");
	membrosorg(playerid, PlayerInfo[playerid][Org]);
	return 1;
}

CMD:convidar(playerid,params[])
{   
	new id, String[500];
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Nao fez Login.");
	if(PlayerInfo[playerid][Org] == 0)return ErrorMsg(playerid, "Nao e de nenhuma organizacao.");
	if(PlayerInfo[playerid][Cargo] < 2)return ErrorMsg(playerid, "Nao superior de nenhuma organizacao.");
	if(sscanf(params,"i",id))return ErrorMsg(playerid,"Use: /convidar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == id)
			{
				if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta perto deste jogador.");
				if(PlayerInfo[i][Org] != 0)return ErrorMsg(playerid, "Este jogador ja e de uma organizacao.");
				PlayerInfo[i][convite] = PlayerInfo[playerid][Org];
				format(String,sizeof(String),"Esta sendo convidado por {FFFF00}%04d{FFFFFF}. (%s)",PlayerInfo[playerid][IDF],NomeOrg(playerid));
				ShowPlayerDialog(i,DIALOG_CONVITE,DIALOG_STYLE_MSGBOX,"Convite",String,"Aceitar","X");
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:limparvagas(playerid,params[])
{
	new String[500];
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Nao iniciou login");
	if(PlayerInfo[playerid][Org] == 0)return ErrorMsg(playerid, "Nao e de nenhuma organizacao.");
	if(PlayerInfo[playerid][Cargo] < 2)return ErrorMsg(playerid, "Nao e superior de nenhuma organizacao.");
	new xPlayer;
	if(sscanf(params,"i",xPlayer))
		return ErrorMsg(playerid ,  "/limparvagas [id]");
	format(String, sizeof(String),"Todas as vagas foram removidas.");
	SuccesMsg(playerid, String);
	format(String, sizeof(String), PASTA_ORGS, PlayerInfo[playerid][Org]);
	DOF2_SetString(String, VagasORG[xPlayer], "Nenhum");
	DOF2_SaveFile();
	return 1;
}

CMD:demitir(playerid,params[])
{
	new String[500];
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Nao iniciou login");
	if(PlayerInfo[playerid][Org] == 0)return ErrorMsg(playerid, "Nao faz parte de nenhuma organizacao.");
	if(PlayerInfo[playerid][Cargo] < 2)return ErrorMsg(playerid, "Nao e superior de nenhuma organizacao.");
	new xPlayer;
	if(sscanf(params,"i",xPlayer))
		return ErrorMsg(playerid , "/demitir [playerid]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == xPlayer)
			{
				if(PlayerInfo[i][Org] != PlayerInfo[playerid][Org])return ErrorMsg(playerid, "Este jogador nao e de sua organizacao.");
				format(String, sizeof(String),"Expulsou %04d de sua organizacao!",PlayerInfo[i][IDF]);
				SuccesMsg(playerid, String);
				format(String, sizeof(String),"Foi expulsado de sua organizacao por %04d",PlayerInfo[playerid][IDF]);
				InfoMsg(i, String);
				expulsarmembro(i, PlayerInfo[i][Org]);
				PlayerInfo[i][Org] = 0;
				PlayerInfo[i][Cargo] = 0;
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}
CMD:promover(playerid,params[])
{
	new id,cargo,String[500];
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Nao iniciou login");
	if(PlayerInfo[playerid][Org] == 0)return 1;
	if(PlayerInfo[playerid][Cargo] < 2)return ErrorMsg(playerid, "Nao e superior de nenhuma organizacao.");
	if(sscanf(params,"ii",id,cargo))return ErrorMsg(playerid,"/promover [ID] [CARGO]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == id)
			{
				if(PlayerInfo[i][Cargo] > PlayerInfo[playerid][Cargo])return ErrorMsg(playerid, "Nao pode dar um cargo a um superior.");
				if(cargo > 3)return ErrorMsg(playerid, "Nao pode dar este cargo.");
				if(cargo == 0)return ErrorMsg(playerid, "Nao pode dar este cargo.");
				if(PlayerInfo[i][Org] != PlayerInfo[playerid][Org])return ErrorMsg(playerid, "Este jogador nao de sua organizacao.");
				PlayerInfo[i][Cargo] = cargo;
				format(String,sizeof(String),"Voce deu %s para %04d de organizacao.",NomeCargo(i),PlayerInfo[i][IDF]);
				SuccesMsg(playerid, String);
				format(String,sizeof(String),"%04d colocou voce como %s de organizacao.",PlayerInfo[playerid][IDF],NomeCargo(i));
				InfoMsg(i, String);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:orgs(playerid)
{
	new StringsG[10000],StringsG1[11000];
	format(StringsG,sizeof(StringsG),"{4CBB17}1{FFFFFF} - Policia Militar: %s\n", DOF2_GetString("InfoOrg/1.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}2{FFFFFF} - Policia Rodoviaria: %s\n", DOF2_GetString("InfoOrg/2.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}3{FFFFFF} - ROTA: %s\n", DOF2_GetString("InfoOrg/3.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}4{FFFFFF} - BAEP: %s\n", DOF2_GetString("InfoOrg/4.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}5{FFFFFF} - TROPA DOS AMARELOS: %s\n", DOF2_GetString("InfoOrg/5.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}6{FFFFFF} - TROPA DOS AZUIS: %s\n", DOF2_GetString("InfoOrg/6.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}7{FFFFFF} - TROPA DOS VERMELHOS: %s\n", DOF2_GetString("InfoOrg/7.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}8{FFFFFF} - TROPA DOS VERDES %s\n", DOF2_GetString("InfoOrg/8.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}9{FFFFFF} - Medicos: %s\n", DOF2_GetString("InfoOrg/9.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}10{FFFFFF} - Mecanicos: %s\n", DOF2_GetString("InfoOrg/10.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}11{FFFFFF} - Reportagem: %s\n", DOF2_GetString("InfoOrg/11.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}12{FFFFFF} - Mafia Russa: %s\n", DOF2_GetString("InfoOrg/12.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}13{FFFFFF} - Moto Clube: %s\n", DOF2_GetString("InfoOrg/13.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	ShowPlayerDialog(playerid,DIALOG_ORGS,DIALOG_STYLE_LIST,"Organizacoes do Servidor",StringsG1,"X",#);
	return 1;
}

CMD:darlider(playerid,params[])
{
	new id,org,String[500];
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params,"ii",id,org))return ErrorMsg(playerid,"/darlider [ID] [IDORG]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == id)
			{
				PlayerInfo[i][Org] = org;
				PlayerInfo[i][Cargo] = 3;
				format(String,sizeof(String),"O jogador %s te deu lider da organizacao %s",Name(playerid),NomeOrg(i));
				InfoMsg(i, String);
				format(String,sizeof(String),"O jogador %s recebeu lider da organizacao %s",Name(i),NomeOrg(i));
				SuccesMsg(playerid, String);
				addlider(i, org);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:limparlider(playerid,params[])
{
	new id, String[500];
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params,"i",id))return ErrorMsg(playerid," /limparlider [ID DA ORG]");
	SuccesMsg(playerid,"Org resetada!");
	format(String, sizeof(String), PASTA_ORGS, id);
	if(!DOF2_FileExists(String))return true;
	if(!strcmp(DOF2_GetString(String,VagasORG[0]),"Nenhum",true)) 	return ErrorMsg(playerid, "Nao tem um lider nessa organizacao.");
	for(new i=0; i< sizeof VagasORG; i++)
	{
	   DOF2_SetString(String,VagasORG[i], "Nenhum");
	}
	return 1;
}

CMD:limparlideres(playerid,params[])
{
	new String[500];
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	SuccesMsg(playerid, "Orgs resetadas!");
	for(new vagads = 1; vagads < MAX_ORGS; vagads++)
	{
	   format(String, sizeof(String), PASTA_ORGS, vagads);
	   for(new i=0; i< sizeof VagasORG; i++)
	   {
		   DOF2_SetString(String,VagasORG[i], "Nenhum");
	   }
	   DOF2_SaveFile();
	}
	return 1;
}

CMD:pagar(playerid, params[])
{
	new id, quantia, string[800];
	if(sscanf(params,"ii",id,quantia)) return ErrorMsg(playerid,  " /pagar [ID] [QUANTIA]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == id)
			{
				if(!ProxDetectorS(8.0, playerid, i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");

				PlayerInfo[i][pDinheiro] += quantia;
				PlayerInfo[playerid][pDinheiro] -= quantia;
				format(string, sizeof(string), "Pagou R$%d para %04d", quantia, PlayerInfo[i][IDF]);
				SuccesMsg(playerid, string);
				format(string, sizeof(string), "Recebeu R$%d de %04d.", quantia, PlayerInfo[playerid][IDF]);
				InfoMsg(i, string);
			}
		}
  	}
  	ErrorMsg(playerid, "Jogador nao conectado.");
	return 1;
} 

CMD:aa(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(pLogado[playerid] == false)              				return ErrorMsg(playerid, "Necessita inicia login.");
	{
		new ComandosAdmins[5000];		
		if(PlayerInfo[playerid][pAdmin] == 1)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Estagiario {FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /htrabalhar {FFFFFF}- Comecar turno de ajudante.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /hir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /htrazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /hbanir {FFFFFF}- Banir a conta do jogador.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
		if(PlayerInfo[playerid][pAdmin] == 2)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Administrador{FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /atrabalhar {FFFFFF}- Comecar turno de administrador.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pos {FFFFFF}- Pegar posicao atual.\n");
			strcat(ComandosAdmins, "{FFFF00} /av {FFFFFF}- Anuncio admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /cv {FFFFFF}- Criar um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /cadeia {FFFFFF}- Colocar um jogador na cadeia.\n");
			strcat(ComandosAdmins, "{FFFF00} /ir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /trazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /contagem {FFFFFF}- Iniciar uma contagem.\n");
			strcat(ComandosAdmins, "{FFFF00} /tv {FFFFFF}- Espectar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desarmar {FFFFFF}- Remover todas as armas do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /banir {FFFFFF}- Banir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /tempban {FFFFFF}- Banir o jogador por tempo definido.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendaban {FFFFFF}- Agendar um banimento a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendacadeia {FFFFFF}- Agenda cadeia a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /congelar {FFFFFF}- Congelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /descongelar {FFFFFF}- Descongelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /reanimar {FFFFFF}- Reanimar um jogador morto.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
		if(PlayerInfo[playerid][pAdmin] == 3)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Administrador Geral{FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /atrabalhar {FFFFFF}- Comecar turno de administrador.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pos {FFFFFF}- Pegar posicao atual.\n");
			strcat(ComandosAdmins, "{FFFF00} /av {FFFFFF}- Anuncio admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /cv {FFFFFF}- Criar um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /cadeia {FFFFFF}- Colocar um jogador na cadeia.\n");
			strcat(ComandosAdmins, "{FFFF00} /ir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /trazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /contagem {FFFFFF}- Iniciar uma contagem.\n");
			strcat(ComandosAdmins, "{FFFF00} /tv {FFFFFF}- Espectar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desarmar {FFFFFF}- Remover todas as armas do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /banir {FFFFFF}- Banir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /tempban {FFFFFF}- Banir o jogador por tempo definido.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendaban {FFFFFF}- Agendar um banimento a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendacadeia {FFFFFF}- Agenda cadeia a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /congelar {FFFFFF}- Congelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /descongelar {FFFFFF}- Descongelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /reanimar {FFFFFF}- Reanimar um jogador morto.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
		if(PlayerInfo[playerid][pAdmin] == 4)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Supervisor{FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /atrabalhar {FFFFFF}- Comecar turno de administrador.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pos {FFFFFF}- Pegar posicao atual.\n");
			strcat(ComandosAdmins, "{FFFF00} /av {FFFFFF}- Anuncio admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /cv {FFFFFF}- Criar um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /cadeia {FFFFFF}- Colocar um jogador na cadeia.\n");
			strcat(ComandosAdmins, "{FFFF00} /ir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /trazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /contagem {FFFFFF}- Iniciar uma contagem.\n");
			strcat(ComandosAdmins, "{FFFF00} /tv {FFFFFF}- Espectar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desarmar {FFFFFF}- Remover todas as armas do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /banir {FFFFFF}- Banir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /tempban {FFFFFF}- Banir o jogador por tempo definido.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendaban {FFFFFF}- Agendar um banimento a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendacadeia {FFFFFF}- Agenda cadeia a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /congelar {FFFFFF}- Congelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /descongelar {FFFFFF}- Descongelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /reanimar {FFFFFF}- Reanimar um jogador morto.\n");
			strcat(ComandosAdmins, "{FFFF00} /banirip {FFFFFF}- Banir o IP de um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanir {FFFFFF}- Desbanir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanirip {FFFFFF}- Desbanir o IP do jogador.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
		if(PlayerInfo[playerid][pAdmin] == 5)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Diretor{FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /atrabalhar {FFFFFF}- Comecar turno de administrador.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pos {FFFFFF}- Pegar posicao atual.\n");
			strcat(ComandosAdmins, "{FFFF00} /av {FFFFFF}- Anuncio admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /cv {FFFFFF}- Criar um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /cadeia {FFFFFF}- Colocar um jogador na cadeia.\n");
			strcat(ComandosAdmins, "{FFFF00} /ir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /trazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /contagem {FFFFFF}- Iniciar uma contagem.\n");
			strcat(ComandosAdmins, "{FFFF00} /tv {FFFFFF}- Espectar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desarmar {FFFFFF}- Remover todas as armas do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /banir {FFFFFF}- Banir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /tempban {FFFFFF}- Banir o jogador por tempo definido.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendaban {FFFFFF}- Agendar um banimento a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendacadeia {FFFFFF}- Agenda cadeia a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /congelar {FFFFFF}- Congelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /descongelar {FFFFFF}- Descongelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /reanimar {FFFFFF}- Reanimar um jogador morto.\n");
			strcat(ComandosAdmins, "{FFFF00} /banirip {FFFFFF}- Banir o IP de um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanir {FFFFFF}- Desbanir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanirip {FFFFFF}- Desbanir o IP do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /daritem {FFFFFF}- Dar um item de inventario a um jogador.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
		if(PlayerInfo[playerid][pAdmin] == 6)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Fundador{FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /atrabalhar {FFFFFF}- Comecar turno de administrador.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pos {FFFFFF}- Pegar posicao atual.\n");
			strcat(ComandosAdmins, "{FFFF00} /av {FFFFFF}- Anuncio admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /cv {FFFFFF}- Criar um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /cadeia {FFFFFF}- Colocar um jogador na cadeia.\n");
			strcat(ComandosAdmins, "{FFFF00} /ir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /trazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /contagem {FFFFFF}- Iniciar uma contagem.\n");
			strcat(ComandosAdmins, "{FFFF00} /tv {FFFFFF}- Espectar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desarmar {FFFFFF}- Remover todas as armas do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /banir {FFFFFF}- Banir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /tempban {FFFFFF}- Banir o jogador por tempo definido.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendaban {FFFFFF}- Agendar um banimento a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendacadeia {FFFFFF}- Agenda cadeia a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /congelar {FFFFFF}- Congelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /descongelar {FFFFFF}- Descongelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /reanimar {FFFFFF}- Reanimar um jogador morto.\n");
			strcat(ComandosAdmins, "{FFFF00} /banirip {FFFFFF}- Banir o IP de um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanir {FFFFFF}- Desbanir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanirip {FFFFFF}- Desbanir o IP do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /daritem {FFFFFF}- Dar um item de inventario a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setskin {FFFFFF}- Setar skin a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setvida {FFFFFF}- Setar vida a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setcolete {FFFFFF}- Setar colete a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /dardinheiro {FFFFFF}- Dar dinheiro a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setarma {FFFFFF}- Setar arma a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /antiafk {FFFFFF}- Desativar ou Ativar o AntiAFK do servidor.\n");
			strcat(ComandosAdmins, "{FFFF00} /chat {FFFFFF}- Desativar ou Ativar o chat do servidor.\n");
			strcat(ComandosAdmins, "{FFFF00} /gmx {FFFFFF}- Reniciar o servidor (nao recomendado com muitos jogadores).\n");
			strcat(ComandosAdmins, "{FFFF00} /rorgoff {FFFFFF}- Retirar jogador da org.\n");
			strcat(ComandosAdmins, "{FFFF00} /darlider {FFFFFF}- Dar lider a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /limparlider {FFFFFF}- Limpar lider da org.\n");
			strcat(ComandosAdmins, "{FFFF00} /limparlideres {FFFFFF}- Limpar lideres da org.\n");
			strcat(ComandosAdmins, "{FFFF00} /criarcasa {FFFFFF}- Criar casa.\n");
			strcat(ComandosAdmins, "{FFFF00} /dcasa {FFFFFF}- Deletar casa.\n");
			strcat(ComandosAdmins, "{FFFF00} /rtc {FFFFFF}- Respawnar veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /rac {FFFFFF}- Respawnar todos os veiculos.\n");
			strcat(ComandosAdmins, "{FFFF00} /setgasolina {FFFFFF}- Setar gasolina em um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /addv {FFFFFF}- Adicionar veiculo de concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /editv {FFFFFF}- Editar veiculo da concessionaria\n");
			strcat(ComandosAdmins, "{FFFF00} /adddealership {FFFFFF}- Adicionar concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /deletedealership {FFFFFF}- Deletar concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /movedealership {FFFFFF}- Mover concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /gotodealership {FFFFFF}- Ir ate a concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /addfuelstation {FFFFFF}- Adicionar posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /deletefuelstation {FFFFFF}- Deletar posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /movefuelstation {FFFFFF}- Mover posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /gotofuelstation {FFFFFF}- Ir ate o posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /criarcn {FFFFFF}- Adicionar um caca niquel.\n");
			strcat(ComandosAdmins, "{FFFF00} /dcn {FFFFFF}- Deletar um caca niquel.\n");
			strcat(ComandosAdmins, "{FFFF00} /editcn {FFFFFF}- Editar um caca niquel.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
		if(PlayerInfo[playerid][pAdmin] == 7)
		{
			strcat(ComandosAdmins, "\t{FFFF00}- {FFFFFF}Desenvolvedor{FFFF00}- {FFFFFF}\n\n");
			strcat(ComandosAdmins, "{FFFF00} /atrabalhar {FFFFFF}- Comecar turno de administrador.\n");
			strcat(ComandosAdmins, "{FFFF00} /a {FFFFFF}- Chat admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /kick {FFFFFF}- Kick um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pediravaliar {FFFFFF}- Pedir avaliacao a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /verpontos {FFFFFF}- Ver pontuacao de atendimento.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /pos {FFFFFF}- Pegar posicao atual.\n");
			strcat(ComandosAdmins, "{FFFF00} /av {FFFFFF}- Anuncio admin.\n");
			strcat(ComandosAdmins, "{FFFF00} /cv {FFFFFF}- Criar um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /cadeia {FFFFFF}- Colocar um jogador na cadeia.\n");
			strcat(ComandosAdmins, "{FFFF00} /ir {FFFFFF}- Teleportar ate um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /trazer {FFFFFF}- Teleportar o jogador ate voce.\n");
			strcat(ComandosAdmins, "{FFFF00} /contagem {FFFFFF}- Iniciar uma contagem.\n");
			strcat(ComandosAdmins, "{FFFF00} /tv {FFFFFF}- Espectar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desarmar {FFFFFF}- Remover todas as armas do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /banir {FFFFFF}- Banir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /tempban {FFFFFF}- Banir o jogador por tempo definido.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendaban {FFFFFF}- Agendar um banimento a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /agendacadeia {FFFFFF}- Agenda cadeia a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /adv {FFFFFF}- Adverter um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /congelar {FFFFFF}- Congelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /descongelar {FFFFFF}- Descongelar um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /reanimar {FFFFFF}- Reanimar um jogador morto.\n");
			strcat(ComandosAdmins, "{FFFF00} /banirip {FFFFFF}- Banir o IP de um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanir {FFFFFF}- Desbanir a conta do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /desbanirip {FFFFFF}- Desbanir o IP do jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /daritem {FFFFFF}- Dar um item de inventario a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setskin {FFFFFF}- Setar skin a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setvida {FFFFFF}- Setar vida a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setcolete {FFFFFF}- Setar colete a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /dardinheiro {FFFFFF}- Dar dinheiro a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /setarma {FFFFFF}- Setar arma a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /antiafk {FFFFFF}- Desativar ou Ativar o AntiAFK do servidor.\n");
			strcat(ComandosAdmins, "{FFFF00} /chat {FFFFFF}- Desativar ou Ativar o chat do servidor.\n");
			strcat(ComandosAdmins, "{FFFF00} /gmx {FFFFFF}- Reniciar o servidor (nao recomendado com muitos jogadores).\n");
			strcat(ComandosAdmins, "{FFFF00} /rorgoff {FFFFFF}- Retirar jogador da org.\n");
			strcat(ComandosAdmins, "{FFFF00} /darlider {FFFFFF}- Dar lider a um jogador.\n");
			strcat(ComandosAdmins, "{FFFF00} /limparlider {FFFFFF}- Limpar lider da org.\n");
			strcat(ComandosAdmins, "{FFFF00} /limparlideres {FFFFFF}- Limpar lideres da org.\n");
			strcat(ComandosAdmins, "{FFFF00} /criarcasa {FFFFFF}- Criar casa.\n");
			strcat(ComandosAdmins, "{FFFF00} /dcasa {FFFFFF}- Deletar casa.\n");
			strcat(ComandosAdmins, "{FFFF00} /rtc {FFFFFF}- Respawnar veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /rac {FFFFFF}- Respawnar todos os veiculos.\n");
			strcat(ComandosAdmins, "{FFFF00} /setgasolina {FFFFFF}- Setar gasolina em um veiculo.\n");
			strcat(ComandosAdmins, "{FFFF00} /addv {FFFFFF}- Adicionar veiculo de concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /editv {FFFFFF}- Editar veiculo da concessionaria\n");
			strcat(ComandosAdmins, "{FFFF00} /adddealership {FFFFFF}- Adicionar concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /deletedealership {FFFFFF}- Deletar concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /movedealership {FFFFFF}- Mover concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /gotodealership {FFFFFF}- Ir ate a concessionaria.\n");
			strcat(ComandosAdmins, "{FFFF00} /addfuelstation {FFFFFF}- Adicionar posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /deletefuelstation {FFFFFF}- Deletar posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /movefuelstation {FFFFFF}- Mover posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /gotofuelstation {FFFFFF}- Ir ate o posto de gasolina.\n");
			strcat(ComandosAdmins, "{FFFF00} /criarcn {FFFFFF}- Adicionar um caca niquel.\n");
			strcat(ComandosAdmins, "{FFFF00} /dcn {FFFFFF}- Deletar um caca niquel.\n");
			strcat(ComandosAdmins, "{FFFF00} /editcn {FFFFFF}- Editar um caca niquel.\n");
			ShowPlayerDialog(playerid, DIALOG_AJUDA_ADMIN, DIALOG_STYLE_MSGBOX, "Ajuda Comandos Admin", ComandosAdmins, "X", #);
		}
	}
	return 1;
}

CMD:d(playerid, params[])
{
	if(!IsPolicial(playerid))						return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 								return ErrorMsg(playerid, "Nao esta em patrulha.");
	if(sscanf(params, "s[56]", Str)) 							return ErrorMsg(playerid,"USE: /d [TEXTO]");

	format(Str, sizeof(Str), "{FFFFFF}[{FFFF00}%s{FFFFFF}] {FFFF00}%04d{FFFFFF} disse {FFFF00}%s", NomeCargo(playerid), PlayerInfo[playerid][IDF], Str);
	SendRadioMessage(0xDDA0DDFF, Str);

	return 1;
}

CMD:ga(playerid, params[])
{
	if(!IsBandido(playerid))						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "s[56]", Str)) 							return ErrorMsg(playerid,"USE: /ga [TEXTO]");

	format(Str, sizeof(Str), "{FFFFFF}[{FFFF00}%s{FFFFFF}] {FFFF00}%04d{FFFFFF} disse {FFFF00}%s", NomeCargo(playerid), PlayerInfo[playerid][IDF], Str);
	SendGangMessage(0xDDA0DDFF, Str);

	return 1;
}

CMD:algemar(playerid, params[])
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	if(sscanf(params, "i", ID))					return ErrorMsg(playerid,"USE: /algemar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				TogglePlayerControllable(i, false);
				PlayerInfo[i][pCongelado] = true;
				SuccesMsg(playerid, "Algemou o individuo.");
				InfoMsg(i, "Foi algemado.");
				SetPlayerAttachedObject(i, 5, 19418, 6, -0.031999, 0.024000, -0.024000, -7.900000, -32.000011, -72.299987, 1.115998, 1.322000, 1.406000);
				SetPlayerSpecialAction(i, SPECIAL_ACTION_CUFFED);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}
CMD:desalgemar(playerid, params[])
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	if(sscanf(params, "i", ID))					return ErrorMsg(playerid,"USE: /desalgemar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				TogglePlayerControllable(i, true);
				PlayerInfo[i][pCongelado] = false;
				SuccesMsg(playerid, "Desalgemou o individuo.");
				InfoMsg(i, "Foi desalgemado.");
				ClearAnimations(i);
				RemovePlayerAttachedObject(i,5);
				SetPlayerSpecialAction(i, SPECIAL_ACTION_NONE);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:pveiculo(playerid, params[])
{
	new carid = GetPlayerVehicleID(playerid);
	if(IsPolicial(playerid) || IsBandido(playerid))
	{
		if(sscanf(params, "i", ID))					return ErrorMsg(playerid,"USE: /pveiculo [ID]");
		foreach(Player,i)
		{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == ID)
				{
					if(!IsPlayerInAnyVehicle(playerid))			return ErrorMsg(playerid, "Voce nao esta em um veiculo.");
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 		return ErrorMsg(playerid, "Voce nao esta.");
					if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
					TogglePlayerControllable(i, 0);
					PutPlayerInVehicle(i, carid, 4);
				}
			}
			else
			{
				ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
	}
	return 1;
}

CMD:rveiculo(playerid, params[])
{
	if(IsPolicial(playerid) || IsBandido(playerid))
	{
		if(sscanf(params, "i", ID))					return ErrorMsg(playerid,"USE: /rveiculo [ID]");
		foreach(Player,i)
		{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == ID)
				{
					if(!IsPlayerInAnyVehicle(playerid))			return ErrorMsg(playerid, "Voce nao esta em um veiculo.");
					if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 		return ErrorMsg(playerid, "Voce nao esta como motorista.");
					if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta perto do jogador.");
					TogglePlayerControllable(i, true);
					RemovePlayerFromVehicle(i);
				}
			}
			else
			{
				ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
	}
	return 1;
}

CMD:prender(playerid, params[])
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	if(sscanf(params, "iis[56]", ID, Numero, Motivo))			return ErrorMsg(playerid,"USE: /prender [ID] [TIEMPO EM MINUTOS] [RAZON]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				if(!IsPlayerInAnyVehicle(playerid))			return ErrorMsg(playerid, "Voce nao esta em um veiculo.");
				if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
				if(PlayerToPoint(3.0, playerid, -1606.267578, 733.912414, -5.234413))
				{

					if(Numero != 0)
					{
						PlayerInfo[i][pCadeia] = Numero * 60;
						SetPlayerPos(i, 322.197998,302.497985,999.148437);
						SetPlayerInterior(i, 5);
						SetPlayerVirtualWorld(i, 0);
						InfoMsg(playerid, "Preso por cometer delitos.");
						SetPlayerWantedLevel(playerid, 0);
						TogglePlayerControllable(i, true);
						RemovePlayerFromVehicle(i);
						ResetPlayerWeapons(playerid);
						TogglePlayerControllable(i, false);
						SetTimerEx("carregarobj", 5000, 0, "i", i);

					}
					else
					{
						PlayerInfo[i][pCadeia] = 1;
					}
					//
					format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jogador {FFFF00}%04d{FFFFFF}foi preso por {FFFF00}%s {FFFFFF}por {FFFF00}%i {FFFFFF}minutos. Motivo: {FFFF00}%s", PlayerInfo[i][IDF], NomeOrg(playerid), Numero, Motivo);
					SendClientMessageToAll(-1, Str);
				}
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:ab(playerid)
{
	new String[5000];
	if(IsPolicial(playerid))
	{
		format(String,sizeof(String),"{6959CD}*** %s, PARE OU IREMOS ATIRAR!!!! ***", NomeOrg(playerid));
	}
	if(IsBandido(playerid))
	{
		format(String,sizeof(String),"{6959CD}*** %s, PARE OU IREMOS ATIRAR!!!! ***", NomeOrg(playerid));
	}
	ProxDetector(30.0, playerid, String, -1,-1,-1,-1,-1);
	return 1;
}

CMD:su(playerid, params[])
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	if(sscanf(params, "di", ID, Numero))						return ErrorMsg(playerid,"USE: /su [ID] [LEVEL]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
				//
				format(Str, sizeof(Str), "O Policial %04d colocou %i de procurado em voce.", PlayerInfo[playerid][IDF], Numero);
				InfoMsg(i, Str);

				SuccesMsg(playerid, "Colocou com sucesso o jogador como procurado.");
				//
				SetPlayerWantedLevel(i, Numero);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:revistar(playerid, params[])
{
	new str[64];
	if(IsPolicial(playerid) || IsBandido(playerid))	
	{
		if(sscanf(params, "d", ID))                        return ErrorMsg(playerid,"USE: /verinv [ID]");
		foreach(Player,i)
		{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == ID)
				{
					if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
					if(InventarioAberto[playerid])
					{
						for(new in = 0; in < 40; ++i)
						{
							PlayerTextDrawHide(playerid, DrawInv[playerid][in]);
						}
						InventarioAberto[playerid] = 0;
						CancelSelectTextDraw(playerid);
						return 1;
					}
					else
					{
						format(str, sizeof(str), "Inventario: %s", Name(i));
						PlayerTextDrawSetString(playerid, DrawInv[playerid][34], str);
						PlayerTextDrawSetString(playerid, DrawInv[playerid][38], "");
						for(new in = 1; in < 31; ++i)
						{
							PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][in], PlayerInventario[i][in][Slot]);
							if(PlayerInventario[i][in][Slot] == -1)
							{
								PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][in], 0.000000, 0.000000, 0.000000, 999);
							}
							else
							{
								PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][in], 0.000000, 0.000000, 0.000000, 1);
							}
						}
						for(new in = 0; in < 40; ++i)
						{
							PlayerTextDrawShow(playerid, DrawInv[playerid][in]);
						}
						SelectTextDraw(playerid, 0xC4C4C4AA);
						InventarioAberto[playerid] = 1;
					}
				}
			}
			else
			{
				ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
	}
	return 1;
}

CMD:rarmas(playerid, params[])
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	if(sscanf(params, "d", ID))									return ErrorMsg(playerid,"USE: /rarmas [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
				ResetPlayerWeapons(i);
				//
				format(Str, sizeof(Str), "Desarmou: %04d", PlayerInfo[i][IDF]);
				SuccesMsg(playerid, Str);
				//
				format(Str, 106, "Foi desarmado por %04d", PlayerInfo[playerid][IDF]);
				InfoMsg(i, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:procurados(playerid) 
{ 
	new string[85]; 
	new count; 
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	foreach(new i: Player)
	{ 
		if(GetPlayerWantedLevel(i)) 
		{ 
			if(IsPlayerConnected(i)) 
			{ 
				format(string, sizeof(string), "{FFFF00}%04d{FFFFFF} Nivel:{FFFF00}%d", PlayerInfo[i][IDF], GetPlayerWantedLevel(i)); 
				ShowPlayerDialog(playerid, DIALOG_PROCURADOS, DIALOG_STYLE_LIST,"Lista de Procuraods", string, "X", #);
				count++; 
			} 
		} 
	} 
	if(count == 0) 
		return ErrorMsg(playerid, "Nao tem jogadores procurados."); 

	return true; 
}

CMD:multar(playerid, params[])
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");
	if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
	if(sscanf(params, "dd", ID, Numero))		return ErrorMsg(playerid,"USE: /multar [ID] [QUANTIA]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
				//
				PlayerInfo[i][pMultas] += Numero;
				format(Str, sizeof(Str), "Deu a %04d, %d de multa.", PlayerInfo[i][IDF], Numero);
				SuccesMsg(playerid, Str);
				//
				format(Str, sizeof(Str), "O Policial %04d te deu %d de multa.", PlayerInfo[playerid][IDF], Numero);
				InfoMsg(i, Str);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:verdocumentos(playerid, params[])
{
	if(IsPolicial(playerid) || IsBandido(playerid))
	{
		if(Patrulha[playerid] == false) 				return ErrorMsg(playerid, "Nao esta em servico");
		if(sscanf(params, "dd", ID))		return ErrorMsg(playerid,"USE: /verdocumentos [ID] ");
		foreach(Player,i)
		{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == ID)
				{
					if(!IsPerto(playerid,i))return ErrorMsg(playerid, "Nao esta proximo do jogador.");
					//
					new megastrings[500], String2[500];
					format(String2,sizeof(String2), "{FFFFFF}Nome: {FFFF00}%s{FFFFFF}({FFFF00}%d{FFFFFF})\n{FFFFFF}VIP: {FFFF00}%s\n{FFFFFF}Dinheiro: {FFFF00}%s\n{FFFFFF}Banco: {FFFF00}%s\n", Name(i),PlayerInfo[i][IDF], VIP(i),ConvertMoney(PlayerInfo[i][pDinheiro]),ConvertMoney(PlayerInfo[i][pBanco]));
					strcat(megastrings, String2);
					format(String2,sizeof(String2), "{FFFFFF}Profissao:{FFFF00} %s\n{FFFFFF}Org:{FFFF00} %s\n{FFFFFF}Cargo:{FFFF00} %s\n", Profs(i), NomeOrg(i), NomeCargo(i));
					strcat(megastrings, String2);
					format(String2,sizeof(String2), "{FFFFFF}Multas:{FFFF00} %d\n{FFFFFF}N°Casa:{FFFF00} %d\n", PlayerInfo[i][pMultas], PlayerInfo[i][Casa]);
					strcat(megastrings, String2);
					format(String2,sizeof(String2), "{FFFFFF}Tempo Jogados:{FFFF00} %s\n{FFFFFF}Expira VIP:{FFFF00} %s\n{FFFFFF}Licenca Conduzir: {FFFF00}%s", convertNumber(PlayerInfo[i][pSegundosJogados]), convertNumber(PlayerInfo[i][ExpiraVIP]-gettime()), temlicenca(i));
					strcat(megastrings, String2);
					ShowPlayerDialog(playerid, DIALOG_CMDRG,DIALOG_STYLE_MSGBOX,"Seu Documento",megastrings,"X",#);
				}
			}
			else
			{
				ErrorMsg(playerid, "Jogador nao conectado.");
			}
		}
	}
	return 1;
}

CMD:qplantacao(playerid)
{
	if(!IsPolicial(playerid))		return ErrorMsg(playerid, "Nao possui permissao.");{
		new perto = 0;
		for(new mac = 0; mac < MAX_MACONHA; mac++)
		{
			if(MaconhaInfo[mac][PodeUsar] == false && IsPlayerInRangeOfPoint(playerid, 2, MaconhaInfo[mac][mX],MaconhaInfo[mac][mY],MaconhaInfo[mac][mZ]))
			{
				perto = 1;
				ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop",2.0,1,0,0,0,60000,1);
				SetTimerEx("AnimatioN", 100, false, "i", playerid);
				SetTimerEx("MaconhaQueimar", 17000, false, "id", playerid, mac);
				PlantandoMaconha[playerid] = true;
				SuccesMsg(playerid, "Esperar....");
				return true;
			}
		}
		if(perto == 0)return ErrorMsg(playerid, "Nao esta proximo de nenhum plantacao de maconha.");
	}
	return true;
}

CMD:cmaconha(playerid)
{
	if(PlantandoMaconha[playerid] == true)
		return ErrorMsg(playerid, "Ja a uma semente que voce esta plantando ou colhendo.");

	new perto = 0;

	for(new mac = 0; mac < MAX_MACONHA; mac++)
	{
		if(MaconhaInfo[mac][PodeUsar] == false && IsPlayerInRangeOfPoint(playerid, 2, MaconhaInfo[mac][mX],MaconhaInfo[mac][mY],MaconhaInfo[mac][mZ]))
		{
			perto = 1;
			if(strcmp(MaconhaInfo[mac][Dono], Name(playerid), true) == 0)
			{
				ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop",2.0,1,0,0,0,0);
				SetTimerEx("AnimatioN", 100, false, "i", playerid);
				SetTimerEx("MaconhaColher", 17000, false, "id", playerid, mac);
				PlantandoMaconha[playerid] = true;
				SuccesMsg(playerid, "Voce esta colhendo esta plantacao de maconha, aguarde...");
				return true;
			}
			else return ErrorMsg(playerid, "[?] Opss, parece que nao e dono de esta plantacao");
		}
	}
	if(perto == 0)return ErrorMsg(playerid, "Nao esta proximo a nenhuma plantacao.");
	return true;
}

CMD:maconhas(playerid)
{
	if(CountPlantacao(playerid) < 1)
		return ErrorMsg(playerid, "Nao plantou nenhuma maconha.");

	new localmac = 0;
	new MegaString[500];
	new string[500];
	for(new maconhaid=0;maconhaid < MAX_MACONHA; maconhaid++)
	{
		if(MaconhaInfo[maconhaid][PodeUsar] == false && strcmp(MaconhaInfo[maconhaid][Dono], Name(playerid), true)==0)
		{
			localmac++;
			LocalizeMaconha[localmac][playerid] = maconhaid;

			if(MaconhaInfo[maconhaid][Crescida] >= Max_Crescida)
			{
				format(string, sizeof string, "Plantacao %d: {00BC00}(Pronta) Gramas: [%d]\n",maconhaid+1,MaconhaInfo[maconhaid][GramasProntas]);
				strcat(MegaString,string);
			}
			else
			{
				format(string, sizeof string, "Plantacao %d: {00BC00}Crescemdo:[%d/%d] Gramas:[%d]\n",maconhaid+1, MaconhaInfo[maconhaid][Crescida], Max_Crescida, MaconhaInfo[maconhaid][GramasProntas]);
				strcat(MegaString,string);
			}
		}
	}

	ShowPlayerDialog(playerid, DIALOG_LMARIHUANA, DIALOG_STYLE_LIST, "Menu Maconha", MegaString, "Localizar", "X");
	return true;
}

CMD:reanimar(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 2)		return ErrorMsg(playerid, "Nao possui permissao.");
	format(Str, sizeof(Str),"Introduza o ID do jogador que quer reanimar");
	ShowPlayerDialog(playerid,DIALOG_REANIMAR,1,"Reanimar jogador", Str, "Confirmar",#);
	return 1;
}

CMD:criarkey(playerid, params[])
{
	new File[255];
	new vl;  
	if(PlayerInfo[playerid][pAdmin] < 7)		return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "d", vl)) return ErrorMsg(playerid, "Use: /criarkey [Valor]");
	{
		new Cod = randomEx(0,99999999);
		format(File, sizeof(File), PASTA_KEYS, Cod);
		DOF2_CreateFile(File);
		DOF2_SetInt(File, "Valor", vl);
		DOF2_SaveFile();
		new str[180];
		format(str, sizeof(str), "O cupom %d se criou com %i de coins.", Cod, vl);
		SuccesMsg(playerid,  str);
	}
	return 1;
}

CMD:ativarkey(playerid, params[])
{
	new File[255];
	new Cod, Din;
	if(sscanf(params, "d", Cod)) return ErrorMsg(playerid,  "Use: /ativarkey [Codigo]");
	{
		format(File, sizeof(File), PASTA_KEYS, Cod);
		if(DOF2_FileExists(File)) 
		{
			Din = DOF2_GetInt(File, "Valor");
			new string[255];
			new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
			format(string,sizeof(string),"### COINS ATIVADOS\n\nJogador: %04d\nQuantidade Agora: %s\nQuantidade Antes: %s\nCod: %d", PlayerInfo[playerid][IDF],ConvertMoney(PlayerInfo[playerid][pCoins]+Din),ConvertMoney(PlayerInfo[playerid][pCoins]), Cod);
			DCC_SetEmbedColor(embed, 0xFFFF00);
			DCC_SetEmbedDescription(embed, string);
			DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
			DCC_SendChannelEmbedMessage(AtivarCoins, embed);
			PlayerInfo[playerid][pCoins] += Din;
			Din = 0;
			SuccesMsg(playerid, "Codigo utilizado!");
			DOF2_RemoveFile(File);
		}
		else
		{
			ErrorMsg(playerid, "Codigo nao existe!");
		}
	}
	return 1;
}

CMD:ltumba(playerid)
{
	if(PlayerToPoint(3.0, playerid, 934.1115,-1103.3857,24.3118))
	if(PlayerInfo[playerid][pProfissao] != 5) 	return ErrorMsg(playerid, "Nao possui permissao.");
	if(Cargase[playerid] == true) 	return ErrorMsg(playerid, "Ja localizou um hospital para pegar a tumba."); 
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 442)  	return ErrorMsg(playerid, "Nao esta em veiculo do emprego.");
	ShowPlayerDialog(playerid, DIALOG_LTUMBA, DIALOG_STYLE_LIST, "Hospital.", "{FFFF00}- {FFFFFF}Los Santos\t{32CD32}R$600\n{FFFF00}- {FFFFFF}Las Venturas\t{32CD32}R$1200\n{FFFF00}- {FFFFFF}San Fierro\t{32CD32}R$2000\n", "Localizar", "");
	return 1;
}

CMD:criarcasa(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	{
		new valor, interior;
		if(sscanf(params, "ii", valor, interior))
		{
			return ErrorMsg(playerid,  "Use: /criarcasa [valor] [interior 1 - 10].");
		}
		else if(interior < 0 || interior > 10)
		{
			return ErrorMsg(playerid, "Introduza um interior correto.");
		}
		else if(interior == 1) // Casa Level 1
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 1);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 224.288);
					DOF2_SetFloat(File, "CasaInteriorY", 1289.1907);
					DOF2_SetFloat(File, "CasaInteriorZ", 1082.1406);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 2) // Casa Level 2
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 2);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 225.5707);
					DOF2_SetFloat(File, "CasaInteriorY", 1240.0643);
					DOF2_SetFloat(File, "CasaInteriorZ", 1082.1406);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 3) // Casa Level 3
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 6);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", -68.5145);
					DOF2_SetFloat(File, "CasaInteriorY", 1353.8485);
					DOF2_SetFloat(File, "CasaInteriorZ", 1080.2109);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 4) // Casa Level 4
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 5);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 227.7559);
					DOF2_SetFloat(File, "CasaInteriorY", 1114.3844);
					DOF2_SetFloat(File, "CasaInteriorZ", 1080.9922);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 5) // Casa Level 5
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 10);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 2261.0977);
					DOF2_SetFloat(File, "CasaInteriorY", -1137.8833);
					DOF2_SetFloat(File, "CasaInteriorZ", 1050.6328);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 6) // Casa Level 6
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 8);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 2365.1089);
					DOF2_SetFloat(File, "CasaInteriorY", -1133.0795);
					DOF2_SetFloat(File, "CasaInteriorZ", 1050.875);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 7) // Casa Level 7
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 3);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 2496.0549);
					DOF2_SetFloat(File, "CasaInteriorY", -1695.1749);
					DOF2_SetFloat(File, "CasaInteriorZ", 1014.7422);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 8) // Casa Level 8
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 6);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 234.2826);
					DOF2_SetFloat(File, "CasaInteriorY", 1065.229);
					DOF2_SetFloat(File, "CasaInteriorZ", 1084.2101);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 9) // Casa Level 9
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 5);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 140.3679);
					DOF2_SetFloat(File, "CasaInteriorY", 1367.8837);
					DOF2_SetFloat(File, "CasaInteriorZ", 1083.8621);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
		else if(interior == 10) // Casa Level 10
		{
			for(new i; i < MAX_CASAS; i++)
			{
				format(File, sizeof(File), PASTA_CASAS, i);
				if(!DOF2_FileExists(File))
				{
					new Float:X, Float:Y, Float:Z;
					GetPlayerPos(playerid, Float:X, Float:Y, Float:Z);
					DOF2_CreateFile(File);
					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetString(File, "Casa Texto", "Nenhum");
					DOF2_SetInt(File, "CasaId", i);
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SetInt(File, "CasaValor", valor);
					DOF2_SetInt(File, "CasaInterior", 5);

					DOF2_SetFloat(File, "CasaX", X);
					DOF2_SetFloat(File, "CasaY", Y);
					DOF2_SetFloat(File, "CasaZ", Z);

					DOF2_SetFloat(File, "CasaInteriorX", 1267.8407);
					DOF2_SetFloat(File, "CasaInteriorY", -776.9587);
					DOF2_SetFloat(File, "CasaInteriorZ", 1091.9063);
					DOF2_SaveFile();

					CasaInfo[i][CasaId] = DOF2_GetInt(File, "CasaId");
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");
					CasaInfo[i][CasaValor] = DOF2_GetInt(File, "CasaValor");
					CasaInfo[i][CasaInterior] = DOF2_GetInt(File, "CasaInterior");

					CasaInfo[i][CasaX] = DOF2_GetFloat(File, "CasaX");
					CasaInfo[i][CasaY] = DOF2_GetFloat(File, "CasaY");
					CasaInfo[i][CasaZ] = DOF2_GetFloat(File, "CasaZ");

					CasaInfo[i][CasaInteriorX] = DOF2_GetFloat(File, "CasaInteriorX");
					CasaInfo[i][CasaInteriorY] = DOF2_GetFloat(File, "CasaInteriorY");
					CasaInfo[i][CasaInteriorZ] = DOF2_GetFloat(File, "CasaInteriorZ");

					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					format(CasaInfo[i][CasaTexto], 64, DOF2_GetString(File, "CasaTexto"));

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}R$%s\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], ConvertMoney(CasaInfo[i][CasaValor]));
					TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
					return 1;
				}
			}
		}
	}
	return 1;
}

CMD:dcasa(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return ErrorMsg(playerid, "Nao possui permissao.");
	{
		new id, AccountCA[5000], mensagem[128];
		if(sscanf(params, "i", id)) return ErrorMsg(playerid, "Use: /dcasa [ID da casa].");
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, CasaInfo[id][CasaX], CasaInfo[id][CasaY], CasaInfo[id][CasaZ]))
			{
				format(AccountCA, sizeof(AccountCA), PASTA_CASAS, id);
				if(DOF2_FileExists(AccountCA))
				{
					DOF2_RemoveFile(AccountCA);
					format(mensagem, sizeof(mensagem), "deleto casa id: %d.", id);
					SuccesMsg(playerid, mensagem);
					DestroyDynamicPickup(PickupCasa[id]);
					DestroyDynamicMapIcon(MapIconCasa[id]);
					DestroyDynamic3DTextLabel(TextoCasa[id]);
					CasaInfo[id][CasaX] = 0;
					CasaInfo[id][CasaY] = 0;
					CasaInfo[id][CasaZ] = 0;
					CasaInfo[id][CasaInteriorX] = 0;
					CasaInfo[id][CasaInteriorY] = 0;
					CasaInfo[id][CasaInteriorZ] = 0;
					return 1;
				}
				else
				{
					format(mensagem, sizeof(mensagem), "Casa [%d] nao existente.", id);
					ErrorMsg(playerid, mensagem);
				}
			}
			else
			{
				format(mensagem, sizeof(mensagem), "Nao esta perto da casa Id: %d.", id);
				ErrorMsg(playerid, mensagem);
			}
		}
	}
	return 1;
}

CMD:vendercasa(playerid, params[])
{
	new File[255];
	for(new i = 0; i < MAX_CASAS; i++)
	{
		if(IsPlayerInRangeOfPoint(playerid, 10.0, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]))
		{
			format(File, sizeof(File), PASTA_CASAS, i);
			if(strcmp(DOF2_GetString(File, "CasaDono"), Name(playerid), false))
			{
				ErrorMsg(playerid, "Essa casa nao e sua.");
				return 1;
			}
			else if(CasaInfo[i][CasaAVenda] == 1)
			{
				ErrorMsg(playerid, "Sua casa ja esta a venda");
				return 1;
			}
			else
			{
				if(IsPlayerConnected(playerid))
				{
					PlayerInfo[playerid][Casa] = -1;
					PlayerInfo[playerid][pDinheiro] += CasaInfo[i][CasaValor];

					DOF2_SetString(File, "CasaDono", "Nenhum");
					DOF2_SetInt(File, "CasaAVenda", 1);
					DOF2_SetInt(File, "CasaPickup", 1273);
					DOF2_SetInt(File, "CasaMapIcon", 31);
					DOF2_SaveFile();
					
					format(CasaInfo[i][CasaDono], 30, DOF2_GetString(File, "CasaDono"));
					CasaInfo[i][CasaAVenda] = DOF2_GetInt(File, "CasaAVenda");
					CasaInfo[i][CasaPickup] = DOF2_GetInt(File, "CasaPickup");
					CasaInfo[i][CasaMapIcon] = DOF2_GetInt(File, "CasaMapIcon");

					DestroyDynamicPickup(PickupCasa[i]);
					DestroyDynamicMapIcon(MapIconCasa[i]);

					PickupCasa[i] = CreateDynamicPickup(CasaInfo[i][CasaPickup], 23, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ]);
					MapIconCasa[i] = CreateDynamicMapIcon(CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], CasaInfo[i][CasaMapIcon], 0, -1, -1, -1, 100.0, MAPICON_LOCAL);
					return 1;
				}
			}
		}
	}
	return 1;
}

CMD:menuanim(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_MENUANIM, DIALOG_STYLE_LIST, "Menu Anim", "{FFFF00}-{FFFFFF} Maos para cima\n{FFFF00}+{FFFFFF} Sentar-se\n{FFFF00}+{FFFFFF} Deitar-se\n{FFFF00}+{FFFFFF} Apontar\n{FFFF00}+{FFFFFF} Abaixar\n{FFFF00}+{FFFFFF} Bracos Cruzados\n{FFFF00}+{FFFFFF} Parar animacoes", "Selecionar", "X");
	return 1;
}

CMD:missoes(playerid)
{
	new megastrings[1000];
	if(MissaoPlayer[playerid][MISSAO1] == 1)
	{
		strcat(megastrings,"{FFFFFF}Fazer Documento: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"{FFFFFF}Fazer Documento:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO2] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Primero emprego com carteira: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Primero emprego com carteira:\t{FFFF00}Nao fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO3] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Primero emprego sem carteira: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Primero emprego sem carteira:\t{FFFF00}Nao fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO4] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Fazer carteira de trabalho: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Fazer carteira de trabalho:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO5] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Fazer licencas: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Fazer licencas:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO6] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Comprar telefone: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Comprar telefone:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO7] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Comprar uma casa: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Comprar uma casa:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO8] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Olhar /gps: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Olhar /gps:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO9] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Primeiros 100k: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Primeiros 100k:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$15000");
	}
	if(MissaoPlayer[playerid][MISSAO10] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Fazer aposta no cassino: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Fazer aposta no cassino:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO11] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Olhar /ajuda: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Olhar /ajuda:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO12] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Alugar Moto: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Alugar Moto:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	if(MissaoPlayer[playerid][MISSAO13] == 1)
	{
		strcat(megastrings,"\n{FFFFFF}Entrar em organizacao: {FFFF00}Ja fez{FFFFFF}");
	}
	else
	{
		strcat(megastrings,"\n{FFFFFF}Entrar em organizacao:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}R$500");
	}
	ShowPlayerDialog(playerid, DIALOG_MISSOES,DIALOG_STYLE_LIST,"Missoes",megastrings,"Concluir","X");
	return 1;
}

CMD:criarradar(playerid, params[])
{
	new Account[255];
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
		new velocidade, Float:RadarX, Float:RadarY, Float:RadarZ, Float:RadarRZ;
		if(sscanf(params, "i", velocidade))
		{
			return ErrorMsg(playerid, "Use: /criarradar [velocidade]");
		}
		else if(velocidade <= 0)
		{
			return ErrorMsg(playerid, "Usar uma velocidade de 0Km a 100Km.");
		}
		else
		{
			for(new i; i < MAX_RADAR; i++)
			{
				format(Account, sizeof(Account), PASTA_RADAR, i);
				if(!DOF2_FileExists(Account))
				{
					GetPlayerPos(playerid, Float:RadarX, Float:RadarY, Float:RadarZ);
					GetPlayerFacingAngle(playerid, Float:RadarRZ);

					DOF2_CreateFile(Account);
					DOF2_SetInt(Account, "RadarID", i);
					DOF2_SetInt(Account, "RadarVelocidade", velocidade);

					DOF2_SetFloat(Account, "RadarPosX", RadarX);
					DOF2_SetFloat(Account, "RadarPosY", RadarY);
					DOF2_SetFloat(Account, "RadarPosZ", RadarZ);
					DOF2_SetFloat(Account, "RadarPosR", RadarRZ);
					DOF2_SaveFile();

					RadarInfo[i][RadarID] = DOF2_GetInt(Account, "RadarID");
					RadarInfo[i][RadarVelocidade] = DOF2_GetInt(Account, "RadarVelocidade");

					RadarInfo[i][RadarPosX] = DOF2_GetFloat(Account, "RadarPosX");
					RadarInfo[i][RadarPosY] = DOF2_GetFloat(Account, "RadarPosY");
					RadarInfo[i][RadarPosZ] = DOF2_GetFloat(Account, "RadarPosZ");
					RadarInfo[i][RadarPosR] = DOF2_GetFloat(Account, "RadarPosR");

					ObjetoRadar[i] = CreateDynamicObject(18880, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]-1.5, 0.0, 0.0, RadarInfo[i][RadarPosR]);
					ObjetoRadar2[i] = CreateDynamicObject(18880, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]-1.5, 0.0, 0.0, RadarInfo[i][RadarPosR] + 180.0);

					SetPlayerPos(playerid, RadarX + 1, RadarY + 1, RadarZ + 1);

					new string[5000];
					format(string, sizeof(string), "{FFFFFF}Radar de Velocidade\nID: [{00FF00}%d{FFFFFF}]\nVelocidade Maxima: [{FF2400}%d KM/H{FFFFFF}]", RadarInfo[i][RadarID], RadarInfo[i][RadarVelocidade]);
					TextoRadar[i] = CreateDynamic3DTextLabel(string, -1, RadarInfo[i][RadarPosX], RadarInfo[i][RadarPosY], RadarInfo[i][RadarPosZ]+4, 50.0);

					format(string, sizeof(string), "Radar %d com velocidade de %d KM/H criado com exito!", RadarInfo[i][RadarID], RadarInfo[i][RadarVelocidade]);
					SuccesMsg(playerid, string);
					return 1;
				}
			}
		}
	}
	else
	{
		return ErrorMsg(playerid, "Nao possui permissao.");
	}
	return 1;
}

CMD:dradar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
		new id, arq1[50], mensagem[128];
		if(sscanf(params, "i", id)) return ErrorMsg(playerid,  "Use: /dradar [ID do Radar].");
		format(arq1, sizeof(arq1), PASTA_RADAR, id);
		if(DOF2_FileExists(arq1))
		{
			format(mensagem, sizeof(mensagem), "Voce removeu o radar id %d.", id);
			SuccesMsg(playerid, mensagem);
			DestroyDynamicObject(ObjetoRadar[id]);
			DestroyDynamicObject(ObjetoRadar2[id]);
			DestroyDynamic3DTextLabel(TextoRadar[id]);
			RadarInfo[id][RadarPosX] = 0;
			RadarInfo[id][RadarPosY] = 0;
			RadarInfo[id][RadarPosZ] = 0;
			RadarInfo[id][RadarPosR] = 0;
			RadarInfo[id][RadarVelocidade] = 999;
			DOF2_RemoveFile(arq1);
			return 1;
		}
		else
		{
			format(mensagem, sizeof(mensagem), "O radar %d nao existe nos arquivos do servidor.", id);
			ErrorMsg(playerid, mensagem);
		}
	}
	else
	{
		ErrorMsg(playerid, "Nao possui permissao.");
	}
	return 1;
}

CMD:remolcar(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsTrailerAttachedToVehicle(vehicleid))
	{
		DetachTrailerFromVehicle(vehicleid);
		return 1;
	}
	new Float:x, Float:y, Float:z;
	new Float:dist, Float:closedist=8, closeveh;
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(i != vehicleid && GetVehiclePos(i, x, y, z))
		{
			dist = GetPlayerDistanceFromPoint(playerid, x, y, z);
			if(dist < closedist)
			{
				closedist = dist;
				closeveh = i;
			}
		}
	}
	if(!closeveh) return ErrorMsg(playerid, "Nao esta proximo de um veiculo!");
	AttachTrailerToVehicle(closeveh, vehicleid);
	return 1;
}

CMD:ejetar(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
	new pid, msg[128];
	if(sscanf(params, "u", pid)) return ErrorMsg(playerid,  "USAGE: /ejetar [player]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == pid)
			{
				new vehicleid = GetPlayerVehicleID(playerid);
				if(!IsPlayerInVehicle(i, vehicleid)) return ErrorMsg(playerid, "O jogador nao esta en seu veiculo!.");
				RemovePlayerFromVehicle(i);
				format(msg, sizeof(msg), "O condutor do veiculo %04d (%d) te expulsou do veiculo.", GetPlayerIdfixo(playerid), playerid);
				InfoMsg(i, msg);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:ejetarll(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMsg(playerid, "No estas conduciendo un vehiculo!"); 
	new vehicleid = GetPlayerVehicleID(playerid);
	new msg[128];
	format(msg, sizeof(msg), "O condutor do veiculo %04d (%d) te expulsou do veiculo.", GetPlayerIdfixo(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i) && i != playerid && IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			InfoMsg(playerid, msg);
		}
	}
	SuccesMsg(playerid, "Voce expulsou todos os passageiros.");
	return 1;
}

CMD:limparmods(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return ErrorMsg(playerid, "Este nao e seu veiculo!");
	for(new i=0; i < sizeof(VehicleMods[]); i++)
	{
		RemoveVehicleComponent(VehicleID[id], GetVehicleComponentInSlot(VehicleID[id], i));
		VehicleMods[id][i] = 0;
	}
	VehiclePaintjob[id] = 255;
	ChangeVehiclePaintjob(VehicleID[id], 255);
	SaveVehicle(id);
	SuccesMsg(playerid, "Voce removeu todos os mods do seu veiculo.");
	return 1;
}

CMD:localizarv(playerid, params[])
{
	if(TrackCar[playerid])
	{
		TrackCar[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		SuccesMsg(playerid, "Voce nao esta mais rastreando seu veiculo.");
		return 1;
	}
	new playername[24];
	GetPlayerName(playerid, playername, sizeof(playername));
	new info[256], bool:found;
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] == VEHICLE_PLAYER && strcmp(VehicleOwner[i], playername) == 0)
		{
			found = true;
			format(info, sizeof(info), "{FFFF00}%s{FFFFFF}ID: {FFFF00}%d  {FFFFFF}Name: {FFFF00}%s\n", info, i, VehicleNames[VehicleModel[i]-400]);
		}
	}
	if(!found) return ErrorMsg(playerid, "Nao possui nenhum veiculo!.");
	ShowPlayerDialog(playerid, DIALOG_FINDVEHICLE, DIALOG_STYLE_LIST, "Localizando seu veiculo", info, "Encontrar", "X");
	return 1;
}

CMD:mv(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsBicycle(vehicleid)) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 1)
		return ErrorMsg(playerid, "Nao tem a chave deste veiculo!");
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_VEHICLE);
	return 1;
}

CMD:venderv(playerid, params[])
{
	new pid, id, price, msg[128];
	if(sscanf(params, "udd", pid, id, price)) return ErrorMsg(playerid,  "USAGE: /venderv [player] [vehicleid] [price]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == pid)
			{
				if(GetPlayerVehicleAccess(playerid, id) < 2)
					return ErrorMsg(playerid, "Voce nao e dono deste veiculo!");
				if(price < 1) return ErrorMsg(playerid, "Valor invalido.");
				if(!PlayerToPlayer(playerid, i, 10.0)) return ErrorMsg(playerid, "O jogador esta muito longe!");
				SetPVarInt(i, "DialogValue1", playerid);
				SetPVarInt(i, "DialogValue2", id);
				SetPVarInt(i, "DialogValue3", price);
				ShowDialog(i, DIALOG_VEHICLE_SELL);
				format(msg, sizeof(msg), "Ofereceu a %04d comprar seu veiculo por R$%d", GetPlayerIdfixo(i), price);
				SuccesMsg(playerid, msg);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:darchaves(playerid, params[])
{
	new pid, id, msg[128];
	if(sscanf(params, "ud", pid, id)) return ErrorMsg(playerid,  "USAGE: /darchaves [player] [vehicleid]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == pid)
			{
				if(!IsValidVehicle1(id)) return ErrorMsg(playerid,  "ID de veiculo nao valido!");
				if(GetPlayerVehicleAccess(playerid, id) < 2)
					return ErrorMsg(playerid,  "Voce nao e dono deste veiculo!");
				if(!PlayerToPlayer(playerid, i, 10.0)) return ErrorMsg(playerid,  "O jogador esta muito longe!");
				SetPVarInt(i, "CarKeys", id);
				format(msg, sizeof(msg), "Voce entregou as chaves do seu carro para %04d", GetPlayerIdfixo(i));
				SuccesMsg(playerid, msg);
				format(msg, sizeof(msg), "%04d te deu as chaves do carro", GetPlayerIdfixo(playerid));
				InfoMsg(i, msg);
			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:trancar(playerid, params[])
{
	new vehicleid;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);
	}
	else
	{
		vehicleid = GetClosestVehicle(playerid);
		if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	}
	if(!vehicleid) return ErrorMsg(playerid, "Nao, voce esta perto de um veiculo!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle1(id)) return ErrorMsg(playerid, "Voce nao tem as chaves deste veiculo!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return ErrorMsg(playerid, "Voce nao tem as chaves deste veiculo!");
	new engine, lights, alarm, doors, bonnet, boot, objective;
	GetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	if(doors == 1)
	{
		doors = 0;
		VehicleLock[id] = 0;
		GameTextForPlayer(playerid, "~g~portas aberto", 3000, 6);
	}
	else
	{
		doors = 1;
		VehicleLock[id] = 1;
		GameTextForPlayer(playerid, "~r~portas fechadas", 3000, 6);
	}
	SetVehicleParamsEx(vehicleid, engine, lights, alarm, doors, bonnet, boot, objective);
	SaveVehicle(id);
	return 1;
}

CMD:alarmev(playerid, params[])
{
	new vehicleid;
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		vehicleid = GetPlayerVehicleID(playerid);
	}
	else
	{
		vehicleid = GetClosestVehicle(playerid);
		if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	}
	if(!vehicleid) return ErrorMsg(playerid, "Voce nao esta perto de um veiculo!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle1(id)) return ErrorMsg(playerid, "Voce nao tem as chaves deste veiculo!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return ErrorMsg(playerid, "Voce nao tem as chaves deste veiculo!");
	if(VehicleSecurity[vehicleid] == 0)
	{
		VehicleSecurity[vehicleid] = 1;
		VehicleAlarm[id] = 1;
		GameTextForPlayer(playerid, "~g~alarme ligado", 3000, 6);
	}
	else
	{
		ToggleAlarm(vehicleid, VEHICLE_PARAMS_OFF);
		VehicleSecurity[vehicleid] = 0;
		VehicleAlarm[id] = 0;
		GameTextForPlayer(playerid, "~r~alarme desligado", 3000, 6);
	}
	SaveVehicle(id);
	return 1;
}

CMD:mala(playerid, params[])
{
	new vehicleid = GetClosestVehicle(playerid);
	if(!PlayerToVehicle(playerid, vehicleid, 5.0)) vehicleid = 0;
	if(!vehicleid || IsBicycle(vehicleid) || IsPlayerInAnyVehicle(playerid))
		return ErrorMsg(playerid, "Nao esta perto de um veiculo!");
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle1(id)) return ErrorMsg(playerid, "Voce nao tem as chaves deste veiculo!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return ErrorMsg(playerid, "Voce nao tem as chaves deste veiculo!");
	ToggleBoot(vehicleid, VEHICLE_PARAMS_ON);
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_TRUNK);
	return 1;
}

CMD:abastecer(playerid, params[])
{
	for(new i=1; i < MAX_FUEL_STATIONS; i++)
	{
		if(FuelStationCreated[i])
		{
			if(IsPlayerInRangeOfPoint(playerid, 15.0, FuelStationPos[i][0], FuelStationPos[i][1], FuelStationPos[i][2]))
			{
				SetPVarInt(playerid, "FuelStation", i);
				ShowDialog(playerid, DIALOG_FUEL);
				return 1;
			}
		}
	}
	ErrorMsg(playerid, "Voce nao esta em um posto de combustivel!");
	return 1;
}

CMD:rtc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(!IsPlayerInAnyVehicle(playerid)) return ErrorMsg(playerid, "Nao esta em um veiculo!"); 
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	SuccesMsg(playerid, "Veiculo respawnado");
	return 1;
}

CMD:rac(playerid, params[])
{
	new bool:vehicleused[MAX_VEHICLES];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	foreach(Player, i)
	{
		if(IsPlayerConnected(i) && IsPlayerInAnyVehicle(i))
		{
			vehicleused[GetPlayerVehicleID(i)] = true;
		}
	}
	for(new i=1; i < MAX_VEHICLES; i++)
	{
		if(!vehicleused[i])
		{
			SetVehicleToRespawn(i);
		}
	}
	new msg[128];
	foreach(Player, i)
	{
		format(msg, sizeof(msg), "O Administrador %04d respawnou todos os veiculos sem motorista.", GetPlayerIdfixo(playerid), playerid);
		InfoMsg(i, msg);
	}
	return 1;
}

CMD:setgasolina(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(!IsPlayerInAnyVehicle(playerid)) return ErrorMsg(playerid, "Nao esta em um veiculo");
	new amount, msg[128];
	if(sscanf(params, "d", amount)) return ErrorMsg(playerid,  "USAGE: /setgasolina [amount]");
	if(amount < 0 || amount > 100) return ErrorMsg(playerid, "Coloque de 0 a 100L.");
	Fuel[GetPlayerVehicleID(playerid)] = amount;
	format(msg, sizeof(msg), "Abasteceu o veiculo com %d", amount);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:addv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(!IsPlayerSpawned(playerid)) return ErrorMsg(playerid, "You can't use this command now!");
	new model, dealerid, color1, color2, price;
	if(sscanf(params, "ddddd", dealerid, model, color1, color2, price))
		return ErrorMsg(playerid, "USAGE: /addv [dealerid] [model] [color1] [color2] [price]");
	if(!IsValidDealership(dealerid)) return ErrorMsg(playerid,  "ID invalido");
	if(model < 400 || model > 611) return ErrorMsg(playerid,  "Invalid model ID!");
	if(color1 < 0 || color2 < 0) return ErrorMsg(playerid,  "Invalid color!");
	if(price < 0) return ErrorMsg(playerid,  "Invalid price!");
	new Float:X, Float:Y, Float:Z, Float:angle;
	GetPlayerPos(playerid, X, Y, Z);
	GetPlayerFacingAngle(playerid, angle);
	X += floatmul(floatsin(-angle, degrees), 4.0);
	Y += floatmul(floatcos(-angle, degrees), 4.0);
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(!VehicleCreated[i])
		{
			new msg[128];
			VehicleCreated[i] = VEHICLE_DEALERSHIP;
			VehicleModel[i] = model;
			VehiclePos[i][0] = X;
			VehiclePos[i][1] = Y;
			VehiclePos[i][2] = Z;
			VehiclePos[i][3] = angle+90.0;
			VehicleColor[i][0] = color1;
			VehicleColor[i][1] = color2;
			VehicleInterior[i] = GetPlayerInterior(playerid);
			VehicleWorld[i] = GetPlayerVirtualWorld(playerid);
			VehicleValue[i] = price;
			valstr(VehicleOwner[i], dealerid);
			VehicleNumberPlate[i] = PLACA_CONCESSIONARIA;
			for(new d=0; d < sizeof(VehicleTrunk[]); d++)
			{
				VehicleTrunk[i][d][0] = 0;
				VehicleTrunk[i][d][1] = 0;
			}
			for(new d=0; d < sizeof(VehicleMods[]); d++)
			{
				VehicleMods[i][d] = 0;
			}
			VehiclePaintjob[i] = 255;
			VehicleLock[i] = 0;
			VehicleAlarm[i] = 0;
			UpdateVehicle(i, 0);
			SaveVehicle(i);
			format(msg, sizeof(msg), "Added vehicle id %d to dealerid %d", i, dealerid);
			SuccesMsg(playerid,  msg);
			return 1;
		}
	}
	ErrorMsg(playerid,  "Can't add any more vehicles!");
	return 1;
}

CMD:editv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new id = GetVehicleID(GetPlayerVehicleID(playerid));
		if(!IsValidVehicle1(id)) return ErrorMsg(playerid,  "This is not a dynamic vehicle!");
		SetPVarInt(playerid, "DialogValue1", id);
		ShowDialog(playerid, DIALOG_EDITVEHICLE);
		return 1;
	}
	new vehicleid;
	if(sscanf(params, "d", vehicleid)) return ErrorMsg(playerid,  "USAGE: /editv [vehicleid]");
	if(!IsValidVehicle1(vehicleid)) return ErrorMsg(playerid,  "Invalid vehicleid!");
	SetPVarInt(playerid, "DialogValue1", vehicleid);
	ShowDialog(playerid, DIALOG_EDITVEHICLE);
	return 1;
}

CMD:adddealership(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(!IsPlayerSpawned(playerid)) return ErrorMsg(playerid,  "Voce nao pode usar o comando!");
	for(new i=1; i < MAX_DEALERSHIPS; i++)
	{
		if(!DealershipCreated[i])
		{
			new msg[128];
			DealershipCreated[i] = 1;
			GetPlayerPos(playerid, DealershipPos[i][0], DealershipPos[i][1], DealershipPos[i][2]);
			UpdateDealership(i, 0);
			SaveDealership(i);
			format(msg, sizeof(msg), "Concessionaria %d adicionada.", i);
			SuccesMsg(playerid,  msg);
			return 1;
		}
	}
	ErrorMsg(playerid,  "Ja possui muitas concessionarias.");
	return 1;
}

CMD:deletedealership(playerid, params[])
{	
	new dealerid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(sscanf(params, "d", dealerid)) return ErrorMsg(playerid,  "USAGE: /deletedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return ErrorMsg(playerid,  "ID invalido!");
	for(new i=1; i < MAX_DVEHICLES; i++)
	{
		if(VehicleCreated[i] == VEHICLE_DEALERSHIP && strval(VehicleOwner[i]) == dealerid)
		{
			DestroyVehicle(VehicleID[i]);
			Delete3DTextLabel(VehicleLabel[i]);
			VehicleCreated[i] = 0;
		}
	}
	DealershipCreated[dealerid] = 0;
	Delete3DTextLabel(DealershipLabel[dealerid]);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Concessionaria %d deletada.", dealerid);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:movedealership(playerid, params[])
{
	new dealerid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");	
	if(sscanf(params, "d", dealerid)) return ErrorMsg(playerid,  "USAGE: /movedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return ErrorMsg(playerid,  "ID invalido");
	GetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	UpdateDealership(dealerid, 1);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Concessionaria %d movida.", dealerid);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:gotodealership(playerid, params[])
{
	new dealerid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	
	if(sscanf(params, "d", dealerid)) return ErrorMsg(playerid, "USAGE: /gotodealership [dealerid]");
	if(!IsValidDealership(dealerid)) return ErrorMsg(playerid, "ID invalido");
	SetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	TogglePlayerControllable(playerid, false);
	SetTimerEx("carregarobj", 5000, 0, "i", playerid);
	format(msg, sizeof(msg), "Teleportado para concessionaria %d", dealerid);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:addfuelstation(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(!IsPlayerSpawned(playerid)) return ErrorMsg(playerid, "Voce nao pode usar o comando!");
	for(new i=1; i < MAX_FUEL_STATIONS; i++)
	{
		if(!FuelStationCreated[i])
		{
			new msg[128];
			FuelStationCreated[i] = 1;
			GetPlayerPos(playerid, FuelStationPos[i][0], FuelStationPos[i][1], FuelStationPos[i][2]);
			UpdateFuelStation(i, 0);
			SaveFuelStation(i);
			format(msg, sizeof(msg), "Posto %d adicionado.", i);
			SuccesMsg(playerid, msg);
			return 1;
		}
	}
	ErrorMsg(playerid, "Ja possui muitos postos");
	return 1;
}

CMD:deletefuelstation(playerid, params[])
{
	new stationid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(sscanf(params, "d", stationid)) return ErrorMsg(playerid, "USAGE: /deletefuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return ErrorMsg(playerid, "ID invalido");
	FuelStationCreated[stationid] = 0;
	Delete3DTextLabel(FuelStationLabel[stationid]);
	SaveFuelStation(stationid);
	format(msg, sizeof(msg), "Posto %d deletado.", stationid);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:movefuelstation(playerid, params[])
{
	new stationid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(sscanf(params, "d", stationid)) return ErrorMsg(playerid, "USAGE: /movefuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return ErrorMsg(playerid, "ID invalido");
	GetPlayerPos(playerid, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	UpdateFuelStation(stationid, 1);
	SaveFuelStation(stationid);
	format(msg, sizeof(msg), "Posto %d movido.", stationid);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:gotofuelstation(playerid, params[])
{
	new stationid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return ErrorMsg(playerid, "Sem permissao");
	if(sscanf(params, "d", stationid)) return ErrorMsg(playerid, "USAGE: /gotofuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return ErrorMsg(playerid, "ID invalido");
	SetPlayerPos(playerid, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	TogglePlayerControllable(playerid, false);
	SetTimerEx("carregarobj", 5000, 0, "i", playerid);
	format(msg, sizeof(msg), "Teleportado para o Posto %d", stationid);
	SuccesMsg(playerid, msg);
	return 1;
}

CMD:freq(playerid, params[])
{
	new freq;
	if(sscanf(params, "d", freq)) return ErrorMsg(playerid, "Uso: /freq [FREQ. 1-1000 (0 Desligar)]");
	if(freq > MAX_FREQUENCIAS || freq < 0) return ErrorMsg(playerid, "Freq Invalida!");
	if(freq == 0)
	{
		FrequenciaConectada[playerid] = 0;
		InfoMsg(playerid, "Radio desligado!");
		SvDetachListenerFromStream(Frequencia[freq], playerid);
		FrequenciaConectada[playerid] = 0;
	} else {
		new string[128];
		format(string, 128, "Frequencia conectada: (%d).", freq);
		SuccesMsg(playerid, string);

		format(string, 128, "%04d saiu da frequencia(%d)", GetPlayerIdfixo(playerid), FrequenciaConectada[playerid]);
		MsgFrequencia(FrequenciaConectada[playerid], 0xBF0000FF, string);
		format(string, 128, "%04d entrou na frequencia(%d)", GetPlayerIdfixo(playerid), freq);
		MsgFrequencia(freq, 0xFF6C00FF, string);

		SetTimerEx("ConectarNaFrequencia", 100, false, "id", playerid, freq);
	}
	return 1;
}

CMD:vip(playerid, params[])
{
	if(PlayerInfo[playerid][pVIP] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "s[56]", Motivo)) 							return ErrorMsg(playerid,"USE: /vip [TEXTO]");
	//
	format(Str, sizeof(Str), "[%s] {FFFF00}%04d{FFFFFF} disse {FFFF00}%s", VIP(playerid), GetPlayerIdfixo(playerid), Motivo);
	SendAdminMessage(0xDDA0DDFF, Str);
	return 1;
}

CMD:mudarskin(playerid, params[])
{
	if(PlayerInfo[playerid][pVIP] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(MostrandoMenu[playerid] == false)
	{
		TextDrawShowForPlayer(playerid, TDCadastro[2]);
		TextDrawShowForPlayer(playerid, TDCadastro[3]);
		for(new i=0;i<7;i++){
			PlayerTextDrawShow(playerid, TDCadastro_p[playerid][i]);
		}
		MostrandoMenu[playerid] = true;
		SelectTextDraw(playerid, 0xFF0000FF);
		InfoMsg(playerid, "Use a tecla F para cancelar a mudanca de skin e remover as tde.");
	}
	else
	{
		TextDrawHideForPlayer(playerid, TDCadastro[2]);
		TextDrawHideForPlayer(playerid, TDCadastro[3]);
		for(new i=0;i<7;i++){
			PlayerTextDrawHide(playerid, TDCadastro_p[playerid][i]);
		}
		MostrandoMenu[playerid] = false;
		SalvarDadosSkin(playerid);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}


CMD:mudarskin2(playerid)
{
	if(MostrandoMenu[playerid] == false)
	{
		TextDrawShowForPlayer(playerid, TDCadastro[2]);
		TextDrawShowForPlayer(playerid, TDCadastro[3]);
		for(new i=0;i<7;i++){
			PlayerTextDrawShow(playerid, TDCadastro_p[playerid][i]);
		}
		MostrandoMenu[playerid] = true;
		SelectTextDraw(playerid, 0xFF0000FF);
		InfoMsg(playerid, "Use a tecla F para cancelar a mudanca de skin e remover as tde.");
	}
	else
	{
		TextDrawHideForPlayer(playerid, TDCadastro[2]);
		TextDrawHideForPlayer(playerid, TDCadastro[3]);
		for(new i=0;i<7;i++){
			PlayerTextDrawHide(playerid, TDCadastro_p[playerid][i]);
		}
		MostrandoMenu[playerid] = false;
		SalvarDadosSkin(playerid);
		CancelSelectTextDraw(playerid);
	}
	return 1;
}

CMD:tunagemvip(playerid)
{
	new wVeiculo = GetPlayerVehicleID(playerid);
	if(PlayerInfo[playerid][pVIP] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	switch(GetVehicleModel(wVeiculo))
	{
	    case 483:
	    {
	      	AddVehicleComponent(wVeiculo,1027);
            ChangeVehiclePaintjob(wVeiculo, 0);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1087);
	    }
	    case 562:
	    {
	  		AddVehicleComponent(wVeiculo,1046);
            AddVehicleComponent(wVeiculo,1171);
            AddVehicleComponent(wVeiculo,1149);
            AddVehicleComponent(wVeiculo,1035);
            AddVehicleComponent(wVeiculo,1147);
            AddVehicleComponent(wVeiculo,1036);
            AddVehicleComponent(wVeiculo,1040);
            ChangeVehiclePaintjob(wVeiculo, 2);
            ChangeVehicleColor(wVeiculo, 6, 6);
			OnVehicleRespray(playerid, wVeiculo, 6, 6);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1087);
	  	}
	  	case 560:
	  	{
	  	   	AddVehicleComponent(wVeiculo,1028);
            AddVehicleComponent(wVeiculo,1169);
            AddVehicleComponent(wVeiculo,1141);
            AddVehicleComponent(wVeiculo,1032);
            AddVehicleComponent(wVeiculo,1138);
            AddVehicleComponent(wVeiculo,1026);
            AddVehicleComponent(wVeiculo,1027);
            ChangeVehiclePaintjob(wVeiculo, 2);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1087);
	  	}
	  	case 565:
	  	{
	        AddVehicleComponent(wVeiculo,1046);
	        AddVehicleComponent(wVeiculo,1153);
	        AddVehicleComponent(wVeiculo,1150);
	        AddVehicleComponent(wVeiculo,1054);
	        AddVehicleComponent(wVeiculo,1049);
	        AddVehicleComponent(wVeiculo,1047);
	        AddVehicleComponent(wVeiculo,1051);
	        AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
	        ChangeVehiclePaintjob(wVeiculo, 2);
	  	}
	  	case 559:
	  	{
	  	    AddVehicleComponent(wVeiculo,1065);
            AddVehicleComponent(wVeiculo,1160);
            AddVehicleComponent(wVeiculo,1159);
            AddVehicleComponent(wVeiculo,1067);
            AddVehicleComponent(wVeiculo,1162);
            AddVehicleComponent(wVeiculo,1069);
            AddVehicleComponent(wVeiculo,1071);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1087);
            ChangeVehiclePaintjob(wVeiculo, 1);
	  	}
	  	case 561:
	  	{
	        AddVehicleComponent(wVeiculo,1064);
	        AddVehicleComponent(wVeiculo,1155);
	        AddVehicleComponent(wVeiculo,1154);
	        AddVehicleComponent(wVeiculo,1055);
	        AddVehicleComponent(wVeiculo,1158);
	        AddVehicleComponent(wVeiculo,1056);
	        AddVehicleComponent(wVeiculo,1062);
	        AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
	        ChangeVehiclePaintjob(wVeiculo, 2);
	  	}
	  	case 558:
	  	{
	  	   	AddVehicleComponent(wVeiculo,1089);
	        AddVehicleComponent(wVeiculo,1166);
	        AddVehicleComponent(wVeiculo,1168);
	        AddVehicleComponent(wVeiculo,1088);
	        AddVehicleComponent(wVeiculo,1164);
	        AddVehicleComponent(wVeiculo,1090);
	        AddVehicleComponent(wVeiculo,1094);
	        AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
	        ChangeVehiclePaintjob(wVeiculo, 2);
	  	}
	  	case 575:
	  	{
	        AddVehicleComponent(wVeiculo,1044);
	        AddVehicleComponent(wVeiculo,1174);
	        AddVehicleComponent(wVeiculo,1176);
	        AddVehicleComponent(wVeiculo,1042);
	        AddVehicleComponent(wVeiculo,1099);
	        AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
	        ChangeVehiclePaintjob(wVeiculo, 0);
	  	}
	  	case 534:
	  	{
            AddVehicleComponent(wVeiculo,1126);
            AddVehicleComponent(wVeiculo,1179);
            AddVehicleComponent(wVeiculo,1180);
            AddVehicleComponent(wVeiculo,1122);
            AddVehicleComponent(wVeiculo,1101);
            AddVehicleComponent(wVeiculo,1125);
            AddVehicleComponent(wVeiculo,1123);
            AddVehicleComponent(wVeiculo,1100);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1087);
            ChangeVehiclePaintjob(wVeiculo, 2);
	  	}
	  	case 536:
	  	{
	        AddVehicleComponent(wVeiculo,1104);
	        AddVehicleComponent(wVeiculo,1182);
	        AddVehicleComponent(wVeiculo,1184);
	        AddVehicleComponent(wVeiculo,1108);
	        AddVehicleComponent(wVeiculo,1107);
	        AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
	        ChangeVehiclePaintjob(wVeiculo, 1);
	  	}
	  	case 567:
	  	{
	  	    AddVehicleComponent(wVeiculo,1129);
            AddVehicleComponent(wVeiculo,1189);
            AddVehicleComponent(wVeiculo,1187);
            AddVehicleComponent(wVeiculo,1102);
            AddVehicleComponent(wVeiculo,1133);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1087);
            ChangeVehiclePaintjob(wVeiculo, 2);
	  	}
	  	case 420:
	  	{
	  	   	AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1087);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1139);
	  	}
	  	case 400:
	  	{
	  	    AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1087);
            AddVehicleComponent(wVeiculo,1018);
            AddVehicleComponent(wVeiculo,1013);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1086);
	  	}
	  	case 401:
	  	{
		  	AddVehicleComponent(wVeiculo,1086);
            AddVehicleComponent(wVeiculo,1139);
            AddVehicleComponent(wVeiculo,1079);
            AddVehicleComponent(wVeiculo,1010);
            AddVehicleComponent(wVeiculo,1087);
            AddVehicleComponent(wVeiculo,1012);
            AddVehicleComponent(wVeiculo,1013);
            AddVehicleComponent(wVeiculo,1042);
            AddVehicleComponent(wVeiculo,1043);
            AddVehicleComponent(wVeiculo,1018);
	        AddVehicleComponent(wVeiculo,1006);
	        AddVehicleComponent(wVeiculo,1007);
	        AddVehicleComponent(wVeiculo,1017);
        }
        case 576:
        {
	     	ChangeVehiclePaintjob(wVeiculo,2);
	        AddVehicleComponent(wVeiculo,1191);
	        AddVehicleComponent(wVeiculo,1193);
	        AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1018);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
	        AddVehicleComponent(wVeiculo,1134);
	        AddVehicleComponent(wVeiculo,1137);
        }
		default:
		{
		 	AddVehicleComponent(wVeiculo,1010);
	        AddVehicleComponent(wVeiculo,1079);
	        AddVehicleComponent(wVeiculo,1087);
		}
	}
	return 1;
}

CMD:repararvip(playerid)
{
	if(PlayerInfo[playerid][pVIP] < 2)						return ErrorMsg(playerid, "Nao possui permissao.");
	if(!IsPlayerInAnyVehicle(playerid)) return ErrorMsg(playerid, "Nao esta em um veiculo.");
 
    RepairVehicle(GetPlayerVehicleID(playerid));
	SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
	SuccesMsg(playerid, "Reparou este veiculo.");
	return 1;
}

CMD:pediravaliar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMsg(playerid, "Nao possui permissao.");
	if(sscanf(params, "d", ID)) return ErrorMsg(playerid,"USE: /pediravaliar [ID]");
	foreach(Player,i)
  	{
		if(pLogado[i] == true)
		{
			if(PlayerInfo[i][IDF] == ID)
			{
				ShowPlayerDialog(i, DIALOG_AVALIAR, DIALOG_STYLE_MSGBOX, "Avaliando o administrador", "Um staff pediu sua avaliacao pelo atendimento oferecido.\nAgora a escolha e sua se deseja que ele seja recompensado no futuro\n\nDeseja dar um ponto de avaliacao para o staff?", "SIM", "NAO");

			}
		}
		else
		{
			ErrorMsg(playerid, "Jogador nao conectado.");
		}
  	}
	return 1;
}

CMD:verpontos(playerid)
{
	new string[255];
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMsg(playerid, "Nao possui permissao.");
	format(string, sizeof(string), "Possui %d pontos", PlayerInfo[playerid][pAvaliacao]);
	SuccesMsg(playerid, string);
	return 1;
}

CMD:atendimento(playerid, params[])
{
	new assunto[255];
	if(sscanf(params, "s", assunto))	return ErrorMsg(playerid, "USE: /atendimento [Assunto]");
    new Dialog[300];
	format(stringZCMD, sizeof(stringZCMD), "{FFFFFF}Você está prestes a solicitar um atendimento administrativo\n\nSeu Nome: {0099ff}%s\n{FFFFFF}Assunto do Atendimento: {0099ff}%s\n\n",Name(playerid), assunto);
	strcat(Dialog,stringZCMD);
	format(stringZCMD, sizeof(stringZCMD), "{FF6347}OBS:{BFC0C2} Solicite atendimento para assuntos sérios, para dúvidas use /duvida ou /reportar,\ncaso contrario você será devidamente punido pela administração do servidor.");
	strcat(Dialog,stringZCMD);
	strmid(ArmazenarString[playerid], assunto, 0, strlen(params), 255);
	ShowPlayerDialog(playerid, 8726, DIALOG_STYLE_MSGBOX, "{0099ff}Solicitar Atendimento", Dialog, "Continuar", "Cancelar");
	return 1;
}

CMD:fila(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] < 1)
	{
		ErrorMsg(playerid,  "Você não tem autorização para usar esse comando.");
		return true;
	}
	new lol = 0;
	MEGAString[0]=EOS;
	new prioridade[20];
	format(stringZCMD, sizeof(stringZCMD), "Jogador\tAssunto\tPrioridade\n");
	strcat(MEGAString, stringZCMD);
	while (lol < MAX_PLAYERS)
	{
		new arquivo[64];
		format(arquivo, sizeof(arquivo), Pasta_Relatorios,lol);
		if(DOF2_FileExists(arquivo))
		{
			new NomeFila[MAX_PLAYER_NAME];
			new AssuntoFila[64];
			strmid(NomeFila, DOF2_GetString(arquivo,"Jogador"), 0, strlen(DOF2_GetString(arquivo,"Jogador")), 255);
			strmid(AssuntoFila, DOF2_GetString(arquivo,"Assunto"), 0, strlen(DOF2_GetString(arquivo,"Assunto")), 255);
			DOF2_CreateFile(arquivo);
			DOF2_GetString(arquivo, "Jogador");
			DOF2_GetString(arquivo, "Assunto");
			if(DOF2_GetInt(arquivo, "Prioridade") == 2)
			{
				prioridade = "{FF0000}ALTA";
			}
			else if(DOF2_GetInt(arquivo, "Prioridade") == 1)
			{
				prioridade = "{FFFF00}BAIXA";
			}
			format(stringZCMD, sizeof(stringZCMD), "%s[%d]\t%s\t%s\n", NomeFila,lol, AssuntoFila, prioridade);
			strcat(MEGAString, stringZCMD);
		}
		lol++;
	}
	ShowPlayerDialog(playerid, 5409, DIALOG_STYLE_TABLIST_HEADERS, "{FFFF00}Clique 2x para atender", MEGAString, "Atender","Cancelar");
	return true;
}

CMD:desossar(playerid)
{
	if(!CheckInventario2(playerid, 18644)) return ErrorMsg(playerid, "Nao tem uma chaira.");
	if(PlayerInfo[playerid][pProfissao] != 3) 	return ErrorMsg(playerid, "Nao possui permissao.");
	if(UsouCMD[playerid] == true) 	return ErrorMsg(playerid, "Ainda nao finalizou a pesca atual."); 
	if(Desossando[playerid] == 1 || Desossando[playerid] == 2 || Desossando[playerid] == 3) 	return ErrorMsg(playerid, "Voce ja esta fazendo as etapas."); 
	for(new i; i < 8; i++)
	if(IsPlayerInRangeOfPoint(playerid, 1, PosDesossa[i][0], PosDesossa[i][1], PosDesossa[i][2]))
	{
		CreateProgress(playerid, "Desossar","Desossando...", 100);
		TogglePlayerControllable(playerid, 0);
		ApplyAnimation(playerid, "BASEBALL", "Bat_M", 4.1, 1, 0, 0, 0, 0, 1);
		RemovePlayerAttachedObject(playerid, 1);
		UsouCMD[playerid] = true;
	}
	return 1;
}

CMD:deixarcarne(playerid)
{
	if(Desossando[playerid] == 1)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.577758, 2117.902099, 1011.030273))
		{
			RemovePlayerAttachedObject(playerid, 1);
			DisablePlayerCheckpoint(playerid);
			ClearAnimations(playerid);
			ObjetoAcougue[playerid][0] = CreateDynamicObject(2804, 942.313171, 2118.938232, 1011.229980, 0.0, 0.0, 1000.000);
			MoveDynamicObject(ObjetoAcougue[playerid][0], 942.313171, 2136.355224, 1011.229980,2.0);
			SetPlayerCheckpoint(playerid,938.006469, 2144.264892, 1011.023437, 1.0);
			Desossando[playerid] = 2;
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			SuccesMsg(playerid, "Sua carne esta sendo processada, pegue uma embalagem.");
		}
	}
	return 1;
}

CMD:pegarcaixa(playerid)
{
	if(Desossando[playerid] == 2)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1, 938.006469, 2144.264892, 1011.023437))
		{
			DisablePlayerCheckpoint(playerid);
			ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, 1, 1220, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
			Desossando[playerid] = 3;
			SuccesMsg(playerid, "Pegou a embalagem, pegue empacote a carne.");
		}
	}
	return 1;
}

CMD:empacotarcarne(playerid)
{
	if(Desossando[playerid] == 3)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.416259, 2137.294921, 1011.023437))
		{
			DisablePlayerCheckpoint(playerid);
			DestroyDynamicObject(ObjetoAcougue[playerid][0]);
			Desossando[playerid] = 4;
			SuccesMsg(playerid, "Leve a embalagem ate a revisao.");
		}
	}
	return 1;
}

CMD:deixarcaixa(playerid)
{
	if(Desossando[playerid] == 4)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.421325, 2153.745849, 1011.023437))
		{
			RemovePlayerAttachedObject(playerid, 1);
			ObjetoAcougue[playerid][1] = CreateDynamicObject(1220, 942.429260, 2154.825195, 1011.523071, 0.0, 0.0, 1000.000);
			MoveDynamicObject(ObjetoAcougue[playerid][1], 942.429260, 2172.342285, 1011.523071,2.0);
			Desossando[playerid] = 5;
			SuccesMsg(playerid, "Iniciou processo de revisao.");
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
			ClearAnimations(playerid);
		}
	}
	return 1;
}

CMD:pegarcaixa2(playerid)
{
	if(Desossando[playerid] == 5)
	{
		if(IsPlayerInRangeOfPoint(playerid, 1, 942.288391, 2173.139404, 1011.023437))
		{
			DisablePlayerCheckpoint(playerid);
			DestroyDynamicObject(ObjetoAcougue[playerid][1]);
			SetPlayerCheckpoint(playerid, 964.872192, 2159.816406, 1011.030273, 1.0);
			ApplyAnimation(playerid, "BSKTBALL", "BBALL_pickup", 4.0, 0, 1, 1, 0, 0, 1);
			SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
			SetPlayerAttachedObject(playerid, 1, 1220, 5, 0.044377, 0.029049, 0.161334, 265.922912, 9.904896, 21.765972, 0.500000, 0.500000, 0.500000);
			Desossando[playerid] = 6;
			SuccesMsg(playerid, "Caixa revisada, leve ate o ponto de entrega.");
		}
	}
	return 1;
}

CMD:iniciarminerador(playerid)
{
	new procha = randomEx(1,4);
	if(PlayerInfo[playerid][pProfissao] != 2) 	return ErrorMsg(playerid, "Nao possui permissao.");
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 530)  	return ErrorMsg(playerid, "Nao esta no veiculo de trabalho");
	
	if(procha == 1)
	{
		SetPlayerCheckpoint(playerid, 638.114257, 831.205871, -42.960937, 2.0);  
		SuccesMsg(playerid, "Pegue uma rocha no local marcado.");
		EtapasMinerador[playerid] = 1;
	}
	if(procha == 2)
	{
		SetPlayerCheckpoint(playerid, 638.953063, 851.907104, -42.960937, 2.0);  
		SuccesMsg(playerid, "Pegue uma rocha no local marcado.");
		EtapasMinerador[playerid] = 1;
	}
	if(procha == 3)
	{
		SetPlayerCheckpoint(playerid, 602.181091, 867.931518, -42.960937, 2.0);  
		SuccesMsg(playerid, "Pegue uma rocha no local marcado.");
		EtapasMinerador[playerid] = 1;
	}
	if(procha == 4) 
	{ 
		SetPlayerCheckpoint(playerid, 602.180358, 867.173095, -42.960937, 2.0);  
		SuccesMsg(playerid, "Pegue uma rocha no local marcado.");
		EtapasMinerador[playerid] = 1;
	}
	return 1; 
} 

CMD:pescar(playerid)
{
	if(PlayerInfo[playerid][pProfissao] != 1) 	return ErrorMsg(playerid, "Nao possui permissao.");
	if(!CheckInventario2(playerid, 18632)) return ErrorMsg(playerid, "Nao tem uma vara de pesca.");
	if(UsouCMD[playerid] == true) 	return ErrorMsg(playerid, "Ainda nao finalizou a pesca atual."); 
	for(new i; i < 13; i++)
	if(IsPlayerInRangeOfPoint(playerid, 2.0, PosPesca[i][0], PosPesca[i][1], PosPesca[i][2]))
	{
		CreateProgress(playerid, "Pesca","Pescando...", 60);
		TogglePlayerControllable(playerid, 0);
		UsouCMD[playerid] = true;	
	}
	return 1;
}

CMD:resetanuncios(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMsg(playerid, "Nao possui permissao.");
	for(new a; a < NA; a++)
	{
	    if(strlen(Anuncio[a][Texto]) > 0)
	    {
	    	format(Anuncio[a][Texto],35,"");
	    	TextDrawHideForAll(TextDraw[a]);
		}
	}
	return true;
}

CMD:anuncio(playerid,params[])
{
	new anuncio[75];
	if(strlen(params) >= 74) return ErrorMsg(playerid,"Ha muitos caracteres no anuncio.");
	if(sscanf(params,"s[75]",anuncio)) return ErrorMsg(playerid,"Usa /anuncio [anuncio]");
	new string[200];
	if(TiempoAnuncio[playerid] > 0)
	{
	    format(string,100,"Espera %d segundos para poder fazer outro anuncio.",TiempoAnuncio[playerid]);
	    ErrorMsg(playerid, string);
		return true;
	}
	TiempoAnuncio[playerid] = 60;
	PlayerInfo[playerid][pBanco] -= 5000;
	for(new a; a < NA-1; a++)
	{
	    if(strlen(Anuncio[a+1][Texto]) > 0)
	    {
			format(Anuncio[a][Texto],75,"%s",Anuncio[a+1][Texto]);
			format(string,sizeof(string),"~g~Anuncio:~w~ %s ~g~",Anuncio[a][Texto]);
			TextDrawSetString(TextDraw[a],string);
			TextDrawShowForAll(TextDraw[a]);
		}
	}
	Anuncio[NA-1][Texto] = anuncio;
	format(string,sizeof(string),"~g~Anuncio:~w~ %s ~g~",anuncio);
	TextDrawSetString(TextDraw[NA-1],string);
	TextDrawShowForAll(TextDraw[NA-1]);
	return true;
}

CMD:trazercofre(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return ErrorMsg(playerid, "Nao possui permissao.");
	new id;
	if(sscanf(params, "i", id))return ErrorMsg(playerid, "Use: /trazercofre [id da org do 0 ao 14]");
	{
	    if(id >= 0 && id < 14)
	    {
	        new Float:XX, Float:YY, Float:ZZ, Float:RR, string[550];
     		GetPlayerPos(playerid, XX, YY, ZZ);
     		GetPlayerFacingAngle(playerid, RR);

            CofreInfo[id][CofreID] = id;
			CofreInfo[id][CofrePosX] = XX;
			CofreInfo[id][CofrePosY] = YY;
			CofreInfo[id][CofrePosZ] = ZZ;
			CofreInfo[id][CofrePosR] = RR;

			SetPlayerPos(playerid, XX, YY, ZZ+5);

			DestroyDynamicObject(ObjetoCofre[id]);
			DestroyDynamic3DTextLabel(TextoCofreOrg[id]);

			ObjetoCofre[id] = CreateDynamicObject(19772, CofreInfo[id][CofrePosX], CofreInfo[id][CofrePosY], CofreInfo[id][CofrePosZ]-1, 0.0, 0.0, CofreInfo[id][CofrePosR]);
			format(string, sizeof(string), "{BEBEBE}ID Cofre: %d\nAperte {FF2400}H\n{BEBEBE}Para Abrir o Menu do Bau", CofreInfo[id][CofreID]);
			TextoCofreOrg[id] = CreateDynamic3DTextLabel(string, -1, CofreInfo[id][CofrePosX], CofreInfo[id][CofrePosY], CofreInfo[id][CofrePosZ], 25.0);

			SalvarCofreF(id);
	    }
	    else
	    {
	        ErrorMsg(playerid, "Voce so pode colocar orgs do 11 ao 49");
	    }
	}
	return 1;
}

CMD:iniciarrotamaconha(playerid)
{
	new Alt = randomEx(0,303);
	SetPlayerCheckpoint(playerid, PosRota[Alt][0],PosRota[Alt][1],PosRota[Alt][2], 0.5);
	InfoMsg(playerid, "Rota iniciada, faça a entrega no local marcado. use /cancelarrota.");
	RotaMaconha[playerid] = true;
	return 1;
}

CMD:iniciarrotacocaina(playerid)
{
	new Alt = randomEx(0,303);
	SetPlayerCheckpoint(playerid, PosRota[Alt][0],PosRota[Alt][1],PosRota[Alt][2], 0.5);
	InfoMsg(playerid, "Rota iniciada, faça a entrega no local marcado. use /cancelarrota.");
	RotaMaconha[playerid] = true;
	return 1;
}

CMD:cancelarrota(playerid)
{
	if(RotaMaconha[playerid] == true)
	{
		RotaMaconha[playerid] = false;
		DisablePlayerCheckpoint(playerid);
		InfoMsg(playerid, "Rota cancelada.");
	}
	if(RotaCocaina[playerid] == true)
	{
		RotaCocaina[playerid] = false;
		DisablePlayerCheckpoint(playerid);
		InfoMsg(playerid, "Rota cancelada.");
	}
	return 1;
}

CMD:roubar(playerid)
{
	if(GetPlayerWeapon(playerid) == 22 || GetPlayerWeapon(playerid) == 24)
	{
		new noti = randomEx(0, 2);
		if(PlayerToPoint(5.0, playerid, 393.256561, -1895.308471, 7.844118))
		{
			if(RouboLoja1 == true)return ErrorMsg(playerid, "Esta loja ja foi roubada.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");

			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				
			CreateProgress(playerid, "RoubarLoja","Roubando caixa lojinha...", 1000);
			
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar a Lojinha 1");
						WarningMsg(i, Str);
					}
				}
			}
			InfoMsg(playerid, "Voce comecou a roubar a Loja de Utilidades 1.");
			return 1;
		}
		if(PlayerToPoint(5.0, playerid, 1359.771850, -1774.149291, 13.551797))
		{
			if(RouboLoja2 == true)return ErrorMsg(playerid, "Esta loja ja foi roubada.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");

			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				
			CreateProgress(playerid, "RoubarLoja","Roubando caixa lojinha...", 1000);
			
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar a Lojinha 2");
						WarningMsg(i, Str);
					}
				}
			}
			InfoMsg(playerid, "Voce comecou a roubar a Loja de Utilidades 2.");
			return 1;
		}
		if(PlayerToPoint(5.0, playerid, 1663.899047, -1899.635009, 13.569333))
		{
			if(RouboLoja3 == true)return ErrorMsg(playerid, "Esta loja ja foi roubada.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");

			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				
			CreateProgress(playerid, "RoubarLoja","Roubando caixa lojinha...", 1000);
			
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar a Lojinha 3");
						WarningMsg(i, Str);
					}
				}
			}
			InfoMsg(playerid, "Voce comecou a roubar a Loja de Utilidades 3.");
			return 1;
		}
		if(PlayerToPoint(5.0, playerid, 2054.312255, -1883.058105, 13.570812))
		{
			if(RouboLoja4 == true)return ErrorMsg(playerid, "Esta loja ja foi roubada.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");

			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				
			CreateProgress(playerid, "RoubarLoja","Roubando caixa lojinha...", 1000);
			
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar a Lojinha 4");
						WarningMsg(i, Str);
					}
				}
			}
			InfoMsg(playerid, "Voce comecou a roubar a Loja de Utilidades 4.");
			return 1;
		}
		if(PlayerToPoint(5.0, playerid, 1310.963256, -856.883911, 39.597454))
		{
			if(RouboLoja5 == true)return ErrorMsg(playerid, "Esta loja ja foi roubada.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");

			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				
			CreateProgress(playerid, "RoubarLoja","Roubando caixa lojinha...", 1000);
			
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar a Lojinha 5");
						WarningMsg(i, Str);
					}
				}
			}
			InfoMsg(playerid, "Voce comecou a roubar a Loja de Utilidades 5.");
			return 1;
		}
		if(PlayerToPoint(5.0, playerid, 1316.121826, -1113.496704, 24.960447))
		{
			if(RouboRestaurante == true)return ErrorMsg(playerid, "Esta pizzaria ja roubado.");
			if(policiaon < 2) return ErrorMsg(playerid, "Nao ha policiais em patrulha no momento.");

			TogglePlayerControllable(playerid, 0);
			ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.1, 1, 0, 0, 0, 0, 1);
				
			CreateProgress(playerid, "RoubarLoja","Roubando caixa pizzaria...", 1000);
			
			if(noti == 1)
			{
				foreach(Player, i)
				{
					if(Patrulha[i] == true)
					{
						format(Str, sizeof(Str), "Um cidadao acabou de denunciar um individuo tentando roubar a Pizzaria");
						WarningMsg(i, Str);
					}
				}
			}
			InfoMsg(playerid, "Voce comecou a roubar a Pizzaria.");
			return 1;
		}
	}
	return 1;	
}

CMD:desmanchar(playerid)
{
	if(PlayerInfo[playerid][Org] == 12 || PlayerInfo[playerid][Org] == 13)
	{
		if(PTP(5.0, playerid, 406.967926, 2435.910644, 17.121870) || PTP(5.0, playerid, 401.748901, 2436.063232, 17.121870) || PTP(5.0, playerid, 395.880065, 2435.940917, 17.121870))
		{
			Controle(playerid, 0);
			CreateProgress(playerid, "DesmancharVeh","Desmanchando Veiculo...", 200);
		}
	}
	return 1;
}

CMD:creditos(playerid)
{
    MEGAString[0] = EOS;
    strcat(MEGAString, "{33CCFF}|________________________________| Créditos do servidor |________________________________|\n\n");

    strcat(MEGAString, "{FFFFFF}»  Luan P Rosa(Rosa Scripter)\n");
    strcat(MEGAString, "{696969}               (Criador/Fundador do servidor | Atual Scripter)\n");
    strcat(MEGAString, "{696969}Função: Cuidar da programação\n\n");

    strcat(MEGAString, "{FFFFFF}»  Allisson Gomes(Chapei)\n");
    strcat(MEGAString, "{696969}               (Criador/Fundador do servidor | Atual Scripter)\n");
    strcat(MEGAString, "{696969}Função: Cuidar da programação\n\n");
    
    strcat(MEGAString, "{FFFFFF}»  Maconha\n");
    strcat(MEGAString, "{696969}               (Criador/Fundador do servidor)\n");
    strcat(MEGAString, "{696969}Função: Responsável Geral\n\n");

	strcat(MEGAString, "{FFFFFF}»  HernandezRL\n");
    strcat(MEGAString, "{696969}               (Criador/Fundador do servidor)\n");
    strcat(MEGAString, "{696969}Função: Responsável Geral\n\n");

    strcat(MEGAString, "{FFFFFF}»  Brabox, Mauricio(Aox), Black, Rxth\n");
    strcat(MEGAString, "{696969}               Agradecimentos por colaborarem com o Servidor\n\n");

    strcat(MEGAString, "{696969}       Toda a gamemode foi feita totalmente da linha 1 por Luan P Rosa(Rosa Scripter)\n\n");
	ShowPlayerDialog(playerid, DIALOG_CREDITOS, DIALOG_STYLE_MSGBOX, "Creditos", MEGAString, "Fechar", "");
	return true;
}

CMD:terminar(playerid, x_Emprego[])
	{
		if(IsPlayerConnected(playerid))
		{
			if(strcmp(x_Emprego,"atendimento",true) == 0)
			{
				if(InviteAtt[playerid] < 999)
				{
					if(IsPlayerConnected(InviteAtt[playerid]))
					{
						if(ChatAtendimento[playerid] == 0)
						{
							ErrorMsg(playerid,  "Você não está em um atendimento.");
							return 1;
						}
						foreach(new i: Player)
						{
							if(InviteAtt[i] == playerid)
							{
								new gstring[255];
								format(stringZCMD,sizeof(stringZCMD),"%d",playerid);
								cmd_pediravaliar(i, stringZCMD);
								ChatAtendimento[playerid] = 0;
								ChatAtendimento[i] = 0;
								IDAvaliou[playerid] = 999;
								IDAvaliou[i] = 999;
								InviteAtt[i] = 999;
								InviteAtt[playerid] = 9999;
								NumeroChatAtendimento[i] = 0;
								NumeroChatAtendimento[playerid] = 0;
								format(gstring, 128, "* %s saiu do atendimento.", Name(playerid));
								SendClientMessage(i, -1, gstring);
								format(gstring, sizeof(gstring), "* Você saiu do atendimento.");
								SendClientMessage(playerid, -1, gstring);
							}
						}
					}
					else
					{
						ErrorMsg(playerid,  "O jogador que lhe convidou não está conectado.");
						return 1;
					}
				}
				else
				{
					ErrorMsg(playerid,  "Você não está em um atendimento.");
					return 1;
				}
			}
		}
		return 1;
	}

DCMD:verificar(user, channel, params[])
{
    new ds_userid[20 + 1];
	new Cod;
	new File[255];
	new str[255];
	new DCC_Role:Role,
		DCC_Role:Role2,
        DCC_Guild:Server;
	new
        DCC_Message:message;
    message = DCMD_GetCommandMessageId();
	new username[33];
        DCC_GetUserName(user, username, sizeof(username));

	Role = DCC_FindRoleById("1167488204425924669");
	Role2 = DCC_FindRoleById("1145554614545031341");
	Server = DCC_FindGuildById("1145549003128315985");
    DCC_GetUserId(user, ds_userid);
	if(sscanf(params, "d", Cod)) return DCC_SendChannelMessage(channel,  "!verificar [IDF]");
	{
		format(File, sizeof(File), "IDCONTAS/%04d.ini", Cod);
		if(DOF2_FileExists(File)) 
		{
			format(str, sizeof(str), "**%s** O IDF informado consta e agora esta verificado!", username);
			DCC_SendChannelMessage(channel, str);
			DCC_AddGuildMemberRole(Server, user, Role);
			DCC_RemoveGuildMemberRole(Server, user, Role2);
			DOF2_RemoveFile(File);
		}
		else
		{
			format(str, sizeof(str), "**%s** O IDF informado nao consta em nosso banco de dados!", username);
			DCC_SendChannelMessage(channel, str);
		}
	}
	DCC_DeleteMessage(message);
    return 1;
} 

DCMD:criarkeydc(user, channel, params[]) {

	new File[255];
	new vl; 
	new
        DCC_Message:message;
    message = DCMD_GetCommandMessageId();
	if(channel == ComandosIG)
	{ 
	    if(sscanf(params, "d", vl)) return DCC_SendChannelMessage(channel, "!criarkeydc [Valor]");
		{
			DCC_DeleteMessage(message);
			new Cod = randomEx(0,99999999);
			format(File, sizeof(File), PASTA_KEYS, Cod);
			DOF2_CreateFile(File);
			DOF2_SetInt(File, "Valor", vl);
			DOF2_SaveFile();
			new str[180];
			format(str, sizeof(str), "O cupom **%d** se criou com %s de coins.", Cod, ConvertMoney(vl));
			DCC_SendChannelMessage(channel, str);
		}
	}
    return 1;
}

DCMD:cadeiadc(user, channel, params[])
{
	new username[33];
        DCC_GetUserName(user, username, sizeof(username));
	if(channel == ComandosIG)
	{ 
		if(sscanf(params, "iis[56]", ID, Numero, Motivo))			return DCC_SendChannelMessage(channel,"USE: !cadeiadc [ID] [TEMPO EM MINUTOS] [MOTIVO]");
		foreach(Player,i)
	  	{
			if(pLogado[i] == true)
			{
				if(PlayerInfo[i][IDF] == ID)
				{
					if(Numero != 0)
					{
						PlayerInfo[i][pCadeia] = Numero * 60;
						SetPlayerPos(i,  322.197998,302.497985,999.148437);
						SetPlayerInterior(i, 5);
						SetPlayerVirtualWorld(i, 0);
						TogglePlayerControllable(i, false);
						SetTimerEx("carregarobj", 5000, 0, "i", i);
					}
					else
					{
						PlayerInfo[i][pCadeia] = 1;
					}
					DCC_SendChannelMessage(channel, "Deu cadeia no jogador.");
					InfoMsg(i, "Algum administrador te colocou na cadeia.");
					format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}prendeu {FFFF00}%04d {FFFFFF}por {FFFF00}%i {FFFFFF}minutos. Motivo: {FFFF00}%s", username, GetPlayerIdfixo(i), Numero, Motivo);
					SendClientMessageToAll(-1, Str);

					new string[255];
					new DCC_Embed:embed = DCC_CreateEmbed("Baixada Roleplay");                                                   
					format(string,sizeof(string),"### CADEIA STAFF\n\nID: %04d\nPertence: %s\nPreso por: %s\nTempo: %i minuto(s)\nMotivo: %s", PlayerInfo[i][IDF],Name(i), username, Numero, Motivo);
					DCC_SetEmbedColor(embed, 0xFFFF00);
					DCC_SetEmbedDescription(embed, string);
					DCC_SetEmbedImage(embed, "https://cdn.discordapp.com/attachments/1145559314900189256/1153871579642613760/JOGA.BAIXADARP.COM.BR7777_20230919_225304_0000.png");
					DCC_SendChannelEmbedMessage(Punicoes, embed);
				}
			}
			else
			{
				DCC_SendChannelMessage(channel, "Jogador nao conectado.");
			}
	  	}
	  	DCC_SendChannelMessage(channel, "Jogador nao conectado.");
	}
	return 1;
}

CMD:dominar(playerid)
{
	if(PlayerInfo[playerid][Org] < 1)						return ErrorMsg(playerid, "Nao possui permissao.");
    if(IsPlayerInPlace(playerid,-460.22906494140625, 1281.9999694824219, -140.22906494140625, 1643.9999694824219))
    {
        if(IsPolicial(playerid))
        {
	        GangZoneFlashForAll(Parabolica,0x328fc00);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 5)
        {
            GangZoneFlashForAll(Parabolica,0xfcf00300);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 6)
        {
            GangZoneFlashForAll(Parabolica,0x0398fc00);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 7)
        {
            GangZoneFlashForAll(Parabolica,0xfc030300);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 8)
        {
            GangZoneFlashForAll(Parabolica,0x13fc0300);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 12)
        {
            GangZoneFlashForAll(Parabolica,0xe3a65600);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 13)
        {
            GangZoneFlashForAll(Parabolica,0x59422500);
            CreateProgress(playerid, "DominarLParabolica","Dominando...", 600+600+600+600+600);
        }
    }
    else if(IsPlayerInPlace(playerid,-1434.2429809570312, 1902.6701049804688, -987.2429809570312, 2672.6701049804688))
    {
	    if(IsPolicial(playerid))
        {
	        GangZoneFlashForAll(Barragem,0x328fc00);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 5)
        {
            GangZoneFlashForAll(Barragem,0xfcf00300);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 6)
        {
            GangZoneFlashForAll(Barragem,0x0398fc00);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 7)
        {
            GangZoneFlashForAll(Barragem,0xfc030300);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 8)
        {
            GangZoneFlashForAll(Barragem,0x13fc0300);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 12)
        {
            GangZoneFlashForAll(Barragem,0xe3a65600);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
        else if(PlayerInfo[playerid][Org] == 13)
        {
            GangZoneFlashForAll(Barragem,0x59422500);
            SetTimer("DominarBarragem",minutos(5),false);
            CreateProgress(playerid, "DominarLBarragem","Dominando...", 600+600+600+600+600);
        }
    }     
    return 1;
}