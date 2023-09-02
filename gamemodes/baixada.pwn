//                          INCLUDES

#define SSCANF_NO_NICE_FEATURES
#define DEBUG

#include        <  	    a_samp  		>
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
#include 		<	  nex-ac_pt_br.lang	>
#include 		<	    nex-ac		 	>
#include        <   	DOF2   			>
#include        <   	ZCMD	   		>
#include 		<	    mapfix		 	>
#include 		< 		notificacao	 	>
#include 		< 		enterfix 		>
#include		<		progress2		>
#include		<		processo		>

#define CallBack::%0(%1) 		forward %0(%1);\
							public %0(%1)

new	UltimaFala[MAX_PLAYERS];
#define SEGUNDOS_SEM_FALAR  		2  

//                          ICONES NOTIFICAÇÃO

#define ICONE_ERRO 			"hud:thumbdn" // ICONE ERRO
#define ICONE_AVISO 		"hud:badchat" //ICONE INFO
#define ICONE_CERTO 		"hud:thumbup" //ICONE CORRETO
#define ICONE_EMPREGO 		"hud:radar_TORENO" //ICONE TRABALHO

//                          CONVERT-TEMPOS

#define minutos(%0) 				(1000 * %0 * 60)
#define horas(%0) 					(1000 * %0 * 60 * 60)
#define segundos(%0) 				(1000 * %0)
#define dias(%0) 					(1000 * %0 * 60 * 60  * 24)

//                          DEFINES FORMATADAS

#define ShowErrorDialog(%1,%2) ShowPlayerDialog(%1, DIALOG_ERROR, DIALOG_STYLE_MSGBOX, "ERRO", %2, "OK", "")
#define Kick(%0) 					SetTimerEx("KickPlayer", 500, false, "i", %0)
#define SpawnPlayerID(%0) 			SetTimerEx("SpawnP", 500, false, "i", %0)

#define SERVERFORUM     			"discord.gg/QYpxa5SvNB" //DISCORD DO SEU SERVER	

//                          SISTEMA DEALERSHIP (CONCE E POSTO)

#define TEMPO_SOM_ALARME 			minutos(2)
#define PLACA_CONCESSIONARIA 		"SEMPLACA"
#define VEHICLE_DEALERSHIP 			1
#define VEHICLE_PLAYER 				2
#define PRECO_GASOLINA 				1200
#define PRECO_GALAO 				500

//                          DEFINES MAX

#define MAX_CAIXAS              	50
#define MAX_ZONE_NAME 				28
#define MAX_VAGAS          			20+1
#define MAX_ORGS           			13
#define MAX_MACONHA        			300
#define Max_Crescida       			10
#define MAX_CASAS        			500
#define MAX_RADAR        			500 
#define MAX_PICKUPS_ROUBO       	50   
#define MAX_DVEHICLES 				500
#define MAX_DEALERSHIPS 			100
#define MAX_FUEL_STATIONS 			100
#define MAX_PLAYER_VEHICLES 		1
#define MAX_SLOTMACHINE 			50
#define MAX_FREQUENCIAS				1000

//                          PASTAS

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
#define PASTA_COFRES                "CofreArmas/Cofre%d.ini"
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
//                           CORES

#define 	CorAmareloServer 	0xFFFF00FF
#define		CorSucesso      	0xFF0000FF
#define     CorErro         	0xFF4500FF
#define     CorErroNeutro   	0xFFFFFFFF
#define     Branco          	0xFFFFFFFF
#define     CinzaClaro      	0xD3D3D3FF
#define     CinzaEscuro     	0xE64022FF
#define     Azul            	0x00FF0000
#define     AzulClaro       	0x1E90FFFF
#define     AzulRoyal       	0x4169E1FF
#define     Verde           	0x00FF00FF
#define     Amarelo         	0xFFFF00FF
#define     Vermelho        	0xFF0000FF
#define     VermelhoEscuro  	0xB22222FF
#define 	COLOR_LGREEN 		0xD7FFB3FF
#define 	COR_VERMELHO    	0xFF0000FF
#define 	COR_GREY	    	0xAFAFAFAA
#define 	COLOR_BLACK 		0x000000FF
#define 	COLOR_RED 			0xEE0000FF
#define 	COLOR_GREEN 		0x00CC00FF
#define 	COLOR_BLUE 			0x0000FFFF
#define 	COLOR_ORANGE 		0xFF6600FF
#define 	COLOR_YELLOW 		0xFFFF00FF
#define 	COLOR_LIGHTBLUE 	0x00FFFFFF
#define 	COLOR_PURPLE 		0xC2A2DAFF
#define 	COLOR_GREY 			0xC0C0C0FF
#define 	COLOR_WHITE 		0xFFFFFFFF

//                          DISCORD

static DCC_Channel:Chat;
static DCC_Channel:Dinn;
static DCC_Channel:EntradaeSaida;
static DCC_Channel:Report;
static DCC_Channel:ChatAdm;
static DCC_Channel:Sets;

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
	DIALOG_SELSEXO,
	DIALOG_SELIDADE,
	DIALOG_BANIDO,
	DIALOG_POS,
	DIALOG_PRESOS,
	DIALOG_CARTORIO,
	DIALOG_BANCO,
	DIALOG_BANCO1,
	DIALOG_BANCO2,
	DIALOG_BANCO3,
	DIALOG_BANCO4,
	DIALOG_BANCO5,
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
	DIALOG_247,
	D_VOIP,
	DIALOG_CELULAR,
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
	DIALOG_2LIST,
	DIALOG_3LIST,
	DIALOG_4LIST,
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
	DIALOG_AVALIAR
}

//                          VARIAVEIS

enum pInfo
{
	pSenha[24],
	IDF,
	pSkin,
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
	pAvaliacao
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
new IniciarRadares;
new Text3D:TextoRadar[MAX_RADAR];

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

enum Cofre
{
	CofreID,

	Float:CofrePosX,
	Float:CofrePosY,
	Float:CofrePosZ,
    Float:CofrePosR
};
new CofreOrg[MAX_ORGS][CofreInfoD];
new CofreInfo[MAX_ORGS][Cofre];
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
new PlayerText:TextDrawMorte[MAX_PLAYERS][6];

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

new
	PlayerText: CasinoPTD[ 33 ],
	Text: CasinoTD[ 15 ],
	MineActive[ MAX_PLAYERS ][ 30 ],
	MineBomb[ MAX_PLAYERS ][ 30 ]
;

//                          STRINGS

new	Motivo[255],
	Str[1200];
new MEGAString[2860];

//                          BOOLS

new	bool:AntiAFK_Ativado = true,
	bool:Moved[MAX_PLAYERS] = false,
	bool:FoiCriado[MAX_VEHICLES] = false,
	bool:FirstLogin[MAX_PLAYERS] = true,
	bool:SpawnPos[MAX_PLAYERS] = false,
	bool:pJogando[MAX_PLAYERS] = true,
	bool:pLogado[MAX_PLAYERS] = false,
	bool:IsAssistindo[MAX_PLAYERS] = false,
	bool:ContagemIniciada = false,
	bool:ChatLigado = true;
new bool:GPS[MAX_PLAYERS] = false;
new bool:UsouCMD[MAX_PLAYERS] = false;
new bool:Patrulha[MAX_PLAYERS] = false;
new bool:PegouMaterial[MAX_PLAYERS] = false;
new bool:TxdBAncoAb[MAX_PLAYERS] = false;
new	bool:AparecendoNoAdmins[MAX_PLAYERS] = true;

//                          TEXTDRAWS

new Text:TDEditor_TD[66];
new PlayerText:TDEditor_PTD[MAX_PLAYERS][6];
new	PlayerText:Textdraw2[MAX_PLAYERS];
new PlayerText:HudCop[MAX_PLAYERS][4];
new PlayerText:CopGuns[MAX_PLAYERS][6];
new Text:Textdraw0,
	Text:Textdraw1;
new PlayerText:HudServer[MAX_PLAYERS][10];
new Text:Logo[8];
new PlayerText:Registration_PTD[MAX_PLAYERS][23];

//                          VARIAVEIS DA SLOTS

enum TLucky {TDName[16]}
new PLucky[][TLucky] = {"ld_slot:r_69", "ld_slot:grapes", "ld_slot:cherry", "ld_slot:bell", "ld_slot:bar2_o", "ld_slot:bar1_o"};
enum InfoSlotMachine {SmObject, DiceIcon, Text3D:TextoSm, bool:Occupied, Jackpot};
new DataSlotMachine[MAX_SLOTMACHINE][InfoSlotMachine];
new PlayerText:TDLucky[5], bool:Playing[MAX_PLAYERS], RandLucky[3][MAX_PLAYERS]; 
new Spin[MAX_PLAYERS], TimerSpin[MAX_PLAYERS], Prize[MAX_PLAYERS], SmID[MAX_PLAYERS], EditingSM[MAX_PLAYERS];
#define MINIMUM_BET 				1000

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

//                          VARIAVEIS SEM COMENT

new RecentlyShot[MAX_PLAYERS];
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
new RepairCar[MAX_PLAYERS];
new bool:TemCinto[MAX_PLAYERS] = false;
new ProxID;

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

new Float:Entradas[7][3] =
{
	{1172.0829, -1323.5533, 15.4034},//Hospital
	{1555.4982, -1676.1260, 16.1953},//Policia de Patrulla
	{2447.828125, -1962.687133, 13.546875},//Mercado Negro
	{1122.706909, -2036.977539, 69.894248},//Prefeitura
	{2105.4880, -1806.2786, 13.5547},//Pizzaria
	{649.326538, -1353.821166, 13.546194},//San News
	{649.283264, -1360.890258, 13.586422}//San News
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

new Float:PosPesca[10][4] =
{
	{403.811187, -2088.797363, 7.835937},
	{398.643920, -2088.798339, 7.835937},
	{396.078948, -2088.797119, 7.835937},
	{391.123809, -2088.797851, 7.835937},
	{383.367950, -2088.795654, 7.835937},
	{374.981445, -2088.798095, 7.835937},
	{369.838806, -2088.797119, 7.835937},
	{367.372222, -2088.798095, 7.835937},
	{362.239532, -2088.796142, 7.835937},
	{354.588775, -2088.798339, 7.835937}
};

new Float:PosEquipar[1][4] =
{
	{307.207489, 1833.923706, 2241.584960}//Policia Patrulla
};

new Float:PosEquiparORG[4][4] =
{
	{2525.950927, -1663.797485, 15.148015},//Verde
	{2349.565673, -1170.487670, 28.066040},//Rojos
	{1673.485595, -2106.939697, 13.546875},//Azul
	{2812.450683, -1188.466308, 25.257419}//Amarillo
};

new Float:PosVeiculos[6][4] =
{
	{1592.244384, -1614.151855, 13.382812},//Policia Patrulla
	{1683.126831, -2312.236816, 13.546875},//Spawn
	{1179.630615, -1339.028686, 13.838010},//Hospital
	{-47.1722,-1143.3977,1.0781},//Camionero
	{926.562072, -1075.043457, 23.885242},//Transportador de Tumba
	{2014.328125, -1770.929077, 13.543199}//Mecanica
};
new VehAlugado[MAX_PLAYERS];
new VeiculoCivil[MAX_PLAYERS];

new Float:PosPVeiculos[1][4] =
{
	{1592.244384, -1614.151855, 13.382812}//Policia Patrulla
};

new Float:PosPrender[1][4] =
{
	{1565.309082, -1694.453125, 5.890625}//Policia Patrulla
};

new Float:Covas[72][3] = 
{
	{838.514343, -1120.070922, 24.028995},
	{838.492248, -1112.102539, 24.161285},
	{843.169799, -1119.531982, 24.030656},
	{843.197021, -1111.562744, 24.170776},
	{848.724182, -1111.063842, 24.179548},
	{848.563354, -1119.039184, 24.039321},
	{851.921630, -1119.228881, 24.035985},
	{848.726867, -1111.066894, 24.179492},
	{851.885192, -1111.270385, 24.175916},
	{857.700134, -1111.258422, 24.183940},
	{862.193725, -1111.259765, 24.183917},
	{867.584045, -1111.255371, 24.183994},
	{871.739318, -1111.152099, 24.177995},
	{875.350402, -1112.102294, 24.161289},
	{879.091247, -1110.783569, 24.184474},
	{881.710205, -1116.761474, 24.123096},
	{878.000793, -1118.220947, 24.053709},
	{874.319885, -1119.562500, 24.030120},
	{869.969177, -1118.612304, 24.046827},
	{865.054687, -1118.719726, 24.044939},
	{857.753295, -1118.719848, 24.052751},
	{887.277954, -1116.763793, 24.185853},
	{895.939270, -1117.318481, 24.188137},
	{903.690490, -1121.058837, 24.052949},
	{907.467895, -1121.057861, 24.052970},
	{911.304260, -1121.054809, 24.015451},
	{908.236328, -1110.870849, 24.196456},
	{916.463073, -1093.511108, 24.296875},
	{911.069763, -1093.596069, 24.296875},
	{915.820983, -1086.327636, 24.296875},
	{911.461425, -1086.280029, 24.296875},
	{904.891601, -1086.752441, 24.296875},
	{901.265380, -1086.375732, 24.296875},
	{898.226989, -1086.025268, 24.296875},
	{889.690551, -1087.238525, 24.296875},
	{884.935363, -1087.238891, 24.296875},
	{881.257019, -1086.855102, 24.303991},
	{878.082641, -1087.638061, 24.296875},
	{872.182556, -1087.627197, 24.296875},
	{867.681274, -1087.716064, 24.296875},
	{863.411743, -1087.715209, 24.296875},
	{857.771301, -1087.715209, 24.296875},
	{849.274719, -1087.527587, 24.296875},
	{844.021667, -1088.019165, 24.303991},
	{838.783874, -1087.444580, 24.303991},
	{838.459289, -1096.225708, 24.303991},
	{842.855407, -1096.473632, 24.303991},
	{848.251647, -1095.981445, 24.303991},
	{857.245178, -1096.170166, 24.296875},
	{865.873596, -1096.168457, 24.296875},
	{870.462158, -1096.061889, 24.296875},
	{874.318542, -1095.788940, 24.296875},
	{877.447753, -1095.691894, 24.303991},
	{914.370361, -1079.848388, 24.296875},
	{918.876892, -1079.138916, 24.293285},
	{910.413146, -1080.277587, 24.296875},
	{905.628784, -1079.737670, 24.296875},
	{881.170593, -1079.338745, 24.296875},
	{878.250671, -1079.310913, 24.296875},
	{876.109191, -1079.392211, 24.296875},
	{872.530944, -1078.522949, 24.296875},
	{867.930541, -1078.628417, 24.296875},
	{862.667053, -1074.790527, 24.308912},
	{858.015686, -1076.194580, 24.296875},
	{852.913391, -1077.910888, 24.296875},
	{851.251708, -1077.043212, 24.296875},
	{844.606445, -1074.848144, 24.305833},
	{839.342895, -1075.449584, 24.296875},
	{898.421386, -1068.702270, 24.481559},
	{890.200439, -1067.922851, 24.602760},
	{883.514099, -1067.509277, 24.798913},
	{879.025329, -1068.310424, 24.867465}
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

main()
{
	Chat = DCC_FindChannelById("1145712079861452850");
	Dinn = DCC_FindChannelById("1145712172794642442");
	EntradaeSaida = DCC_FindChannelById("1145712303124254743");
	Report = DCC_FindChannelById("1145712239614107760");
	ChatAdm = DCC_FindChannelById("1145558205775233044");
	Sets = DCC_FindChannelById("1145712207049527407");

	print("\n'---_.Baixada Roleplay by Luan_Rosa._---'");
	print("--- Gamemode Iniciada Com Sucesso!  ---\n");
}

new RandomMSG[][] =
{
	"Entre em nosso discord <-> Link: {FFFF00}https://discord.gg/QYpxa5SvNB",
	"Creditos aos desenvolvedores no {FFFF00}/creditos.",
	"Boas vindas a um dos melhores servidores inovadores!",
	"Necessita de ajuda? Use {FFFF00}/ajuda {FFFFFF}para verificar os comandos.",
	"Seu dinheiro tem muito valor em nossa cidade, cuide bem dele.",
	"Disfrute o maximo do nosso servidor!",
	"Garanta seu vip em nosso servidor use {FFFF00}/lojavip",
	"Encontre lugares importantes no {FFFF00}/gps",
	"Para denunciar um jogador use {FFFF00}/report",
	"Faca missoes no servidor use {FFFF00}/missoes",
	"Para ver orgs disponiveis use {FFFF00}/orgs",
	"Caso necesita de um atendimento use {FFFF00}/atendimento"
};

//                          PUBLICS

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
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$2100.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2100*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4200.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2100*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4200.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$2150.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2150*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4300.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2150*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4300.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$2150.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2150*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4300.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2150*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4300.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$2400.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2400*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4800.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2400*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4800.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$2500.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2500*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$5000.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2500*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$5000.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$2250.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2250*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4500.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2250*2;
				notificacao(playerid, "TRABALHO", "Entregou a carga e ganhou R$4500.", ICONE_EMPREGO); 
			}
			SetVehicleToRespawn(GetVehicleTrailer(GetPlayerVehicleID(playerid)));
			DisablePlayerCheckpoint(playerid);	
			Carregou[playerid] = 0;
		}
	}
}

Progresso:RotaCova1(playerid, progress)
{
	if(progress >= 100)
	{
		CargoTumba[playerid] = 1;
		TogglePlayerControllable(playerid, 1);
		SetPlayerCheckpoint(playerid, 934.1115,-1103.3857,24.3118, 10);
		notificacao(playerid, "TRABALHO", "Pegou uma cadaver agora volte ao cemiterio.", ICONE_EMPREGO);
	}
}

Progresso:RotaCova2(playerid, progress)
{
	if(progress >= 100)
	{
		CargoTumba[playerid] = 2;
		TogglePlayerControllable(playerid, 1);
		SetPlayerCheckpoint(playerid, 934.1115,-1103.3857,24.3118, 10);
		notificacao(playerid, "TRABALHO", "Pegou uma cadaver agora volte ao cemiterio.", ICONE_EMPREGO);
	}
}

Progresso:RotaCova3(playerid, progress)
{
	if(progress >= 100)
	{
		CargoTumba[playerid] = 3;
		TogglePlayerControllable(playerid, 1);
		SetPlayerCheckpoint(playerid, 934.1115,-1103.3857,24.3118, 10);
		notificacao(playerid, "TRABALHO", "Pegou uma cadaver agora volte ao cemiterio.", ICONE_EMPREGO);
	}
}

Progresso:Cova(playerid, progress)
{
	if(progress >= 100)
	{
		new covastr[500];
		new dincova = randomEx(0,300);
		PlayerInfo[playerid][pDinheiro] += dincova;
		if(PlayerInfo[playerid][pVIP] == 0)
		{
			PlayerInfo[playerid][pDinheiro] += dincova;
			format(covastr,sizeof(covastr),"Ganhou %i concertando essa cova.", dincova);
			notificacao(playerid, "TRABALHO", covastr, ICONE_EMPREGO); 
		}   
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pDinheiro] += dincova*2;
			format(covastr,sizeof(covastr),"Ganhou %i concertando essa cova.", dincova*2);
			notificacao(playerid, "TRABALHO", covastr, ICONE_EMPREGO); 
		}
		if(PlayerInfo[playerid][pVIP] == 3)
		{
			PlayerInfo[playerid][pDinheiro] += dincova*2;
			format(covastr,sizeof(covastr),"Ganhou %i concertando essa cova.", dincova*2);
			notificacao(playerid, "TRABALHO", covastr, ICONE_EMPREGO); 
		}
		ClearAnimations(playerid);
		TogglePlayerControllable(playerid, 1);
		Covaconcerto[playerid] = false;
	}
}

Progresso:Pesca(playerid, progress)
{
	if(progress == 1)
	{ 
		// EM PROGRESSO
	}
	if(progress >= 100)
	{
		new peixes = randomEx(1,3);
		new peixe = randomEx(0,6);
		new s[800];
		if(IsPlayerInRangeOfPoint(playerid, 15.0, 383.2907,-2088.7842,7.8359))
		if(peixe == 0)
		{
			format(s,sizeof(s),"Nao pescou nenhum peixe");
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		if(peixe == 1)
		{
			GanharItem(playerid,902, peixes);
			format(s,sizeof(s),"Pescou %i estrela do mar.",peixes);
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		if(peixe == 2)
		{
			format(s,sizeof(s),"Nao pescou nenhum peixe");
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		if(peixe == 3)
		{
			GanharItem(playerid,19630, peixes);
			format(s,sizeof(s),"Pescou %i tilapia.",peixes);
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		if(peixe == 4)
		{
			GanharItem(playerid,1599, peixes);
			format(s,sizeof(s),"Pescou %i tucunare.",peixes);
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		if(peixe == 5)
		{
			format(s,sizeof(s),"Nao pescou nenhum peixe");
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		if(peixe == 6)
		{
			GanharItem(playerid,1600, peixes);
			format(s,sizeof(s),"Pescou %i royal.",peixes);
			notificacao(playerid, "TRABALHO", s, ICONE_EMPREGO);
		}
		TogglePlayerControllable(playerid, 1);
		UsouCMD[playerid] = false;
	}
	return 1;
}

CallBack::AntiSpam(playerid) 
{
	RecentlyShot[playerid] = 0;
	return 1;
}

CallBack::Attplayer(playerid){
	new str[100];
	if(Falou[playerid] == true){
		format(str,sizeof(str),"{FFFF00}[FALANDO]\n{FFFFFF}%04d{FFFF00}%d",PlayerInfo[playerid][IDF],playerid);
	}else if(Susurrou[playerid] == true){
		format(str,sizeof(str),"{FFFF00}[SUSURRANDO]\n{FFFFFF}%04d{FFFF00}%d",PlayerInfo[playerid][IDF],playerid);
	}else if(Gritou[playerid] == true){
		format(str,sizeof(str),"{FFFF00}[GRITANDO]\n{FFFFFF}%04d{FFFF00}%d",PlayerInfo[playerid][IDF],playerid);
	}
	if(pJogando[playerid] == true){
		format(str,sizeof(str),"{FFFF00}\n{FFFFFF}%04d{FFFF00}%d",PlayerInfo[playerid][IDF],playerid);
	}else{
		format(str,sizeof(str),"%04d{FFFF00}%d",PlayerInfo[playerid][IDF],playerid);
	}
	SetPlayerChatBubble(playerid, str, 0xFFFFFFFF, 8.0, 20000);
	return true;
}

CallBack::attloginname(playerid)
{
	new stringg[50];
	format(stringg, sizeof(stringg), "%s", Name(playerid));
	PlayerTextDrawSetString(playerid, Registration_PTD[playerid][20], stringg);
	PlayerTextDrawSetString(playerid, TDEditor_PTD[playerid][0], stringg);
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
        PlayerMorto[playerid][pSegMorto]-= 1;
        if(PlayerMorto[playerid][pSegMorto] <= 0)
        {
            PlayerMorto[playerid][pSegMorto] = 60;
            PlayerMorto[playerid][pMinMorto]-= 1;
        }
    
        new Jtempo[90];
        format(Jtempo, sizeof(Jtempo),"~r~%s:%s", ConvertTimeX(PlayerMorto[playerid][pMinMorto]) ,ConvertTimeX(PlayerMorto[playerid][pSegMorto]));
        PlayerTextDrawSetString(playerid,TextDrawMorte[playerid][5],Jtempo);
   
        SetPlayerHealth(playerid, 100);
        SetPlayerPos(playerid, PlayerMorto[playerid][pPosMt1], PlayerMorto[playerid][pPosMt2], PlayerMorto[playerid][pPosMt3]);
        SetPlayerInterior(playerid, PlayerMorto[playerid][pInteriorMxxx]);
        SetPlayerVirtualWorld(playerid, PlayerMorto[playerid][pVirtual]);
        ApplyAnimation(playerid, "CRACK", "crckdeth3", 4.1, 0, 1, 1, 1, 60000, 1);
        return 1; 
    }
    if(PlayerMorto[playerid][pEstaMorto] == 0)
    {
        KillTimer(TimerMorto[playerid]);
        return 1; 
    }
    return 1; 
}

CallBack::mostrarTelaLogin(playerid)
{
	if(CarregandoTelaLogin[playerid] < 99){
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
			notificacao(playerid, "INFO", "Seu banimento acabou.", ICONE_AVISO);
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
			for(new i; i < 100; i++)
			{
				SendClientMessage(playerid, CinzaEscuro, " ");
			}
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
		new str[60];
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
		for(new t=0;t<52;t++){
  			TextDrawShowForPlayer(playerid,VeloC_G[t]);
		}
		for(new t=0;t<10;t++){
  			PlayerTextDrawShow(playerid,VeloC[playerid][t]);
		}
	}else{
	    if(mostrandovelo[playerid] != 0){
	    	for(new t=0;t<10;t++){
  				PlayerTextDrawHide(playerid,VeloC[playerid][t]);
			}
			for(new t=0;t<52;t++){
  				TextDrawHideForPlayer(playerid,VeloC_G[t]);
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
	}
	if(keyid == 0x42 && Susurrando[playerid] == true)
	{
		SvAttachSpeakerToStream(Susurrandos[playerid], playerid); //local susurrando
		Susurrou[playerid] = true;
	}
	if(keyid == 0x42 && Gritando[playerid] == true)
	{
		SvAttachSpeakerToStream(Gritandos[playerid], playerid); //local gritando
		Gritou[playerid] = true;
	}
	if(keyid == 0x5A && gstream)
	{
	    if(IsPlayerAdmin(playerid))
	    {
			SvAttachSpeakerToStream(gstream, playerid); //global
		}
	}
	if(keyid == 0x42 && FrequenciaConectada[playerid] >= 1)
	{
		ApplyAnimation(playerid, "ped", "phone_talk", 4.1, 1, 1, 1, 0, 0, 0);
		if(!IsPlayerAttachedObjectSlotUsed(playerid, 9)) SetPlayerAttachedObject(playerid, 9, 19942, 2, 0.0300, 0.1309, -0.1060, 118.8998, 19.0998, 164.2999);
		SvAttachSpeakerToStream(Frequencia[FrequenciaConectada[playerid]], playerid);
	}
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid,SV_UINT:keyid)
{
	if(keyid == 0x42 && Falando[playerid] == true)
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		Falou[playerid] = false;
	}
	if(keyid == 0x42 && Susurrando[playerid] == true)
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		Susurrou[playerid] = false;
	}
	if(keyid == 0x42 && Gritando[playerid] == true)
	{
		SvDetachSpeakerFromStream(lstream[playerid], playerid);
		Gritou[playerid] = false;
	}
	if(keyid == 0x5A && gstream)
	{
	    if(IsPlayerAdmin(playerid))
	    {
			SvDetachSpeakerFromStream(gstream, playerid);
		}
	}
	if(keyid == 0x42 && FrequenciaConectada[playerid] >= 1)
	{
		SvDetachSpeakerFromStream(Frequencia[FrequenciaConectada[playerid]], playerid);
		ClearAnimations(playerid);
		if(IsPlayerAttachedObjectSlotUsed(playerid, 9)) RemovePlayerAttachedObject(playerid, 9);
	}
}

CallBack::StopAnim(playerid)
{
	new Float:X, Float:Y, Float:Z;
	ClearAnimations(playerid), GetPlayerPos(playerid, X, Y, Z), SetPlayerPos(playerid, X, Y, Z+1), DataSlotMachine[SmID[playerid]][Occupied] = false, SmID[playerid] = -1;
	return 1;
}

CallBack::SpinSlotMachine(playerid)
{
	Spin[playerid]++;
	if(Spin[playerid] == 1)
	{
		for(new i; i < 5; i++) {PlayerTextDrawShow(playerid, TDLucky[i]);}
		TimerSpin[playerid] = SetTimerEx("SpinSlotMachine", 50, true, "i", playerid), ApplyAnimation(playerid, "CASINO", "Slot_wait", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 4201, 0.0, 0.0, 0.0);
	}
	if(Spin[playerid] < 38) return PlayerTextDrawSetString(playerid, TDLucky[1], PLucky[random(6)][TDName]), PlayerTextDrawSetString(playerid, TDLucky[2], PLucky[random(6)][TDName]), PlayerTextDrawSetString(playerid, TDLucky[3], PLucky[random(6)][TDName]);
	if(Spin[playerid] == 39) return PlayerPlaySound(playerid, 4202, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDLucky[1], PLucky[RandLucky[0][playerid] = random(6)][TDName]), PlayerTextDrawSetString(playerid, TDLucky[2], PLucky[random(6)][TDName]), PlayerTextDrawSetString(playerid, TDLucky[3], PLucky[random(6)][TDName]);
	if(Spin[playerid] < 69) return PlayerTextDrawSetString(playerid, TDLucky[2], PLucky[random(6)][TDName]), PlayerTextDrawSetString(playerid, TDLucky[3], PLucky[random(6)][TDName]);
	if(Spin[playerid] == 69) return PlayerPlaySound(playerid, 4202, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDLucky[2], PLucky[RandLucky[1][playerid] = random(6)][TDName]), PlayerTextDrawSetString(playerid, TDLucky[3], PLucky[random(6)][TDName]);
	if(Spin[playerid] < 99) return PlayerTextDrawSetString(playerid, TDLucky[3], PLucky[random(6)][TDName]);
	if(Spin[playerid] == 99) return PlayerPlaySound(playerid, 4202, 0.0, 0.0, 0.0), PlayerTextDrawSetString(playerid, TDLucky[3], PLucky[RandLucky[2][playerid] = random(6)][TDName]);
	if(Spin[playerid] == 100) return RewardPrize(playerid);
	if(Spin[playerid] == 130)
	{
		for(new i; i < 5; i++) {PlayerTextDrawHide(playerid, TDLucky[i]);}
		Spin[playerid] = 0, RandLucky[0][playerid] = 0, RandLucky[1][playerid] = 0, RandLucky[2][playerid] = 0, Playing[playerid] = false, Prize[playerid] = 0, KillTimer(TimerSpin[playerid]);
	}
	return 0;
}
RewardPrize(playerid)
{
	new String[128];
	if(RandLucky[0][playerid] == 0)
	{
		if(RandLucky[0][playerid] == RandLucky[1][playerid] && RandLucky[1][playerid] == RandLucky[2][playerid]) 
		{
			new PrizeJackpot[MAX_PLAYERS];
			PrizeJackpot[playerid] = DataSlotMachine[SmID[playerid]][Jackpot]+Prize[playerid]*10, GameTextForPlayer(playerid, "~p~JACKPOT", 1400, 6), format(String, sizeof(String), "Parabens, Voce acaba de fazer um JACKPOT e ganhou R$%i.", PrizeJackpot[playerid]), notificacao(playerid, "INFO", String, ICONE_AVISO);
			PlayerInfo[playerid][pDinheiro] += PrizeJackpot[playerid], DOF2_SetInt(GetSlotMachine(SmID[playerid]), "Jackpot", DataSlotMachine[SmID[playerid]][Jackpot] = 0), DOF2_SaveFile(), ApplyAnimation(playerid, "CASINO", "Slot_win_out", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 5461, 0.0, 0.0, 0.0), SetTimerEx("StopAnim", segundos(7), false, "i", playerid);
		}
		if(RandLucky[0][playerid] != RandLucky[1][playerid] || RandLucky[1][playerid] != RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~r~PERDIO", 1400, 6), ApplyAnimation(playerid, "CASINO", "Slot_lose_out", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0), DOF2_SetInt(GetSlotMachine(SmID[playerid]), "Jackpot", DataSlotMachine[SmID[playerid]][Jackpot]+Prize[playerid]), DOF2_SaveFile(), SetTimerEx("StopAnim", segundos(4), false, "i", playerid);
	}
	if(RandLucky[0][playerid] == 4)
	{
		if(RandLucky[0][playerid] == RandLucky[1][playerid] && RandLucky[1][playerid] == RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~y~8X APUESTA", 1400, 6), format(String, sizeof(String), "Parabens recebeu R$%i.", Prize[playerid]*8), notificacao(playerid, "INFO", String, ICONE_AVISO), PlayerInfo[playerid][pDinheiro] += Prize[playerid]*8,
		ApplyAnimation(playerid, "CASINO", "manwind", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 5448, 0.0, 0.0, 0.0), SetTimerEx("StopAnim", segundos(2), false, "i", playerid);
		if(RandLucky[0][playerid] != RandLucky[1][playerid] || RandLucky[1][playerid] != RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~r~PERDIO", 1400, 6), ApplyAnimation(playerid, "CASINO", "Roulette_lose", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0), DOF2_SetInt(GetSlotMachine(SmID[playerid]), "Jackpot", DataSlotMachine[SmID[playerid]][Jackpot]+Prize[playerid]), DOF2_SaveFile(), SetTimerEx("StopAnim", segundos(2), false, "i", playerid);
	}
	if(RandLucky[0][playerid] == 5)
	{
		if(RandLucky[0][playerid] == RandLucky[1][playerid] && RandLucky[1][playerid] == RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~b~6X APUESTA", 1400, 6), format(String, sizeof(String), "Parabens recebeu R$%i.", Prize[playerid]*6), notificacao(playerid, "INFO", String, ICONE_AVISO), PlayerInfo[playerid][pDinheiro] += Prize[playerid]*6,
		ApplyAnimation(playerid, "CASINO", "manwind", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 5448, 0.0, 0.0, 0.0), SetTimerEx("StopAnim", segundos(2), false, "i", playerid);
		if(RandLucky[0][playerid] != RandLucky[1][playerid] || RandLucky[1][playerid] != RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~r~PERDIO", 1400, 6), ApplyAnimation(playerid, "CASINO", "Roulette_lose", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0), DOF2_SetInt(GetSlotMachine(SmID[playerid]), "Jackpot", DataSlotMachine[SmID[playerid]][Jackpot]+Prize[playerid]), DOF2_SaveFile(), SetTimerEx("StopAnim", segundos(2), false, "i", playerid);
	}
	if(RandLucky[0][playerid] == 1 || RandLucky[0][playerid] == 2 || RandLucky[0][playerid] == 3)
	{
		if(RandLucky[0][playerid] == RandLucky[1][playerid] && RandLucky[1][playerid] == RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~g~3X APUESTA", 1400, 6), format(String, sizeof(String), "Parabens recebeu R$%i.", Prize[playerid]*3), notificacao(playerid, "INFO", String, ICONE_AVISO), PlayerInfo[playerid][pDinheiro] += Prize[playerid]*3,
		ApplyAnimation(playerid, "CASINO", "manwinb", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 5448, 0.0, 0.0, 0.0), SetTimerEx("StopAnim", segundos(2), false, "i", playerid);
		if(RandLucky[0][playerid] != RandLucky[1][playerid] || RandLucky[1][playerid] != RandLucky[2][playerid]) return GameTextForPlayer(playerid, "~r~PERDIO", 1400, 6), ApplyAnimation(playerid, "CASINO", "Roulette_lose", 4.1, 0, 0, 0, 1, 1, 1), PlayerPlaySound(playerid, 4203, 0.0, 0.0, 0.0), DOF2_SetInt(GetSlotMachine(SmID[playerid]), "Jackpot", DataSlotMachine[SmID[playerid]][Jackpot]+Prize[playerid]), DOF2_SaveFile(), SetTimerEx("StopAnim", segundos(2), false, "i", playerid);
	}
	return 1;
}

LoadSlotMachines()
{
	new string[255];
	for(new i; i < MAX_SLOTMACHINE; i++)
	{
	    if(!DOF2_FileExists(GetSlotMachine(i))) continue;
		DataSlotMachine[i][DiceIcon] = CreateDynamicMapIcon(DOF2_GetFloat(GetSlotMachine(i), "PozX"), DOF2_GetFloat(GetSlotMachine(i), "PozY"), DOF2_GetFloat(GetSlotMachine(i), "PozZ"), 25, 0, 0, 0, -1, 50.0),format(string, sizeof(string), "{FF0033}Caca-niquel\n{FFFFFF}Aperte {FFFF00}'F' {FFFFFF}para jogar\n{EAF202}!!JACKPOT!!\n{FFFF00}%d", DOF2_GetInt(GetSlotMachine(i), "Jackpot")), DataSlotMachine[i][TextoSm] = CreateDynamic3DTextLabel(string, -1, DOF2_GetFloat(GetSlotMachine(i), "PozX"), DOF2_GetFloat(GetSlotMachine(i), "PozY"), DOF2_GetFloat(GetSlotMachine(i), "PozZ"), 40.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 10.0);
		DataSlotMachine[i][SmObject] = CreateObject(2325, DOF2_GetFloat(GetSlotMachine(i), "PozXX"), DOF2_GetFloat(GetSlotMachine(i), "PozYY"), DOF2_GetFloat(GetSlotMachine(i), "PozZZ"), DOF2_GetFloat(GetSlotMachine(i), "RotXX"), DOF2_GetFloat(GetSlotMachine(i), "RotYY"), DOF2_GetFloat(GetSlotMachine(i), "RotZZ")), DataSlotMachine[i][Jackpot] = DOF2_GetInt(GetSlotMachine(i), "Jackpot");
	}
	return 1;
}

GetSlotMachine(ID2)
{
	new File[38];
	format(File, sizeof(File), PASTA_SLOTS, ID2);
	return File;
} 	

CallBack::SendMSG()
{
	for(new i = GetPlayerPoolSize(); i != -1; --i) //Loop through all players
	{
		if(pLogado[i] == true)
		{
			LimparChat(i, 50);
			SendClientMessage(i, -1, RandomMSG[random(sizeof(RandomMSG))]);
		}
	}
	return 1;
}

CallBack::TimerHack(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	ResetPlayerMoney(playerid);
	GivePlayerMoney(playerid, PlayerInfo[playerid][pDinheiro]);
	SetTimerEx("TimerHack", segundos(1), false, "i", playerid);
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
				format(info, sizeof(info), "%s\n{FFFF00}-{FFFFFF} Vender veiculo (${FFFF00}%d{FFFFFF})\n{FFFF00}-{FFFFFF} Estacionar vehiculo", info, value);
			}
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, caption, info, "Selecionar", "X");
		}
		case DIALOG_VEHICLE_BUY:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Veiculo {FFFF00}%d", vehicleid);
			format(info, sizeof(info), "Este veiculo esta a venda por ($%d)\n-", VehicleValue[vehicleid]);
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_MSGBOX, caption, info, "Comprar", "X");
		}
		case DIALOG_VEHICLE_SELL:
		{
			new targetid = GetPVarInt(playerid, "DialogValue1");
			new id = GetPVarInt(playerid, "DialogValue2");
			new price = GetPVarInt(playerid, "DialogValue3");
			new info[256];
			format(info, sizeof(info), "{FFFF00}%s {FFFFFF}({FFFF00}%d{FFFFFF}) quer vender  {FFFF00}%s {FFFFFF}por {FFFF00}$%d.", PlayerName(targetid), targetid,
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
			strcat(info, "Abastecer Veiculo ({FFFF00}$" #PRECO_GASOLINA "{FFFFFF})\nComprar galao ({FFFF00}$" #PRECO_GALAO "{FFFFFF})", sizeof(info));
			ShowPlayerDialog(playerid, dialogid, DIALOG_STYLE_LIST, "Posto Gasolina", info, "OK", "X");
		}
		case DIALOG_EDITVEHICLE:
		{
			new vehicleid = GetPVarInt(playerid, "DialogValue1");
			new caption[32], info[256];
			format(caption, sizeof(caption), "Veiculo %d", vehicleid);
			format(info, sizeof(info), "1. Valor: [$%d]\n2. Modelo: [%d (%s)]\n3. Cores: [%d] [%d]\n4. Placa[%s]",
				VehicleValue[vehicleid], VehicleModel[vehicleid], VehicleNames[VehicleModel[vehicleid]-400],
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
	printf("[Arquivos Load] Foram Carregados %d veiculos", count);
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
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 3600);
			SetVehicleHealth(VehicleID[vehicleid], health);
			SetVehicleParamsEx(VehicleID[vehicleid], engine, lights, alarm, doors, bonnet, boot, objective);
			UpdateVehicleDamageStatus(VehicleID[vehicleid], panels, doorsd, lightsd, tires);
		}
		else
		{
			VehicleID[vehicleid] = CreateVehicle(VehicleModel[vehicleid], VehiclePos[vehicleid][0], VehiclePos[vehicleid][1],
				VehiclePos[vehicleid][2], VehiclePos[vehicleid][3], VehicleColor[vehicleid][0], VehicleColor[vehicleid][1], 3600);
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
		format(labeltext, sizeof(labeltext), "{FFFF00}%s\n{FFFFFF}ID: {FFFF00}%d\n{FFFFFF}Concessionaria ID: {FFFF00}%s\n{FFFFFF}Valor: {FFFF00}$%d", VehicleNames[VehicleModel[vehicleid]-400],
			vehicleid, VehicleOwner[vehicleid], VehicleValue[vehicleid]);
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
			if(strcmp(VehicleOwner[vehicleid], PlayerName(playerid)) == 0)
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
	printf("[Arquivos Load] Foram Carregados %d Concessionarias", count);
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
	printf("[Arquivos Load] Foram Carregadas %d Postos", count);
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
						GameTextForPlayer(i,"~r~ Sem combustivel.", 3000, 3);
						notificacao(i, "INFO", "Este veiculo esta sem gasolina!", ICONE_AVISO);
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
						format(string, sizeof(string), "~r~-$%d", cost);
						GameTextForPlayer(i, string, 2000, 3);
						format(string, sizeof(string), "Usted paga $%d por combustible", cost);
						notificacao(i, "INFO", string, ICONE_AVISO);
						SetPVarInt(i, "FuelStation", 0);
						SetPVarFloat(i, "Fuel", 0.0);
					}
					else
					{
						RefuelTime[i] = 5;
						format(string, sizeof(string), "~w~repostaje...~n~~r~-$%d", cost);
						GameTextForPlayer(i, string, 2000, 3);
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
	printf("[Arquivos Load] AntiDeAMX Iniciado com Sucesso.");
	new antidamx[][] =
	{
		"Unarmed (Fist)",
		"Brass K",
		"Fire Ex"
	};
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
								GameTextForPlayer(playerid, "~w~RADAR", 1000, 1);
								SetTimerEx("LiberarRadar", segundos(5), false, "d", playerid);
								return 1;
							}
						}
						else if(IsPolicial(playerid))
						{
							if(Patrulha[playerid] == true)
							{
								if(PassouRadar[playerid] == 0)
								{
									PassouRadar[playerid] = 1;
									SetTimerEx("LiberarRadar", segundos(5), false, "d", playerid);
									return 1;
								}
							}
						}
						else
						{
							if(PassouRadar[playerid] == 0)
							{

								new multaradar = randomEx(500, 5000);
								PassouRadar[playerid] = 1;
								GameTextForPlayer(playerid, "~n~ ~r~RADAR", 2000, 1);
								SetTimerEx("LiberarRadar", segundos(5), false, "d", playerid);
								PlayerPlaySound(playerid,1132,0.0,0.0,0.0);
								PlayerInfo[playerid][pMultas] += multaradar;
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

CallBack::Reparar(playerid, id) 
{
	ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 0, 0, 0, 0, 1, 1);
	ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 0, 0, 0, 0, 1, 1);
	ClearAnimations(playerid);
	ClearAnimations(playerid);
	notificacao(playerid, "EXITO", "Reparou um veiculo.", ICONE_EMPREGO);
	RepairVehicle(id);
	SetVehicleHealth(id, 1000.0);
	TogglePlayerControllable(playerid, 1);
	ocupadodemais[playerid] = 0;
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
			if(!DOF2_FileExists(string))DOF2_CreateFile(string);

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
}

CallBack::MaconhaColher(playerid, mac)
{
	new gfstring[128];
	format(gfstring, sizeof(gfstring), "** %s suas maconhas foram cultivadas!", Name(playerid));
	ProxDetector(30.0, playerid, gfstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	format(gfstring, sizeof gfstring, "Colheu uma maconha com %d gramas.",MaconhaInfo[mac][GramasProntas]);
	notificacao(playerid, "EXITO", gfstring, ICONE_CERTO);
	GanharItem(playerid, 3027, MaconhaInfo[mac][GramasProntas]);
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
	notificacao(playerid, "EXITO", "Afaste, Plantacao sera queimada.", ICONE_CERTO);
	return true;
}

CallBack::MaconhaQueimar2(playerid, mac)
{
	new gfstring[128];
	format(gfstring, sizeof gfstring, "O Policial %s queimou uma plantacao de maconha.",Name(playerid));
	ProxDetector(30.0, playerid, gfstring, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
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
	format(string, sizeof(string), "* %s plantou uma semente de maconha!", Name(playerid));
	ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	notificacao(playerid, "EXITO", "Semente plantada use /maconhas para suas plantacoes.", ICONE_CERTO);
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
				MaconhaInfo[maconhaid][GramasProntas] += random(10)+5;
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
	return idx;
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
		if(member == 5 || member == 6 || member == 7 || member == 8 || member == 10 || member == 11)
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
	print("[Arquivos Load] Foram Carregadas todas as orgs");
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
		return GameTextForPlayer(playerid, "~r~Nao esta em local de roubo.", 5000, 1);
	}
	new str[200];
	new picks = CaixaInfo[caixa_id][Caixa_Pickups];
	GanharItem(playerid,1212, CaixaInfo[caixa_id][Caixa_Dinheiro]/picks);
	format(str, sizeof str, "~w~~h~Pegou do chao~n~~g~~h~~h~R$%i", CaixaInfo[caixa_id][Caixa_Dinheiro]/picks);
	GameTextForPlayer(playerid, str, 5000, 1);

	format(str, sizeof str, "Ganhou R$%i de dinheiro sujo.",CaixaInfo[caixa_id][Caixa_Dinheiro]/picks);
	notificacao(playerid, "INFO", str, ICONE_AVISO);

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
		return notificacao(playerid, "ERRO", "Esta longe de um caixa", ICONE_ERRO);
	}

	TendoRoubo = true;
	SetTimer(#LiberarRoubo, Temporoubo, 0);
	GetDynamicObjectPos(CaixaInfo[caixa_id][Caixa_Object], px, py, pz);
	GetDynamicObjectRot(CaixaInfo[caixa_id][Caixa_Object], rx, ry, rz);
	GetXYInFrontOfCaixa(CaixaInfo[caixa_id][Caixa_Object], px, py, 0.3);

	CaixaInfo[caixa_id][Caixa_ObjectBomba] = CreateDynamicObject(1252, px, py, pz, 0.0, 0.0, rz);
	SetTimerEx("ExplodirCaixa", 10000, 0, "d", caixa_id);

	new string[128];
	new sendername[MAX_PLAYER_NAME];
	GetPlayerName(playerid,sendername,sizeof(sendername));
	format(string, sizeof(string), "{FFFFFF}* {FFFF00}%s {FFFFFF}Colocou uma bomba em um caixa!", sendername);
	SendClientMessageInRange(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);

	notificacao(playerid, "EXITO", "Colocou uma bomba em um caixa, agora afasta-se.", ICONE_CERTO);
	ClearAnimations(playerid, 1);
	return 0;
}

CallBack::ExplodirCaixa(caixa_id)
{
	new Float:px, Float:py, Float:pz,
	Float:rx, Float:ry, Float:rz;

	new str[200];

	new add = random(2000);
	CaixaInfo[caixa_id][Caixa_Dinheiro] = (MAX_PICKUPS_ROUBO*4549)+add;

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

	SendClientMessageToAll(-1, "{FFFF00}CNN {FFFFFF}Um caixa acaba de ser consertado!");

	//--------- Jogar grana no chão --

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
		SendClientMessageToAll(0x00660CC8, "{FFFF00}CNN {FFFFFF}Um caixa automatico foi consertado pelo governo!");

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

	new megastrings[500], String2[500];
	if(pLogado[playerid] == true)
	{
		if(GetPlayerMoney(playerid) < 100000)
		{
			MissaoPlayer[playerid][MISSAO9] = 1;
		}
		new g; g = random(1000);
		new gjuros; gjuros = random(100);
		new gimposto; gimposto = random(200);
		new gi; gi = random(350);
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
		strcat(megastrings,"{FFFFFF}---------------------------------- PayDay ----------------------------------\n\n");
		format(String2,sizeof(String2), "{FFFFFF}Salario Civil: {00FF00}$%i\n", g);
		strcat(megastrings, String2);
		if(PlayerInfo[playerid][pProfissao] == 3)
		{
			PlayerInfo[playerid][pBanco] += 2500;
			format(String2,sizeof(String2), "{FFFFFF}Salario Emprego: {00FF00}$2500\n");
			strcat(megastrings, String2);
		}
		if(PlayerInfo[playerid][pProfissao] == 4)
		{
			PlayerInfo[playerid][pBanco] += 3200;
			format(String2,sizeof(String2), "{FFFFFF}Salario Emprego: {00FF00}$3200\n");
			strcat(megastrings, String2);
		}
		if(PlayerInfo[playerid][pVIP] == 1)
		{
			PlayerInfo[playerid][pBanco] += 500;
			format(String2,sizeof(String2), "{FFFFFF}Ganho beneficio do seu VIP\n");
			strcat(megastrings, String2);
		}
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pBanco] += 800;
			format(String2,sizeof(String2), "{FFFFFF}Ganho beneficio de seu VIP\n");
			strcat(megastrings, String2);
		}
		if(PlayerInfo[playerid][pVIP] == 3)
		{
			PlayerInfo[playerid][pBanco] += 3000;
			format(String2,sizeof(String2), "{FFFFFF}Ganho beneficio de seu VIP\n");
			strcat(megastrings, String2);
		}
		format(String2,sizeof(String2), "{FFFFFF}Taxa Bancaria: {FFFF00}-R$%i\n", gjuros);
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Imposto Governo: {FFFF00}-R$%i\n", gimposto);
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Plano de Saude: {FFFF00}-R$%i\n", gi);
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Saldo anterior: {FFFF00}R$%i\n", saldoantigo);
		strcat(megastrings, String2);
		format(String2,sizeof(String2), "{FFFFFF}Novo Saldo: {00FF00}R$%i\n", PlayerInfo[playerid][pBanco]);
		strcat(megastrings, String2);
		strcat(megastrings,"{FFFFFF}---------------------------------- PayDay ----------------------------------\n\n");
		ShowPlayerDialog(playerid, DIALOG_PAYDAY,DIALOG_STYLE_MSGBOX,"PAYDAY",megastrings,"X","");
		PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
		SalvarDados(playerid);

		TimerPayDay[playerid] = SetTimerEx("PayDay", minutos(30), false, "i", playerid); 

		new string[100];
		format(string,sizeof(string),"%s agora tem R$%i na mao e R$%i no banco", Name(playerid), PlayerInfo[playerid][pDinheiro], PlayerInfo[playerid][pBanco]);
		DCC_SendChannelMessage(Dinn, string);
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

				SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
				SetPlayerInterior(playerid, 0);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				IniciouTesteHabilitacaoA[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Reprovado!", 5001, 6);

				notificacao(playerid, "AVISO", "Voce foi reprovado.", ICONE_ERRO);

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

				SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
				SetPlayerInterior(playerid, 0);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				IniciouTesteHabilitacaoB[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Reprovado!", 5001, 6);

				notificacao(playerid, "AVISO", "Voce foi reprovado.", ICONE_ERRO);

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

				SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
				SetPlayerInterior(playerid, 0);
				TogglePlayerControllable(playerid, false);
				SetTimerEx("carregarobj", 5000, 0, "i", playerid);
				IniciouTesteHabilitacaoC[playerid] = 0;
				GameTextForPlayer(playerid, "~r~Reprovado!", 5001, 6);

				notificacao(playerid, "AVISO", "Voce foi reprovado.", ICONE_ERRO);

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

CallBack::CriandoCpf(playerid)
{
	notificacao(playerid, "EXITO", "Seus documentos estao prontos.", ICONE_CERTO);
	MissaoPlayer[playerid][MISSAO1] = 1;
	TogglePlayerControllable(playerid, 1);
	return 1;
}

CallBack::FomeBar(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	new fome = randomEx(1,3);
	FomePlayer[playerid] -= fome;
	if(FomePlayer[playerid] == 10)
	{
		GameTextForPlayer(playerid, " ~y~Tem 10 de ~r~Fome", 3000, 3);
	}
	if(FomePlayer[playerid] >= 5)
	{
		
	}
	return 1;
}

CallBack::SedeBar(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;
	new sede = randomEx(1,3);
	SedePlayer[playerid] -= sede;
	if(SedePlayer[playerid] == 10)
	{
		GameTextForPlayer(playerid, "~y~Tienes 10 de ~b~Sed", 3000, 3);
	}
	if(SedePlayer[playerid] >= 5)
	{

	}
	return 1;
}

CallBack::Colete(playerid)
{
	if(!IsPlayerConnected(playerid))
		return true;

	new BankV[258], str[255];
	new Hora, Minuto;
	gettime(Hora, Minuto);

	format(BankV, sizeof(BankV), "%i", PlayerInfo[playerid][pBanco]);
	TextDrawSetString(TDEditor_TD[28], BankV);

	format(str, sizeof(str), "%d", SedePlayer[playerid]);
	PlayerTextDrawSetString(playerid, HudServer[playerid][8], str);

	format(str, sizeof(str), "%d", FomePlayer[playerid]);
	PlayerTextDrawSetString(playerid, HudServer[playerid][7], str);

	format(str, sizeof(str), "bC: %d", PlayerInfo[playerid][pCoins]);
	PlayerTextDrawSetString(playerid, HudServer[playerid][9], str);

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
	notificacao(playerid, "ERRO", "Tu inventario esta lleno.", ICONE_ERRO);

	return 1;
}

RetirarItem(playerid, itemid)
{
    for(new i = 1; i < 33; ++i)
    {
        if(PlayerInventario[playerid][i][Slot] == itemid)
        {
            if(PlayerInventario[playerid][i][Unidades] > 1) return PlayerInventario[playerid][i][Unidades] --;
            
            PlayerInventario[playerid][i][Slot] = -1;
            PlayerInventario[playerid][i][Unidades] = -1;
            return 1;
        }
        AtualizarInventario(playerid, itemid);
    }
    notificacao(playerid, "ERRO", "Inventario cheio.", ICONE_ERRO);

    return 1;
}

CallBack::CriarInventario(playerid)
{
	new file[64], str[128], string[128];
	format(file, sizeof(file), PASTA_INVENTARIO, Name(playerid));
	
	if(!DOF2_FileExists(file))
	{
		DOF2_CreateFile(file);
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

CallBack::LoadInv(playerid)
{
	new file[64], key[64], string[2][64], str[64];
	format(file, sizeof(file), PASTA_INVENTARIO, Name(playerid));
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

CallBack::SalvarInventario(playerid)
{
	new file[64], str[128], string[128];
	format(file, sizeof(file), PASTA_INVENTARIO, Name(playerid));
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
	foreach(Player, i)
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

CheckInventario2(playerid, itemid)
{
	for(new i = 1; i < 33; ++i)
	{
		if(PlayerInventario[playerid][i][Slot] == itemid) return 1;
	}
	return 0;
}

ItemNomeInv(itemid) // AQUI VOCÊ PODE ADICIONAR OS ID DOS ITENS E SETAR SEU NOME (OBS: TOME CUIDADO AO OPTAR O USO DE LOOPS)
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
		case 1212: name = "Dinero Sucio";
		case 19835: name = "Cafe";
		case 2881: name = "Fatia de Pizza";
		case 2702: name = "Fatia de Pizza";
		case 2769: name = "Taco";
		case 2709: name = "Remedio";
		case 19579: name = "Pao";
		case 19630: name = "Tilapia";
		case 19094: name = "Hamburger";
		case 1582: name = "Pizza Media";
		case 19580: name = "Pizza Grande";
		case 19602: name = "Mina Terrestre";
		case 1654: name = "Dinamite";
		case 11736: name = "MedKit";
		case 1650: name = "Galao de Gasolina";
		case 1252: name = "C4";
		case 19893: name = "Notebook";
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
		case 1853: name = "Licenca A";
		case 1854: name = "Licenca B";
		case 1855: name = "Licenca C";
		case 1856: name = "Licenca D";
		case 18645: name = "Capacete";
		case 18870: name = "Celular";
		case 11738: name = "Bau";
		case 3027: name = "Maconha";
		case 1279: name = "Cocaine";
		case 3930: name = "Crack";
		case 3520: name = "Semente de Maconha";
		case 19921: name = "Caixa de ferramentas";
		case 902: name = "Estrela do mar";
		case 1599: name = "Tucunare";
		case 1600: name = "Royal";
		case 18632: name = "Vara de Pescar";
		case 11750: name = "Esposar";
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
					DropItemSlot[i][LabelItem] = CreateDynamic3DTextLabel(str, -1, x,y,z-1, 5, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, GetPlayerVirtualWorld(playerid), GetPlayerInterior(playerid));
					format(str, sizeof(str), "{FFFFFF}*{FFFF00}%s {FFFFFF}soltou {FFFF00}%s {FFFFFF}com {FFFF00}%s {FFFFFF}unidades no chao.", Name(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]), ConvertMoney(PlayerInventario[playerid][modelid][Unidades]));
					SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
					format(str, sizeof(str), "{FFFF00}%s {FFFFFF}soltou o item {FFFF00}%s {FFFFFF}com {FFFF00}%s {FFFFFF}unidades no chao.", Name(playerid), ItemNomeInv(DropItemSlot[i][DropItemID]), ConvertMoney(DropItemSlot[i][DropItemUni]));
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
	new str[128];
	new fomesede = randomEx(1,20);
	switch(PlayerInventario[playerid][modelid][Slot])
	{
		case 19921:
		{
			GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
			new counter = 0;
			new result;
			for(new i; i != MAX_VEHICLES; i++)
			{
				new dist = Checarveiculo(5, playerid, i);
				if(dist)
				{
					result = i;
					counter++;
				}
			}
			switch(counter)
			{
				case 0:
				{
					notificacao(playerid, "ERRO", "Nao esta perto de um veiculo.", ICONE_ERRO);
				}
				case 1:
				{
					if(PlayerInfo[playerid][pProfissao] == 7)
					{
						if(IsPlayerInRangeOfPoint(playerid, 10.0, 2016.0741,-1781.5780,13.7402) || IsPlayerInRangeOfPoint(playerid, 10.0, 2007.1235,-1781.4824,13.7402) || IsPlayerInRangeOfPoint(playerid, 10.0, 1998.0106,-1781.4078,13.7402) || IsPlayerInRangeOfPoint(playerid, 10.0, 1988.7588,-1781.4812,13.7402) || IsPlayerInRangeOfPoint(playerid, 10.0, 1979.9341,-1781.5359,13.7402))
						{					
							if(IsPlayerInAnyVehicle(playerid)) return notificacao(playerid, "INFO", "Voce esta em um veiculo.", ICONE_AVISO);
							ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 1, 8000, 1);
							ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 1, 8000, 1);
							ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 0, 1, 1, 0, 0, 1);
							ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 0, 1, 1, 0, 0, 1);
							SetTimerEx("Reparar",10000,0,"dd",playerid,result);
							ocupadodemais[playerid] = 1;
							if(PlayerInfo[playerid][pVIP] == 0)
							{
								PlayerInfo[playerid][pDinheiro] += 800;
								notificacao(playerid, "TRABALHO", "Ganhou R$800 consertando este veiculo.", ICONE_EMPREGO); 
							}   
							if(PlayerInfo[playerid][pVIP] == 2)
							{
								PlayerInfo[playerid][pDinheiro] += 800*2;
								notificacao(playerid, "TRABALHO", "Ganhou R$1600 consertando este veiculo.", ICONE_EMPREGO); 
							}
							if(PlayerInfo[playerid][pVIP] == 3)
							{
								PlayerInfo[playerid][pDinheiro] += 800*2;
								notificacao(playerid, "TRABALHO", "Ganhou R$1600 consertando este veiculo.", ICONE_EMPREGO); 
							}
							PlayerInventario[playerid][modelid][Unidades] --;
							AtualizarInventario(playerid, modelid);
							cmd_inventario(playerid);
							return 1;
						}
						if(IsPlayerInAnyVehicle(playerid)) return notificacao(playerid, "INFO", "Voce nao esta em um veiculo.", ICONE_AVISO);
						ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 1, 8000, 1);
						ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 1, 8000, 1);
						ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 0, 1, 1, 0, 0, 1);
						ApplyAnimation(playerid, "CAR", "Fixn_Car_Loop", 4.0, 0, 1, 1, 0, 0, 1);
						SetTimerEx("Reparar",10000,0,"dd",playerid,result);
						ocupadodemais[playerid] = 1;
						if(PlayerInfo[playerid][pVIP] == 0)
						{
							PlayerInfo[playerid][pDinheiro] += 500;
							notificacao(playerid, "TRABALHO", "Ganhou R$500 consertando este veiculo.", ICONE_EMPREGO); 
						}   
						if(PlayerInfo[playerid][pVIP] == 2)
						{
							PlayerInfo[playerid][pDinheiro] += 500*2;
							notificacao(playerid, "TRABALHO", "Ganhou R$1000 consertando este veiculo.", ICONE_EMPREGO); 
						}
						if(PlayerInfo[playerid][pVIP] == 3)
						{
							PlayerInfo[playerid][pDinheiro] += 500*2;
							notificacao(playerid, "TRABALHO", "Ganhou R$1000 consertando este veiculo.", ICONE_EMPREGO); 
						}
						PlayerInventario[playerid][modelid][Unidades] --;
						AtualizarInventario(playerid, modelid);
						cmd_inventario(playerid);
					}
				}
				default:
				{
					notificacao(playerid, "ERRO", "Tem muitos veiculos proximos.", ICONE_ERRO);
				}
			}
			return true;
		}
		case 400..611:
		{
			new Float:X,Float:Y,Float:Z,Float:A;
			GetPlayerPos(playerid, X,Y,Z);
			GetPlayerFacingAngle(playerid, A);
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(PlayerInventario[playerid][modelid][Slot], X, Y, Z, A, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
				
			}
			else
			{
				notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
			}
			AtualizarInventario(playerid, modelid);
			cmd_inventario(playerid);
		}
		case 3520:
		{

			if(GetPlayerInterior(playerid) > 0 || IsPlayerInAnyVehicle(playerid))
				return notificacao(playerid, "ERRO", "Nao pode plantar uma semente agora!", ICONE_ERRO);

			if(CountPlantacao(playerid) >= 10)
				return notificacao(playerid, "ERRO", "Ja possui 10 plantacoes.", ICONE_ERRO);

			if(PlantandoMaconha[playerid] == true)
				return notificacao(playerid, "ERRO", "Ja esta plantanddo uma semente.", ICONE_ERRO);

			for(new mac = 0; mac < MAX_MACONHA; mac++)
			{
				if(MaconhaInfo[mac][PodeUsar] == false && IsPlayerInRangeOfPoint(playerid, 5.0, MaconhaInfo[mac][mX],MaconhaInfo[mac][mY],MaconhaInfo[mac][mZ]))
				{
					notificacao(playerid, "EXITO", "Ja tem uma plantacao nesse local.", ICONE_CERTO);
					return true;
				}
			}

			new slt = CheckSlot();

			if(slt == -1)
				return notificacao(playerid, "EXITO", "Ja plantou muitas sementes..", ICONE_CERTO);

			new string[128];
			ApplyAnimation(playerid,"BOMBER","BOM_Plant_Loop",4.1,0,1,1,1,60000,1);
			SetTimerEx("AnimatioN", 500, false, "i", playerid);
			SetTimerEx("PlantarMaconhas", 17000, false, "id", playerid, slt);
			PlantandoMaconha[playerid] = true;

			format(string, sizeof(string), "** %s ja comecou a plantar uma semente.", Name(playerid));
			ProxDetector(30.0, playerid, string, -1,-1,-1,-1,-1);
			notificacao(playerid, "EXITO", "Espere que se complete.", ICONE_CERTO);

			PlayerInventario[playerid][modelid][Unidades] --;
			AtualizarInventario(playerid, modelid);
			cmd_inventario(playerid);
			return true;
		}
		case 1581:
		{
			new megastrings[500], String2[500];
			format(String2,sizeof(String2), "{FFFFFF}Nome: {FFFF00}%s\t{FFFFFF}Idade: {FFFF00}%d {FFFFFF}anos\t{FFFFFF}VIP: {FFFF00}%s\n", Name(playerid),PlayerInfo[playerid][pIdade], VIP(playerid));
			strcat(megastrings, String2);
			format(String2,sizeof(String2), "{FFFFFF}Profissao:{FFFF00} %s\t{FFFFFF}Org:{FFFF00} %s\t{FFFFFF}Cargo:{FFFF00} %s\n", Profs(playerid), NomeOrg(playerid), NomeCargo(playerid));
			strcat(megastrings, String2);
			format(String2,sizeof(String2), "{FFFFFF}Multas:{FFFF00} %d\t{FFFFFF}N�Casa:{FFFF00} %d\n", PlayerInfo[playerid][pMultas], PlayerInfo[playerid][Casa]);
			strcat(megastrings, String2);
			format(String2,sizeof(String2), "{FFFFFF}Tempo Jogados:{FFFF00} %s\t{FFFFFF}Expira VIP:{FFFF00} %s\n", ConvertTimeX(PlayerInfo[playerid][pSegundosJogados]), convertNumber(PlayerInfo[playerid][ExpiraVIP]-gettime()));
			strcat(megastrings, String2);
			ShowPlayerDialog(playerid, DIALOG_CMDRG,DIALOG_STYLE_MSGBOX,"Seu Documento",megastrings,"X",#);
		}
		case 18632:
		{
			if(PlayerInfo[playerid][pProfissao] != 1) 	return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			if(PlayerInventario[playerid][modelid][Unidades] < 1) return notificacao(playerid, "ERRO", "Nao tem uma vara de pesca.", ICONE_ERRO);
			if(UsouCMD[playerid] == true) 	return notificacao(playerid, "ERRO", "Ainda nao passou 30s.", ICONE_ERRO); 
			for(new i; i < 10; i++)
			if(IsPlayerInRangeOfPoint(playerid, 2.0, PosPesca[i][0], PosPesca[i][1], PosPesca[i][2]))
			{
				cmd_inventario(playerid);
				CreateProgress(playerid, "Pesca","Pescando...", 300);
				TogglePlayerControllable(playerid, 0);
				UsouCMD[playerid] = true;	
			}
			return 1;		
		}
		case 902:
		{
			if(PlayerToPoint(3.0, playerid, 357.781768, -2031.161865, 7.835937))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return notificacao(playerid, "ERRO", "Quantidade insuficiente", ICONE_ERRO);
				new dinpeixes = randomEx(0, 800);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 estrela do mar y ganhou R$%i.", dinpeixes);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 estrela do mar e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				if(PlayerInfo[playerid][pVIP] == 3)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 estrela do mar e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 19630:
		{
			if(PlayerToPoint(3.0, playerid, 357.781768, -2031.161865, 7.835937))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return notificacao(playerid, "ERRO", "Quantidade insuficiente", ICONE_ERRO);
				new dinpeixes = randomEx(0, 600);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 tilapia e ganhou R$%i.", dinpeixes);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 tilapia e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				if(PlayerInfo[playerid][pVIP] == 3)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 tilapia e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1599:
		{
			if(PlayerToPoint(3.0, playerid, 357.781768, -2031.161865, 7.835937))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return notificacao(playerid, "ERRO", "Quantidade insuficiente", ICONE_ERRO);
				new dinpeixes = randomEx(0, 400);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 tucunare e ganhou R$%i.", dinpeixes);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 tucunare e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				if(PlayerInfo[playerid][pVIP] == 3)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 tucunare e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 1600:
		{
			if(PlayerToPoint(3.0, playerid, 357.781768, -2031.161865, 7.835937))
			{
				if(PlayerInventario[playerid][modelid][Unidades] < 5) return notificacao(playerid, "ERRO", "Quantidade insuficiente", ICONE_ERRO);
				new dinpeixes = randomEx(0, 500);
				PlayerInventario[playerid][modelid][Unidades] -= 5;
				if(PlayerInfo[playerid][pVIP] == 0)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes;
					format(Str,sizeof(Str),"Vendeu 5 royal e ganhou R$%i.", dinpeixes);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}   
				if(PlayerInfo[playerid][pVIP] == 2)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 royal e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				if(PlayerInfo[playerid][pVIP] == 3)
				{
					PlayerInfo[playerid][pDinheiro] += dinpeixes*2;
					format(Str,sizeof(Str),"Vendeu 5 royal e ganhou R$%i.", dinpeixes*2);
					notificacao(playerid, "TRABALHO", Str, ICONE_EMPREGO); 
				}
				AtualizarInventario(playerid, modelid);
			}
			return 1;		
		}
		case 331..371:
		{
			GivePlayerWeapon(playerid, GetArmaInv(PlayerInventario[playerid][modelid][Slot]), PlayerInventario[playerid][modelid][Unidades]);
			format(str, sizeof(str), "{FFFFFF}*{FFFF00}%s {FFFFFF}retirou um(a) {FFFF00}%s {FFFFFF}do seu inventario.", Name(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
			SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
			PlayerInventario[playerid][modelid][Unidades] = 0;
			AtualizarInventario(playerid, modelid);
			cmd_inventario(playerid);
			return 1;
		}
		case 1484, 1644, 1546, 2601:
		{
			if(SedePlayer[playerid] >= 80) return notificacao(playerid, "ERRO", "Nao esta com sede.", ICONE_ERRO);
			SedePlayer[playerid] += fomesede;
			PlayerInventario[playerid][modelid][Unidades]--;
			format(str, 128, "{FFFFFF}*{FFFF00}%s {FFFFFF}bebeu uma garrafa de {FFFF00}%s", Name(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
			ApplyAnimation(playerid, "VENDING", "VEND_Drink_P", 4.1, 0, 0, 0, 0, 0, 1);
			SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
			AtualizarInventario(playerid, modelid);
			return 1;
		}
		case 2218, 2355, 2219, 2220:
		{
			if(FomePlayer[playerid] >= 80) return notificacao(playerid, "ERRO", "Nao esta com fome.", ICONE_ERRO);
			FomePlayer[playerid] += fomesede;
			PlayerInventario[playerid][modelid][Unidades]--;
			format(str, 128, "{FFFFFF}*{FFFF00}%s {FFFFFF}comeu um(a) {FFFF00}%s", Name(playerid), ItemNomeInv(PlayerInventario[playerid][modelid][Slot]));
			ApplyAnimation(playerid, "FOOD", "EAT_Burger", 4.1, 0, 0, 0, 0, 0, 1);
			SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
			AtualizarInventario(playerid, modelid);
			return 1;
		}
		case 1212:
		{
			for(new i; i < 4; i++)
			if(PlayerToPoint(3.0, playerid, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]))
			{
				new string[300];
				if(!IsBandido(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				
				DepositarGranaOrg(org,PlayerInventario[playerid][modelid][Unidades]);
				format(string,sizeof(string),"Voce depositou R$%d dinheiro, e o novo balance e R$%d",PlayerInventario[playerid][modelid][Unidades],CofreOrg[org][Dinheiro]);
				notificacao(playerid, "INFO", string, ICONE_AVISO);
				PlayerInventario[playerid][modelid][Unidades] = 0;
				AtualizarInventario(playerid, modelid);
				cmd_inventario(playerid);
				return true;
			}
			return 1;
		}
		case 3027:
		{
			for(new i; i < 4; i++)
			if(PlayerToPoint(3.0, playerid, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]))
			{
				new string[300];
				if(!IsBandido(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				
				DepositarMaconhaOrg(org,PlayerInventario[playerid][modelid][Unidades]);
				format(string,sizeof(string),"Voce depositou %d maconha, e o novo balance e %d",PlayerInventario[playerid][modelid][Unidades],CofreOrg[org][Maconha]);
				notificacao(playerid, "INFO", string, ICONE_AVISO);
				PlayerInventario[playerid][modelid][Unidades] = 0;
				AtualizarInventario(playerid, modelid);
				cmd_inventario(playerid);
				return true;
			}
		}
		case 1279:
		{
			for(new i; i < 4; i++)
			if(PlayerToPoint(3.0, playerid, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]))
			{
				new string[300];
				if(!IsBandido(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				
				DepositarCocainaOrg(org,PlayerInventario[playerid][modelid][Unidades]);
				format(string,sizeof(string),"Voce depositou %d cocaina, e o novo balance e %d",PlayerInventario[playerid][modelid][Unidades],CofreOrg[org][Cocaina]);
				notificacao(playerid, "INFO", string, ICONE_AVISO);
				PlayerInventario[playerid][modelid][Unidades] = 0;
				AtualizarInventario(playerid, modelid);
				cmd_inventario(playerid);
				return true;
			}
		}
		case 3930:
		{
			for(new i; i < 4; i++)
			if(PlayerToPoint(3.0, playerid, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]))
			{
				new string[300];
				if(!IsBandido(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				
				DepositarCrackOrg(org,PlayerInventario[playerid][modelid][Unidades]);
				format(string,sizeof(string),"Voce depositou %d crack, e o novo balance e %d",PlayerInventario[playerid][modelid][Unidades],CofreOrg[org][Crack]);
				notificacao(playerid, "INFO", string, ICONE_AVISO);
				PlayerInventario[playerid][modelid][Unidades] = 0;
				AtualizarInventario(playerid, modelid);
				cmd_inventario(playerid);
				return true;
			}
		}
		case 18645:
		{
			if(EquipouCasco[playerid] == 0)
			{
				format(str, sizeof(str), "{FFFF00}%s{FFFFFF} colocou um capacete.", Name(playerid));
				SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
				SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.07, 0, 0, 88, 75, 0);
				AtualizarInventario(playerid, modelid);
				EquipouCasco[playerid] = 1;
			}
			else
			{
				format(str, sizeof(str), "{FFFF00}%s{FFFFFF} retirou um capacete.", Name(playerid));
				SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
				RemovePlayerAttachedObject(playerid,1);
				AtualizarInventario(playerid, modelid);
				EquipouCasco[playerid] = 0;
			}
			cmd_inventario(playerid);
			return 1;
		}
		case 18870:
		{
			format(str, sizeof(str), "{FFFF00}%s{FFFFFF} pegou um celular.", Name(playerid));
			SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
			AtualizarInventario(playerid, modelid);
			ShowPlayerDialog(playerid, DIALOG_CELULAR, DIALOG_STYLE_LIST, "Telefono", "Transferencia PIX", "Confirmar", "X");
			return 1;
		}
		case 11738:
		{
			format(Str, sizeof(Str),"Introduza o ID do jogador que quer reanimar");
			ShowPlayerDialog(playerid,DIALOG_REANIMAR,1,"Reanimar jogador", Str, "Confirmar",#);
			PlayerInventario[playerid][modelid][Unidades]--;
			AtualizarInventario(playerid, modelid);
			cmd_inventario(playerid);
		}
		case 1252:
		{
			new caixa_id;
			if(!(caixa_id=GetPlayerCaixa(playerid)))return notificacao(playerid, "ERRO", "Nao esta proximo de um caixa.", ICONE_ERRO);
			if(CaixaInfo[caixa_id][Caixa_Roubada])return notificacao(playerid, "ERRO", "Este caixa ja foi roubado.", ICONE_ERRO);
			if(TendoRoubo)return notificacao(playerid, "ERRO", "Ja roubaram a pouco tempo.", ICONE_ERRO);
			
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
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);

			ApplyAnimation(playerid, "BOMBER", "BOM_Plant_Loop", 4.0, 1, 0, 0, 0, 0);
			SetTimerEx("RoubarCaixa", 20*1000, 0, "dd", playerid, GetPlayerCaixa(playerid));
			SetPlayerWantedLevel(playerid, GetPlayerWantedLevel(playerid)+2);
			SetTimerEx(#SetAnimRoubo, 500, 0, "d", playerid);
			PlayerInventario[playerid][modelid][Unidades]--;
			AtualizarInventario(playerid, modelid);

			CaixaInfo[caixa_id][Caixa_Roubada] = true;

			new location[MAX_ZONE_NAME];
			GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);

			new string[800];
			format(string, sizeof string, "{FFFF00}CNN {FFFF00}%s {FFFFFF}e {FFFF00}seus companheiros {FFFFFF}estao roubando um caixa em {FFFF00}%s", Name(playerid), location);
			SendClientMessageToAll(-1, string);

			new sendername[MAX_PLAYER_NAME];
			GetPlayerName(playerid,sendername,sizeof(sendername));
			format(string, sizeof(string), "{FFFFFF}* {FFFF00}%s {FFFFFF}colocou um explosivo em um caixa.", sendername);
			SendClientMessageInRange(30.0, playerid, string, -1,-1,-1,-1,-1);
			notificacao(playerid, "INFO", "Voce esta colocando um explosivo.", ICONE_AVISO);
			cmd_inventario(playerid);
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

IsValidItemInv(itemid) //AQUI VOCÊ DEVE DEFINIR OS ID'S DOS ITENS PARA SER VALIDO AO SETAR, CASO CONTRARIO RETORNARA COMO ERRO
{
	if(GetArmaInv(itemid)) return 1;
	switch(itemid)
	{
		case 2218, 2355, 2219, 2220, 1484, 1644, 1546, 1581, 19823, 19820, 11722, 11723, 19570, 19824, 1486, 19822, 1668, 2958, 19625, 11746,
		1853, 1854, 1855, 19792, 3044, 19039, 19040, 19042, 19044, 19045, 19046, 19047, 11747, 18865, 18866, 18867, 
		18645, 1856, 18868, 18869, 18870, 18871, 18872, 18873, 18874, 19513, 18875, 19874, 19138, 19139, 
		19140, 19022, 19023, 19024, 19025, 19026, 19027, 19028, 19029, 19030, 19031, 19032, 19473, 3027, 3520,
		19033, 19034, 19035, 2992, 3065, 11712, 18953, 18954, 19554, 18974, 2114, 1279, 3930,
		18894, 18903, 18898, 18899, 18891, 18909, 18908, 18907, 18906, 18905, 18904, 18901, 
		18902, 18892, 18900, 18897, 18896, 18895, 18893, 18810, 18947, 18948, 18949, 18950, 
		18951, 19488, 18921, 18922, 18923, 18924, 18925, 18939, 18940, 18941, 18942, 18943, 11750,
		1314, 19578, 18636, 19942, 18646, 19141, 19558, 19801, 19330, 1210, 19528, 902, 1599, 1600,
		19134, 19904, 19515, 19142, 19315, 19527, 19317, 18688, 18702, 18728, 19605, 19606, 18632,
		19607, 19577, 1485, 19574, 19575, 19576, 2703, 2880, 19883, 19896, 19897, 2768, 1212, 
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
		SendClientMessage(playerid, VermelhoEscuro, "{FFFF00}AVISO{FFFFFF} foi expulso por inatividade");
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
				notificacao(i, "INFO", "esta livre.", ICONE_AVISO);
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
					notificacao(i, "INFO", "Ainda nao cumpriu sua prissao..", ICONE_AVISO);
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
	new minuto, hora, segundo;

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
	return 1;
}

CallBack::ShowMine( playerid ) {
	if( GetPVarInt( playerid, "StartedGame" ) == 1 ) {
		ShowCasinoTDs( playerid );
		PlayerTextDrawSetString( playerid, CasinoPTD[ 31 ], "Jogadas: ~g~0~w~~h~~n~Dinheiro ganho: ~g~0" );
	}
	return 1;
}

CallBack::ShowCasinoTDs( playerid ) {
	ResetColorTD( playerid );
	PlayerTextDrawSetString( playerid, CasinoPTD[ 32 ], "Valor_Da_Aposta" );
	TextDrawColor( CasinoTD[ 9 ], -1 );
	TextDrawColor( CasinoTD[ 7 ], -1 );
	TextDrawColor( CasinoTD[ 12 ], -1 );
	for( new i = 0; i < 33; i++ ) PlayerTextDrawShow( playerid, CasinoPTD[ i ] );
	for( new i = 0; i < 15; i++ ) TextDrawShowForPlayer( playerid, CasinoTD[ i ] );
	PlayerTextDrawHide( playerid, CasinoPTD[ 30 ] );
	SelectTextDraw( playerid, 0x80FF00FF );
	SetPVarInt( playerid, "MoneyEarned", 0 );
	SetPVarInt( playerid, "Mines", 0 );
	SetPVarInt( playerid, "MineType", 0 );
	SetPVarInt( playerid, "BetAmount", 0 );
	SetPVarInt( playerid, "StartedGame", 0 );
	SetPVarInt( playerid, "Loser", 0 );
	for( new i = 0; i < 30; i++ ) MineActive[ playerid ][ i ] = 0;
	return 1;
}

CallBack::ResetColorTD( playerid ) {
	for( new i = 0; i < 33; i++ ) {
		PlayerTextDrawBoxColor( playerid, CasinoPTD[ i ], -123 );
		PlayerTextDrawShow( playerid, CasinoPTD[ i ] );
	}
	return 1;
}

CallBack::HideCasinoTDs( playerid ) {
	for( new i = 0; i < 33; i++ ) PlayerTextDrawHide( playerid, CasinoPTD[ i ] );
	for( new i = 0; i < 15; i++ ) TextDrawHideForPlayer( playerid, CasinoTD[ i ] );
	CancelSelectTextDraw( playerid );
	SetPVarInt( playerid, "PlayMine", 0 );
	SetPVarInt( playerid, "BetAmount", 0 );
	SetPVarInt( playerid, "Mines", 0 );
	SetPVarInt( playerid, "StartedGame", 0 );
	SetPVarInt( playerid, "MineType", 0 );
	return 1;
}

CallBack::PlayerTextDraw( playerid ) 
{
	CasinoPTD[ 0 ] = CreatePlayerTextDraw( playerid, 183.333343, 190.000000, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 0 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 0 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 0 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 0 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 0 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 0 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 0 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 0 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 0 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 0 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 0 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 0 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 0 ], true );

	CasinoPTD[ 1 ] = CreatePlayerTextDraw( playerid, 202.666671, 190.000000, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 1 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 1 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 1 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 1 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 1 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 1 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 1 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 1 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 1 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 1 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 1 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 1 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 1 ], true );

	CasinoPTD[ 2 ] = CreatePlayerTextDraw( playerid, 222.333419, 190.000000, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 2 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 2 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 2 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 2 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 2 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 2 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 2 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 2 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 2 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 2 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 2 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 2 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 2 ], true );

	CasinoPTD[ 3 ] = CreatePlayerTextDraw( playerid, 242.333480, 190.000030, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 3 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 3 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 3 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 3 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 3 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 3 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 3 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 3 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 3 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 3 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 3 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 3 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 3 ], true );

	CasinoPTD[ 4 ] = CreatePlayerTextDraw( playerid, 261.333465, 190.000030, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 4 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 4 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 4 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 4 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 4 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 4 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 4 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 4 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 4 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 4 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 4 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 4 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 4 ], true );

	CasinoPTD[ 5 ] = CreatePlayerTextDraw( playerid, 183.333450, 211.985229, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 5 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 5 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 5 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 5 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 5 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 5 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 5 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 5 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 5 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 5 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 5 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 5 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 5 ], true );

	CasinoPTD[ 6 ] = CreatePlayerTextDraw( playerid, 202.666793, 211.570388, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 6 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 6 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 6 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 6 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 6 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 6 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 6 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 6 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 6 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 6 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 6 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 6 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 6 ], true );

	CasinoPTD[ 7 ] = CreatePlayerTextDraw( playerid, 222.333465, 211.570373, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 7 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 7 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 7 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 7 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 7 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 7 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 7 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 7 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 7 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 7 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 7 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 7 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 7 ], true );

	CasinoPTD[ 8 ] = CreatePlayerTextDraw( playerid, 242.333480, 211.570388, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 8 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 8 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 8 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 8 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 8 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 8 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 8 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 8 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 8 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 8 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 8 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 8 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 8 ], true );

	CasinoPTD[ 9 ] = CreatePlayerTextDraw( playerid, 261.666778, 211.570388, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 9 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 9 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 9 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 9 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 9 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 9 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 9 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 9 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 9 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 9 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 9 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 9 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 9 ], true );

	CasinoPTD[ 10 ] = CreatePlayerTextDraw( playerid, 183.333435, 233.555557, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 10 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 10 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 10 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 10 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 10 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 10 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 10 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 10 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 10 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 10 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 10 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 10 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 10 ], true );

	CasinoPTD[ 11 ] = CreatePlayerTextDraw( playerid, 202.666763, 233.555557, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 11 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 11 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 11 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 11 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 11 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 11 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 11 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 11 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 11 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 11 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 11 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 11 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 11 ], true );

	CasinoPTD[ 12 ] = CreatePlayerTextDraw( playerid, 222.333419, 233.555572, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 12 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 12 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 12 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 12 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 12 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 12 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 12 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 12 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 12 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 12 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 12 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 12 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 12 ], true );

	CasinoPTD[ 13 ] = CreatePlayerTextDraw( playerid, 242.333404, 233.555572, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 13 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 13 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 13 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 13 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 13 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 13 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 13 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 13 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 13 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 13 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 13 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 13 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 13 ], true );

	CasinoPTD[ 14 ] = CreatePlayerTextDraw( playerid, 261.333435, 233.555572, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 14 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 14 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 14 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 14 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 14 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 14 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 14 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 14 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 14 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 14 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 14 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 14 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 14 ], true );

	CasinoPTD[ 15 ] = CreatePlayerTextDraw( playerid, 183.333419, 255.125930, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 15 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 15 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 15 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 15 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 15 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 15 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 15 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 15 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 15 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 15 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 15 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 15 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 15 ], true );

	CasinoPTD[ 16 ] = CreatePlayerTextDraw( playerid, 203.000091, 255.125930, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 16 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 16 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 16 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 16 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 16 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 16 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 16 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 16 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 16 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 16 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 16 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 16 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 16 ], true );

	CasinoPTD[ 17 ] = CreatePlayerTextDraw( playerid, 222.333450, 255.125930, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 17 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 17 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 17 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 17 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 17 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 17 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 17 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 17 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 17 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 17 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 17 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 17 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 17 ], true );

	CasinoPTD[ 18 ] = CreatePlayerTextDraw( playerid, 242.333450, 255.125930, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 18 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 18 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 18 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 18 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 18 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 18 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 18 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 18 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 18 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 18 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 18 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 18 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 18 ], true );

	CasinoPTD[ 19 ] = CreatePlayerTextDraw( playerid, 261.000122, 255.125930, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 19 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 19 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 19 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 19 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 19 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 19 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 19 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 19 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 19 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 19 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 19 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 19 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 19 ], true );

	CasinoPTD[ 20 ] = CreatePlayerTextDraw( playerid, 183.333480, 276.281433, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 20 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 20 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 20 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 20 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 20 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 20 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 20 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 20 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 20 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 20 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 20 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 20 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 20 ], true );

	CasinoPTD[ 21 ] = CreatePlayerTextDraw( playerid, 203.333465, 276.281433, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 21 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 21 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 21 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 21 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 21 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 21 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 21 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 21 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 21 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 21 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 21 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 21 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 21 ], true );

	CasinoPTD[ 22 ] = CreatePlayerTextDraw( playerid, 222.666793, 276.696228, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 22 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 22 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 22 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 22 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 22 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 22 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 22 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 22 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 22 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 22 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 22 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 22 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 22 ], true );

	CasinoPTD[ 23 ] = CreatePlayerTextDraw( playerid, 242.333465, 276.696228, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 23 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 23 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 23 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 23 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 23 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 23 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 23 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 23 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 23 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 23 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 23 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 23 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 23 ], true );

	CasinoPTD[ 24 ] = CreatePlayerTextDraw( playerid, 261.333404, 276.696228, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 24 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 24 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 24 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 24 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 24 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 24 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 24 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 24 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 24 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 24 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 24 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 24 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 24 ], true );

	CasinoPTD[ 25 ] = CreatePlayerTextDraw( playerid, 183.333404, 297.436981, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 25 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 25 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 25 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 25 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 25 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 25 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 25 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 25 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 25 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 25 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 25 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 25 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 25 ], true );

	CasinoPTD[ 26 ] = CreatePlayerTextDraw( playerid, 203.666656, 297.436981, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 26 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 26 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 26 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 26 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 26 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 26 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 26 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 26 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 26 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 26 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 26 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 26 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 26 ], true );

	CasinoPTD[ 27 ] = CreatePlayerTextDraw( playerid, 222.666671, 297.436981, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 27 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 27 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 27 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 27 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 27 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 27 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 27 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 27 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 27 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 27 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 27 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 27 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 27 ], true );

	CasinoPTD[ 28 ] = CreatePlayerTextDraw( playerid, 242.333282, 297.436981, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 28 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 28 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 28 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 28 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 28 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 28 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 28 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 28 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 28 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 28 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 28 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 28 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 28 ], true );

	CasinoPTD[ 29 ] = CreatePlayerTextDraw( playerid, 261.333282, 297.436950, "box" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 29 ], 0.000000, 1.633334 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 29 ], 15.000000, 13.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 29 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 29 ], -1 );
	PlayerTextDrawUseBox( playerid, CasinoPTD[ 29 ], 1 );
	PlayerTextDrawBoxColor( playerid, CasinoPTD[ 29 ], -123 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 29 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 29 ], 0 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 29 ], 255 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 29 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 29 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 29 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 29 ], true );

	CasinoPTD[ 30 ] = CreatePlayerTextDraw( playerid, 367.000061, 312.785186, "~r~Voce perdeu! :( " );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 30 ], 0.254666, 1.085628 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 30 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 30 ], -1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 30 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 30 ], 1 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 30 ], 136 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 30 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 30 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 30 ], 0 );

	CasinoPTD[ 31 ] = CreatePlayerTextDraw( playerid, 366.666961, 236.044342, "Jogadas: 0~n~Dinheiro ganho: ~g~R$0~w~~h~~n~" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 31 ], 0.254666, 1.085628 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 31 ], 2 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 31 ], -1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 31 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 31 ], 1 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 31 ], 136 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 31 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 31 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 31 ], 0 );

	CasinoPTD[ 32 ] = CreatePlayerTextDraw( playerid, 318.999969, 217.377777, "Introduza um valor de aposta" );
	PlayerTextDrawLetterSize( playerid, CasinoPTD[ 32 ], 0.252000, 1.098074 );
	PlayerTextDrawTextSize( playerid, CasinoPTD[ 32 ], 396.000000, 10.000000 );
	PlayerTextDrawAlignment( playerid, CasinoPTD[ 32 ], 1 );
	PlayerTextDrawColor( playerid, CasinoPTD[ 32 ], -1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 32 ], 0 );
	PlayerTextDrawSetOutline( playerid, CasinoPTD[ 32 ], 1 );
	PlayerTextDrawBackgroundColor( playerid, CasinoPTD[ 32 ], 122 );
	PlayerTextDrawFont( playerid, CasinoPTD[ 32 ], 1 );
	PlayerTextDrawSetProportional( playerid, CasinoPTD[ 32 ], 1 );
	PlayerTextDrawSetShadow( playerid, CasinoPTD[ 32 ], 0 );
	PlayerTextDrawSetSelectable( playerid, CasinoPTD[ 32 ], true );
	return 1;
}

//                          STOCKS

stock GetPlayerIdfixo(playerid) return PlayerInfo[playerid][IDF];
stock GetIdfixo()
{
	new id;
	ProxID ++;
	id  = ProxID;
	new File[150];format(File, sizeof(File), "IDs/ProxID.ini");
	DOF2_SetInt(File,"ProxID",ProxID);
	DOF2_SaveFile();
	return id;
}

stock Timers(playerid)
{
	TimerFomebar[playerid] = SetTimerEx("FomeBar", minutos(5), true, "d", playerid);
	TimerSedebar[playerid] = SetTimerEx("SedeBar", minutos(5), true, "d", playerid); 
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
    SetTimerEx("ParaDeBugaPoraaaDk", 100, 1, "i", playerid);
    PlayerMorto[playerid][pMinMorto] = 0;
    PlayerMorto[playerid][pSegMorto] = 0;
    SetPlayerHealth(playerid, 100);
    SetPlayerPos(playerid, 1150.7927,-1324.8185,-43.4495);
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    for(new idx=0; idx<6; idx++){
    PlayerTextDrawHide(playerid,TextDrawMorte[playerid][idx]); }
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
	format(File,  sizeof(File),  PASTA_MORTOS,  PlayerName(playerid));
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
	Registration_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 269.6997, 149.4332, "LD_SPAC:white"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][0], 99.0000, 158.8589);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][0], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][0], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][0], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][0], 0);

	Registration_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 262.3834, 146.2775, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][1], 16.0000, 20.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][1], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][1], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][1], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][1], 0);

	Registration_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 360.4683, 146.7776, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][2], 16.0000, 17.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][2], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][2], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][2], 0);

	Registration_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 261.9351, 288.4777, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][3], 19.0000, 24.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][3], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][3], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][3], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][3], 0);

	Registration_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 358.0848, 288.4038, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][4], 19.0000, 24.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][4], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][4], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][4], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][4], 0);

	Registration_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 264.9833, 155.5185, "LD_SPAC:white"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][5], 109.0000, 145.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][5], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][5], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][5], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][5], 0);

	Registration_PTD[playerid][6] = CreatePlayerTextDraw(playerid, 304.5830, 160.7037, "ld_pool:ball"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][6], 26.0000, 31.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][6], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][6], -65281);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][6], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][6], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][6], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][6], 0);

	Registration_PTD[playerid][7] = CreatePlayerTextDraw(playerid, 312.4002, 167.3332, "ld_pool:ball"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][7], 23.0000, 29.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][7], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][7], -65281);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][7], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][7], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][7], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][7], 0);

	Registration_PTD[playerid][8] = CreatePlayerTextDraw(playerid, 299.7514, 154.6260, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][8], 42.0000, 48.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][8], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][8], 640166143);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][8], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][8], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][8], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][8], 0);

	Registration_PTD[playerid][9] = CreatePlayerTextDraw(playerid, 299.1665, 206.5925, "CONECTANDO.."); // ïóñòî
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][9], 0.1508, 0.9881);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][9], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][9], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][9], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][9], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][9], 0);

	Registration_PTD[playerid][10] = CreatePlayerTextDraw(playerid, 308.2330, 172.3703, "BAIXADA"); // ïóñòî
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][10], 0.1508, 0.9881);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][10], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][10], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][10], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][10], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][10], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][10], 0);

	Registration_PTD[playerid][11] = CreatePlayerTextDraw(playerid, 288.9169, 248.3787, "LD_SPAC:white"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][11], 63.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][11], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][11], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][11], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][11], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][11], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][11], 0);

	Registration_PTD[playerid][12] = CreatePlayerTextDraw(playerid, 281.5332, 245.5828, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][12], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][12], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][12], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][12], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][12], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][12], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][12], 0);

	Registration_PTD[playerid][13] = CreatePlayerTextDraw(playerid, 345.4332, 245.5828, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][13], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][13], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][13], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][13], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][13], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][13], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][13], 0);

	Registration_PTD[playerid][14] = CreatePlayerTextDraw(playerid, 305.8001, 282.1371, "LD_SPAC:white"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][14], 30.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][14], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][14], 916987903);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][14], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][14], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][14], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][14], 0);

	Registration_PTD[playerid][15] = CreatePlayerTextDraw(playerid, 298.4165, 279.3412, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][15], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][15], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][15], 916987903);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][15], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][15], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][15], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][15], 0);

	Registration_PTD[playerid][16] = CreatePlayerTextDraw(playerid, 329.4663, 279.3412, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][16], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][16], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][16], 916987903);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][16], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][16], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][16], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][16], 0);

	Registration_PTD[playerid][17] = CreatePlayerTextDraw(playerid, 288.7169, 227.1774, "LD_SPAC:white"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][17], 63.0000, 12.0000);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][17], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][17], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][17], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][17], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][17], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][17], 0);

	Registration_PTD[playerid][18] = CreatePlayerTextDraw(playerid, 281.3332, 224.3815, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][18], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][18], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][18], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][18], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][18], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][18], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][18], 0);

	Registration_PTD[playerid][19] = CreatePlayerTextDraw(playerid, 345.2332, 224.3815, "LD_BEAT:chit"); // ïóñòî
	PlayerTextDrawTextSize(playerid, Registration_PTD[playerid][19], 13.7399, 17.6300);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][19], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][19], -1128132865);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][19], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][19], 4);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][19], 0);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][19], 0);

	Registration_PTD[playerid][20] = CreatePlayerTextDraw(playerid, 294.1000, 228.8889, "NOME_SOBRENOME"); // ïóñòî
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][20], 0.1500, 0.7859);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][20], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][20], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][20], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][20], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][20], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][20], 0);

	Registration_PTD[playerid][21] = CreatePlayerTextDraw(playerid, 296.4002, 250.0902, "DIGITE_SENHA"); // ïóñòî
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][21], 0.1500, 0.7859);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][21], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][21], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][21], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][21], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][21], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid,Registration_PTD[playerid][21], true);

	Registration_PTD[playerid][22] = CreatePlayerTextDraw(playerid, 311.1177, 283.8107, "LOGAR"); // ïóñòî
	PlayerTextDrawLetterSize(playerid, Registration_PTD[playerid][22], 0.1500, 0.7859);
	PlayerTextDrawAlignment(playerid, Registration_PTD[playerid][22], 1);
	PlayerTextDrawColor(playerid, Registration_PTD[playerid][22], -1);
	PlayerTextDrawBackgroundColor(playerid, Registration_PTD[playerid][22], 255);
	PlayerTextDrawFont(playerid, Registration_PTD[playerid][22], 2);
	PlayerTextDrawSetProportional(playerid, Registration_PTD[playerid][22], 1);
	PlayerTextDrawSetShadow(playerid, Registration_PTD[playerid][22], 0);

	//Loadscreen strings e progressbar
	Loadsc_p[playerid][0] = CreatePlayerTextDraw(playerid, 438.000000, 271.000000, "100%");
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
	PlayerTextDrawSetSelectable(playerid, Loadsc_p[playerid][0], 0);
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

	HudServer[playerid][0] = CreatePlayerTextDraw(playerid,288.000000, -1.000000, "_"); //Logomarca antiga
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][0], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][0], 1);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][0], 0.519999, 3.300002);
	PlayerTextDrawColor(playerid,HudServer[playerid][0], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][0], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][0], 0);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][0], 0);

	HudServer[playerid][1] = CreatePlayerTextDraw(playerid,293.000000, 22.000000, "_"); //2
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][1], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][1], 2);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][1], 0.239999, 1.200003);
	PlayerTextDrawColor(playerid,HudServer[playerid][1], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][1], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][1], 0);

	HudServer[playerid][2] = CreatePlayerTextDraw(playerid,61.000000, 387.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][2], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][2], 1);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][2], 0.469999, 2.300000);
	PlayerTextDrawColor(playerid,HudServer[playerid][2], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][2], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][2], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][2], 1);
	PlayerTextDrawUseBox(playerid,HudServer[playerid][2], 1);
	PlayerTextDrawBoxColor(playerid,HudServer[playerid][2], 100);
	PlayerTextDrawTextSize(playerid,HudServer[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][2], 0);

	HudServer[playerid][3] = CreatePlayerTextDraw(playerid,25.000000, 388.000000, "hud:radar_burgerShot");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][3], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][3], 4);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][3], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,HudServer[playerid][3], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][3], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][3], 0);
	PlayerTextDrawUseBox(playerid,HudServer[playerid][3], 1);
	PlayerTextDrawBoxColor(playerid,HudServer[playerid][3], 255);
	PlayerTextDrawTextSize(playerid,HudServer[playerid][3], 14.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][3], 0);

	HudServer[playerid][4] = CreatePlayerTextDraw(playerid,41.000000, 387.000000, "hud:radar_centre");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][4], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][4], 4);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][4], 0.500000, 1.000000);
	PlayerTextDrawColor(playerid,HudServer[playerid][4], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][4], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][4], 0);
	PlayerTextDrawUseBox(playerid,HudServer[playerid][4], 1);
	PlayerTextDrawBoxColor(playerid,HudServer[playerid][4], 255);
	PlayerTextDrawTextSize(playerid,HudServer[playerid][4], 14.000000, 13.000000);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][4], 0);

	HudServer[playerid][5] = CreatePlayerTextDraw(playerid,23.000000, 390.000000, "_");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][5], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][5], 1);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][5], 0.419999, 1.600000);
	PlayerTextDrawColor(playerid,HudServer[playerid][5], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][5], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][5], 1);
	PlayerTextDrawUseBox(playerid,HudServer[playerid][5], 1);
	PlayerTextDrawBoxColor(playerid,HudServer[playerid][5], 100);
	PlayerTextDrawTextSize(playerid,HudServer[playerid][5], 4.000000, 6.000000);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][5], 0);

	HudServer[playerid][6] = CreatePlayerTextDraw(playerid,10.000000, 386.000000, "F");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][6], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][6], 1);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][6], 0.430000, 2.200002);
	PlayerTextDrawColor(playerid,HudServer[playerid][6], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][6], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][6], 0);

	HudServer[playerid][7] = CreatePlayerTextDraw(playerid,25.000000, 399.000000, "100");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][7], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][7], 2);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][7], 0.219999, 1.000002);
	PlayerTextDrawColor(playerid,HudServer[playerid][7], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][7], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][7], 0);

	HudServer[playerid][8] = CreatePlayerTextDraw(playerid,41.000000, 399.000000, "100");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][8], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][8], 2);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][8], 0.219999, 1.000002);
	PlayerTextDrawColor(playerid,HudServer[playerid][8], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][8], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][8], 0);

	HudServer[playerid][9] = CreatePlayerTextDraw(playerid,1.000000, 375.000000, "bC: 10000");
	PlayerTextDrawBackgroundColor(playerid,HudServer[playerid][9], 255);
	PlayerTextDrawFont(playerid,HudServer[playerid][9], 2);
	PlayerTextDrawLetterSize(playerid,HudServer[playerid][9], 0.219999, 1.000002);
	PlayerTextDrawColor(playerid,HudServer[playerid][9], -1);
	PlayerTextDrawSetOutline(playerid,HudServer[playerid][9], 0);
	PlayerTextDrawSetProportional(playerid,HudServer[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid,HudServer[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid,HudServer[playerid][9], 0);

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
	
/*	wMenuRodas[11] = CreatePlayerTextDraw(playerid,123.000000, 350.000000+50, "Grove");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[11], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[11], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[11], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[11], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[11], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[11], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[11], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[11], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[11], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[11], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[11], 0);
	
	wMenuRodas[12] = CreatePlayerTextDraw(playerid,123.000000, 410.000000+50, "Switch");
	PlayerTextDrawBackgroundColor(playerid,wMenuRodas[12], 255);
	PlayerTextDrawFont(playerid,wMenuRodas[12], 2);
	PlayerTextDrawLetterSize(playerid,wMenuRodas[12], 0.209998, 1.200000);
	PlayerTextDrawColor(playerid,wMenuRodas[12], -1);
	PlayerTextDrawSetOutline(playerid,wMenuRodas[12], 0);
	PlayerTextDrawSetProportional(playerid,wMenuRodas[12], 1);
	PlayerTextDrawSetShadow(playerid,wMenuRodas[12], 0);
	PlayerTextDrawUseBox(playerid,wMenuRodas[12], 1);
	PlayerTextDrawBoxColor(playerid,wMenuRodas[12], 0);
	PlayerTextDrawTextSize(playerid,wMenuRodas[12], 282.000000, 10.000000);
	PlayerTextDrawSetSelectable(playerid,wMenuRodas[12], 0);
*/
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

	TDLucky[0] = CreatePlayerTextDraw(playerid, 331.000000, 130.000000, "_");
	PlayerTextDrawAlignment(playerid, TDLucky[0], 2), PlayerTextDrawFont(playerid, TDLucky[0], 1); 
	PlayerTextDrawLetterSize(playerid, TDLucky[0], 0.500000, 6.000000), PlayerTextDrawUseBox(playerid, TDLucky[0], 1); 
	PlayerTextDrawBoxColor(playerid, TDLucky[0], 255), PlayerTextDrawTextSize(playerid, TDLucky[0], 18.000000, -175.000000);

	TDLucky[1] = CreatePlayerTextDraw(playerid, 247.000000, 130.000000, "ld_slot:grapes");
	PlayerTextDrawFont(playerid, TDLucky[1], 4), PlayerTextDrawLetterSize(playerid, TDLucky[1], 0.500000, 1.000000);
	PlayerTextDrawUseBox(playerid, TDLucky[1], 1), PlayerTextDrawTextSize(playerid, TDLucky[1], 57.000000, 73.000000);

	TDLucky[2] = CreatePlayerTextDraw(playerid, 302.000000, 130.000000, "ld_slot:cherry");
	PlayerTextDrawFont(playerid, TDLucky[2], 4), PlayerTextDrawLetterSize(playerid, TDLucky[2], 0.500000, 1.000000);
	PlayerTextDrawUseBox(playerid, TDLucky[2], 1), PlayerTextDrawTextSize(playerid, TDLucky[2], 57.000000, 73.000000);

	TDLucky[3] = CreatePlayerTextDraw(playerid, 357.000000, 130.000000, "ld_slot:bell");
	PlayerTextDrawFont(playerid, TDLucky[3], 4), PlayerTextDrawLetterSize(playerid, TDLucky[3], 0.500000, 1.000000);
	PlayerTextDrawUseBox(playerid, TDLucky[3], 1), PlayerTextDrawTextSize(playerid, TDLucky[3], 57.000000, 73.000000);

	TDLucky[4] = CreatePlayerTextDraw(playerid, 263.000000, 107.000000, "CACA-NIQUEL");
	PlayerTextDrawFont(playerid, TDLucky[4], 3), PlayerTextDrawLetterSize(playerid, TDLucky[4], 0.700000, 2.000000);
	PlayerTextDrawSetOutline(playerid, TDLucky[4], 1);

	DrawInv[playerid][0] = CreatePlayerTextDraw(playerid, 373.000000, 179.000000, "box");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][0], 0.000000, 14.687500);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][0], 592.389404, 0.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][0], 150);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][0], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][0], 1);

	DrawInv[playerid][1] = CreatePlayerTextDraw(playerid, 372.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][1], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][1], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][1], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][1], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][1], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][1], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][1], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][1], 0.000000, 0.000000, 0.000000, 99.000000);

	DrawInv[playerid][2] = CreatePlayerTextDraw(playerid, 400.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][2], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][2], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][2], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][2], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][2], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][2], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][2], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][3] = CreatePlayerTextDraw(playerid, 428.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][3], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][3], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][3], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][3], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][3], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][3], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][3], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][3], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][4] = CreatePlayerTextDraw(playerid, 456.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][4], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][4], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][4], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][4], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][4], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][4], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][4], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][4], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][5] = CreatePlayerTextDraw(playerid, 484.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][5], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][5], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][5], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][5], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][5], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][5], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][5], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][5], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][6] = CreatePlayerTextDraw(playerid, 512.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][6], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][6], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][6], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][6], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][6], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][6], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][6], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][6], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][6], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][7] = CreatePlayerTextDraw(playerid, 540.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][7], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][7], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][7], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][7], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][7], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][7], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][7], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][7], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][7], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][8] = CreatePlayerTextDraw(playerid, 568.000000, 179.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][8], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][8], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][8], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][8], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][8], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][8], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][8], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][8], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][8], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][9] = CreatePlayerTextDraw(playerid, 372.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][9], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][9], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][9], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][9], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][9], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][9], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][9], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][9], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][9], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][10] = CreatePlayerTextDraw(playerid, 400.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][10], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][10], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][10], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][10], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][10], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][10], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][10], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][10], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][10], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][10], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][11] = CreatePlayerTextDraw(playerid, 428.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][11], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][11], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][11], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][11], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][11], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][11], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][11], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][11], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][11], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][11], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][12] = CreatePlayerTextDraw(playerid, 456.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][12], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][12], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][12], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][12], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][12], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][12], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][12], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][12], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][12], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][12], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][13] = CreatePlayerTextDraw(playerid, 484.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][13], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][13], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][13], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][13], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][13], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][13], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][13], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][13], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][13], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][13], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][14] = CreatePlayerTextDraw(playerid, 512.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][14], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][14], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][14], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][14], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][14], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][14], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][14], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][14], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][14], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][14], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][15] = CreatePlayerTextDraw(playerid, 540.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][15], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][15], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][15], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][15], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][15], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][15], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][15], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][15], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][15], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][15], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][16] = CreatePlayerTextDraw(playerid, 568.000000, 207.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][16], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][16], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][16], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][16], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][16], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][16], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][16], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][16], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][16], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][16], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][17] = CreatePlayerTextDraw(playerid, 372.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][17], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][17], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][17], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][17], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][17], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][17], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][17], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][17], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][17], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][17], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][18] = CreatePlayerTextDraw(playerid, 400.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][18], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][18], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][18], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][18], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][18], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][18], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][18], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][18], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][18], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][18], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][19] = CreatePlayerTextDraw(playerid, 428.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][19], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][19], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][19], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][19], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][19], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][19], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][19], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][19], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][19], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][19], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][20] = CreatePlayerTextDraw(playerid, 456.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][20], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][20], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][20], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][20], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][20], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][20], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][20], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][20], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][20], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][20], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][21] = CreatePlayerTextDraw(playerid, 484.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][21], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][21], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][21], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][21], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][21], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][21], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][21], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][21], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][21], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][21], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][22] = CreatePlayerTextDraw(playerid, 512.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][22], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][22], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][22], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][22], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][22], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][22], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][22], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][22], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][22], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][22], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][23] = CreatePlayerTextDraw(playerid, 540.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][23], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][23], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][23], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][23], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][23], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][23], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][23], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][23], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][23], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][23], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][24] = CreatePlayerTextDraw(playerid, 568.000000, 235.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][24], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][24], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][24], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][24], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][24], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][24], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][24], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][24], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][24], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][24], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][25] = CreatePlayerTextDraw(playerid, 372.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][25], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][25], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][25], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][25], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][25], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][25], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][25], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][25], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][25], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][25], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][26] = CreatePlayerTextDraw(playerid, 400.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][26], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][26], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][26], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][26], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][26], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][26], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][26], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][26], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][26], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][26], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][27] = CreatePlayerTextDraw(playerid, 428.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][27], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][27], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][27], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][27], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][27], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][27], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][27], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][27], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][27], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][27], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][28] = CreatePlayerTextDraw(playerid, 456.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][28], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][28], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][28], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][28], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][28], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][28], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][28], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][28], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][28], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][28], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][29] = CreatePlayerTextDraw(playerid, 484.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][29], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][29], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][29], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][29], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][29], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][29], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][29], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][29], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][29], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][29], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][30] = CreatePlayerTextDraw(playerid, 512.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][30], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][30], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][30], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][30], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][30], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][30], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][30], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][30], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][30], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][30], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][31] = CreatePlayerTextDraw(playerid, 540.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][31], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][31], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][31], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][31], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][31], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][31], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][31], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][31], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][31], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][31], 0.000000, 0.000000, 0.000000, 1.000000);

	DrawInv[playerid][32] = CreatePlayerTextDraw(playerid, 568.000000, 263.000000, "");
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][32], 25.000000, 25.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][32], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][32], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][32], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][32], 150);
	PlayerTextDrawFont(playerid, DrawInv[playerid][32], 5);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][32], 0);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][32], true);
	PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][32], 0);
	PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][32], 0.000000, 0.000000, 0.000000, 1.000000);

	for(new i = 1; i < 33; ++i)
	{
		PlayerTextDrawSetPreviewRot(playerid, DrawInv[playerid][i], 0.000000, 0.000000, 0.000000, 999);
	}

	DrawInv[playerid][33] = CreatePlayerTextDraw(playerid, 373.000000, 161.000000, "box");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][33], 0.000000, 1.466506);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][33], 592.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][33], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][33], -1);
	PlayerTextDrawUseBox(playerid, DrawInv[playerid][33], 1);
	PlayerTextDrawBoxColor(playerid, DrawInv[playerid][33], 255);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][33], 0);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][33], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][33], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][33], 1);

	DrawInv[playerid][34] = CreatePlayerTextDraw(playerid, 372.000000, 162.000000, "INVENTARIO:_MAX_PLAYER_NAME");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][34], 0.210623, 0.888332);
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

	DrawInv[playerid][36] = CreatePlayerTextDraw(playerid, 374.000000, 296.000000, "Usar");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][36], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][36], 396, 10.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][36], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][36], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][36], 0);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][36], 1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][36], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][36], 2);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][36], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][36], true);

	DrawInv[playerid][37] = CreatePlayerTextDraw(playerid, 405.000000, 296.000000, "Descartar");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][37], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][37], 455, 10.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][37], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][37], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][37], 0);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][37], 1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][37], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][37], 2);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][37], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][37], true);

	DrawInv[playerid][38] = CreatePlayerTextDraw(playerid, 593.147094, 303.800354, "_0_unidades");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][38], 0.200000, 0.800000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][38], 3);
	PlayerTextDrawColor(playerid, DrawInv[playerid][38], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][38], 0);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][38], 1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][38], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][38], 1);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][38], 1);

	DrawInv[playerid][39] = CreatePlayerTextDraw(playerid, 464.601501, 296.016723, "Separar");
	PlayerTextDrawLetterSize(playerid, DrawInv[playerid][39], 0.200000, 1.000000);
	PlayerTextDrawTextSize(playerid, DrawInv[playerid][39], 502.000000, 10.000000);
	PlayerTextDrawAlignment(playerid, DrawInv[playerid][39], 1);
	PlayerTextDrawColor(playerid, DrawInv[playerid][39], -1);
	PlayerTextDrawSetShadow(playerid, DrawInv[playerid][39], 0);
	PlayerTextDrawSetOutline(playerid, DrawInv[playerid][39], 1);
	PlayerTextDrawBackgroundColor(playerid, DrawInv[playerid][39], 255);
	PlayerTextDrawFont(playerid, DrawInv[playerid][39], 2);
	PlayerTextDrawSetProportional(playerid, DrawInv[playerid][39], 1);
	PlayerTextDrawSetSelectable(playerid, DrawInv[playerid][39], true);

	TDEditor_PTD[playerid][0] = CreatePlayerTextDraw(playerid, 247.067092, 184.241149, "Nome_Sobrenome");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][0], 0.149665, 0.786961);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][0], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][0], 1825272575);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][0], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][0], 2);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][0], 1);

	TDEditor_PTD[playerid][1] = CreatePlayerTextDraw(playerid, 373.966705, 172.992630, "Depositar");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][1], 0.224333, 1.060739);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][1], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][1], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][1], 3);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][1], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][1], true);

	TDEditor_PTD[playerid][2] = CreatePlayerTextDraw(playerid, 373.966705, 197.794143, "Retirar");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][2], 0.224333, 1.060739);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][2], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][2], 3);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][2], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][2], true);

	TDEditor_PTD[playerid][3] = CreatePlayerTextDraw(playerid, 373.966705, 225.095809, "Tranferir");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][3], 0.224333, 1.060739);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][3], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][3], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][3], 3);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][3], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][3], true);

	TDEditor_PTD[playerid][4] = CreatePlayerTextDraw(playerid, 343.300109, 142.111007, "clique aqui para fechar");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][4], 0.180000, 0.981926);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][4], 571.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][4], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][4], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][4], 3);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][4], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][4], true);

	TDEditor_PTD[playerid][5] = CreatePlayerTextDraw(playerid, 412.866851, 141.892745, ">");
	PlayerTextDrawLetterSize(playerid, TDEditor_PTD[playerid][5], 0.234666, 1.052445);
	PlayerTextDrawTextSize(playerid, TDEditor_PTD[playerid][5], -37.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawColor(playerid, TDEditor_PTD[playerid][5], -1);
	PlayerTextDrawSetShadow(playerid, TDEditor_PTD[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, TDEditor_PTD[playerid][5], 255);
	PlayerTextDrawFont(playerid, TDEditor_PTD[playerid][5], 3);
	PlayerTextDrawSetProportional(playerid, TDEditor_PTD[playerid][5], 1);
	PlayerTextDrawSetSelectable(playerid, TDEditor_PTD[playerid][5], true);

    //----Desmanhado -----//
	TextDrawMorte[playerid][0] = CreatePlayerTextDraw(playerid,827.000000, -7.000000, "_");
    PlayerTextDrawBackgroundColor(playerid,TextDrawMorte[playerid][0], 255);
    PlayerTextDrawFont(playerid,TextDrawMorte[playerid][0], 1);
    PlayerTextDrawLetterSize(playerid,TextDrawMorte[playerid][0], -5.039997, 56.599998);
    PlayerTextDrawColor(playerid,TextDrawMorte[playerid][0], -1);
    PlayerTextDrawSetOutline(playerid,TextDrawMorte[playerid][0], 0);
    PlayerTextDrawSetProportional(playerid,TextDrawMorte[playerid][0], 1);
    PlayerTextDrawSetShadow(playerid,TextDrawMorte[playerid][0], 1);
    PlayerTextDrawUseBox(playerid,TextDrawMorte[playerid][0], 1);
    PlayerTextDrawBoxColor(playerid,TextDrawMorte[playerid][0], 102);
    PlayerTextDrawTextSize(playerid,TextDrawMorte[playerid][0], -82.000000, -52.000000);
    PlayerTextDrawSetSelectable(playerid,TextDrawMorte[playerid][0], 0);

    TextDrawMorte[playerid][1] = CreatePlayerTextDraw(playerid,827.000000, -7.000000, "_");
    PlayerTextDrawBackgroundColor(playerid,TextDrawMorte[playerid][1], 255);
    PlayerTextDrawFont(playerid,TextDrawMorte[playerid][1], 1);
    PlayerTextDrawLetterSize(playerid,TextDrawMorte[playerid][1], -5.039997, 56.599998);
    PlayerTextDrawColor(playerid,TextDrawMorte[playerid][1], -1);
    PlayerTextDrawSetOutline(playerid,TextDrawMorte[playerid][1], 0);
    PlayerTextDrawSetProportional(playerid,TextDrawMorte[playerid][1], 1);
    PlayerTextDrawSetShadow(playerid,TextDrawMorte[playerid][1], 1);
    PlayerTextDrawUseBox(playerid,TextDrawMorte[playerid][1], 1);
    PlayerTextDrawBoxColor(playerid,TextDrawMorte[playerid][1], 102);
    PlayerTextDrawTextSize(playerid,TextDrawMorte[playerid][1], -82.000000, -52.000000);
    PlayerTextDrawSetSelectable(playerid,TextDrawMorte[playerid][1], 0);

    TextDrawMorte[playerid][2] = CreatePlayerTextDraw(playerid,191.000000, 142.000000, "VOCE");
    PlayerTextDrawBackgroundColor(playerid,TextDrawMorte[playerid][2], 255);
    PlayerTextDrawFont(playerid,TextDrawMorte[playerid][2], 2);
    PlayerTextDrawLetterSize(playerid,TextDrawMorte[playerid][2], 0.479999, 5.300001);
    PlayerTextDrawColor(playerid,TextDrawMorte[playerid][2], -1);
    PlayerTextDrawSetOutline(playerid,TextDrawMorte[playerid][2], 0);
    PlayerTextDrawSetProportional(playerid,TextDrawMorte[playerid][2], 1);
    PlayerTextDrawSetShadow(playerid,TextDrawMorte[playerid][2], 0);
    PlayerTextDrawSetSelectable(playerid,TextDrawMorte[playerid][2], 0);

    TextDrawMorte[playerid][3] = CreatePlayerTextDraw(playerid,299.000000, 141.000000, "DESMAIOU");
    PlayerTextDrawBackgroundColor(playerid,TextDrawMorte[playerid][3], 255);
    PlayerTextDrawFont(playerid,TextDrawMorte[playerid][3], 2);
    PlayerTextDrawLetterSize(playerid,TextDrawMorte[playerid][3], 0.479999, 5.300001);
    PlayerTextDrawColor(playerid,TextDrawMorte[playerid][3], -602653441);
    PlayerTextDrawSetOutline(playerid,TextDrawMorte[playerid][3], 0);
    PlayerTextDrawSetProportional(playerid,TextDrawMorte[playerid][3], 1);
    PlayerTextDrawSetShadow(playerid,TextDrawMorte[playerid][3], 0);
    PlayerTextDrawSetSelectable(playerid,TextDrawMorte[playerid][3], 0);

    TextDrawMorte[playerid][4] = CreatePlayerTextDraw(playerid,242.000000, 189.000000, "AGUARDE");
    PlayerTextDrawBackgroundColor(playerid,TextDrawMorte[playerid][4], 255);
    PlayerTextDrawFont(playerid,TextDrawMorte[playerid][4], 1);
    PlayerTextDrawLetterSize(playerid,TextDrawMorte[playerid][4], 0.409999, 1.600000);
    PlayerTextDrawColor(playerid,TextDrawMorte[playerid][4], -1);
    PlayerTextDrawSetOutline(playerid,TextDrawMorte[playerid][4], 0);
    PlayerTextDrawSetProportional(playerid,TextDrawMorte[playerid][4], 1);
    PlayerTextDrawSetShadow(playerid,TextDrawMorte[playerid][4], 0);
    PlayerTextDrawSetSelectable(playerid,TextDrawMorte[playerid][4], 0);

    TextDrawMorte[playerid][5] = CreatePlayerTextDraw(playerid,298.000000, 189.000000, "");
    PlayerTextDrawBackgroundColor(playerid,TextDrawMorte[playerid][5], 255);
    PlayerTextDrawFont(playerid,TextDrawMorte[playerid][5], 1);
    PlayerTextDrawLetterSize(playerid,TextDrawMorte[playerid][5], 0.409999, 1.600000);
    PlayerTextDrawColor(playerid,TextDrawMorte[playerid][5], -602653441);
    PlayerTextDrawSetOutline(playerid,TextDrawMorte[playerid][5], 0);
    PlayerTextDrawSetProportional(playerid,TextDrawMorte[playerid][5], 1);
    PlayerTextDrawSetShadow(playerid,TextDrawMorte[playerid][5], 0);
    PlayerTextDrawSetSelectable(playerid,TextDrawMorte[playerid][5], 0);

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

	Loadsc[1] = TextDrawCreate(293.000000, 146.000000, "B");
	TextDrawFont(Loadsc[1], 1);
	TextDrawLetterSize(Loadsc[1], 0.849999, 3.299998);
	TextDrawTextSize(Loadsc[1], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[1], 2);
	TextDrawSetShadow(Loadsc[1], 2);
	TextDrawAlignment(Loadsc[1], 1);
	TextDrawColor(Loadsc[1], -65281);
	TextDrawBackgroundColor(Loadsc[1], 255);
	TextDrawBoxColor(Loadsc[1], 50);
	TextDrawUseBox(Loadsc[1], 0);
	TextDrawSetProportional(Loadsc[1], 1);
	TextDrawSetSelectable(Loadsc[1], 0);

	Loadsc[2] = TextDrawCreate(309.000000, 144.000000, "A");
	TextDrawFont(Loadsc[2], 1);
	TextDrawLetterSize(Loadsc[2], 0.849999, 3.299998);
	TextDrawTextSize(Loadsc[2], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[2], 2);
	TextDrawSetShadow(Loadsc[2], 0);
	TextDrawAlignment(Loadsc[2], 1);
	TextDrawColor(Loadsc[2], -65281);
	TextDrawBackgroundColor(Loadsc[2], 255);
	TextDrawBoxColor(Loadsc[2], 50);
	TextDrawUseBox(Loadsc[2], 0);
	TextDrawSetProportional(Loadsc[2], 1);
	TextDrawSetSelectable(Loadsc[2], 0);

	Loadsc[3] = TextDrawCreate(330.000000, 146.000000, "I");
	TextDrawFont(Loadsc[3], 1);
	TextDrawLetterSize(Loadsc[3], 0.849999, 3.299998);
	TextDrawTextSize(Loadsc[3], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[3], 2);
	TextDrawSetShadow(Loadsc[3], 0);
	TextDrawAlignment(Loadsc[3], 1);
	TextDrawColor(Loadsc[3], -65281);
	TextDrawBackgroundColor(Loadsc[3], 255);
	TextDrawBoxColor(Loadsc[3], 50);
	TextDrawUseBox(Loadsc[3], 0);
	TextDrawSetProportional(Loadsc[3], 1);
	TextDrawSetSelectable(Loadsc[3], 0);

	Loadsc[4] = TextDrawCreate(319.000000, 167.000000, "C");
	TextDrawFont(Loadsc[4], 3);
	TextDrawLetterSize(Loadsc[4], 1.079167, 3.299998);
	TextDrawTextSize(Loadsc[4], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[4], 2);
	TextDrawSetShadow(Loadsc[4], 0);
	TextDrawAlignment(Loadsc[4], 1);
	TextDrawColor(Loadsc[4], -65281);
	TextDrawBackgroundColor(Loadsc[4], 255);
	TextDrawBoxColor(Loadsc[4], 50);
	TextDrawUseBox(Loadsc[4], 0);
	TextDrawSetProportional(Loadsc[4], 1);
	TextDrawSetSelectable(Loadsc[4], 0);

	Loadsc[5] = TextDrawCreate(318.000000, 167.000000, "C");
	TextDrawFont(Loadsc[5], 3);
	TextDrawLetterSize(Loadsc[5], -1.104168, 3.299998);
	TextDrawTextSize(Loadsc[5], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[5], 2);
	TextDrawSetShadow(Loadsc[5], 0);
	TextDrawAlignment(Loadsc[5], 1);
	TextDrawColor(Loadsc[5], -65281);
	TextDrawBackgroundColor(Loadsc[5], 255);
	TextDrawBoxColor(Loadsc[5], 50);
	TextDrawUseBox(Loadsc[5], 0);
	TextDrawSetProportional(Loadsc[5], 1);
	TextDrawSetSelectable(Loadsc[5], 0);

	Loadsc[6] = TextDrawCreate(291.000000, 191.000000, "A");
	TextDrawFont(Loadsc[6], 1);
	TextDrawLetterSize(Loadsc[6], 0.849999, 3.299998);
	TextDrawTextSize(Loadsc[6], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[6], 2);
	TextDrawSetShadow(Loadsc[6], 0);
	TextDrawAlignment(Loadsc[6], 1);
	TextDrawColor(Loadsc[6], -65281);
	TextDrawBackgroundColor(Loadsc[6], 255);
	TextDrawBoxColor(Loadsc[6], 50);
	TextDrawUseBox(Loadsc[6], 0);
	TextDrawSetProportional(Loadsc[6], 1);
	TextDrawSetSelectable(Loadsc[6], 0);

	Loadsc[7] = TextDrawCreate(310.000000, 190.000000, "D");
	TextDrawFont(Loadsc[7], 1);
	TextDrawLetterSize(Loadsc[7], 0.849999, 3.299998);
	TextDrawTextSize(Loadsc[7], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[7], 2);
	TextDrawSetShadow(Loadsc[7], 0);
	TextDrawAlignment(Loadsc[7], 1);
	TextDrawColor(Loadsc[7], -65281);
	TextDrawBackgroundColor(Loadsc[7], 255);
	TextDrawBoxColor(Loadsc[7], 50);
	TextDrawUseBox(Loadsc[7], 0);
	TextDrawSetProportional(Loadsc[7], 1);
	TextDrawSetSelectable(Loadsc[7], 0);

	Loadsc[8] = TextDrawCreate(326.000000, 191.000000, "A");
	TextDrawFont(Loadsc[8], 1);
	TextDrawLetterSize(Loadsc[8], 0.849999, 3.299998);
	TextDrawTextSize(Loadsc[8], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[8], 2);
	TextDrawSetShadow(Loadsc[8], 0);
	TextDrawAlignment(Loadsc[8], 1);
	TextDrawColor(Loadsc[8], -65281);
	TextDrawBackgroundColor(Loadsc[8], 255);
	TextDrawBoxColor(Loadsc[8], 50);
	TextDrawUseBox(Loadsc[8], 0);
	TextDrawSetProportional(Loadsc[8], 1);
	TextDrawSetSelectable(Loadsc[8], 0);

	Loadsc[9] = TextDrawCreate(278.000000, 217.000000, "ROLEPLAY");
	TextDrawFont(Loadsc[9], 3);
	TextDrawLetterSize(Loadsc[9], 0.600000, 2.000000);
	TextDrawTextSize(Loadsc[9], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[9], 0);
	TextDrawSetShadow(Loadsc[9], 0);
	TextDrawAlignment(Loadsc[9], 1);
	TextDrawColor(Loadsc[9], -1);
	TextDrawBackgroundColor(Loadsc[9], 255);
	TextDrawBoxColor(Loadsc[9], 50);
	TextDrawUseBox(Loadsc[9], 0);
	TextDrawSetProportional(Loadsc[9], 1);
	TextDrawSetSelectable(Loadsc[9], 0);

	Loadsc[10] = TextDrawCreate(363.000000, 207.000000, "]");
	TextDrawFont(Loadsc[10], 0);
	TextDrawLetterSize(Loadsc[10], 0.354166, 1.350000);
	TextDrawTextSize(Loadsc[10], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[10], 0);
	TextDrawSetShadow(Loadsc[10], 0);
	TextDrawAlignment(Loadsc[10], 1);
	TextDrawColor(Loadsc[10], -65281);
	TextDrawBackgroundColor(Loadsc[10], 255);
	TextDrawBoxColor(Loadsc[10], 50);
	TextDrawUseBox(Loadsc[10], 0);
	TextDrawSetProportional(Loadsc[10], 1);
	TextDrawSetSelectable(Loadsc[10], 0);

	Loadsc[11] = TextDrawCreate(372.000000, 199.000000, "]");
	TextDrawFont(Loadsc[11], 0);
	TextDrawLetterSize(Loadsc[11], 0.354166, 1.350000);
	TextDrawTextSize(Loadsc[11], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[11], 0);
	TextDrawSetShadow(Loadsc[11], 0);
	TextDrawAlignment(Loadsc[11], 1);
	TextDrawColor(Loadsc[11], -65281);
	TextDrawBackgroundColor(Loadsc[11], 255);
	TextDrawBoxColor(Loadsc[11], 50);
	TextDrawUseBox(Loadsc[11], 0);
	TextDrawSetProportional(Loadsc[11], 1);
	TextDrawSetSelectable(Loadsc[11], 0);

	Loadsc[12] = TextDrawCreate(382.000000, 194.000000, "]");
	TextDrawFont(Loadsc[12], 0);
	TextDrawLetterSize(Loadsc[12], 0.354166, 1.350000);
	TextDrawTextSize(Loadsc[12], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[12], 0);
	TextDrawSetShadow(Loadsc[12], 0);
	TextDrawAlignment(Loadsc[12], 1);
	TextDrawColor(Loadsc[12], -65281);
	TextDrawBackgroundColor(Loadsc[12], 255);
	TextDrawBoxColor(Loadsc[12], 50);
	TextDrawUseBox(Loadsc[12], 0);
	TextDrawSetProportional(Loadsc[12], 1);
	TextDrawSetSelectable(Loadsc[12], 0);

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

	Loadsc[14] = TextDrawCreate(265.000000, 207.000000, "]");
	TextDrawFont(Loadsc[14], 0);
	TextDrawLetterSize(Loadsc[14], 0.354166, 1.350000);
	TextDrawTextSize(Loadsc[14], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[14], 0);
	TextDrawSetShadow(Loadsc[14], 0);
	TextDrawAlignment(Loadsc[14], 1);
	TextDrawColor(Loadsc[14], -65281);
	TextDrawBackgroundColor(Loadsc[14], 255);
	TextDrawBoxColor(Loadsc[14], 50);
	TextDrawUseBox(Loadsc[14], 0);
	TextDrawSetProportional(Loadsc[14], 1);
	TextDrawSetSelectable(Loadsc[14], 0);

	Loadsc[15] = TextDrawCreate(255.000000, 199.000000, "]");
	TextDrawFont(Loadsc[15], 0);
	TextDrawLetterSize(Loadsc[15], 0.354166, 1.350000);
	TextDrawTextSize(Loadsc[15], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[15], 0);
	TextDrawSetShadow(Loadsc[15], 0);
	TextDrawAlignment(Loadsc[15], 1);
	TextDrawColor(Loadsc[15], -65281);
	TextDrawBackgroundColor(Loadsc[15], 255);
	TextDrawBoxColor(Loadsc[15], 50);
	TextDrawUseBox(Loadsc[15], 0);
	TextDrawSetProportional(Loadsc[15], 1);
	TextDrawSetSelectable(Loadsc[15], 0);

	Loadsc[16] = TextDrawCreate(245.000000, 193.000000, "]");
	TextDrawFont(Loadsc[16], 0);
	TextDrawLetterSize(Loadsc[16], 0.354166, 1.350000);
	TextDrawTextSize(Loadsc[16], 400.000000, 17.000000);
	TextDrawSetOutline(Loadsc[16], 0);
	TextDrawSetShadow(Loadsc[16], 0);
	TextDrawAlignment(Loadsc[16], 1);
	TextDrawColor(Loadsc[16], -65281);
	TextDrawBackgroundColor(Loadsc[16], 255);
	TextDrawBoxColor(Loadsc[16], 50);
	TextDrawUseBox(Loadsc[16], 0);
	TextDrawSetProportional(Loadsc[16], 1);
	TextDrawSetSelectable(Loadsc[16], 0);

}

stock GetPlayerSerial(playerid)
{
    new serial[512];
    gpci(playerid,serial,sizeof(serial));
    return serial;
}

stock GuardarItem2(playerid)
{
	new Item = GetPlayerWeapon(playerid);
	new Ammo = GetPlayerAmmo(playerid);
	new orgid = GetPlayerOrg(playerid);
	if(Item == 0) return notificacao(playerid, "ERRO", "Nao tem uma arma na mao", ICONE_ERRO);
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
 	return i == 20 ? notificacao(playerid, "ERRO", "Este bau esta cheio.", ICONE_ERRO) : 1;
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
	return ShowPlayerDialog(playerid,DIALOG_ARMAS12,DIALOG_STYLE_LIST,"Bau","Pegar Arma\nRetirar Arma do Bau","Selecionar","X");
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

		ObjetoCofre[idorg] = CreateDynamicObject(3796, CofreInfo[idorg][CofrePosX], CofreInfo[idorg][CofrePosY], CofreInfo[idorg][CofrePosZ]+0.5, 0.0, 0.0, CofreInfo[idorg][CofrePosR]);
		format(string, sizeof(string), "{FFFFFF}Bau ID: %d\nAperte {00FFFF}F\n{FFFFFF}para verifaicar o bau.", CofreInfo[idorg][CofreID]);
		TextoCofreOrg[idorg] = CreateDynamic3DTextLabel(string, -1, CofreInfo[idorg][CofrePosX], CofreInfo[idorg][CofrePosY], CofreInfo[idorg][CofrePosZ]+1, 25.0);
		return 1;
	}
	return printf("[Arquivos Load] Foram Carregados Cofres de Orgs.");
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
	return printf("[Arquivos Load] Foram Carregadas %d Radares.", IniciarRadares);
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
			format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
			TextoCasa[i] = CreateDynamic3DTextLabel(string, -1, CasaInfo[i][CasaX], CasaInfo[i][CasaY], CasaInfo[i][CasaZ], 15.0);
		}
	}
	return printf("[Arquivos Load] Foram Carregadas %d Casas.", IniciarCasas);
}

stock GetName( playerid ) {
	new playerName[ MAX_PLAYER_NAME ];
	GetPlayerName( playerid, playerName, sizeof( playerName ) );
	return playerName;
}

FormatNumber( number ) {
   format( Str, 15, "%d", number );
   if( strlen( Str ) < sizeof( Str ) ) {
	  if( number >= 1000 && number < 10000 ) strins(  Str, ",", 1, sizeof( Str ) );
	  else if( number >= 10000 && number < 100000 ) strins( Str, ",", 2, sizeof( Str ) );
	  else if( number >= 100000 && number < 1000000 ) strins( Str, ",", 3, sizeof( Str ) );
	  else if( number >= 1000000 && number < 10000000 ) strins( Str, ",", 1, sizeof( Str ) ),strins( Str, ",", 5, sizeof( Str ) );
	  else if( number >= 10000000 && number < 100000000 ) strins( Str, ",", 2, sizeof( Str ) ),strins( Str, ",", 6, sizeof( Str ) );
	  else if( number >= 100000000 && number < 1000000000 ) strins( Str, ",", 3, sizeof( Str ) ),strins( Str, ",", 7, sizeof( Str ) );
	  else if( number >= 1000000000 && number < 10000000000 )
		   strins( Str, ",", 1, sizeof( Str ) ),
		   strins( Str, ",", 5, sizeof( Str ) ),
		   strins( Str, ",", 9, sizeof( Str ) );
	  else format( Str, 10, "%d", number );
   }
   return Str;
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
	if(!strcmp(DOF2_GetString(String,VagasORG[0]),"Nenhum",true))return notificacao(playerid, "ERRO", "Nao tem um lider nessa org.", ICONE_ERRO);
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
	notificacao(playerid, "INFO", "Foi expulsado.", ICONE_AVISO);
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
		orG = "Exercito";
	}
	if(org == 3)
	{
		orG = "Policia Federal";
	}
	if(org == 4)
	{
		orG = "BOPE";
	}
	if(org == 5)
	{
		orG = "Ballas";
	}
	if(org == 6)
	{
		orG = "Los Aztecas";
	}
	if(org == 7)
	{
		orG = "Los Vagos";
	}
	if(org == 8)
	{
		orG = "Reportagem";
	}
	if(org == 9)
	{
		orG = "Groove Street";
	}
	if(org == 10)
	{
		orG = "Republica";
	}
	if(org == 11)
	{
		orG = "Mafia Triad";
	}
	if(org == 12)
	{
		orG = "Mafia Russa";
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
		if(IsPlayerInRangeOfPoint(playerid, 2.0, px, py, pz))
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
	if(PlayerInfo[playerid][pAdmin] == 0) { LipeStrondaAdmin = "Civil"; }
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
	else if(PlayerInfo[playerid][pProfissao] == 2) { LipeStrondaProfs = "Coveiro"; }
	else if(PlayerInfo[playerid][pProfissao] == 3) { LipeStrondaProfs = "Enfermeiro"; }
	else if(PlayerInfo[playerid][pProfissao] == 4) { LipeStrondaProfs = "Caminhoneiro"; }
	else if(PlayerInfo[playerid][pProfissao] == 5) { LipeStrondaProfs = "Tranporte de Tumba"; }
	else if(PlayerInfo[playerid][pProfissao] == 6) { LipeStrondaProfs = "Construtor"; }
	else if(PlayerInfo[playerid][pProfissao] == 7) { LipeStrondaProfs = "Mecanico"; }
	return LipeStrondaProfs;
}

stock VIP(playerid)
{
	new LipeStrondaVIP[64];
	if(PlayerInfo[playerid][pVIP] != 0) { LipeStrondaVIP = "NENHUM"; }
	if(PlayerInfo[playerid][pVIP] == 1) { LipeStrondaVIP = "VIP PRATA"; }
	else if(PlayerInfo[playerid][pVIP] == 2) { LipeStrondaVIP = "VIP OURO"; }
	else if(PlayerInfo[playerid][pVIP] == 3) { LipeStrondaVIP = "VIP PATROCINADOR"; }
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
			notificacao(playerid, "INFO", "Seu beneficio expirou.", ICONE_AVISO);
		} 
		else 
		{ 
			format(string, sizeof(string), "Seu beneficio expira em %s.", convertNumber(PlayerInfo[playerid][ExpiraVIP]-gettime())); 
			notificacao(playerid, "INFO", string, ICONE_AVISO);
			SetPlayerColor(playerid, Amarelo);
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

	Actor[0] = CreateActor(217, 1685.058349, -2326.510742, 13.546875, 175.751434); 
	label[0] = Create3DTextLabel("{FFFFFF}Ola, Use {FFFF00}/ajuda {FFFFFF}para \nconhecer os comandos.", 0x008080FF, 1685.058349, -2326.510742, 13.546875, 15.0, 0);
	Attach3DTextLabelToPlayer(label[0], Actor[0], 0.0, 0.0, 0.7);

	Actor[1] = CreateActor(76, -501.242370, 296.501190, 2001.094970, 179.496414); 
	label[1] = Create3DTextLabel("{FFFF00}Prefeitura\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, -501.242370, 296.501190, 2001.094970, 15.0, 0);
	Attach3DTextLabelToPlayer(label[1], Actor[1], 0.0, 0.0, 0.7);

	Actor[2] = CreateActor(147, 1245.0440, -1650.9316, 17.028537, -95.5000);  
	label[2] = Create3DTextLabel("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1245.0440, -1650.9316, 17.028537, 15.0, 0);
	Attach3DTextLabelToPlayer(label[2], Actor[2], 0.0, 0.0, 0.7);

	Actor[3] = CreateActor(147, 1244.7418, -1675.3851, 17.028537, -95.5000);  
	label[3] = Create3DTextLabel("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1244.7418, -1675.3851, 17.028537, 15.0, 0);
	Attach3DTextLabelToPlayer(label[3], Actor[3], 0.0, 0.0, 0.7);

	Actor[4] = CreateActor(147, 1244.9561, -1669.2781, 17.028537, -95.5000);  
	label[4] = Create3DTextLabel("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1244.9561, -1669.2781, 17.028537, 15.0, 0);
	Attach3DTextLabelToPlayer(label[4], Actor[4], 0.0, 0.0, 0.7);

	Actor[9] = CreateActor(147, 1244.9105, -1663.0659, 17.028537, -95.5000);  
	label[9] = Create3DTextLabel("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1244.9105, -1663.0659, 17.028537, 15.0, 0);
	Attach3DTextLabelToPlayer(label[9], Actor[9], 0.0, 0.0, 0.7);

	Actor[21] = CreateActor(147, 1244.8408, -1657.1215, 17.028537, -95.5000);  
	label[21] = Create3DTextLabel("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1244.8408, -1657.1215, 17.028537, 15.0, 0);
	Attach3DTextLabelToPlayer(label[21], Actor[21], 0.0, 0.0, 0.7);

	Actor[5] = CreateActor(155, 376.4162, -117.2733, 1001.4922, 180.0);  
	label[5] = Create3DTextLabel("{FFFF00}Pizzaria.\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 376.4162, -117.2733, 1001.4922, 15.0, 0);
	Attach3DTextLabelToPlayer(label[5], Actor[5], 0.0, 0.0, 0.7);

	Actor[6] = CreateActor(182, 1345.0359,-1761.5284,13.5992,180.0017);  
	label[6] = Create3DTextLabel("{FFFF00}Loja 24/7\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1345.0359,-1761.5284,13.5992, 15.0, 0);
	Attach3DTextLabelToPlayer(label[6], Actor[6], 0.0, 0.0, 0.7);

	Actor[7] = CreateActor(182, -30.870576, -30.705114, 1003.557250, 3.0);  
	label[7] = Create3DTextLabel("{FFFF00}Loja 24/7\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, -30.870576, -30.705114, 1003.557250, 15.0, 0);
	Attach3DTextLabelToPlayer(label[7], Actor[7], 0.0, 0.0, 0.7);

	Actor[8] = CreateActor(194, 617.928100, -1.965069, 1001.040832, 185.973175);  
	label[8] = Create3DTextLabel("{FFFF00}Agencia de Emprego\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 617.928100, -1.965069, 1001.040832, 15.0, 0);
	Attach3DTextLabelToPlayer(label[8], Actor[8], 0.0, 0.0, 0.7);

	Actor[10] = CreateActor(28, 514.767089, -2334.465820, 508.693756,1.0);  
	label[10] = Create3DTextLabel("{FFFF00}Loja Ilegal\n{FFFFFF}Use '{00FFFF}F{FFFFFF}' para abrir o menu.", 0x008080FF, 514.767089, -2334.465820, 508.693756, 15.0, 0);
	Attach3DTextLabelToPlayer(label[10], Actor[10], 0.0, 0.0, 0.7);

	Actor[11] = CreateActor(147, 1526.1862,-1798.9884,16.8121, 92.23461);  
	label[11] = Create3DTextLabel("{FFFF00}Banco Central\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1526.1862,-1798.9884,17.028537, 15.0, 0);
	Attach3DTextLabelToPlayer(label[11], Actor[11], 0.0, 0.0, 0.7); 

	Actor[12] = CreateActor(165, 1322.202148, -1168.256591, 23.911737, 5.436280);  
	label[12] = Create3DTextLabel("{FFFF00}Auto Escola\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para abrir o menu.", 0x008080FF, 1322.202148, -1168.256591, 23.911737, 15.0, 0);
	Attach3DTextLabelToPlayer(label[12], Actor[12], 0.0, 0.0, 0.7); 

	Actor[13] = CreateActor(35, 376.6558,-2056.4216,8.0156, 3.0);  
	label[13] = Create3DTextLabel("{FFFF00}Pescador\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 376.6558,-2056.4216,8.0156, 15.0, 0);
	Attach3DTextLabelToPlayer(label[13], Actor[13], 0.0, 0.0, 0.7);

	Actor[14] = CreateActor(35, 357.781768, -2031.161865, 7.835937, 264.071380);  
	label[14] = Create3DTextLabel("{FFFF00}Loja de Pescados\n{FFFFFF}Use o {FFFF00}Inventario{FFFFFF}' para vender.", 0x008080FF, 357.781768, -2031.161865, 7.835937, 15.0, 0);
	Attach3DTextLabelToPlayer(label[14], Actor[14], 0.0, 0.0, 0.7);

	Actor[15] = CreateActor(34, 818.8176,-1106.7904,25.7940, 4.0);  
	label[15] = Create3DTextLabel("{FFFF00}Coveiro\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 818.8176,-1106.7904,25.7940, 15.0, 0);
	Attach3DTextLabelToPlayer(label[15], Actor[15], 0.0, 0.0, 0.7);

	Actor[16] = CreateActor(274, 1174.452636, -1312.022338, -44.283576, 87.023475);  
	label[16] = Create3DTextLabel("{FFFF00}Enfermeiro\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 1174.452636, -1312.022338, -44.28357, 15.0, 0);
	Attach3DTextLabelToPlayer(label[16], Actor[16], 0.0, 0.0, 0.7);

	Actor[17] = CreateActor(78, -74.9909,-1135.9198,1.0781, 335.0);  
	label[17] = Create3DTextLabel("{FFFF00}Caminhoneiro\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, -74.9909,-1135.9198,1.0781, 15.0, 0);
	Attach3DTextLabelToPlayer(label[17], Actor[17], 0.0, 0.0, 0.7);

	Actor[18] = CreateActor(188, 937.6857,-1085.2791,24.2891,180.9397);  
	label[18] = Create3DTextLabel("{FFFF00}Tranporte de Tumba\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 937.6857,-1085.2791,24.2891, 15.0, 0);
	Attach3DTextLabelToPlayer(label[18], Actor[18], 0.0, 0.0, 0.7);

	Actor[19] = CreateActor(188, 1282.408813, -1296.472167, 13.368761, 98.212844);  
	label[19] = Create3DTextLabel("{FFFF00}Construtor\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 1282.408813, -1296.472167, 13.368761, 15.0, 0);
	Attach3DTextLabelToPlayer(label[19], Actor[19], 0.0, 0.0, 0.7);

	Actor[20] = CreateActor(50, 1974.8208,-1779.0802,13.5432,91.2385);  
	label[20] = Create3DTextLabel("{FFFF00}Mecanico\n{FFFFFF}Use '{FFFF00}F{FFFFFF}' para pegar o emprego.", 0x008080FF, 1974.8208,-1779.0802,13.5432, 15.0, 0);
	Attach3DTextLabelToPlayer(label[20], Actor[20], 0.0, 0.0, 0.7);
	// HOSPITAL
	CreateDynamicActor(14, 1162.4888,-1317.6584,-44.2763,184.1570,1);
	CreateDynamicActor(38, 1163.7817,-1317.7325,-44.2763,178.7385,1);
	CreateDynamicActor(216, 1170.5933,-1316.8535,-44.2836,1.8186,1);
	CreateDynamicActor(89, 1175.0618,-1328.4419,-44.2763,0.8491,1);
	CreateDynamicActor(78, 1175.4545,-1330.4432,-44.2836,0.1106,1);
	CreateDynamicActor(77, 1173.4073,-1330.3613,-44.2763,359.9097,1);
	CreateDynamicActor(276, 1172.2578,-1330.1912,-44.2836,263.2446,1);
	CreateDynamicActor(70,  1152.3639,-1324.5789,-44.2836,210.2227,1);
	CreateDynamicActor(10,  1151.2439,-1313.3135,-43.3857,87.2187,1);
	CreateDynamicActor(220,  1149.9236,-1313.0739,-43.3857,262.8163,1);
	CreateDynamicActor(222,  1150.2721,-1310.6918,-43.3857,89.1543,1);
	CreateDynamicActor(240,  1161.9667,-1326.1674,-44.2836,89.3729,1);
	CreateDynamicActor(275,  1152.3860,-1312.7823,-44.2836,89.0595,1);
	CreateDynamicActor(76,  1164.7887,-1325.1915,-44.2836,357.7768,1);
	CreateDynamicActor(275,  1158.9094,-1313.6294,-44.2836,323.2950,1);
	CreateDynamicActor(70,  1160.3220,-1313.4536,-44.2836,353.6012,1);
	CreateDynamicActor(274,  1161.4368,-1313.4595,-44.2836,37.2423,1);
	CreateDynamicActor(162,  1160.3904,-1312.7845,-43.2287,356.2141,1);
	CreateDynamicActor(308,  1163.5415,-1327.3192,-44.2836,180.7570,1);
	CreateDynamicActor(308,  1163.2001,-1314.2628,-44.2836,298.5011,1);
	CreateDynamicActor(70,  1166.0807,-1326.8601,-44.2836,270.6365,1);
	CreateDynamicActor(308,  1170.5376,-1315.0913,-44.2836,178.1753,1);
	CreateDynamicActor(306,  1172.9111,-1315.0123,-44.2836,176.6414,1);
	CreateDynamicActor(150,  1175.0746,-1315.0142,-44.2836,180.2010,1);
	CreateDynamicActor(70, 1163.6564,-1329.6337,-44.2836,1.1118,1);
	CreateDynamicActor(70, 1162.4279,-1329.7173,-44.2836,356.2107,1);
	CreateDynamicActor(12, 1161.9567,-1339.4816,-44.2836,1.1868,1);
	CreateDynamicActor(90, 1173.8785,-1341.4683,-44.2836,2.9074,1);
	CreateDynamicActor(91, 1175.0562,-1341.0431,-44.2836,89.5660,1);
	CreateDynamicActor(93, 1173.8239,-1336.6687,-44.2836,0.3774,1);
	CreateDynamicActor(274, 1161.9514,-1337.6799,-44.2836,180.2219,1);
	CreateDynamicActor(219, 1165.4480,-1330.0576,-43.6433,84.6880,1);
	CreateDynamicActor(240, 1160.5548,-1329.8822,-43.6432,89.2106, 1);
	// CASINO
	CreateDynamicActor(11, 1677.515625, -2294.236328, 13.539777, 264.095306, 1);
	CreateDynamicActor(172, 1687.8646, -2294.1325, 13.3542, 90.5000, 1);
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
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}baniu o jogador {FFFF00}%s. {FFFFFF}Motivo: {FFFF00}%s", Name(playerid), Name(administrador), Motivo1);
	SendClientMessageToAll(VermelhoEscuro, Str);
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
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}baniu o jogador {FFFF00}%s{FFFFFF}. Motivo: {FFFF00}%s", Name(playerid), Name(administrador), Motivo1);
	SendClientMessageToAll(VermelhoEscuro, Str);
	Log("Logs/BanirIP.ini", Str);
	Kick(playerid);
	return 1;
}

stock ZerarDados(playerid)
{
	PlayerInfo[playerid][pSkin] = 0;
	PlayerInfo[playerid][pDinheiro] = 0;
	PlayerInfo[playerid][pBanco] = 0;
	PlayerInfo[playerid][pIdade] = 0;
	PlayerInfo[playerid][pSegundosJogados] = 0;
	PlayerInfo[playerid][pAvisos] = 0;
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
	ItemOpcao[playerid] = 0;
	TemCinto[playerid] = false;
	Susurrando[playerid] = false;
	Falando[playerid] = false;
	Gritando[playerid] = false;
	PlantandoMaconha[playerid] = false;
	RoubandoCaixa[playerid] = false;
	Moved[playerid] = false;
	FirstLogin[playerid] = false;
	SpawnPos[playerid] =  false;
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
	ltumba[playerid] = false;
	RecentlyShot[playerid] = 0;
	InventarioAberto[playerid] = 0;
	SetPlayerColor(playerid, 0xFFFFFFFF);
	SetPlayerSkillLevel(playerid,WEAPONSKILL_PISTOL,200);
	SetPlayerSkillLevel(playerid,WEAPONSKILL_MICRO_UZI,200);
	SetPlayerSkillLevel(playerid,WEAPONSKILL_SNIPERRIFLE,200);
	return 1;
}

stock SalvarDados(playerid)
{
	new File[255];
	new Data[24], Dia, Mes, Ano, Hora, Minuto, Float:A, Float:X, Float:Y, Float:Z;
	GetPlayerCameraPos(playerid, X, Y, Z);
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, A);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);

	format(File, sizeof(File), PASTA_CONTAS, PlayerName(playerid));
	if(DOF2_FileExists(File))
	{
		DOF2_SaveFile();
		DOF2_SetInt(File, "IDF", PlayerInfo[playerid][IDF]);
		DOF2_SetInt(File, "pDinheiro", PlayerInfo[playerid][pDinheiro]);
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
		DOF2_SaveFile();
	}
	return 1;
}

stock SalvarDadosSkin(playerid)
{
	new File[255];
	new Data[24], Dia, Mes, Ano, Hora, Minuto, Float:A, Float:X, Float:Y, Float:Z;
	GetPlayerCameraPos(playerid, X, Y, Z);
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	GetPlayerFacingAngle(playerid, A);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);

	format(File, sizeof(File), PASTA_CONTAS, PlayerName(playerid));
	if(DOF2_FileExists(File))
	{
		DOF2_SaveFile();
		DOF2_SetInt(File, "pSkin", GetPlayerSkin(playerid));
		DOF2_SetInt(File, "pDinheiro", PlayerInfo[playerid][pDinheiro]);
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
	new pNome[MAX_PLAYER_NAME];
	GetPlayerName(playerid, pNome, 24);
	return pNome;
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
		return notificacao(playerid, "INFO", string, ICONE_AVISO);
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
#include 		"../modulos/pickup3dlabel.inc"
#include 		"../modulos/txdglobal.inc"

public OnGameModeInit()
{
	// CONFIG
	AntiDeAMX();
	SetGameModeText("Roleplay");
	SendRconCommand("mapname Los Santos");

	ShowPlayerMarkers(0);
	DisableInteriorEnterExits();
	EnableStuntBonusForAll(0);
	UsePlayerPedAnims();
	ShowNameTags(0);
	SetNameTagDrawDistance(30.0);
	AllowInteriorWeapons(1);
	ManualVehicleEngineAndLights();

	// CARREGAMENTOS

	NpcText();
	ORGCarrega();
	CarregarMapIcons();
	CarregarCaixas();
	CarregarPickup3dLabel();
	CarregarTxdGlobal();
	LoadVehicles();
	LoadDealerships();
	LoadFuelStations();
	LoadSlotMachines();
	CarregarMapas();
	LoadCofreOrg();
	CarregarPlantacao();
	CriarCasas();	
	CriarRadares();
	CreateTelaLogin();
	TextDrawBase();
	//SvDebug(SV_TRUE);
	
	gstream = SvCreateGStream(0xFF0000FF, "[]");
	for(new i = 0; i < MAX_FREQUENCIAS; i++)
	{
		Frequencia[i] = SvCreateGStream(0xFF5800FF, "Radio");
	}
	for(new j; j < MAX_ORGS; j++)
	{
	    CarregarCofre(j);
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
	for(new i; i < 6; i++)
	{
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}H{FFFFFF}'para \npegar um veiculo.", -1, PosVeiculos[i][0], PosVeiculos[i][1], PosVeiculos[i][2], 10.0);
		CreateDynamicPickup(1083, 23, PosVeiculos[i][0], PosVeiculos[i][1], PosVeiculos[i][2]); // Veh Spawn
	}
	for(new i; i < 1; i++)
	{
		CreateDynamicPickup(1275, 23, PosEquipar[i][0], PosEquipar[i][1], PosEquipar[i][2]);
	}
	for(new i; i < 4; i++)
	{
		CreateDynamicPickup(1314, 23, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]);
	}
	for(new i; i < 10; i++)
	{
		CreateDynamic3DTextLabel("{FFFFFF}Use a'{FFFF00}Vara de Pescar{FFFFFF}'para\ncomecar a pescar.", -1, PosPesca[i][0], PosPesca[i][1], PosPesca[i][2], 15.0);
	}

	for(new i; i < 1; i++)
	{
		CreateDynamicPickup(19606,23,PosPrender[i][0],PosPrender[i][1],PosPrender[i][2],0);
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}/prender{FFFFFF}'para \nprender o jogador.",-1,PosPrender[i][0],PosPrender[i][1],PosPrender[i][2],15);
	}

	for(new i; i < 7; i++)
	{
		CreateDynamicPickup(19606,23,Entradas[i][0],Entradas[i][1],Entradas[i][2],0);
		CreateDynamic3DTextLabel("{FFFFFF}Use '{FFFF00}Y{FFFFFF}'para \nentrar no interior.",-1,Entradas[i][0],Entradas[i][1],Entradas[i][2],15);
	}
	TimerRelogio = SetTimer("Relogio",1000,true);
	TimerCadeia = SetTimer("CheckCadeia", 2000, true);
	TimerAfk = SetTimer("AntiAway", minutos(10), true);
	TimerMaconha = SetTimer("UpdateDrogas", minutos(15), true);
	TimerMensagemAuto = SetTimer("SendMSG", minutos(2), true);
	maintimer = SetTimer("MainTimer", 1000, true);
	savetimer = SetTimer("SaveTimer", 2222, true);
	return 1;
}

public OnGameModeExit()
{
	printf("\n\nSalvando Dados...");
	KillTimer(maintimer);
	KillTimer(savetimer);
	KillTimer(TimerRelogio);
	KillTimer(TimerCadeia);
	KillTimer(TimerAfk);
	KillTimer(TimerMaconha);
	KillTimer(TimerMensagemAuto);
	SalvarPlantacao();
	IniciarCasas = 0;
	IniciarRadares = 0;
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && pLogado[i] == true) SalvarDados(i);
	}
	for(new i = 0; i < MAX_FREQUENCIAS; i++)
	{
		SvDeleteStream(Frequencia[i]);
	}
	for(new i; i < MAX_ORGS; i++)
	{
	    SalvarCofre(i);
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
	print("Dados salvos. Desligado...");
	DOF2_Exit();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	ZerarDados(playerid);
	for(new t=0;t<17;t++){
		TextDrawShowForPlayer(playerid, Loadsc[t]);
	}
	PlayerTextDrawShow(playerid, Loadsc_p[playerid][0]);
	ShowPlayerProgressBar(playerid, Loadsc_b[playerid][0]);
    TogglePlayerSpectating(playerid, true);
    TimerLogin[playerid] = SetTimerEx("mostrarTelaLogin", 50, false, "d", playerid);
 	PlayerPlaySound(playerid, 1098, 0.0, 0.0, 0.0);
	LimparChat(playerid, 10);
  	InterpolateCameraPos(playerid, 987.909362, -1712.450805, 47.442787, 1238.741821, -1714.237304, 28.193325, 50000);
	InterpolateCameraLookAt(playerid, 992.657348, -1712.335937, 45.879596, 1239.015380, -1710.006103, 25.543354, 60000);
	LimparChat(playerid, 10);
	return 0;
}

public OnPlayerConnect(playerid)
{	
	new string[255];
	format(string,sizeof(string),"%s entrou no servidor!", Name(playerid));
	DCC_SendChannelMessage(EntradaeSaida, string);
	todastextdraw(playerid);
	if(!SvGetVersion(playerid))
	{

	}
	else if(!SvHasMicro(playerid))
	{

	}
	else
	{
		Falando[playerid] = true;
 		lstream[playerid] = SvCreateDLStreamAtPlayer(15.0, SV_INFINITY, playerid, 0xff0000ff, "L");
		Susurrandos[playerid] = SvCreateDLStreamAtPlayer(5.0, SV_INFINITY, playerid, 0xff0000ff, "L");
		Gritandos[playerid] = SvCreateDLStreamAtPlayer(30.0, SV_INFINITY, playerid, 0xff0000ff, "L");
  		SendClientMessage(playerid, -1, "SAMPVOICE carregado");
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
		new string[255];
		format(string,sizeof(string),"%s saiu do servidor!", Name(playerid));
		DCC_SendChannelMessage(EntradaeSaida, string);
		SalvarDados(playerid);
		SalvarMortos(playerid);
		SalvarMissoes(playerid);
		SalvarInventario(playerid);
		SalvarArmas(playerid);
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
	for(new i = 0; i < 8; i++)
	{
		TextDrawHideForPlayer(playerid, Logo[i]);
	}
	PlayerTextDrawDestroy(playerid, Textdraw2[playerid]);
	ZerarDados(playerid);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	//
	TogglePlayerSpectating(playerid, false);
	TogglePlayerControllable(playerid, true);
	SetTimerEx("Attplayer",1000,true,"i",playerid);
	for(new idx=0; idx<6; idx++)
	{
    	PlayerTextDrawHide(playerid,TextDrawMorte[playerid][idx]); 
	}
	if(GetPVarInt(playerid, "PlayMine") == 1) HideCasinoTDs(playerid);
	if(SpawnPos[playerid] == true) 
	{
		SetPlayerPos(playerid, PlayerInfo[playerid][pPosX], PlayerInfo[playerid][pPosY], PlayerInfo[playerid][pPosZ]);
		SetPlayerFacingAngle(playerid, PlayerInfo[playerid][pPosA]);
		SetPlayerCameraPos(playerid, PlayerInfo[playerid][pCamX], PlayerInfo[playerid][pCamY], PlayerInfo[playerid][pCamZ]);
		SetPlayerInterior(playerid, PlayerInfo[playerid][pInterior]);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		SpawnPos[playerid] = false;	 
	}
	else if(PlayerInfo[playerid][Casa] >= 0)
	{
		PlayerInfo[playerid][Entrada] = PlayerInfo[playerid][Casa];
		SetPlayerPos(playerid, CasaInfo[PlayerInfo[playerid][Casa]][CasaInteriorX], CasaInfo[PlayerInfo[playerid][Casa]][CasaInteriorY], CasaInfo[PlayerInfo[playerid][Casa]][CasaInteriorZ]);
		SetPlayerInterior(playerid, CasaInfo[PlayerInfo[playerid][Casa]][CasaInterior]);
		SetPlayerVirtualWorld(playerid, PlayerInfo[playerid][Casa]);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		SpawnPos[playerid] = false;
	}
    if(PlayerMorto[playerid][pEstaMorto] == 1)
    {
        if(PlayerMorto[playerid][pSegMorto] <= 0)
        {
            PlayerMorto[playerid][pSegMorto] = 60;
        }
        SalvarMortos(playerid);
        for(new idx=0; idx<6; idx++)
        {
       	 	PlayerTextDrawShow(playerid,TextDrawMorte[playerid][idx]);
    	}
        TimerMorto[playerid] = SetTimerEx("mortoxx", 1000, 1, "i", playerid);
        ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.1, 1, 0, 0, 0, 13000, 1);
    }
	new File[255];
	format(File, 56, PASTA_AGENDADOS, Name(playerid));
	if(DOF2_FileExists(File))
	{
		format(Str, sizeof(Str), "O Administrador %s te deu %i minuto(s) de cadeia. Motivo(s): %s", DOF2_GetString(File, "Administrador"), DOF2_GetInt(File, "Tempo"), DOF2_GetString(File, "Motivo"));
		notificacao(playerid, "INFO", Str, ICONE_AVISO);
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
			notificacao(playerid, "INFO", "Seu beneficio expirou.", ICONE_AVISO);
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
	if(TemCinto[playerid] == false){
		new Float:PosP[4], Float:HV;
		GetPlayerPos(playerid, PosP[0], PosP[1], PosP[2]);
		GetPlayerFacingAngle(playerid, PosP[3]);
		GetVehicleHealth(vehicleid,HV);
		SetPlayerHealth(playerid,HV/10);
		SetPlayerPos(playerid,PosP[0]+2,PosP[1]+2,PosP[2]+1);
		SetPlayerFacingAngle(playerid, PosP[3]);
		RemovePlayerFromVehicle(playerid);
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
		ApplyAnimation(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0);
		GameTextForPlayer(playerid, "~r~Voce esta tonto ~n~Aguarde...", 3000, 4);
		SetTimerEx("CANIM",5000,false,"i",playerid);
    }
	return 1;
}

public OnPlayerText(playerid, text[])
{
	if(gettime() < UltimaFala[playerid] + SEGUNDOS_SEM_FALAR)
	{
		Erro[playerid]++;
		format(Str, sizeof(Str), "Esta falando muito rapido (AVISO %i/10)", Erro[playerid]);
		notificacao(playerid, "INFO",Str, ICONE_AVISO);
		if(Erro[playerid] == 10) Kick(playerid);
		return 0;
	}
	if(ChatLigado == false)
	{
		notificacao(playerid, "ERRO", "O chat esta desativado.", ICONE_ERRO);
		return 0;
	}
	if(PlayerInfo[playerid][pCalado] == true)
	{
		notificacao(playerid, "ERRO", "Esta calado e nao podera falar.", ICONE_ERRO);
		return 0;
	}
	format(Str, sizeof(Str), "%s %s", Name(playerid), text);
	Log("Logs/FalaTodos.ini", Str);
	Moved[playerid] = true;
	//
	UltimaFala[playerid] = gettime();
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao esta conectado", ICONE_AVISO);
	{
		new string[128];
		format(string, sizeof(string), "%s(%04d{FFFF00}%d{FFFFFF}) falou {FFFF00}%s",Name(playerid), PlayerInfo[playerid][IDF],playerid,text);
		ProxDetector(30.0, playerid, string, -1, -1, -1, -1, -1);

		format(string,sizeof(string),"%s falou %s", Name(playerid), text);
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
			notificacao(playerid, "INFO", msg, ICONE_AVISO);
		}
	}
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new IdVeiculo = GetPlayerVehicleID(playerid);
		if(GetVehicleModel(IdVeiculo) != 481)
		{
			new motor, luzes, alarmev, portas, capo, mala, objective;
			GetVehicleParamsEx(vehicleid, motor, luzes, alarmev, portas, capo, mala, objective);
			SetVehicleParamsEx(vehicleid, false, luzes,alarmev, portas, capo, mala, objective);
			MotorOn[playerid] = 0;
		}
	}
	if(TemCinto[playerid] == false){
		for(new x=0;x<5;x++){
			TextDrawShowForPlayer(playerid, Tdcinto[x]);
		}
	}
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new motor, luzes, alarmev, portas, capo, mala, objective;
		GetVehicleParamsEx(vehicleid, motor, luzes, alarmev, portas, capo, mala, objective);
		SetVehicleParamsEx(vehicleid, false, luzes,alarmev, portas, capo, mala, objective);
		MotorOn[playerid] = 0;
	}
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

			notificacao(playerid, "AVISO", "Reprovou pos saiu do veiculo.", ICONE_AVISO);
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

			notificacao(playerid, "AVISO", "Reprovou pos saiu do veiculo.", ICONE_AVISO);
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

			notificacao(playerid, "AVISO", "Reprovou pos saiu do veiculo.", ICONE_AVISO);

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

			notificacao(playerid, "AVISO", "Reprovou pos saiu do veiculo.", ICONE_AVISO);
		}
	}
	if(TemCinto[playerid] == true){
		new string3[128];
		TemCinto[playerid] = false;
		format(string3, sizeof(string3), "** %s tirou o cinto de seguranca", Name(playerid));
		ProxDetector(20.0, playerid, string3, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		notificacao(playerid, "EXITO", "Cinto de seguranca removido", ICONE_CERTO);
	}else{
		for(new x=0;x<5;x++){
			TextDrawHideForPlayer(playerid, Tdcinto[x]);
		}
	}
	return 1;
}

public OnPlayerCommandReceived(playerid, cmdtext[])
{
	return 1;
}

public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
	if(!success)return notificacao(playerid, "ERRO", "Comando desconhecido",ICONE_ERRO);
	return 0x01;
}


public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(oldstate == PLAYER_STATE_ONFOOT && newstate == PLAYER_STATE_DRIVER)//O jogador entrou no veiculo como motorista
    {
		if(mostrandovelo[playerid] == 0){
			for(new t=0;t<52;t++){
  				TextDrawShowForPlayer(playerid,VeloC_G[t]);
			}
			for(new t=0;t<10;t++){
  				PlayerTextDrawShow(playerid,VeloC[playerid][t]);
			}
			mostrandovelo[playerid] = 1;
		}
		
		TimerVelo[playerid] = SetTimerEx("VelocimetroEx", 50, true, "d", playerid);
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
			notificacao(playerid, "INFO", Str, ICONE_AVISO);
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
	if(GPS[playerid] == true) 
	{ 
		DisablePlayerCheckpoint(playerid);
		GPS[playerid] = false;
	}
	if(Covaconcerto[playerid] == true) 
	{ 
		ApplyAnimation(playerid, "BOMBER", "BOM_Plant", 4.0, 1, 1, 0, 1, 0, 1);
		DisablePlayerCheckpoint(playerid); 
		TogglePlayerControllable(playerid, 0);
		CreateProgress(playerid, "Cova","Concertando cova...", 100);
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
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$600.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 600*2;
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$1200.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 600*2;
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$1200.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$1200.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 1200*2;
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$2400.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 1200*2;
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$2400.", ICONE_EMPREGO); 
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
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$2000.", ICONE_EMPREGO); 
			}   
			if(PlayerInfo[playerid][pVIP] == 2)
			{
				PlayerInfo[playerid][pDinheiro] += 2000*2;
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$4000.", ICONE_EMPREGO); 
			}
			if(PlayerInfo[playerid][pVIP] == 3)
			{
				PlayerInfo[playerid][pDinheiro] += 2000*2;
				notificacao(playerid, "TRABALHO", "Terminou o trabalho e ganhou R$4000.", ICONE_EMPREGO); 
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
			notificacao(playerid, "TRABALHO", constrstr, ICONE_EMPREGO); 
		}   
		if(PlayerInfo[playerid][pVIP] == 2)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale*2;
			format(constrstr,sizeof(constrstr),"Ganhou %i com este material.", dinmateriale*2);
			notificacao(playerid, "TRABALHO", constrstr, ICONE_EMPREGO); 
		}
		if(PlayerInfo[playerid][pVIP] == 3)
		{
			PlayerInfo[playerid][pDinheiro] += dinmateriale*2;
			format(constrstr,sizeof(constrstr),"Ganhou %i com este material.", dinmateriale*2);
			notificacao(playerid, "TRABALHO", constrstr, ICONE_EMPREGO); 
		}
		DisablePlayerCheckpoint(playerid);
		PegouMaterial[playerid] = false;
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoA[playerid] = 0;
						GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);

						notificacao(playerid, "AVISO", "Reprovou no teste de licenca.", ICONE_ERRO);
						GameTextForPlayer(playerid, "~w~Desa~r~probado!", 5000, 0);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoA[playerid] = 0;

						notificacao(playerid, "INFO", "Aprovado no teste de licenca.", ICONE_CERTO);
						GanharItem(playerid, 1853, 1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~A~g~probado!", 5000, 0);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoB[playerid] = 0;
						GameTextForPlayer(playerid, "~r~Reprovou!", 5001, 6);

						notificacao(playerid, "AVISO", "Reprovou no teste de licenca.", ICONE_ERRO);
						GameTextForPlayer(playerid, "~w~Desa~r~probado!", 5000, 0);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoB[playerid] = 0;

						notificacao(playerid, "INFO", "Aprovado no teste de licenca.", ICONE_CERTO);
						GanharItem(playerid, 1854, 1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~A~g~probado!", 5000, 0);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoC[playerid] = 0;

						notificacao(playerid, "AVISO", "Reprovou no teste de licenca.", ICONE_ERRO);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoC[playerid] = 0;

						notificacao(playerid, "INFO", "Aprovado no teste de licenca.", ICONE_CERTO);
						GanharItem(playerid, 1855, 1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~Para~g~bens!", 5000, 0);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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
					notificacao(playerid, "INFO", "Va ate o proximo ponto", ICONE_CERTO);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoD[playerid] = 0;

						notificacao(playerid, "AVISO", "Reprovou no teste de licenca.", ICONE_ERRO);
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

						SetPlayerPos(playerid, 1322.5415,-1166.1248,23.9117);
						SetPlayerInterior(playerid, 0);
						TogglePlayerControllable(playerid, false);
						SetTimerEx("carregarobj", 5000, 0, "i", playerid);
						IniciouTesteHabilitacaoD[playerid] = 0;

						notificacao(playerid, "INFO", "Aprovado no teste de licenca.", ICONE_CERTO);
						GanharItem(playerid, 1856,1);
						MissaoPlayer[playerid][MISSAO5] = 1;
						GameTextForPlayer(playerid, "~w~A~g~probado!", 5000, 0);
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
					if(keys & KEY_CTRL_BACK)
					{
						GranaRoubo(playerid, i);
						DestroyPickup(pickupid);
						Pickups_Roubo[i][p] = -1;
					}
					else
					{
						GameTextForPlayer(playerid, "~b~~h~USE |~w~H~b~~h~| para pegar o ~b~~h~dinheiro", 1000, 1);
					}
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
	new String[128], Float:PozX, Float:PozY, Float:PozZ;
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
		if(PlayerToPoint(3.0, playerid, 1683.126831, -2312.236816, 13.546875))
		{
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(462, 1683.126831, -2312.236816, 13.546875, 90, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
				MissaoPlayer[playerid][MISSAO12] = 1;
				
			}
			else
			{
				notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
			}
		}
		else if(PlayerToPoint(3.0, playerid, 1179.630615, -1339.028686, 13.838010))
		{
			if(PlayerInfo[playerid][pProfissao] != 3)    		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(416, 1179.630615, -1339.028686, 13.838010, 272.896881, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
			}
			else
			{
				notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
			}
		}
		else if(PlayerToPoint(3.0, playerid, -47.1722,-1143.3977,1.0781))
		{
			if(PlayerInfo[playerid][pProfissao] != 4)    		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(456, -47.260238, -1143.313598, 0.676024, 273.778228, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
			}
			else
			{
				notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
			}
		}
		else if(PlayerToPoint(3.0, playerid, 926.562072, -1075.043457, 23.885242))
		{
			if(PlayerInfo[playerid][pProfissao] != 5)    		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(442, 926.562072, -1075.043457, 23.885242, 273.778228, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
			}
			else
			{
				notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
			}
		}
		else if(PlayerToPoint(3.0, playerid, 2014.328125, -1770.929077, 13.543199))
		{
			if(PlayerInfo[playerid][pProfissao] != 7)    		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			if(VehAlugado[playerid] == 0)
			{
				VehAlugado[playerid] = 1;
				VeiculoCivil[playerid] = CreateVehicle(525, 2014.328125, -1770.929077, 13.543199, 88.247947, -1, -1, false);
				PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
				notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
			}
			else
			{
				notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
			}
		}
		for(new i; i < 1; i++)
		if(PlayerToPoint(3.0, playerid, PosPVeiculos[i][0], PosPVeiculos[i][1], PosPVeiculos[i][2]))
		{
			if(PlayerInfo[playerid][pProfissao] == 1)    
			{
				ShowPlayerDialog(playerid, DIALOG_2LIST, DIALOG_STYLE_LIST, "Selecionar um veiculo.", "{FFFF00}- {FFFFFF}CopCarla\t{FFFF00}596\n{FFFF00}- {FFFFFF}SwatVan\t{FFFF00}601\n{FFFF00}- {FFFFFF}CopBike\t{FFFF00}523", "Selecionar", "X");
			}
		}
	}
	if(newkeys == KEY_YES)
	{
		if(EditingSM[playerid] == 2)
		{
			GetPlayerPos(playerid, PozX, PozY, PozZ), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "PozX", PozX), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "PozY", PozY), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "PozZ", PozZ), DOF2_SaveFile();
			DestroyDynamic3DTextLabel(DataSlotMachine[SmID[playerid]][TextoSm]), DataSlotMachine[SmID[playerid]][TextoSm] = CreateDynamic3DTextLabel("{FF0033}Caca-niquel\n{FFFFFF}Pulsa F para jogar\n{FFFF00}/infocn", -1, PozX, PozY, PozZ, 100.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 0, 0, 0, -1, 10.0);
			format(String, sizeof(String), "Local da maquina: %i confirmado com exito.", SmID[playerid]), notificacao(playerid, "EXITO", String, ICONE_CERTO), EditingSM[playerid] = 0;
		}
		if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
		{
			new vehicleid = GetPlayerVehicleID(playerid);
			if(IsBicycle(vehicleid)) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
			new id = GetVehicleID(vehicleid);
			if(GetPlayerVehicleAccess(playerid, id) < 1)
				return notificacao(playerid, "ERRO", "Nao possui a chave do veiculo!", ICONE_ERRO);
			SetPVarInt(playerid, "DialogValue1", id);
			ShowDialog(playerid, DIALOG_VEHICLE);
		}
		else
		{
			//
		}
		//HOSPITAL ENTRADA
		if(IsPlayerInRangeOfPoint(playerid,2.0, 1172.0829,-1323.5533,15.4034))
		{
			SetPlayerPos(playerid,  1176.3602,-1326.3590,-44.2836);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//PIZZARIA ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 2105.4880,-1806.2786,13.5547))
		{
			SetPlayerPos(playerid,  372.2827,-133.5237,1001.4922);
			SetPlayerInterior(playerid, 5);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//SAN NEWS ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 649.326538, -1353.821166, 13.546194) || IsPlayerInRangeOfPoint(playerid,2.0, 649.283264, -1360.890258, 13.586422))
		{
			SetPlayerPos(playerid, -5465.766113, -4536.025878, 4051.079589);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//PREFEITURA ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 1122.706909, -2036.977539, 69.894248))
		{
			SetPlayerPos(playerid,  -501.1714,286.6785,2001.0950);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//AGENCIA ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 914.273193, -1004.627075, 37.979484))
		{
			SetPlayerPos(playerid,  617.5486,-25.6596,1000.9903);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//POLICIA DE PATRULLA ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 1555.4982,-1676.1260,16.1953))
		{
			SetPlayerPos(playerid, 350.7115,1834.2186,2241.5850);
			SetPlayerInterior(playerid, 1);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//MERCADO NEGRO ENTRADA
		else if(IsPlayerInRangeOfPoint(playerid,2.0, 2447.828125, -1962.687133, 13.546875))
		{
			SetPlayerPos(playerid,  504.942962, -2317.662597, 512.790771);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//SAN NEWS SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,-5465.766113, -4536.025878, 4051.079589))
		{
			SetPlayerPos(playerid, 649.326538, -1353.821166, 13.546194);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//HOSPITAL SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,1176.3602,-1326.3590,-44.2836))
		{
			SetPlayerPos(playerid, 1172.0829,-1323.5533,15.4034);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//PIZZARIA SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,372.2827,-133.5237,1001.4922))
		{
			SetPlayerPos(playerid, 2105.4880,-1806.2786,13.5547);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//PREFEITURA SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,-501.1714,286.6785,2001.0950))
		{
			SetPlayerPos(playerid, 1122.706909, -2036.977539, 69.894248);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//AGENCIA SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,617.5486,-25.6596,1000.9903))
		{
			SetPlayerPos(playerid, 914.273193, -1004.627075, 37.979484);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//POLICIA DE PATRULLA SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,350.7115,1834.2186,2241.5850))
		{
			SetPlayerPos(playerid, 1555.4982,-1676.1260,16.1953);
			SetPlayerInterior(playerid, 0);
			SetPlayerVirtualWorld(playerid, 0);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		}
		//MERCADO NEGRO SAIDA
		else if(IsPlayerInRangeOfPoint(playerid,2.0,504.942962, -2317.662597, 512.790771))
		{
			SetPlayerPos(playerid, 2447.828125, -1962.687133, 13.546875);
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
					format(gstring, sizeof(gstring), "{8B008B}Valor:{00FF00} %d\n\n", CasaInfo[c][CasaValor]);
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
		cmd_pegaritem(playerid);
		if(PlayerToPoint(3.0, playerid, 934.1115,-1103.3857,24.3118)){
			cmd_ltumba(playerid);
		}
		new Inv[5000], Nick[5000], orgid = GetPlayerOrg(playerid);
		for(new i; i < MAX_SLOTMACHINE; i++)
		{
			if(!DOF2_FileExists(GetSlotMachine(i))) continue;
			if(IsPlayerInRangeOfPoint(playerid, 1.0, DOF2_GetFloat(GetSlotMachine(i), "PozX"), DOF2_GetFloat(GetSlotMachine(i), "PozY"), DOF2_GetFloat(GetSlotMachine(i), "PozZ")) && EditingSM[playerid] == 0 && Playing[playerid] == false)
			{
				if(DataSlotMachine[i][Occupied] == true) return notificacao(playerid, "ERRO", "Esta maquina esta ocupada!", ICONE_ERRO);
				else
				{
					ShowPlayerDialog(playerid, DIALOG_SLOTMACHINE, DIALOG_STYLE_INPUT, "Maquina Caca-Niquel","{87CEFA}Introduza a quantidade quer deseja apostar\n\nAposta minima: {228B22}R${FFFFFF}1000","Confirmar","X"), Playing[playerid] = true, DataSlotMachine[SmID[playerid] = i][Occupied] = true;
					break;
				}
			}
		}
		if(IsPlayerInRangeOfPoint(playerid, 10.0, CofreInfo[orgid][CofrePosX], CofreInfo[orgid][CofrePosY], CofreInfo[orgid][CofrePosZ]))
		{
            if(IsBandido(playerid) && IsPolicial(playerid))
            {
				for(new ii = 0; ii != 20; ii++)
				{
					GetWeaponName(CofreArma[ii][orgid], Nick, 20);
					strcat(Inv, CofreArma[ii][orgid] > 0 ? (CofreArma[ii][orgid] == 18 ? ("{FFDC33}Cocktail Molotov") : (Nick)) : ("{FFDC33}(Vazio)"));
					strcat(Inv, "\n");
				}
				strcat(Inv, "Guardar Arma");
				ShowPlayerDialog(playerid, DIALOG_ARMAS2, DIALOG_STYLE_LIST, "Bau de Armas", Inv, "Selecionar", "X");
				return 1;
			}
            else
            {
                notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
                return 1;
            }
		}
		if(PlayerToPoint(3.0, playerid, -5467.627441, -4536.831054, 4046.774902))
		{
			if(PlayerInfo[playerid][Org] != 9) 		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			GivePlayerWeapon(playerid, 43, 20);
		}
		if(PlayerToPoint(3.0, playerid, 1972.6611,-1783.9337,13.5432))
		{
			if(PlayerInfo[playerid][pProfissao] != 7) 		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			ShowPlayerDialog(playerid, DIALOG_ARMARIOMEC, DIALOG_STYLE_LIST,"Menu Mecanico", "{FFFF00}- {FFFFFF}Caixa de Ferramientas\t{32CD32}R$800\n", "Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, -501.242370, 296.501190, 2001.094970))
		{
			ShowPlayerDialog(playerid, DIALOG_CARTORIO, DIALOG_STYLE_LIST,"Prefeitura", "{FFFF00}- {FFFFFF}Fazer Documentos\n{FFFF00}- {FFFFFF}Fazer Carteira de Trabalho\t{32CD32}R$8000", "Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, 514.767089, -2334.465820, 508.693756))
		{
			ShowPlayerDialog(playerid, DIALOG_TIENDAILEGAL, DIALOG_STYLE_LIST,"Loja Ilegal", "{FFFF00}- {FFFFFF}C4\t{32CD32}R$25000\n{FFFF00}- {FFFFFF}Sementes de Maconha\t{32CD32}R$1000", "Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, 1245.0440, -1650.9316, 19.3384) || PlayerToPoint(3.0, playerid, 1244.7418, -1675.3851, 19.3384) || PlayerToPoint(3.0, playerid,  1244.9561, -1669.2781, 19.3384) || PlayerToPoint(3.0, playerid, 1244.9105, -1663.0659, 19.3384) || PlayerToPoint(3.0, playerid, 1244.8408, -1657.1215, 19.3384))
		{
			if(TxdBAncoAb[playerid] == false)
			{
				for(new i; i < 66; i++)
				{
					TextDrawShowForPlayer(playerid, TDEditor_TD[i]);
				}
				for(new i; i < 6; i++)
				{
					PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
				}
				SelectTextDraw(playerid, 0xFF0000FF);
				TxdBAncoAb[playerid] = true;
			}
			else
			{
				for(new i; i < 66; i++)
				{
					TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
				}
				for(new i; i < 6; i++)
				{
					PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
				}
				CancelSelectTextDraw(playerid);
				TxdBAncoAb[playerid] = false;
			}
		}
		if(PlayerToPoint(3.0, playerid, 617.928100, -1.965069, 1001.040832))
		{
			MEGAString[0] = EOS;
			new string[128];
			format(string, sizeof(string), "{FFFF00}{FFFFFF} Profissao\t{FFFF00}Level\t{FFFFFF}Licencias\t{FFFF00}T.Trabajo\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Enfermeiro\t{FFFF00}0\t{FFFFFF}Licencia B\t{FFFF00}NECESSITA\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Caminhoneiro\t{FFFF00}+2\t{FFFFFF}Licencia C\t{FFFF00}NECESSITA\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Coveiro\t{FFFF00}1\t{FFFFFF}NAO NECESSITA\t{FFFF00}NAO NECESSITA\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Pescador\t{FFFF00}0\t{FFFFFF}NAO NECESSITA\t{FFFF00}NAO NECESSITA\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Tranportador de Tumba\t{FFFF00}2\t{FFFFFF}Licencia B\t{FFFF00}NAO NECESSITA\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Construtor\t{FFFF00}0\t{FFFFFF}NAO NECESSITA\t{FFFF00}NAO NECESSITA\n");
			strcat(MEGAString,string);
			format(string, sizeof(string), "{FFFF00}-{FFFFFF} Mecanico\t{FFFF00}0\t{FFFFFF}Licencia B\t{FFFF00}NAO NECESSITA\n");
			strcat(MEGAString,string);
			ShowPlayerDialog(playerid,DIALOG_SELTRABALHO,DIALOG_STYLE_TABLIST_HEADERS, "Profissoes", MEGAString,"Selecionar","X");
		}
		if(PlayerToPoint(3.0, playerid, 376.4162, -117.2733, 1001.4922))
		{
			ShowPlayerDialog(playerid, DIALOG_CATLANCHE, DIALOG_STYLE_LIST, "Pizzeria", "{FFFF00}- {FFFFFF}Alimentos\n{FFFF00}- {FFFFFF}Refrescos", "Selecionar", "X");
		}
		if(PlayerToPoint(2.0, playerid, 1322.5415,-1166.1248,23.9117))
		{
			new string[1000], mercada[1000];
			strcat(string, "Habilitacao\tValor\n");
			format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria A\t{00FF00}R$2.000\n");
			strcat(string, mercada);
			format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria B\t{00FF00}R$2.500\n");
			strcat(string, mercada);
			format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria C\t{00FF00}R$5.000\n");
			strcat(string, mercada);
			format(mercada, sizeof(mercada), "{FFFF00}- {BEBEBE}Categoria Aerea\t{00FF00}R$50.000");
			strcat(string, mercada);

			return ShowPlayerDialog(playerid, DIALOG_AUTO_ESCOLA, DIALOG_STYLE_TABLIST_HEADERS, "Auto Escola", string, "Confirmar", "X");
		}
		if(PlayerToPoint(3.0, playerid,  1345.0359,-1761.5284,13.5992))
		{
			ShowPlayerDialog(playerid, DIALOG_247, DIALOG_STYLE_LIST, "Loja 24/7", "{FFFF00}- {FFFFFF}Celular\t{32CD32}R$1200\n{FFFF00}- {FFFFFF}Capacete\t{32CD32}R$580\n{FFFF00}- {FFFFFF}Vara de pescar\t{32CD32}R$1200\n", "Selecionar", "X");
		}
		for(new i; i < 1; i++)
		if(PlayerToPoint(3.0, playerid, PosEquipar[i][0], PosEquipar[i][1], PosEquipar[i][2]))
		{
			if(!IsPolicial(playerid))						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			{
				PlayerTextDrawShow(playerid, HudCop[playerid][0]);
				PlayerTextDrawShow(playerid, HudCop[playerid][1]);
				PlayerTextDrawShow(playerid, HudCop[playerid][2]);
				PlayerTextDrawShow(playerid, HudCop[playerid][3]);
				SelectTextDraw(playerid, 0xFF0000FF);
				return 1;
			}
		}
		if(GetPlayerCaixa(playerid))
		{
			if(TxdBAncoAb[playerid] == false)
			{
				for(new i; i < 66; i++)
				{
					TextDrawShowForPlayer(playerid, TDEditor_TD[i]);
				}
				for(new i; i < 6; i++)
				{
					PlayerTextDrawShow(playerid, TDEditor_PTD[playerid][i]);
				}
				SelectTextDraw(playerid, 0xFF0000FF);
				TxdBAncoAb[playerid] = true;
			}
			else
			{
				for(new i; i < 66; i++)
				{
					TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
				}
				for(new i; i < 6; i++)
				{
					PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
				}
				CancelSelectTextDraw(playerid);
				TxdBAncoAb[playerid] = false;
			}
		}
		for(new i; i < 4; i++)
		if(PlayerToPoint(3.0, playerid, PosEquiparORG[i][0], PosEquiparORG[i][1], PosEquiparORG[i][2]))
		{
			if(PlayerInfo[playerid][Org] != 5)
			{
				format(String, sizeof(String), "{FFFFFF}Vezer equipar: {FFFF00}%i", CofreOrg[5][Equipar]);
				ShowPlayerDialog(playerid, DIALOG_COFREORG, DIALOG_STYLE_LIST, String, "{FFFF00}- {FFFFFF}Dinheiro Sujo\n{FFFF00}- {FFFFFF}Maconha\n{FFFF00}- {FFFFFF}Cocaina\n{FFFF00}- {FFFFFF}Sementes de Maconha", "Selecionar", "X");
			}
			if(PlayerInfo[playerid][Org] != 6)
			{
				format(String, sizeof(String), "{FFFFFF}Vezer equipar: {FFFF00}%i", CofreOrg[6][Equipar]);
				ShowPlayerDialog(playerid, DIALOG_COFREORG, DIALOG_STYLE_LIST, String, "{FFFF00}- {FFFFFF}Dinheiro Sujo\n{FFFF00}- {FFFFFF}Maconha\n{FFFF00}- {FFFFFF}Cocaina\n{FFFF00}- {FFFFFF}Sementes de Maconha", "Selecionar", "X");
			}
			if(PlayerInfo[playerid][Org] != 7) return 1;
			{
				format(String, sizeof(String), "{FFFFFF}Vezer equipar: {FFFF00}%i", CofreOrg[7][Equipar]);
				ShowPlayerDialog(playerid, DIALOG_COFREORG, DIALOG_STYLE_LIST, String, "{FFFF00}- {FFFFFF}Dinheiro Sujo\n{FFFF00}- {FFFFFF}Maconha\n{FFFF00}- {FFFFFF}Cocaina\n{FFFF00}- {FFFFFF}Sementes de Maconha", "Selecionar", "X");
			}
			if(PlayerInfo[playerid][Org] != 8) return 1;
			{
				format(String, sizeof(String), "{FFFFFF}Vezer equipar: {FFFF00}%i", CofreOrg[8][Equipar]);
				ShowPlayerDialog(playerid, DIALOG_COFREORG, DIALOG_STYLE_LIST, String, "{FFFF00}- {FFFFFF}Dinheiro Sujo\n{FFFF00}- {FFFFFF}Maconha\n{FFFF00}- {FFFFFF}Cocaina\n{FFFF00}- {FFFFFF}Sementes de Maconha", "Selecionar", "X");
			}
		}
		if(PlayerToPoint(3.0, playerid, 1277.651367, -1301.349487, 13.336478))
		{
			if(PlayerInfo[playerid][pProfissao] != 6) 	return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
			if(PegouMaterial[playerid] == true) 	return notificacao(playerid, "ERRO", "Ja pegou um material.", ICONE_ERRO); 
			
			ApplyAnimation(playerid, "CARRY", "CRRY_PRTIAL", 4.1, 0, 0, 0, 1, 1, 1);
			SetPlayerCheckpoint(playerid, 1258.313720, -1263.115478, 17.821365, 1);
			SetPlayerAttachedObject(playerid, 6, 3502, 1, 0.2779, 0.4348, 0.0000, -95.3000, 0.0000, 0.0000, 0.1209, 0.0740, 0.1028);
			PegouMaterial[playerid] = true;
		}
		if(PlayerToPoint(3.0, playerid, 376.6558,-2056.4216,8.0156))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);
			else
			{
				PlayerInfo[playerid][pProfissao] = 1;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		}
		if(PlayerToPoint(3.0, playerid, 818.8176,-1106.7904,25.7940))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);
			else
			{
				PlayerInfo[playerid][pProfissao] = 2;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 1174.452636, -1312.022338, -44.283576))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);
			if(!CheckInventario2(playerid, 1854)) 	return notificacao(playerid, "ERRO", "Nao tem Licenca B.", ICONE_ERRO);
			if(!CheckInventario2(playerid, 19792)) 	return notificacao(playerid, "ERRO", "Nao possui carteira de trabalho.", ICONE_ERRO);
			else
			{
				PlayerInfo[playerid][pProfissao] = 3;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO2] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 1171.679931, -1306.941650, -44.064826))
		{
			if(PlayerInfo[playerid][pProfissao] != 3)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);
			else
			{
				if(GetPlayerSkin(playerid) == 275)
				{
					GanharItem(playerid, 11738, 5);
					SetPlayerSkin(playerid, 275);
				}
				else
				{
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
				}
				
			}
		}
		if(PlayerToPoint(3.0, playerid, -74.9909,-1135.9198,1.0781))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);    		
			else
			{
				if(!CheckInventario2(playerid, 1855)) return notificacao(playerid, "ERRO", "Nao possui Licenca C", ICONE_ERRO);
				if(!CheckInventario2(playerid, 19792)) 	return notificacao(playerid, "ERRO", "Nao possui carteira de trabalho.", ICONE_ERRO);
				PlayerInfo[playerid][pProfissao] = 4;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO2] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 937.6857,-1085.2791,24.2891))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);    		
			else
			{
				if(!CheckInventario2(playerid, 1854)) return notificacao(playerid, "ERRO", "Nao possui Licenca B", ICONE_ERRO);
				PlayerInfo[playerid][pProfissao] = 5;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		}
		if(PlayerToPoint(3.0, playerid, 1282.408813, -1296.472167, 13.368761))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);
			else
			{
				PlayerInfo[playerid][pProfissao] = 6;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		} 
		if(PlayerToPoint(3.0, playerid, 1974.8153, -1779.7526, 13.5432))
		{
			if(PlayerInfo[playerid][pProfissao] != 0)    		return notificacao(playerid, "INFO", "Ja possui um emprego /sairemprego.", ICONE_ERRO);
			else
			{
				if(!CheckInventario2(playerid, 1854)) return notificacao(playerid, "ERRO", "Nao possui Licenca B", ICONE_ERRO);
				PlayerInfo[playerid][pProfissao] = 7;
				notificacao(playerid, "EXITO", "Aceitou em emprego novo.", ICONE_CERTO);
				MissaoPlayer[playerid][MISSAO3] = 1;
			}
		} 
		if(PlayerToPoint(1.0, playerid, 1679.127563, -2290.863525, 13.529936) || PlayerToPoint(3.0, playerid, 1686.527221, -2288.146728, 13.510719))
		{
			if(GetPVarInt(playerid, "PlayMine") == 1) return 1;
			ShowCasinoTDs(playerid);
			SetPVarInt(playerid, "PlayMine",1);
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
				notificacao(playerid, "ERRO", "Nao introduziu nada.", ICONE_ERRO);
				format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
				ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Eres nuevo aca.", Str, "Crear", "X");
				return 1;
			}
			if(!response)
			{
				notificacao(playerid, "INFO", "Decidiu nao fazer Login.", ICONE_AVISO);
				Kick(playerid);
				return 1;
			}
			else
			{
				format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
				if(!strlen(inputtext)) return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Eres nuevo aca.", Str, "Crear", "X");
				if(strlen(inputtext) < 4 || strlen(inputtext) > 20)
				{
					notificacao(playerid, "ERRO", "Sua senha dve ter de 4 a 20 caracteres.", ICONE_ERRO);
					format(Str, 256, "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
					return ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Eres nuevo aca.", Str, "Crear", "X");
				}

				format(PlayerInfo[playerid][pSenha], 20, inputtext);
				new uid = GetIdfixo();
				PlayerInfo[playerid][IDF] = uid;
				if(!DOF2_FileExists(Account))
				{
					DOF2_CreateFile(Account); 
					DOF2_SaveFile();
					DOF2_SetString(Account, "pSenha", PlayerInfo[playerid][pSenha]);
					DOF2_SetInt(Account, "IDF", PlayerInfo[playerid][IDF]);
					DOF2_SetInt(Account, "pSkin", 0);
					DOF2_SetInt(Account, "pDinheiro", 0);
					PlayerInfo[playerid][pDinheiro] = 0;
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
					PlayerInfo[playerid][Casa] = -1;
					DOF2_SaveFile();
				}
				for(new i = 0; i < 23; ++i)
				{
					PlayerTextDrawHide(playerid, Registration_PTD[playerid][i]);
				}
				CancelSelectTextDraw(playerid);
				ShowPlayerDialog(playerid, DIALOG_SELSEXO, DIALOG_STYLE_INPUT, "Escolhendo skin do personagem", "Voce precisar informar a skin do seu personagem.\nColoque id de 1 a 299", "Confirmar", #);
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
						PlayerTextDrawSetString(playerid, HudServer[playerid][6], "F");
						notificacao(playerid, "EXITO", "Voce mudou o modo do seu voip para (Falando)", ICONE_CERTO);
					}
					case 1:{
						Susurrando[playerid] = true;
						if(Falando[playerid] == true){
							Falando[playerid] = false;
						}
						if(Gritando[playerid] == true){
							Gritando[playerid] = false;
						}
						PlayerTextDrawSetString(playerid, HudServer[playerid][6], "S");
						notificacao(playerid, "EXITO", "Voce mudou o modo do seu voip para (Susurrando)", ICONE_CERTO);
					}
					case 2:{
						Gritando[playerid] = true;
						if(Falando[playerid] == true){
							Falando[playerid] = false;
						}
						if(Susurrando[playerid] == true){
							Susurrando[playerid] = false;
						}
						PlayerTextDrawSetString(playerid, HudServer[playerid][6], "G");
						notificacao(playerid, "EXITO", "Voce mudou o modo do seu voip para (Gritando)", ICONE_CERTO);
					}
				}
			}
		}
		case DIALOG_LOGIN:
		{
			if(!strlen(inputtext))
			{
				notificacao(playerid, "INFO", "Introduza senha para entrar.", ICONE_AVISO);
				format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Confirmar", "X");
				return 1;
			}
			if(!response)
			{
				notificacao(playerid, "INFO", "Decidiu nao fazer login.", ICONE_AVISO);
				Kick(playerid);
				return 1;
			}
			else
			{
				if(strcmp(inputtext, DOF2_GetString(Account, "pSenha"), true))
				{
					format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
					ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Ingresar", "X");
					Erro[playerid]++;
					if(Erro[playerid] == 3)
					{
						notificacao(playerid, "INFO", "Senha errada", ICONE_AVISO);
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
						PlayerInfo[playerid][IDF] = DOF2_GetInt(Account, "IDF");
						PlayerInfo[playerid][pSkin] = DOF2_GetInt(Account, "pSkin");
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
						DOF2_SaveFile();
						//
					}
					if(FirstLogin[playerid] == false)
					{
						ShowPlayerDialog(playerid, DIALOG_POS, DIALOG_STYLE_MSGBOX, "Voce gostaria...", "Voce gostaria de voltar a sua ultima posicao?", "Sim", "Nao");
						format(Str, sizeof(Str), "Bem vindo %s. Seu ultimo login foi em %s.", Name(playerid), PlayerInfo[playerid][pLastLogin]);
						notificacao(playerid, "INFO", Str, ICONE_AVISO);
						if(IsPlayerMobile(playerid)){
							notificacao(playerid, "INFO", "Voce esta conectado pelo Celular", ICONE_AVISO);
						}else{
							notificacao(playerid, "INFO", "Voce esta conectado pelo Computador", ICONE_AVISO);
						}
					}
					else
					{ 
						SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 1685.7053, -2335.2058, 13.5469, 0.8459, 0, 0, 0, 0, 0, 0);
						SpawnPlayer(playerid);
						FirstLogin[playerid] = false;
					}	
					for(new i = 0; i < 23; ++i)
					{
						PlayerTextDrawHide(playerid, Registration_PTD[playerid][i]);	
					}
					for(new i = 0; i < 10; i ++)
					{
						PlayerTextDrawShow(playerid, HudServer[playerid][i]);
					}
					for(new i = 0; i < 8; i ++)
					{
						TextDrawShowForPlayer(playerid, Logo[i]);
					}
					CancelSelectTextDraw(playerid);
					Timers(playerid);
					PlayerTextDraw(playerid);
					CarregarAvaliacao(playerid);
					CarregarVIP(playerid);
					MapRemocao(playerid);
					CarregarAnims(playerid);
					CriarInventario(playerid);	
					CarregarMissoes(playerid);
					CarregarArmas(playerid);
					CarregarMortos(playerid);
					pLogado[playerid] = true; 
					pJogando[playerid] = true;
					Erro[playerid] = 0;
				}
			}
		}
		case DIALOG_SELSEXO:
		{
			if(response)
			{
				if(!IsNumeric(inputtext)) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO),ShowPlayerDialog(playerid, DIALOG_SELSEXO, DIALOG_STYLE_INPUT, "Escolhendo skin do personagem", "Voce precisar informar a skin do seu personagem.\nColoque id de 1 a 299", "Confirmar", #);
				if(strval(inputtext) < 1 || strval(inputtext) > 299) return notificacao(playerid, "ERRO", "Escolha entre 1 a 299.", ICONE_ERRO),ShowPlayerDialog(playerid, DIALOG_SELSEXO, DIALOG_STYLE_INPUT, "Escolhendo skin do personagem", "Voce precisar informar a skin do seu personagem.\nColoque id de 1 a 299", "Confirmar", #);
				if(strval(inputtext) == 217 || strval(inputtext) == 211 || strval(inputtext) == 265 || strval(inputtext) == 266 || strval(inputtext) == 267 || strval(inputtext) == 274 || strval(inputtext) == 275 || strval(inputtext) == 276 || strval(inputtext) == 277 || strval(inputtext) == 278 || strval(inputtext) == 279 || strval(inputtext) == 280 || strval(inputtext) == 281 || strval(inputtext) == 282 || strval(inputtext) == 283 || strval(inputtext) == 284 || strval(inputtext) == 285 || strval(inputtext) == 286 || strval(inputtext) == 287 || strval(inputtext) == 288) return notificacao(playerid, "ERRO", "Esse id esta proibido no servidor.", ICONE_ERRO),ShowPlayerDialog(playerid, DIALOG_SELSEXO, DIALOG_STYLE_INPUT, "Escolhendo skin do personagem", "Voce precisar informar a skin do seu personagem.\nColoque id de 1 a 299", "Confirmar", #);
				SetPlayerSkin(playerid,  strval(inputtext));
				PlayerInfo[playerid][pSkin] =  strval(inputtext);
				ShowPlayerDialog(playerid, DIALOG_SELIDADE, DIALOG_STYLE_INPUT, "Escolha sua idade", "Voce precisa selecionar a idade\ndo seu personagem.", "Confirmar", #);
			}
		}
		case DIALOG_SELIDADE:
		{
			if(response)
			{
				new string[50];
				if(!IsNumeric(inputtext)) return SendClientMessage(playerid, CorErro, "Voce so pode digitar somente numeros"), ShowPlayerDialog(playerid, DIALOG_SELIDADE, DIALOG_STYLE_INPUT, "Escolha sua idade", "Voce precisa selecionar a idade\ndo seu personagem.", "Confirmar", #);
				PlayerInfo[playerid][pIdade] = strval(inputtext);
				format(string, sizeof(string), "Voce infomou que seu personagem tera %d anos.", PlayerInfo[playerid][pIdade]);
				SendClientMessage(playerid, CorSucesso, string);
				SalvarDadosSkin(playerid);
				LimparChat(playerid, 10);
				format(Str, sizeof(Str), "Desejo boas vindas, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
 				ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Seja bem vindo ao servidor...", Str, "Validar", "Cancelar");
			}
		}
		case DIALOG_BANIDO: Kick(playerid);
		case DIALOG_POS:
		{
			SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], 1685.7053, -2335.2058, 13.5469, 0.8459, 0, 0, 0, 0, 0, 0);
			SpawnPlayer(playerid);
			if(response) SpawnPos[playerid] = true;
			else SpawnPos[playerid] = false;
		}
		case DIALOG_CARTORIO:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(CheckInventario2(playerid, 1581)) return notificacao(playerid, "ERRO", "Ja possui documentos", ICONE_ERRO);
					SetTimerEx("CriandoCpf", 7000, false, "i", playerid);		
					TogglePlayerControllable(playerid, 0);
					GanharItem(playerid, 1581, 1);

				}
				if(listitem == 1)
				{
					if(CheckInventario2(playerid, 19792)) return notificacao(playerid, "ERRO", "Ja possui carteira de trabalho", ICONE_ERRO);
					if(GetPlayerMoney(playerid) < 8000) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					PlayerInfo[playerid][pDinheiro] -= 8000;
					notificacao(playerid, "EXITO", "Comprou carteira de trabalho e agora podera trabalhar com empregos que necessita disso.", ICONE_CERTO);
					GanharItem(playerid, 19792, 1);
					MissaoPlayer[playerid][MISSAO4] = 1;
				}
			}
		}
		case DIALOG_BANCO:
		{
			if(response)
			{
				if(listitem == 0)/*[Depositar]*/
				{
					format(Str, sizeof(Str), "Saldo Bancario: {FFFFFF}R${32CD32}%i\n\n{FFFFFF}Quanto quer depositar?",PlayerInfo[playerid][pBanco]);
					ShowPlayerDialog(playerid,DIALOG_BANCO1,1,"Depositar", Str, "Selecionar","X");
				}
				if(listitem == 1)/*[Sacar]*/
				{
					format(Str, sizeof(Str), "Saldo Bancario: {FFFFFF}R${32CD32}%i\n\n{FFFFFF}Quanto quer retirar?",PlayerInfo[playerid][pBanco]);
					ShowPlayerDialog(playerid,DIALOG_BANCO2,1,"Sacar", Str, "Selecionar","X");
				}
				if(listitem == 2)/*[Saldo Banco]*/
				{
					format(Str, sizeof(Str),"Saldo Bancario: {FFFFFF}R${32CD32}%i",PlayerInfo[playerid][pBanco]);
					ShowPlayerDialog(playerid,DIALOG_BANCO3,0,"Saldo Banco", Str, "X",#);
				}
				if(listitem == 3)/*[Transferir]*/
				{
					format(Str, sizeof(Str),"Introduza o ID para transferir o dinheiro",PlayerInfo[playerid][pBanco]);
					ShowPlayerDialog(playerid,DIALOG_BANCO4,1,"Transferir", Str, "Selecionar","X");
				}
			}
		}
		case DIALOG_BANCO1:
		{
			if(response)
			{
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				if(!IsNumeric(inputtext)) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				if(strlen(inputtext) > 7) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
				if(GetPlayerMoney(playerid) < strval(inputtext)) return notificacao(playerid, "ERRO", "Nao pode mas do que nao possui.", ICONE_ERRO);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				PlayerInfo[playerid][pBanco] += strval(inputtext);
				PlayerInfo[playerid][pDinheiro] -= strval(inputtext);
			}
		}
		case DIALOG_BANCO2:
		{
			if(response)
			{
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				if(!IsNumeric(inputtext)) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				if(strlen(inputtext) > 7) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
				if(PlayerInfo[playerid][pBanco] < strval(inputtext)) return notificacao(playerid, "ERRO", "Nao pode retirar mas do que possui.", ICONE_ERRO);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				PlayerInfo[playerid][pDinheiro] += strval(inputtext);
				PlayerInfo[playerid][pBanco] -= strval(inputtext);
			}
		}
		case DIALOG_BANCO3:
		{
			if(response)
			{
				ShowPlayerDialog(playerid,DIALOG_BANCO,DIALOG_STYLE_LIST,"Banco Central","{FFFF00}- {FFFFFF}Depositar Dinheiro\n{FFFF00}- {FFFFFF}Sacar Dinheiro\n{FFFF00}- {FFFFFF}Saldo Bancario\n{FFFF00}- {FFFFFF}Transferir Dinheiro","Selecionar","X");
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
				if(!IsNumeric(inputtext)) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				if(strlen(inputtext) > 3) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
				if(!IsPlayerConnected(id)) return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
				if(id == playerid) return notificacao(playerid, "ERRO", "Nao pode transferir para voce.", ICONE_ERRO);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				format(Str, sizeof(Str),"Saldo Bancario: {FFFFFF}R${32CD32}%i\n\n{FFFFFF}Transferir dinheiro a{00C2EC}%s\n\n{FFFFFF}Quanto quer transferir?",PlayerInfo[playerid][pBanco],Name(id));
				ShowPlayerDialog(playerid,DIALOG_BANCO5,1,"Transferir", Str, "Selecionar","Voltar");
				SetPVarInt(playerid, "IdTransferiu", id);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
			}
		}
		case DIALOG_BANCO5:
		{
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
			if(!IsNumeric(inputtext)) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
			if(strlen(inputtext) > 3) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
			if(PlayerInfo[playerid][pBanco] < strval(inputtext)) return notificacao(playerid, "ERRO", "No puede hacer tranferencia mas do que no tienes.", ICONE_ERRO);
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/

			PlayerInfo[playerid][pBanco] -= strval(inputtext);
			PlayerInfo[GetPVarInt(playerid, "IdTransferiu")][pBanco] += strval(inputtext);
			format(Str,sizeof(Str), "Voce recebeu R$%i, em sua conta bancaria %s",strval(inputtext),Name(playerid));
			notificacao(GetPVarInt(playerid, "IdTransferiu"), "INFO", Str, ICONE_AVISO);
			DeletePVar(playerid, "IdTransferiu");
			/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
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
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
				if(listitem == 1)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -74.9909,-1135.9198,1.0781, 3.0);
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
				if(listitem == 2)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 818.8176,-1106.7904,25.7940, 3.0);
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
				if(listitem == 3)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 376.6558,-2056.4216,8.0156, 3.0);
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
				if(listitem == 4)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 937.6857,-1085.2791,24.2891, 3.0);
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
				if(listitem == 5)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1282.408813, -1296.472167, 13.368761, 3.0);
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
				if(listitem == 6)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1974.8153, -1779.7526, 13.5432, 3.0);
					notificacao(playerid, "EXITO", "Foi marcado no seu mapa.", ICONE_CERTO);
				}
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
					if(GetPlayerMoney(playerid) < 10) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Pizza N1.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 10;
					GanharItem(playerid, 2218, 1);
				}
				if(listitem == 1)
				{
					if(GetPlayerMoney(playerid) < 18) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Pizza N2.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 18;
					GanharItem(playerid, 2355, 1);
				}
				if(listitem == 2)
				{
					if(GetPlayerMoney(playerid) < 25) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Pizza N3.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 25;
					GanharItem(playerid, 2219, 1);
				}
				if(listitem == 3)
				{
					if(GetPlayerMoney(playerid) < 50) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Pizzza N4.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 50;
					GanharItem(playerid, 2220, 1);
				}
			}
		}
		case DIALOG_REFRECOS:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(GetPlayerMoney(playerid) < 2) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Agua.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 2;
					GanharItem(playerid, 1484, 1);
				}
				if(listitem == 1)
				{
					if(GetPlayerMoney(playerid) < 5) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Jugo.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 5;
					GanharItem(playerid, 1644, 1);
				}
				if(listitem == 2)
				{
					if(GetPlayerMoney(playerid) < 8) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Sprite.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 8;
					GanharItem(playerid, 1546, 1);
				}
				if(listitem == 3)
				{
					if(GetPlayerMoney(playerid) < 10) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Voce comprou Sprunk.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 10;
					GanharItem(playerid, 2601, 1);
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
					new stringZCMD[500];
					format(stringZCMD, sizeof(stringZCMD), "1* Começo agora e esta perdido e nao sabe o que fazer?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n2* Como faco para encontrar locais?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n3* Como faco para conseguir um emprego?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n4* Como faco para subir de level?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n5* Como faco para obter minhas licencas?");
					strcat(MEGAString,stringZCMD);
					format(stringZCMD, sizeof(stringZCMD), "\n6* Como faco para ingressar em uma organizacao?");
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
					strcat(stg, "{FFFF00}/relatorio{FFFFFF} Para enviar un relatorio.\n");
					strcat(stg, "{FFFF00}/report{FFFFFF} Para denuncia un jugador.\n");
					strcat(stg, "{FFFF00}/duvida{FFFFFF} Para falar no chat de duvida.\n");
					strcat(stg, "{FFFF00}/coinscatalogo{FFFFFF} Para verificar menu de coins.\n");
					strcat(stg, "{FFFF00}/uplvl{FFFFFF} Subir um level.\n");
					strcat(stg, "{FFFF00}/sairemprego{FFFFFF} deixar seu emprego.\n");
					strcat(stg, "{FFFF00}/pagar{FFFFFF} Envia dinheiro a um jugador.\n");
					strcat(stg, "{FFFF00}/maconhas{FFFFFF} Verificar plantacoes.\n");
					strcat(stg, "{FFFF00}/cmaconha{FFFFFF} Colher plantacoes.\n");
					strcat(stg, "{FFFF00}/orgs{FFFFFF} Verificar orgs.\n\n");
					strcat(stg, "{FFFF00}/menuanim{FFFFFF} Menu de animacoes.\n\n");
					strcat(stg, "{FFFF00}/missoes{FFFFFF} Menu de missoes.\n\n");
					strcat(stg, "{FFFFFF} Para cada 30min de jogo voce recebera um PayDay,\ncada PayDay lhe dara 1XP para subir de level.");
					ShowPlayerDialog(playerid, DIALOG_AJUDACOMANDOS, DIALOG_STYLE_MSGBOX, "Comandos Servidor", stg, "Ok", #);
				}
				if(listitem == 2)
				{
					new Str2[1200];
					if(PlayerInfo[playerid][pProfissao] == 0)
					{
						strcat(Str2, "{FFFFFF} Voce nao tem emprego, voce ainda esta desempregado.");
						ShowPlayerDialog(playerid, DIALOG_EMP0, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 1)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Pescador{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Nota:{FFFFFF} Compre uma vara de pescar na 24/7\n entao use a proximo do texto para comecar a pescar, para vender\n o peixe va para a peixaria.");
						ShowPlayerDialog(playerid, DIALOG_EMP1, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 2)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Coveiro{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Comando valido:{FFFFFF} /ctumba\nConcertar uma cova.\n");
						ShowPlayerDialog(playerid, DIALOG_EMP2, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 3)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Enfermeiro{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Comando valido:{FFFFFF} /feridos /lferidos\n Para mirar los heridos y localizalos.\n");
						strcat(Str2, "\n{FFFF00}Nota:{FFFFFF} Para reviver uma pessoa, basta usar o ");
						strcat(Str2, "\n{FFFFFF}o kit de primeiros socorros disponível no vestiario e depois seguir para o hospital para finalizar o tratamento.");
						ShowPlayerDialog(playerid, DIALOG_EMP3, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 4)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Caminhoneiro{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Comando valido:{FFFFFF} /carregar\nCarregue o caminhao para uma entrega.\n");
						strcat(Str2, "\n{FFFF00}Nota:{FFFFFF} Quando chegar use  {FFFF00}/descarregar.");
						ShowPlayerDialog(playerid, DIALOG_EMP4, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
					if(PlayerInfo[playerid][pProfissao] == 5)
					{
						strcat(Str2, "\t{FFFF00}- {FFFFFF}Ajuda Entregador de Tumba{FFFF00}- {FFFFFF}\n\n");
						strcat(Str2, "\n{FFFF00}Comando valido:{FFFFFF} /ltumba\nLocalizar uma tumba em um hospital.\n");
						ShowPlayerDialog(playerid, DIALOG_EMP5, DIALOG_STYLE_MSGBOX, "Ajuda Emprego", Str2, "OK", #);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][Cargo] == 3) return 0;
					{
						new stg[1100];
						strcat(stg, "{FFFF00}/infoorg{FFFFFF} Abrir o menu\n\n");
						strcat(stg, "{FFFF00}/convidar{FFFFFF} Convide um jogador para sua organizacao.\n\n");
						strcat(stg, "{FFFF00}/limparvagas{FFFFFF} Remova todos os membros da sua organizacao.\n\n");
						strcat(stg, "{FFFF00}/demitir{FFFFFF} Demitir um membro da organizacao.\n\n");
						strcat(stg, "{FFFF00}/promover{FFFFFF} Subir cargo de um jogador.\n\n");
						ShowPlayerDialog(playerid, DIALOG_AJUDAJEFORG, DIALOG_STYLE_MSGBOX, "Comandos Chefes Orgs", stg, "Ok", #);
					}
				}
				if(listitem == 4)
				{
					if(IsPolicial(playerid)) 
					{
						new stg[1100];
						strcat(stg, "{FFFF00}/d{FFFFFF} Central de Policia\n\n");
						strcat(stg, "{FFFF00}/algemar{FFFFFF} Colocar uma algema em um jogador.\n\n");
						strcat(stg, "{FFFF00}/desalgemar{FFFFFF} Remove uma algema de um jogador.\n\n");
						strcat(stg, "{FFFF00}/pveiculo{FFFFFF} Coloque um jogador no veiculo.\n\n");
						strcat(stg, "{FFFF00}/rveiculo{FFFFFF} Remova um jogador no veiculo.\n\n");
						strcat(stg, "{FFFF00}/prender{FFFFFF} Acorrentar um jogador.\n\n");
						strcat(stg, "{FFFF00}/ab{FFFFFF} Anuncia o embarque de um jogador.\n\n");
						strcat(stg, "{FFFF00}/su{FFFFFF} Coloque o nível de procurado.\n\n");
						strcat(stg, "{FFFF00}/verinv{FFFFFF} Verificar o inventário de um jogador.\n\n");
						strcat(stg, "{FFFF00}/patrulhar{FFFFFF} Informe de uma patrulha na cidade.\n\n");
						strcat(stg, "{FFFF00}/rarmas{FFFFFF} Remover armas de um jogador.\n\n");
						strcat(stg, "{FFFF00}/lprocurados{FFFFFF} Localize um jogador procurado.\n\n");
						strcat(stg, "{FFFF00}/procurados{FFFFFF} Todos os jogadores pesquisados.\n\n");
						strcat(stg, "{FFFF00}/multar{FFFFFF} Colocar uma multa em um jogador.\n\n");
						strcat(stg, "{FFFF00}/olhardocumentos{FFFFFF} Veja os documentos de um jogador.\n\n");
						strcat(stg, "{FFFF00}/qplantacao{FFFFFF} Queimar uma plantacao de maconha.\n\n");
						ShowPlayerDialog(playerid, DIALOG_AJUDAORG, DIALOG_STYLE_MSGBOX, "Comandos Organizacao", stg, "Ok", "");
					}
					if(IsBandido(playerid)) 
					{
						new stg[1100];
						strcat(stg, "{FFFF00}/ga{FFFFFF} Radio de gang\n\n");
						strcat(stg, "{FFFF00}/ab{FFFFFF} Anuncio de abordagem.\n\n");
						strcat(stg, "{FFFF00}/pveiculo{FFFFFF} Coloque um jogador no veiculo.\n\n");
						strcat(stg, "{FFFF00}/rveiculo{FFFFFF} Remova um jogador no veiculo.\n\n");
						strcat(stg, "{FFFF00}/verinv{FFFFFF} Verificar inventario de um jogador.\n\n");
						ShowPlayerDialog(playerid, DIALOG_AJUDAORG, DIALOG_STYLE_MSGBOX, "Comandos Organizacao", stg, "Ok", "");
					}
				}
				if(listitem == 5)
				{
					new stg[1100];
					strcat(stg, "{FFFF00}/mv{FFFFFF} Abre un menu\n\n");
					strcat(stg, "{FFFF00}/localizarv{FFFFFF} Lozaliza seu veiculo no mapa.\n\n");
					strcat(stg, "{FFFF00}/trancar{FFFFFF} Tranque seu veiculo.\n\n");
					strcat(stg, "{FFFF00}/alarmev{FFFFFF} Ligue o alarme do veiculo.\n\n");
					strcat(stg, "{FFFF00}/mala{FFFFFF} Olhar o porta-malas do veiculo.\n\n");
					strcat(stg, "{FFFF00}/venderv{FFFFFF} Venda seu veiculo por um jogador.\n\n");
					strcat(stg, "{FFFF00}/darchaves{FFFFFF} Deixe suas chaves com um jogador.\n\n");
					strcat(stg, "{FFFF00}/ejetar{FFFFFF} Remova o jogador do seu veiculo.\n\n");
					strcat(stg, "{FFFF00}/ejetarll{FFFFFF} Remova todos os jogadores do seu veiculo.\n\n");
					strcat(stg, "{FFFF00}/limparmods{FFFFFF} Limpar modificações do seu veiculo.\n\n");
					ShowPlayerDialog(playerid, DIALOG_AJUDAVEH, DIALOG_STYLE_MSGBOX, "Comandos Veiculo", stg, "Ok", "");
				}
				if(listitem == 6)
				{
					new stg[1100];
					strcat(stg, "{FFFF00}/pegaritem{FFFFFF} pegar um item chao\n\n");
					strcat(stg, "{FFFF00}/inventario{FFFFFF} Abra e saia do inventario.\n\n");
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
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Iniciou agora, você está perdido e não sabe o que fazer?","Entre em contato com nossa equipe via /report [texto] ou /duvida [texto] para falar com outras pessoas\nTeremos o maior prazer em ajudá-lo com qualquer dúvida\nNota : Por favor, verifique primeiro se a sua pergunta não foi respondida abaixo em nossas Perguntas Frequentes.","Voltar","X");
					   }
					   case 1:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faço para encontrar locais?","Digite: /gps, ele criará um ponto vermelho no seu mapa, basta ir até lá.","Voltar","X");
					   }
					   case 2:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faço para conseguir um emprego?","Para conseguir um emprego você terá que ir à agência de empregos\nLá você encontrará o 'Menu Emprego'\nVocê terá que escolher um emprego e iniciar sua jornada\nNão sei onde fica a agencia? Use /gps.","Voltar","X");
					   }
					   case 3:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faço para subir de nível?","A cada 30 minutos jogados, você ganha XP\nAo atingir o XP necessário para completar o próximo nível\nAparecerá na tela para você comprar o nível\nDigite: /uplvl para ver como quanto XP você precisa.","Voltar","X");
					   }
					   case 4:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faço para tirar minhas licencas?","Você deve ir ao centro de habilitação (/gps)\nAo chegar lá, vá até o npc\nPressione F e faça o teste\nVá devagar e não bata o veiculo para que você não perca.","Voltar","X");
					   }
					   case 5:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Como faço para entrar em alguma organização?","Para entrar em qualquer organização é necessário fazer um teste com os líderes\nEntre no nosso discord e veja as organizações que estão fazendo testes.","Voltar","X");
					   }
					   case 6:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Entrei em um emprego, não sei o que fazer!","Você começou o dia e está perdido? Não sabe o que fazer?\nUse:/ajuda > emprego para ver seus comandos e boa sorte.","Voltar","X");
					   }
					   case 7:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Travo com frequência, o que pode ser?","Mods de aparência de veiculos, armas, skins, podem causar crash\nEvite usá-los, alguns mods são proibidos\nDependendo do mod, você pode sofrer punições.","Voltar","X");
					   }
					   case 8:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Estão me matando sem motivo e não sei o que fazer!","É considerado DM (Death Match) matar sem motivo\nSe isso acontecer, informe o jogador em nosso discord (discord.gg/ bBT3cT8B4Q)\nO jogador será devidamente punido","Voltar","X");
					   }
					   case 9:
					   {
							ShowPlayerDialog(playerid,DIALOG_FAQ1,DIALOG_STYLE_MSGBOX,"Fiz uma doação e estou perdido, o que faço?","Após fazer sua doação, você deve confirmá-la em nosso discord.","Voltar","X");
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
					ShowPlayerDialog(playerid, DIALOG_GPS1, DIALOG_STYLE_LIST, " Selecionar um local", "{FFFF00}- {FFFFFF}Prefeitura\n{FFFF00}- {FFFFFF}Banco\n{FFFF00}- {FFFFFF}Agencia de Empregos\n{FFFF00}- {FFFFFF}Hospital\n{FFFF00}- {FFFFFF}Loja 24/7\n{FFFF00}- {FFFFFF}Central de Licencas\n{FFFF00}- {FFFFFF}Mercado Negro\n{FFFF00}- {FFFFFF}Pizzaria\n{FFFF00}- {FFFFFF}Concesionario 1\n", "Selecionar", "X");
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
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
					SetPlayerCheckpoint(playerid, 1122.706909, -2036.977539, 69.894248, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 1)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1481.0083, -1771.7889, 18.7958, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 2)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 914.273193, -1004.627075, 37.979484, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 3)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1171.679931, -1306.941650, -44.064826, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 4)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1352.4470, -1759.2511, 13.5078, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 5)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1322.202148, -1168.256591, 23.911737, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 6)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 2447.828125, -1962.687133, 13.546875, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 7)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 2105.4880, -1806.2786, 13.5547, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
				}
				if(listitem == 8)
				{
					GPS[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 2124.720214, -1122.188110, 25.385765, 8.0);
					notificacao(playerid, "INFO", "Ponto marcado no mapa.", ICONE_CERTO);
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
							notificacao(playerid, "INFO", string, ICONE_AVISO);
						}
						else
						{	
							notificacao(playerid, "ERRO", "Este ID nao existe.", ICONE_ERRO);
							ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
						}
					}
					else
					{
						notificacao(playerid, "ERRO", "Introduza somente numeros", ICONE_ERRO);
						ShowPlayerDialog(playerid, DIALOG_LOCALIZARCASA, DIALOG_STYLE_INPUT, "Localizar Casas", "{FFFF00}- {FFFFFF}Introduza o ID da casa que queira localizar", "Localizar", "X");
					}
				}
				else
				{
					notificacao(playerid, "ERRO", "Introduza o ID para localizar.", ICONE_ERRO);
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
					ShowPlayerDialog(playerid, DIALOG_CATVIPS, DIALOG_STYLE_LIST, "CATALOGO VIP's", "{FFFF00}- {FFFFFF}VIP PRATA{32CD32}\tBC$5,000\n{FFFF00}- {FFFFFF}VIP OURO{32CD32}\tBC$10,000\n{FFFF00}- {FFFFFF}VIP PATROCINADOR{32CD32}\tBC$20,000", "Selecionar", "X");	
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, DIALOG_CATVEHINV, DIALOG_STYLE_LIST, "CATALOGO VEH INV", "{FFFF00}- {FFFFFF}Sultan{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}HotKnife{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}RC Bandit{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}RC Baron{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}RC Raider{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}Hotring{FFFF00}\tBC$5,000\n{FFFF00}- {FFFFFF}RC Goblin{FFFF00}\tBC$2,000\n{FFFF00}- {FFFFFF}Monster{FFFF00}\tBC$5,000", "Selecionar", "X");	
				}
				if(listitem == 2)
				{
					ShowPlayerDialog(playerid, DIALOG_BENEVIP, DIALOG_STYLE_MSGBOX, "BENEFICIOS VIP's", "{565957}PLATA{FFFFFF}\nColor en nombre\nAcesso al /vip\nRango en discord del servidor\nGana +$500 en PayDay\nGana +1exp en PayDay", "X", #);
				}
			}
		}
		case DIALOG_CATVEHINV:
		{
			if(response)
			{
				new String[500];
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}SULTAN{FFFFFF} por{FFFF00} BC$5.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 560, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}HOTKNIFE{FFFFFF} por{FFFF00} BC$5.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 434, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}RC BANDIT{FFFFFF} por{FFFF00} BC$2.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 441, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}RC BARON{FFFFFF} por{FFFF00} BC$2.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 464, 1);
					notificacao(playerid, "EXITO", "Comprou um vip e recebeu seus beneficios.", ICONE_CERTO);
				}
				if(listitem == 4)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}RC RAIDER{FFFFFF} por{FFFF00} BC$2.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 465, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
				if(listitem == 5)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}HOTRING{FFFFFF} por{FFFF00} BC$5.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 502, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
				if(listitem == 6)
				{
					if(PlayerInfo[playerid][pCoins] < 2000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}RC GOBLIN{FFFFFF} por{FFFF00} BC$2.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 2000;
					GanharItem(playerid, 501, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
				if(listitem == 7)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}MONSTER{FFFFFF} por{FFFF00} BC$5.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 5000;
					GanharItem(playerid, 556, 1);
					notificacao(playerid, "EXITO", "Comprou um veiculo de inventario.", ICONE_CERTO);
				}
			}
		}
		case DIALOG_CATVIPS:
		{
			if(response)
			{
				new String[500], string[500];
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pCoins] < 5000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}VIP PRATA {FFFFFF} por{FFFF00} BC$5.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pCoins] -= 5000;
					PlayerInfo[playerid][ExpiraVIP] = ConvertDays(30); 
					PlayerInfo[playerid][pVIP] = 1;
					format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
					DOF2_CreateFile(string); 
					DOF2_SetInt(string,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
					DOF2_SaveFile(); 
					notificacao(playerid, "EXITO", "Comprou um vip e recebeu seus beneficios.", ICONE_CERTO);
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pCoins] < 10000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}VIP GOLD {FFFFFF} por{FFFF00} BC$10.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pBanco] += 5000;
					PlayerInfo[playerid][pCoins] -= 10000;
					PlayerInfo[playerid][ExpiraVIP] = ConvertDays(30); 
					PlayerInfo[playerid][pVIP] = 2;
					format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
					DOF2_CreateFile(string); 
					DOF2_SetInt(string,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
					DOF2_SaveFile(); 
					notificacao(playerid, "EXITO", "Comprou um vip e recebeu seus beneficios.", ICONE_CERTO);
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pCoins] < 20000) 	return notificacao(playerid, "ERRO", "Coins insuficiente.", ICONE_ERRO);
					format(String, sizeof(String), "{FFFF00}[SERVER]: {FFFFFF}%s compro  {0080FF}VIP PATROCINADOR por{FFFF00} BC$20.000", Name(playerid));
					SendClientMessageToAll(-1, String);
					PlayerInfo[playerid][pBanco] += 25000;
					PlayerInfo[playerid][pCoins] -= 20000;
					PlayerInfo[playerid][ExpiraVIP] = ConvertDays(30); 
					PlayerInfo[playerid][pVIP] = 3;
					format(string, sizeof(string), PASTA_VIPS, Name(playerid)); 
					DOF2_CreateFile(string); 
					DOF2_SetInt(string,"VipExpira", PlayerInfo[playerid][ExpiraVIP]); 
					DOF2_SaveFile(); 
					notificacao(playerid, "EXITO", "Comprou um vip e recebeu seus beneficios.", ICONE_CERTO);
				}
			}
		}
		case DIALOG_AUTO_ESCOLA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(GetPlayerMoney(playerid) < 2000)	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					if(CheckInventario2(playerid,1853)) return notificacao(playerid, "ERRO", "Ja possui essa licenca", ICONE_ERRO);
					new StrHab[15000];
					strcat(StrHab,  "{BEBEBE}: Você está prestes a iniciar um test drive\n");
					strcat(StrHab,  "{BEBEBE}: Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{BEBEBE}: Lembrando! Após clicar no botão, o teste será iniciado automaticamente.\n");
					strcat(StrHab,  "{BEBEBE}: A cobrança será feita assim que o teste começar.\n");
					strcat(StrHab,  "{BEBEBE}: Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA1, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
				if(listitem == 1)
				{
					if(GetPlayerMoney(playerid) < 2500)	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					if(CheckInventario2(playerid,1854)) return notificacao(playerid, "ERRO", "Ja possui essa licenca", ICONE_ERRO);
					new StrHab[15000];
					strcat(StrHab,  "{BEBEBE}: Você está prestes a iniciar um test drive\n");
					strcat(StrHab,  "{BEBEBE}: Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{BEBEBE}: Lembrando! Após clicar no botão, o teste será iniciado automaticamente.\n");
					strcat(StrHab,  "{BEBEBE}: A cobrança será feita assim que o teste começar.\n");
					strcat(StrHab,  "{BEBEBE}: Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA2, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
				if(listitem == 2)
				{
					if(GetPlayerMoney(playerid) < 5000)	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					if(CheckInventario2(playerid,1855)) return notificacao(playerid, "ERRO", "Ja possui essa licenca", ICONE_ERRO);
					new StrHab[15000];
					strcat(StrHab,  "{BEBEBE}: Você está prestes a iniciar um test drive\n");
					strcat(StrHab,  "{BEBEBE}: Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{BEBEBE}: Lembrando! Após clicar no botão, o teste será iniciado automaticamente.\n");
					strcat(StrHab,  "{BEBEBE}: A cobrança será feita assim que o teste começar.\n");
					strcat(StrHab,  "{BEBEBE}: Siga a rota sem bater ou danificar o veiculo.\n");
					ShowPlayerDialog(playerid, DIALOG_CONFIRMA_ESCOLA3, DIALOG_STYLE_MSGBOX, "Teste de conducao", StrHab, "Fazer Teste","X");
				}
				if(listitem == 3)
				{
					if(GetPlayerMoney(playerid) < 50000)	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					if(CheckInventario2(playerid,1856)) return notificacao(playerid, "ERRO", "Ja possui essa licenca", ICONE_ERRO);
					new StrHab[15000];
					strcat(StrHab,  "{BEBEBE}: Você está prestes a iniciar um test drive\n");
					strcat(StrHab,  "{BEBEBE}: Para iniciar o teste, clique em '{00FF00}COMECAR{BEBEBE}'\n");
					strcat(StrHab,  "{BEBEBE}: Lembrando! Após clicar no botão, o teste será iniciado automaticamente.\n");
					strcat(StrHab,  "{BEBEBE}: A cobrança será feita assim que o teste começar.\n");
					strcat(StrHab,  "{BEBEBE}: Siga a rota sem bater ou danificar o veiculo.\n");
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

				notificacao(playerid, "EXITO", "Va ate o ponto em seu mapa", ICONE_CERTO);
				GameTextForPlayer(playerid, "~w~Prueba ~g~Comenzo!", 5000, 0);

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
				AutoEscolaVeiculo[playerid] = CreateVehicle(589, SpawnAT[indx2][0], SpawnAT[indx2][1], SpawnAT[indx2][2], SpawnAT[indx2][3], 6, 6, 2400000);
				SetVehicleVirtualWorld(AutoEscolaVeiculo[playerid], 0);
				PutPlayerInVehicle(playerid, AutoEscolaVeiculo[playerid], 0);

				notificacao(playerid, "EXITO", "Va ate o ponto em seu mapa", ICONE_CERTO);
				GameTextForPlayer(playerid, "~w~Teste ~g~Comecou!", 5000, 0);

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

				notificacao(playerid, "EXITO", "Va ate o ponto em seu mapa", ICONE_CERTO);
				GameTextForPlayer(playerid, "~w~Teste ~g~Comecou!", 5000, 0);

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

				notificacao(playerid, "EXITO", "Va ate o ponto em seu mapa", ICONE_CERTO);
				GameTextForPlayer(playerid, "~w~Teste ~g~Comecou!", 5000, 0);
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
		case DIALOG_247:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(GetPlayerMoney(playerid) < 1200) 			return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Item comprado.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 1200;
					GanharItem(playerid, 18870, 1);
					MissaoPlayer[playerid][MISSAO6] = 1;
				}
				if(listitem == 1)
				{
					if(GetPlayerMoney(playerid) < 580) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					PlayerInfo[playerid][pDinheiro] -= 580;
					notificacao(playerid, "EXITO", "Item comprado.", ICONE_CERTO);
					GanharItem(playerid, 18645, 1);
				}
				if(listitem == 2)
				{
					if(GetPlayerMoney(playerid) < 1200) 	return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					PlayerInfo[playerid][pDinheiro] -= 1200;
					notificacao(playerid, "EXITO", "Item comprado.", ICONE_CERTO);
					GanharItem(playerid, 18632, 1);
				}
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
				if(!IsNumeric(inputtext)) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
				if(strlen(inputtext) > 3) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
				if(!IsPlayerConnected(id)) return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
				if(id == playerid) return notificacao(playerid, "ERRO", "Nao pode animar voce.", ICONE_ERRO);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
				if (ProxDetectorS(1.5, playerid,id))
				{
				    if(PlayerMorto[id][pSegMorto] == 0)
					{
						if(PlayerMorto[id][pMinMorto] == 0)
						{
						    SendClientMessage(playerid, -1, "Esse jogador nao esta desmaiado!");
						    return 1;
					    }
					}
					SetTimerEx("ParaDeBugaPoraaaDk", 100, 1, "i", id);
					PlayerMorto[id][pEstaMorto] = 0;
				    KillTimer(TimerMorto[id]);
			        SetPlayerHealth(id, 50);
			        PlayerMorto[id][pMinMorto] = 0;
			        PlayerMorto[id][pSegMorto] = 0;
			        for(new idx=0; idx<6; idx++){
			        PlayerTextDrawHide(id,TextDrawMorte[playerid][idx]); }
				    ClearAnimations(id, 1);
				    ClearAnimations(id);
			        SetPlayerPos(id, PlayerMorto[id][pPosMt1], PlayerMorto[id][pPosMt2], PlayerMorto[id][pPosMt3]);
			        new string[200];
			        format(string, 200, "{00FF00}~> voce reviveu o jogador %s!", PlayerName(id));
				    SendClientMessage(playerid, -1, string);
				    format(string, 200, "{00FF00}~> %s te reviveu!", PlayerName(playerid));
				    SendClientMessage(id, -1, string);
				    return 1;
				}
				notificacao(playerid, "ERRO", "Estas lejos de un jugador!", ICONE_ERRO);
				/*~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*/
			}
		}
		case DIALOG_CARGA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					notificacao(playerid, "EXITO", "Seu caminhao foi carregado para Ind. Solarin!", ICONE_EMPREGO);
					notificacao(playerid, "EXITO", "Foi marcado um ponto para descarregar.", ICONE_EMPREGO);
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -1823.9757,54.3441,15.1228, 10.0);
				}
				if(listitem == 1)
				{
					notificacao(playerid, "EXITO", "Seu caminhao foi carregado para Wang Cars!", ICONE_EMPREGO);
					notificacao(playerid, "EXITO", "Foi marcado um ponto para descarregar.", ICONE_EMPREGO);
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, -1934.6858,259.0710,41.6420, 10.0);
				}
				if(listitem == 2)
				{
					notificacao(playerid, "EXITO", "Seu caminhao foi carregado para Michelin Pneus!", ICONE_EMPREGO);
					notificacao(playerid, "EXITO", "Foi marcado um ponto para descarregar.", ICONE_EMPREGO);
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1635.2142,2192.1284,11.4099, 10.0);
				}
				if(listitem == 3)
				{
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					notificacao(playerid, "EXITO", "Seu caminhao foi carregado para Sprunk!", ICONE_EMPREGO);
					notificacao(playerid, "EXITO", "Foi marcado um ponto para descarregar.", ICONE_EMPREGO);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1338.3881,286.8327,20.1563, 10.0);
				}
				if(listitem == 4)
				{
					notificacao(playerid, "EXITO", "Seu caminhao foi carregado para Xoomer!", ICONE_EMPREGO);
					notificacao(playerid, "EXITO", "Foi marcado um ponto para descarregar.", ICONE_EMPREGO);
					GameTextForPlayer(playerid, "~y~~h~carregado", 1000, 0);
					Cargase[playerid] = true;
					Carregou[playerid] = 1;
					SetTimerEx("CheckComandos", 30000, false, "d", playerid);
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 219.3734,9.5520,3.1495, 10.0);
				}
				if(listitem == 5)
			   {
					notificacao(playerid, "EXITO", "Seu caminhao foi carregado para FlaischBerg!", ICONE_EMPREGO);
					notificacao(playerid, "EXITO", "Foi marcado um ponto para descarregar.", ICONE_EMPREGO);
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
				notificacao(playerid, "ERRO", "Você tem entregas não selecionadas.", ICONE_EMPREGO);
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
				notificacao(playerid, "INFO", String, ICONE_AVISO);
				format(String,sizeof(String),"%s acaba de entrar na sua organizaccao (%s)",Name(playerid),NomeOrg(playerid));
				notificacao(PlayerInfo[playerid][convite], "INFO", String, ICONE_AVISO);
				PlayerInfo[playerid][convite] = 0;
				convidarmembro(playerid, PlayerInfo[playerid][Org]);
				MissaoPlayer[playerid][MISSAO13] = 1;
			}
			if(!response)
			{
				format(String,sizeof(String),"%s Recusou o convite para org (%s)",Name(playerid),NomeOrg(playerid));
				notificacao(PlayerInfo[playerid][convite], "INFO", String, ICONE_AVISO);
				format(String,sizeof(String),"Recusou o convite para sua organizacao (%s)",NomeOrg(playerid));
				notificacao(playerid, "INFO", String, ICONE_AVISO);
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
					notificacao(playerid, "INFO", string, ICONE_CERTO);
					DOF2_SetInt(StringContas, "pOrg", 0);
					DOF2_SaveFile();
				}
				else
				{
					format(string,sizeof(string),"Conta: %s nao encontrada!", inputtext);
					notificacao(playerid, "INFO", string, ICONE_ERRO);
				}
			}
		}
		case DIALOG_ROPACOP:
		{
			if(response)
			{
				new string[800];
				if(listitem == 0)
				{
					SetPlayerSkin(playerid, 265);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 1)
				{
					SetPlayerSkin(playerid, 266);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 2)
				{
					SetPlayerSkin(playerid, 267);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 3)
				{
					SetPlayerSkin(playerid, 280);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 4)
				{
					SetPlayerSkin(playerid, 281);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 5)
				{
					SetPlayerSkin(playerid, 282);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 6)
				{
					SetPlayerSkin(playerid, 283);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 7)
				{
					SetPlayerSkin(playerid, 284);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 8)
				{
					SetPlayerSkin(playerid, 285);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 9)
				{
					SetPlayerSkin(playerid, 286);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 10)
				{
					SetPlayerSkin(playerid, 300);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 11)
				{
					SetPlayerSkin(playerid, 301);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 12)
				{
					SetPlayerSkin(playerid, 302);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 13)
				{
					SetPlayerSkin(playerid, 306);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 14)
				{
					SetPlayerSkin(playerid, 307);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 15)
				{
					SetPlayerSkin(playerid, 308);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 16)
				{
					SetPlayerSkin(playerid, 309);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 17)
				{
					SetPlayerSkin(playerid, 310);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 18)
				{
					SetPlayerSkin(playerid, 311);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}pegou um uniforme no armario", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
				if(listitem == 19)
				{
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					format(string, sizeof(string), "{FFFFFF}* Oficial {FFFF00}%s {FFFFFF}Saco su ROPA de trabajo", Name(playerid));
					ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
				}
			}
		}
		case DIALOG_2LIST:
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
						VeiculoCivil[playerid] = CreateVehicle(596, X, Y, Z, ROT, 127, 152, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
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
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
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
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
					}
					return 1;
				}
			}
		}
		case DIALOG_3LIST:
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
						VeiculoCivil[playerid] = CreateVehicle(596, X, Y, Z, ROT, 127, 6, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
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
						VeiculoCivil[playerid] = CreateVehicle(523, X, Y, Z, ROT, 127, 6, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
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
						VeiculoCivil[playerid] = CreateVehicle(525, X, Y, Z, ROT, 127, 6, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
					}
					return 1;
				}
			}
		}
		case DIALOG_4LIST:
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
						VeiculoCivil[playerid] = CreateVehicle(490, X, Y, Z, ROT, 127, 127, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
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
						VeiculoCivil[playerid] = CreateVehicle(599, X, Y, Z, ROT, 127, 127, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
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
						VeiculoCivil[playerid] = CreateVehicle(560, X, Y, Z, ROT, 127, 127, false);
						PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
						notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
					}
					else
					{
						notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
					}
					return 1;
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
					ShowPlayerDialog(playerid, DIALOG_COFREORG12, DIALOG_STYLE_INPUT, "Boveda de organización", string, "Sacar", "X");
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
					ShowPlayerDialog(playerid, DIALOG_COFREORG22, DIALOG_STYLE_INPUT, "Boveda de organización", string, "Sacar", "X");
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
					ShowPlayerDialog(playerid, DIALOG_COFREORG32, DIALOG_STYLE_INPUT, "Boveda de organización", string, "Sacar", "X");
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
					ShowPlayerDialog(playerid, DIALOG_COFREORG42, DIALOG_STYLE_INPUT, "Boveda de organización", string, "Sacar", "X");
				}
			}
		}
		case DIALOG_COFREORG12:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Dinheiro] > sac)
				{
					notificacao(playerid, "ERRO", "Nao possui tudo isso.", ICONE_ERRO);
					return true;
				}
				if(sac > 0)
				{
					GanharItem(playerid, 1212, sac);
					SacarGranaOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d dinheiro sujo, o novo balance e %d",sac,CofreOrg[org][Dinheiro]);
					notificacao(playerid, "INFO", string, ICONE_AVISO);
					return true;
				}
			}
		}
		case DIALOG_COFREORG22:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Maconha] > sac)
				{
					notificacao(playerid, "ERRO", "Nao possui tudo isso.", ICONE_ERRO);
					return true;
				}
				if(sac > 0)
				{
					GanharItem(playerid, 3027, sac);
					SacarMaconhaOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d maconha, o novo balance e %d",sac,CofreOrg[org][Maconha]);
					notificacao(playerid, "INFO", string, ICONE_AVISO);
					return true;
				}
			}
		}
		case DIALOG_COFREORG32:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Cocaina] > sac)
				{
					notificacao(playerid, "ERRO", "Nao possui tudo isso.", ICONE_ERRO);
					return true;
				}
				if(sac > 0)
				{

					GanharItem(playerid, 1279, sac);
					SacarCocainaOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d cocaina, o novo balance e %d",sac,CofreOrg[org][Cocaina]);
					notificacao(playerid, "INFO", string, ICONE_AVISO);
					return true;
				}
			}
		}
		case DIALOG_COFREORG42:
		{
			if(response)
			{
				new string[300];
				if(strfind(inputtext,"%",true) != -1) return notificacao(playerid, "ERRO", "Somente numeros", ICONE_ERRO);
				new org = GetPlayerOrg(playerid);
				new sac = strval(inputtext);
				if(CofreOrg[org][Crack] > sac)
				{
					notificacao(playerid, "ERRO", "Nao possui tudo isso.", ICONE_ERRO);
					return true;
				}
				if(sac > 0)
				{
					GanharItem(playerid, 3930, sac);
					SacarCrackOrg(org, sac);
					format(string,sizeof(string),"Voce sacou %d crack, o novo balance e %d",sac,CofreOrg[org][Crack]);
					notificacao(playerid, "INFO", string, ICONE_AVISO);
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
					if(GetPlayerMoney(playerid) < 25000) 			return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Compro uma C4.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 25000;
					GanharItem(playerid, 1252, 1);
				}
				if(listitem == 1)
				{
					if(GetPlayerMoney(playerid) < 1000) 			return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					notificacao(playerid, "EXITO", "Compro uma semente.", ICONE_CERTO);
					PlayerInfo[playerid][pDinheiro] -= 1000;
					GanharItem(playerid, 3520, 1);
				}
			}
		}
		case DIALOG_LMARIHUANA:
		{
			if(!response)return true;
			new id = LocalizeMaconha[listitem+1][playerid];
			SetPlayerCheckpoint(playerid, MaconhaInfo[id][mX],MaconhaInfo[id][mY],MaconhaInfo[id][mZ], 5.0);
			notificacao(playerid, "EXITO", "Sua plantacao foi marcada", ICONE_CERTO);
			return true;
		}
		case DIALOG_BETCASINO: 
		{
			if( !response ) return 1;
			new string[ 128 ];
			if( strval( inputtext ) < 50000 || strval( inputtext ) > 100000000 ) return notificacao(playerid, "ERRO", "Valor invalido! Coloque um minimo de R$50k e um maximo de R$100kk.", ICONE_ERRO);
			if( GetPlayerMoney( playerid ) < strval( inputtext ) ) return notificacao(playerid, "ERRO", "Dinheiro insuficiente", ICONE_ERRO);
			SetPVarInt( playerid, "BetAmount", strval( inputtext ) );
			PlayerInfo[playerid][pDinheiro] -= strval( inputtext );
			format( string, sizeof( string ), "~w~~h~Aposta: ~g~R$%s", FormatNumber( strval( inputtext ) ) );
			PlayerTextDrawSetString( playerid, CasinoPTD[ 32 ], string );
			PlayerTextDrawShow( playerid, CasinoPTD[ 32 ] );
		}
		case DIALOG_LTUMBA:
		{
			if(response)
			{
				if(listitem == 0)
				{
					notificacao(playerid, "TRABALHO", "Foi marcado um ponto no mapa.", ICONE_EMPREGO);
					ltumba[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1173.5168,-1308.6056,13.6994, 10.0);
				}
				if(listitem == 1)
				{
					notificacao(playerid, "TRABALHO", "Foi marcado um ponto no mapa.", ICONE_EMPREGO);
					ltumba[playerid] = true;
					DisablePlayerCheckpoint(playerid);
					SetPlayerCheckpoint(playerid, 1609.8369,1823.2799,10.5249, 10.0);
				}
				if(listitem == 2)
				{
					notificacao(playerid, "TRABALHO", "Foi marcado um ponto no mapa.", ICONE_EMPREGO);
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
								notificacao(playerid, "ERRO", "Essa casa ja e sua.", ICONE_ERRO);
								return 1;
							}
							else if(CasaInfo[i][CasaAVenda] == 0)
							{
								notificacao(playerid, "ERRO", "Casa nao esta a venda.", ICONE_ERRO);
								return 1;
							}
							else if(PlayerInfo[playerid][Casa] > -1)
							{
								notificacao(playerid, "ERRO", "Ja possui uma casa", ICONE_ERRO);
								return 1;
							}
							else if(GetPlayerMoney(playerid) < CasaInfo[i][CasaValor])
							{
								return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
							}
							else
							{
								new location[MAX_ZONE_NAME];
								GetPlayer2DZone2(playerid, location, MAX_ZONE_NAME);

								format(File, sizeof(File), PASTA_CONTAS, CasaInfo[i][CasaDono]);

								format(gstring, sizeof(gstring), "| IMOBILIARIA |{FFFFFF} O Jogador {FFFF00}%s {FFFFFF}comprou uma casa em {FFFF00}%s {FFFFFF}valor de {FFFF00}R$%d.", Name(playerid), location, CasaInfo[i][CasaValor]);
								SendClientMessageToAll(COR_GREY, gstring);

								format(gstring, sizeof(gstring), "Compro casa id %d e pagou R$%d.", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
								notificacao(playerid, "EXITO", gstring, ICONE_CERTO);

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
									format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					notificacao(playerid, "EXITO", "Iniciou uma animacao.", ICONE_CERTO);
				}
				if(listitem == 1)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "SUNBATHE", "ParkSit_M_in", 4.0, 0, 0, 0, 1, 0, 1);
					notificacao(playerid, "EXITO", "Iniciou uma animacao.", ICONE_CERTO);
				}
				if(listitem == 2)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "BEACH", "bather", 4.0, 0, 0, 0, 1, 0, 1);
					notificacao(playerid, "EXITO", "Iniciou uma animacao.", ICONE_CERTO);
				}
				if(listitem == 3)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "ped", "ARRESTgun", 4.0, 0, 0, 0, 1, 0, 1);
					notificacao(playerid, "EXITO", "Iniciou uma animacao.", ICONE_CERTO);
				}
				if(listitem == 4)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "ped", "cower", 4.0, 0, 0, 0, 1, 0, 1);
					notificacao(playerid, "EXITO", "Iniciou uma animacao.", ICONE_CERTO);
				}
				if(listitem == 5)
				{
					ClearAnimations(playerid);
					ApplyAnimation(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 0, 0, 1, 0, 1);
					notificacao(playerid, "EXITO", "Iniciou uma animacao.", ICONE_CERTO);
				}
				if(listitem == 6)
				{
					ClearAnimations(playerid);
					notificacao(playerid, "EXITO", "Parou a animacao.", ICONE_CERTO);
				}
			}
		}
		case DIALOG_ARMARIOMEC:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(GetPlayerMoney(playerid) < 800) 			return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO);
					PlayerInfo[playerid][pDinheiro] -= 800;
					GanharItem(playerid, 19921, 1);
					notificacao(playerid, "EXITO", "Compro una caja de herramientas.", ICONE_CERTO);
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
						if(MissaoPlayer[playerid][CMISSAO1] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO1] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 1)
				{
					if(MissaoPlayer[playerid][MISSAO2] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO2] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO2] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 2)
				{
					if(MissaoPlayer[playerid][MISSAO3] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO3] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO3] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 3)
				{
					if(MissaoPlayer[playerid][MISSAO4] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO4] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] = 500;
						MissaoPlayer[playerid][CMISSAO4] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 4)
				{
					if(MissaoPlayer[playerid][MISSAO5] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO5] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO5] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 5)
				{
					if(MissaoPlayer[playerid][MISSAO6] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO6] != 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO6] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 6)
				{
					if(MissaoPlayer[playerid][MISSAO7] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO7] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] = 500;
						MissaoPlayer[playerid][CMISSAO7] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 7)
				{
					if(MissaoPlayer[playerid][MISSAO8] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO8] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO8] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 8)
				{
					if(MissaoPlayer[playerid][MISSAO9] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO9] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$15000.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 15000;
						MissaoPlayer[playerid][CMISSAO9] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 9)
				{
					if(MissaoPlayer[playerid][MISSAO10] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO10] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO10] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 10)
				{
					if(MissaoPlayer[playerid][MISSAO11] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO11] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500 expericencia.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO11] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 11)
				{
					if(MissaoPlayer[playerid][MISSAO12] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO12] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] += 500;
						MissaoPlayer[playerid][CMISSAO12] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
				if(listitem == 12)
				{
					if(MissaoPlayer[playerid][MISSAO13] == 1)
					{
						if(MissaoPlayer[playerid][CMISSAO13] == 1) return notificacao(playerid, "ERRO", "Missao completa", ICONE_ERRO);
						notificacao(playerid, "EXITO", "Completou a missao e ganhou R$500.", ICONE_CERTO);
						PlayerInfo[playerid][pDinheiro] = 500;
						MissaoPlayer[playerid][CMISSAO13] = 1;
					}
					else
					{
						notificacao(playerid, "ERRO", "Missao ainda nao completada.", ICONE_ERRO);
					}
				}
			}
		}
		case DIALOG_SLOTMACHINE:
		{
			new String[64];
			if(!response) return Playing[playerid] = false, DataSlotMachine[SmID[playerid]][Occupied] = false;
			Prize[playerid] = strval(inputtext);
			if(Prize[playerid] < 1000) return format(String, sizeof(String), "Aposta minima de R$%d.", MINIMUM_BET), notificacao(playerid, "ERRO", String, ICONE_ERRO), Playing[playerid] = false, DataSlotMachine[SmID[playerid]][Occupied] = false;
			if(GetPlayerMoney(playerid) < Prize[playerid]) return notificacao(playerid, "ERRO", "Dinheiro insuficiente.", ICONE_ERRO), Playing[playerid] = false, DataSlotMachine[SmID[playerid]][Occupied] = false;
			DataSlotMachine[SmID[playerid]][Jackpot] = DOF2_GetInt(GetSlotMachine(SmID[playerid]), "Jackpot"), PlayerInfo[playerid][pDinheiro] -= Prize[playerid], SetTimerEx("SpinSlotMachine", 1000, false, "i", playerid), ApplyAnimation(playerid, "CASINO", "Slot_in", 4.1, 0, 0, 0, 1, 1, 1);
		}
		case DIALOG_ARMAS2:
		{
			if(response)
	 		{
		 		switch(listitem)
		 		{
	                case 0: ItemOpcoes2(playerid, 0);
	                case 1: ItemOpcoes2(playerid, 1);
	                case 2: ItemOpcoes2(playerid, 2);
	                case 3: ItemOpcoes2(playerid, 3);
	                case 4: ItemOpcoes2(playerid, 4);
	                case 5: ItemOpcoes2(playerid, 5);
	                case 6: ItemOpcoes2(playerid, 6);
	                case 7: ItemOpcoes2(playerid, 7);
	                case 8: ItemOpcoes2(playerid, 8);
	                case 9: ItemOpcoes2(playerid, 9);
	                case 10: ItemOpcoes2(playerid, 10);
	                case 11: ItemOpcoes2(playerid, 11);
	                case 12: ItemOpcoes2(playerid, 12);
	                case 13: ItemOpcoes2(playerid, 13);
	                case 14: ItemOpcoes2(playerid, 14);
	                case 15: ItemOpcoes2(playerid, 15);
	                case 16: ItemOpcoes2(playerid, 16);
	                case 17: ItemOpcoes2(playerid, 17);
	                case 18: ItemOpcoes2(playerid, 18);
	                case 19: ItemOpcoes2(playerid, 19);
		 			case 20: GuardarItem2(playerid);
				}
				return 1;
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

	     				notificacao(playerid, "EXITO", "Pego uma arma no cofre.", ICONE_CERTO);
	     				GivePlayerWeapon(playerid, CofreArma[ItemOpcao[playerid]][orgid], CofreAmmo[ItemOpcao[playerid]][orgid]);
	    				CofreArma[ItemOpcao[playerid]][orgid]=0;
	    				CofreAmmo[ItemOpcao[playerid]][orgid]=0;
	    				SalvarCofre(orgid);
	 				}
	 				case 1:
	 				{
	     				GivePlayerWeapon(playerid, CofreArma[ItemOpcao[playerid]][orgid], CofreAmmo[ItemOpcao[playerid]][orgid]);
	    				CofreAmmo[ItemOpcao[playerid]][orgid]=0;
	    				CofreAmmo[ItemOpcao[playerid]][orgid]=0;
	     				notificacao(playerid, "ERRO", "Voce deixou cair uma arma.", ICONE_ERRO);
	     				SalvarCofre(orgid);
	 				}
				}
				return 1;
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
						notificacao(playerid, "INFO", "Encheu 20L no seu tanque.", ICONE_AVISO);
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
						notificacao(playerid, "EXITO", msg, ICONE_CERTO);
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
						notificacao(playerid, "EXITO", "Veiculo estacionado.", ICONE_CERTO);
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
					return 1;
				}
				new id = GetPVarInt(playerid, "DialogValue1");
				if(GetPlayerMoney(playerid) < VehicleValue[id])
				{
					ShowErrorDialog(playerid, "Dinheiro insuficiente");
					return 1;
				}
				new freeid = GetFreeVehicleID();
				if(!freeid)
				{
					ShowErrorDialog(playerid, "Veiculos esgotados");
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
				notificacao(playerid, "EXITO", msg, ICONE_CERTO);
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
				if(GetPlayerMoney(playerid) < price)
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
				notificacao(playerid, "EXITO", msg, ICONE_CERTO);
				format(msg, sizeof(msg), "%s (%d) aceitou a oferta", PlayerName(playerid), playerid);
				notificacao(targetid, "INFO", msg, ICONE_AVISO);
			}
			else
			{
				new targetid = GetPVarInt(playerid, "DialogValue1");
				new msg[128];
				format(msg, sizeof(msg), " %s (%d) recusou a oferta", PlayerName(playerid), playerid);
				notificacao(targetid, "INFO", msg, ICONE_AVISO);
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
					notificacao(playerid, "INFO", "Localizando veiculo.", ICONE_AVISO);
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
				notificacao(playerid, "EXITO", msg, ICONE_CERTO);
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
					if(GetPlayerMoney(playerid) < PRECO_GASOLINA)
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
					if(GetPlayerMoney(playerid) < PRECO_GALAO)
					{
						ShowErrorDialog(playerid, "Dinheiro insuficiente");
						return 1;
					}
					PlayerInfo[playerid][pDinheiro] -= PRECO_GALAO;
					SetPVarInt(playerid, "GasCan", 1);
					notificacao(playerid, "EXITO", "Comprou um galao.", ICONE_CERTO);
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
						notificacao(playerid, "EXITO", msg, ICONE_CERTO);
					}
					case 6:
					{
						if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
						{
							ShowErrorDialog(playerid, "Usted no está conduciendo el vehiculo!");
							return 1;
						}
						GetVehiclePos(VehicleID[id], VehiclePos[id][0], VehiclePos[id][1], VehiclePos[id][2]);
						GetVehicleZAngle(VehicleID[id], VehiclePos[id][3]);
						VehicleInterior[id] = GetPlayerInterior(playerid);
						VehicleWorld[id] = GetPlayerVirtualWorld(playerid);
						notificacao(playerid, "EXITO", "Estaciono este veiculo aca.", ICONE_CERTO);
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
						notificacao(playerid, "EXITO", msg, ICONE_CERTO);
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
				notificacao(playerid, "EXITO", "Voce decidiu dar ponto de avaliacao para o administrador.", ICONE_CERTO);
			}
			else
			{
				notificacao(playerid, "EXITO", "Voce decidiu nao dar ponto de avaliacao para o administrador.", ICONE_CERTO);
			}
		}
	}
	return 1;
}

public OnPlayerEditObject(playerid, playerobject, objectid, response, Float:fX, Float:fY, Float:fZ, Float:fRotX, Float:fRotY, Float:fRotZ)
{
	if(EditingSM[playerid] == 1) 
	{
		if(response == EDIT_RESPONSE_FINAL)
		{
			notificacao(playerid, "INFO", "Aperte Y para salvar.", ICONE_AVISO), DOF2_SaveFile(), EditingSM[playerid] = 2;
			DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "PozXX", fX), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "PozYY", fY), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "PozZZ", fZ);
			DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "RotXX", fRotX), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "RotYY", fRotY), DOF2_SetFloat(GetSlotMachine(SmID[playerid]), "RotZZ", fRotZ);
		}
		if(response == EDIT_RESPONSE_CANCEL) return EditingSM[playerid] = 0;
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	SetPlayerPos(playerid, fX,fY,fZ);
	return 1;
}

public OnPlayerClickPlayerTextDraw(playerid, PlayerText: playertextid)
{
	new str[64], File[255];
	new wVeiculo = GetPlayerVehicleID(playerid);
	if(playertextid == TDEditor_PTD[playerid][4])
	{
		for(new i; i < 66; i++)
		{
			TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
		}
		for(new i; i < 6; i++)
		{
			PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
		}
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == TDEditor_PTD[playerid][5])
	{
		for(new i; i < 66; i++)
		{
			TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
		}
		for(new i; i < 6; i++)
		{
			PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
		}
		CancelSelectTextDraw(playerid);
	}
	if(playertextid == TDEditor_PTD[playerid][1])
	{
		format(Str, sizeof(Str), "Saldo Bancario: {FFFFFF}R${32CD32}%i\n\n{FFFFFF}Quanto quer depositar?",PlayerInfo[playerid][pBanco]);
		ShowPlayerDialog(playerid,DIALOG_BANCO1,1,"Depositar", Str, "Selecionar","X");
	}
	if(playertextid == TDEditor_PTD[playerid][2])
	{
		format(Str, sizeof(Str), "Saldo Bancario: {FFFFFF}R${32CD32}%i\n\n{FFFFFF}Quanto quer retirar?",PlayerInfo[playerid][pBanco]);
		ShowPlayerDialog(playerid,DIALOG_BANCO2,1,"Sacar", Str, "Selecionar","X");
	}
	if(playertextid == TDEditor_PTD[playerid][3])
	{
		format(Str, sizeof(Str),"Introduza o ID do jogador que quer transferir o dinheiro",PlayerInfo[playerid][pBanco]);
		ShowPlayerDialog(playerid,DIALOG_BANCO4,1,"Transferir", Str, "Selecionar","X");
	}
	if(playertextid == Registration_PTD[playerid][21])
	{
		format(File, sizeof(File), PASTA_CONTAS, Name(playerid));
		if(DOF2_FileExists(File))
		{
			FirstLogin[playerid] = false;
			format(Str, sizeof(Str), "Desejo boas vindas novamente, %s.\nPara Entrar no servidor Digite sua senha abaixo.", Name(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "Bem vindo de novo", Str, "Ingresar", "X");
			return 0;
		}
		else
		{
			FirstLogin[playerid] = true;
			format(Str, sizeof(Str), "Seja bem-vindo ao nosso servidor, %s!\nPara efetuar seu cadastro, insira uma senha abaixo.\n*Sua senha deve conter entre 4 e 20 caracteres.", Name(playerid));
			ShowPlayerDialog(playerid, DIALOG_REGISTRO, DIALOG_STYLE_INPUT, "Bem vindo", Str, "Crear", "X");
			return 0;
		}
	}
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
		new strings[800];
		if(Patrulha[playerid] == false)
		{
			Patrulha[playerid] = true;
			SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			format(strings, sizeof(strings), "* Oficial %s se identificou e iniciou o trabalho.", Name(playerid));
			ProxDetector(30.0, playerid, strings, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
			SetPlayerColor(playerid, 0x0012FFFF);
			SetPlayerHealth(playerid, 100);
		}
		else
		{
			Patrulha[playerid] = false;
			SetPlayerHealth(playerid, 100);
			SetPlayerArmour(playerid, 0);	
			format(strings, sizeof(strings), "* Oficial %s se identificou como policial e deixou o trabado.", Name(playerid));
			ProxDetector(30.0, playerid, strings, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
			SetPlayerColor(playerid, 0xFFFFFFFF);
			SetPlayerHealth(playerid, 100);
		}
		return 1;
	}
	if(playertextid == HudCop[playerid][1])
	{
		if(Patrulha[playerid] == false) 		return notificacao(playerid, "INFO", "Nao esta em servico", ICONE_ERRO);
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
		new string[800];
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		format(string, sizeof(string), "* Oficial %s Pegou 9mm do armario", Name(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
		GivePlayerWeapon(playerid, 22, 100);
	}
	if(playertextid == CopGuns[playerid][1])
	{
		new string[800];
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		RemovePlayerWeapon(playerid, 25);
		RemovePlayerWeapon(playerid, 29);
		RemovePlayerWeapon(playerid, 31);
		format(string, sizeof(string), "* Oficial %s Pegou uma M4 do armario", Name(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
		GivePlayerWeapon(playerid, 31, 250);
	}
	if(playertextid == CopGuns[playerid][2])
	{
		new string[800];
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		RemovePlayerWeapon(playerid, 29);
		RemovePlayerWeapon(playerid, 31);
		RemovePlayerWeapon(playerid, 25);
		format(string, sizeof(string), "* Oficial %s Pegou uma SHOTGUN do armario", Name(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
		GivePlayerWeapon(playerid, 25, 15);
	}
	if(playertextid == CopGuns[playerid][3])
	{
		new string[800];
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 34);
		RemovePlayerWeapon(playerid, 25);
		RemovePlayerWeapon(playerid, 31);
		RemovePlayerWeapon(playerid, 29);
		format(string, sizeof(string), "* Oficial %s Pegou uma MP5 do armario", Name(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
		GivePlayerWeapon(playerid, 29, 250);
	}
	if(playertextid == CopGuns[playerid][4])
	{
		new string[800];
		SetPlayerArmour(playerid, 100);
		RemovePlayerWeapon(playerid, 29);
		RemovePlayerWeapon(playerid, 25);
		RemovePlayerWeapon(playerid, 31);
		RemovePlayerWeapon(playerid, 34);
		format(string, sizeof(string), "* Oficial %s Pegou um RIFLE del armario", Name(playerid));
		ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);    
		GivePlayerWeapon(playerid, 34, 25);
	}
	if(playertextid == HudCop[playerid][2])
	{
		new Ropa[800];
		if(Patrulha[playerid] == false) 		return notificacao(playerid, "INFO", "Nao esta em servico", ICONE_ERRO);
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}265\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}266\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}267\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}280\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}281\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}282\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}283\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}284\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}285\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}286\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}300\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}301\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}302\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}306\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}307\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}308\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}309\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}310\n");
		strcat(Ropa, "{FFFF00}- {FFFFFF}Roupa\t{FFFF00}311\n");
		strcat(Ropa, "{FFFFFF}- {FFFF00}Sacar Uniform\n");
		ShowPlayerDialog(playerid, DIALOG_ROPACOP, DIALOG_STYLE_LIST, "Roupas de Policia", Ropa, "Selecionar", "X");
	}
	if(GetPVarInt(playerid, "PlayMine") == 1) 
	{
		if(GetPVarInt(playerid, "StartedGame") == 1 && GetPVarInt(playerid, "Loser") == 0 ) 
		{
			new string[ 126 ];
			for(new i = 0; i < 30; i++) 
			{
				if(playertextid == CasinoPTD[i] && MineActive[playerid][i] == 0) 
				{
					MineActive[playerid][i] = 1;
					SetPVarInt(playerid, "Mines", 1+GetPVarInt(playerid, "Mines"));
					if(MineBomb[playerid][i] == 0) 
					{
						PlayerTextDrawBoxColor(playerid, CasinoPTD[i], 0x80FF00FF);
						PlayerTextDrawShow(playerid, CasinoPTD[i]);
						new money, bet = GetPVarInt(playerid, "BetAmount");
						if(GetPVarInt( playerid, "MineType") == 1) money += bet/8;
						else if(GetPVarInt(playerid, "MineType") == 3) money += bet/5;
						else if(GetPVarInt(playerid, "MineType") == 6) money += bet/3;
						SetPVarInt(playerid, "MoneyEarned", money+GetPVarInt(playerid, "MoneyEarned"));

						PlayerTextDrawSetString(playerid, CasinoPTD[30], "~g~Ganhou! : )" );
						format(string, sizeof(string), "Jugadas: ~g~%d~w~~h~~n~Dinheiro ganho: ~g~R$%s", GetPVarInt(playerid, "Mines"), FormatNumber(GetPVarInt(playerid, "MoneyEarned")));
						PlayerTextDrawSetString(playerid, CasinoPTD[31], string);
						MissaoPlayer[playerid][MISSAO10] = 1;
					} 
					else 
					{
						PlayerTextDrawSetString(playerid, CasinoPTD[30], "~r~Perdeu!~n~");

						format(string, sizeof(string), "* %s perdeu R$%s no jogo da mina.", GetName(playerid), FormatNumber(GetPVarInt(playerid, "BetAmount")));
						ProxDetector(30.0, playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
						MissaoPlayer[playerid][MISSAO10] = 1;
						for( new x = 0; x < 30; x++ ) 
						{
							if(MineBomb[playerid][x] == 1) 
							{
								PlayerTextDrawBoxColor(playerid, CasinoPTD[x], 0xFF0000FF);
								PlayerTextDrawShow(playerid, CasinoPTD[x]);
							}
						} 

						format(string, sizeof(string), "Jogadas: ~g~%d~w~~h~~n~Dinheiro ganho: ~g~R$%s", GetPVarInt(playerid, "Mines"), FormatNumber(GetPVarInt(playerid, "MoneyEarned")));
						PlayerTextDrawSetString(playerid, CasinoPTD[31], string);

						SetTimerEx("ShowMine", 5000, 0, "i", playerid);
						SetPVarInt(playerid, "Loser", 1);
					}
					PlayerTextDrawShow(playerid, CasinoPTD[30]);
					PlayerTextDrawShow(playerid, CasinoPTD[31]);
				}
			}
		}
		if(playertextid == CasinoPTD[32] && GetPVarInt(playerid, "BetAmount") == 0) 
		{
			ShowPlayerDialog(playerid, DIALOG_BETCASINO, DIALOG_STYLE_INPUT, "Quanto quer apostar?", "Quantidade de dinheiro que deseja apostar.\nPode colocar de 50k a 100kk", "Confirmar", "X");
		}
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

	if(playertextid == wMenuRodas[1]) AddVehicleComponent(wVeiculo,1073);         // SHADOW
    if(playertextid == wMenuRodas[2]) AddVehicleComponent(wVeiculo, 1074);        // MEGA
    if(playertextid == wMenuRodas[3]) AddVehicleComponent(wVeiculo,1075);         // RINSHIME
    if(playertextid == wMenuRodas[4]) AddVehicleComponent(wVeiculo,1076);         // WIRES
    if(playertextid == wMenuRodas[5]) AddVehicleComponent(wVeiculo,1077);         // CLASSIC
    if(playertextid == wMenuRodas[6]) AddVehicleComponent(wVeiculo,1078);         // TWIST
    if(playertextid == wMenuRodas[7]) AddVehicleComponent(wVeiculo,1079);         // CUTTER
    if(playertextid == wMenuRodas[8]) AddVehicleComponent(wVeiculo,1083);         // DOLLAR
    if(playertextid == wMenuRodas[9]) AddVehicleComponent(wVeiculo,1085);         // ATOMIC
    if(playertextid == wMenuRodas[10]) AddVehicleComponent(wVeiculo,1097);        // VIRTUAL
    //if(playertextid == wMenuRodas[11]) AddVehicleComponent(wVeiculo,1081);        // GROVE
    //if(playertextid == wMenuRodas[12]) AddVehicleComponent(wVeiculo,1080);        // SWIST

    if(playertextid == wMenuCores[1]) ChangeVehicleColor(wVeiculo, 1, 1);         // BRANCO
    if(playertextid == wMenuCores[2]) ChangeVehicleColor(wVeiculo, 79, 79);       // AZUL
    if(playertextid == wMenuCores[3]) ChangeVehicleColor(wVeiculo, 194, 194);     // AMARELO
    if(playertextid == wMenuCores[4]) ChangeVehicleColor(wVeiculo, 211, 211);     // ROXO
    if(playertextid == wMenuCores[5]) ChangeVehicleColor(wVeiculo, 137, 137);     // VERDE
    if(playertextid == wMenuCores[6]) ChangeVehicleColor(wVeiculo, 75, 75);       // CINZA
    if(playertextid == wMenuCores[7]) ChangeVehicleColor(wVeiculo, 136, 136);     // ROSA
    if(playertextid == wMenuCores[8]) ChangeVehicleColor(wVeiculo, 129, 129);     // MARROM
    if(playertextid == wMenuCores[9]) ChangeVehicleColor(wVeiculo, 3, 3);         // VERMELHO
    if(playertextid == wMenuCores[10]) ChangeVehicleColor(wVeiculo, 158, 158);    // LARANJA

    if(playertextid == wMenuPaintJobs[1])  ChangeVehiclePaintjob(wVeiculo, 0);    // PAINTJOBS 1
    if(playertextid == wMenuPaintJobs[2])   ChangeVehiclePaintjob(wVeiculo, 1);   // PAINTJOBS 2
    if(playertextid == wMenuPaintJobs[3])   ChangeVehiclePaintjob(wVeiculo, 2);   // PAINTJOBS 3

    if(playertextid == wMenuNitro[1])      AddVehicleComponent(wVeiculo,1009);    // NITRO 1
    if(playertextid == wMenuNitro[2])      AddVehicleComponent(wVeiculo,1008);    // NITRO 2
    if(playertextid == wMenuNitro[3])      AddVehicleComponent(wVeiculo,1010);    // NITRO 3

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
    }
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == TDEditor_TD[20])
	{
		for(new i; i < 66; i++)
		{
			TextDrawHideForPlayer(playerid, TDEditor_TD[i]);
		}
		for(new i; i < 6; i++)
		{
			PlayerTextDrawHide(playerid, TDEditor_PTD[playerid][i]);
		}
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
	if(GetPVarInt(playerid, "PlayMine") == 1 && GetPVarInt(playerid, "Loser") == 0) 
	{
		new string[128];
		if(clickedid == CasinoTD[4]) 
		{
			if(GetPVarInt(playerid, "StartedGame") == 1 && GetPVarInt(playerid, "Mines") > 0) return notificacao(playerid, "ERRO", "Para salir deber sacar su dinero.", ICONE_ERRO);
			HideCasinoTDs(playerid);
		}
		if(clickedid == CasinoTD[6] && GetPVarInt(playerid, "StartedGame") == 1 && GetPVarInt(playerid, "Mines") > 0) 
		{
			PlayerInfo[playerid][pDinheiro] += GetPVarInt( playerid, "BetAmount");
			PlayerInfo[playerid][pDinheiro] += GetPVarInt( playerid, "MoneyEarned");
			format(string, sizeof(string), "* %s ganhou R$%s no jogo da mina.", GetName(playerid), FormatNumber(GetPVarInt(playerid, "MoneyEarned")));
			ProxDetector(30.0,playerid, string, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE, COLOR_PURPLE);
			format(string, sizeof(string), "~g~Ganhou R$%s.", FormatNumber(GetPVarInt(playerid, "MoneyEarned")));
			ShowCasinoTDs(playerid);
			PlayerTextDrawSetString(playerid, CasinoPTD[30], string);
			PlayerTextDrawShow(playerid, CasinoPTD[ 30]);
			format(string, sizeof(string), "Jogadas: ~g~%d~w~~h~~n~Dinheiro ganho: ~g~R$%s", GetPVarInt(playerid, "Mines"), FormatNumber(GetPVarInt(playerid, "MoneyEarned")));
			PlayerTextDrawSetString(playerid, CasinoPTD[31], string);
			PlayerTextDrawShow(playerid, CasinoPTD[31]);
			return 1;
		}
		if(GetPVarInt(playerid, "StartedGame") == 1) return notificacao(playerid, "INFO", "Juego iniciado! No se pueden realizar mas cambios hasta que realice el retiro.", ICONE_AVISO);
		if( clickedid == CasinoTD[ 9 ] && GetPVarInt( playerid, "MineType" ) == 0 ) SetPVarInt( playerid, "MineType", 1 ), TextDrawColor(CasinoTD[9], 0x80FF00FF ), TextDrawShowForPlayer( playerid, CasinoTD[ 9 ] );
		if( clickedid == CasinoTD[ 7 ] && GetPVarInt( playerid, "MineType" ) == 0 ) SetPVarInt( playerid, "MineType", 3 ), TextDrawColor(CasinoTD[7], 0x80FF00FF ), TextDrawShowForPlayer( playerid, CasinoTD[ 7 ] );
		if( clickedid == CasinoTD[ 12 ] && GetPVarInt( playerid, "MineType" ) == 0 ) SetPVarInt( playerid, "MineType", 6 ), TextDrawColor(CasinoTD[ 12 ], 0x80FF00FF ), TextDrawShowForPlayer( playerid, CasinoTD[ 12 ] );

		if( clickedid == CasinoTD[ 5 ] ) 
		{
			if( GetPVarInt( playerid, "MineType" ) == 0 || GetPVarInt( playerid, "BetAmount" ) == 0 ) return notificacao(playerid, "ERRO", "El juego no comenzo porque no aposto un valor / no eligio la cantidad de bombas.", ICONE_ERRO);
			for( new i = 0; i < 30; i++ ) MineBomb[ playerid ][ i ] = 0;

			new
				rand1 = random( 30 ),
				rand2 = random( 30 ),
				rand3 = random( 30 ),
				rand4 = random( 30 ),
				rand5 = random( 30 ),
				rand6 = random( 30 );

			if( rand1 == rand2 || rand1 == rand3 || rand1 == rand4 || rand1 == rand5 || rand1 == rand6 ) rand1 = random( 30 );
			if( rand2 == rand1 || rand2 == rand3 || rand2 == rand4 || rand2 == rand5 || rand2 == rand6 ) rand2 = random( 30 );
			if( rand3 == rand1 || rand3 == rand2 || rand3 == rand4 || rand3 == rand5 || rand3 == rand6 ) rand3 = random( 30 );
			if( rand4 == rand1 || rand4 == rand2 || rand4 == rand3 || rand4 == rand5 || rand4 == rand6 ) rand4 = random( 30 );
			if( rand5 == rand1 || rand5 == rand2 || rand5 == rand3 || rand5 == rand4 || rand5 == rand6 ) rand5 = random( 30 );
			if( rand6 == rand1 || rand6 == rand2 || rand6 == rand3 || rand6 == rand4 || rand6 == rand5 ) rand6 = random( 30 );

			if( rand1 == rand2 || rand1 == rand3 || rand1 == rand4 || rand1 == rand5 || rand1 == rand6 ) rand1 = random( 30 );
			if( rand2 == rand1 || rand2 == rand3 || rand2 == rand4 || rand2 == rand5 || rand2 == rand6 ) rand2 = random( 30 );
			if( rand3 == rand1 || rand3 == rand2 || rand3 == rand4 || rand3 == rand5 || rand3 == rand6 ) rand3 = random( 30 );
			if( rand4 == rand1 || rand4 == rand2 || rand4 == rand3 || rand4 == rand5 || rand4 == rand6 ) rand4 = random( 30 );
			if( rand5 == rand1 || rand5 == rand2 || rand5 == rand3 || rand5 == rand4 || rand5 == rand6 ) rand5 = random( 30 );
			if( rand6 == rand1 || rand6 == rand2 || rand6 == rand3 || rand6 == rand4 || rand6 == rand5 ) rand6 = random( 30 );

			if( rand1 == rand2 || rand1 == rand3 || rand1 == rand4 || rand1 == rand5 || rand1 == rand6 ) rand1 = random( 30 );
			if( rand2 == rand1 || rand2 == rand3 || rand2 == rand4 || rand2 == rand5 || rand2 == rand6 ) rand2 = random( 30 );
			if( rand3 == rand1 || rand3 == rand2 || rand3 == rand4 || rand3 == rand5 || rand3 == rand6 ) rand3 = random( 30 );
			if( rand4 == rand1 || rand4 == rand2 || rand4 == rand3 || rand4 == rand5 || rand4 == rand6 ) rand4 = random( 30 );
			if( rand5 == rand1 || rand5 == rand2 || rand5 == rand3 || rand5 == rand4 || rand5 == rand6 ) rand5 = random( 30 );
			if( rand6 == rand1 || rand6 == rand2 || rand6 == rand3 || rand6 == rand4 || rand6 == rand5 ) rand6 = random( 30 );

			if( GetPVarInt( playerid, "MineType" ) >= 1 ) MineBomb[ playerid ][ rand1 ] = 1;
			if( GetPVarInt( playerid, "MineType" ) >= 3 ) 
			{
				MineBomb[ playerid ][ rand2 ] = 1;
				MineBomb[ playerid ][ rand3 ] = 1;
			}
			if( GetPVarInt( playerid, "MineType" ) == 6 ) 
			{
				MineBomb[ playerid ][ rand4 ] = 1;
				MineBomb[ playerid ][ rand5 ] = 1;
				MineBomb[ playerid ][ rand6 ] = 1;
			}

			SetPVarInt( playerid, "StartedGame", 1 );
			PlayerTextDrawSetString( playerid, CasinoPTD[ 30 ], "O_jogo_comecou!" );
			PlayerTextDrawShow( playerid, CasinoPTD[ 30 ] );
		}
	}
	if(clickedid == Text:INVALID_TEXT_DRAW) 
	{
		if(GetPVarInt(playerid, "PlayMine") == 1 || GetPVarInt(playerid, "StartedGame") == 1) SelectTextDraw(playerid, 0x80FF00FF);
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

CMD:ajuda(playerid, params[])
{
	MEGAString[0] = EOS;
	strcat(MEGAString, "{FFFF00}- {ffffff}FAQ\n{FFFF00}- {ffffff}Comandos Geral\n{FFFF00}- {ffffff}Comandos Empregos\n");
	strcat(MEGAString, "{FFFF00}- {ffffff}Comandos Lideres\n{FFFF00}- {ffffff}Comandos Organizacao\n{FFFF00}- {ffffff}Comandos Veiculo\n");
	strcat(MEGAString, "{FFFF00}- {ffffff}Comandos Inventario\n");
	strcat(MEGAString, "{FFFF00}- {ffffff}Comandos Casa\n");
	ShowPlayerDialog(playerid, DIALOG_AJUDA, DIALOG_STYLE_LIST, "Central de Ajuda", MEGAString, "Confirmar", "X");
	MissaoPlayer[playerid][MISSAO11] = 1;
	return 1;
}
CMD:mvoip(playerid){
	ShowPlayerDialog(playerid, D_VOIP, DIALOG_STYLE_LIST, "Config VOIP", "{FFFF00}[1].{FFFFFF} Falando\n{FFFF00}[2].{FFFFFF} Susurrando\n\
	{FFFF00}[3].{FFFFFF} Gritando\n", "Selecionar", "Cancelar");
	return 1;
}

CMD:cinto(playerid){
	new str[128];
	if(TemCinto[playerid] == false){
		TemCinto[playerid] = true;
		notificacao(playerid, "EXITO", "Cinto de seguranca colocado", ICONE_CERTO);
		format(str, sizeof(str), "** %s colocou o cinto de seguranca", Name(playerid));
		ProxDetector(20.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		for(new x=0;x<5;x++){
			TextDrawHideForPlayer(playerid, Tdcinto[x]);
		}
	}else{
		TemCinto[playerid] = false;
		notificacao(playerid, "EXITO", "Cinto de seguranca removido", ICONE_CERTO);
		format(str, sizeof(str), "** %s retirou o cinto de seguranca", Name(playerid));
		ProxDetector(20.0, playerid, str, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
		for(new x=0;x<5;x++){
			TextDrawShowForPlayer(playerid, Tdcinto[x]);
		}
	}
	return true;
}

CMD:gps(playerid)
{
	ShowPlayerDialog(playerid, DIALOG_GPS, DIALOG_STYLE_LIST, "Onde deseja ir?", "{FFFF00}- {FFFFFF}Locais importantes\n{FFFF00}- {FFFFFF}Localizar uma Casa", "Selecionar", "X");
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
				if(!CheckInventario(playerid, DropItemSlot[i][DropItemID])) return notificacao(playerid, "ERRO", "Su inventario esta lleno.", ICONE_ERRO);
				GanharItem(playerid, DropItemSlot[i][DropItemID], DropItemSlot[i][DropItemUni]);
				format(str, sizeof(str), "Pegou %s do chao %s com unidades.", ItemNomeInv(DropItemSlot[i][DropItemID]), ConvertMoney(DropItemSlot[i][DropItemUni]));
				DestroyDynamicObject(DropItemSlot[i][DropItem]);
				DestroyDynamic3DTextLabel(DropItemSlot[i][LabelItem]);
				DropItemSlot[i][DropItem] = 0;
				DropItemSlot[i][DropItemID] = -1;
				DropItemSlot[i][DropItemUni] = 0;
				DropItemSlot[i][Interior] = 0;
				DropItemSlot[i][Virtual] = 0;
				notificacao(playerid, "EXITO", str, ICONE_CERTO);
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
	if(PlayerInfo[playerid][pAdmin] < 5)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "iii", id, item, quantia)) return SendClientMessage(playerid, -1, "Use: /daritem [ID] [ITEM ID] [UNIDADES].");
	if(!IsPlayerConnected(id)) return notificacao(playerid, "ERRO", "Jogador nao conectado.", ICONE_ERRO);
	if(!IsValidItemInv(item)) return notificacao(playerid, "ERRO", "Item indefinido.", ICONE_ERRO);
	if(quantia < 1) return notificacao(playerid, "ERRO", "Coloque uma quantia.", ICONE_ERRO);
	if(!CheckInventario(id, item)) return notificacao(playerid, "ERRO", "Inventario cheio.", ICONE_ERRO);
	GanharItem(id, item, quantia);
	new str[256];
	format(str, sizeof(str), "[Items]: %s setou o item %s com %s unidades no inventario de %s.", Name(playerid),
		ItemNomeInv(item), ConvertMoney(quantia), PlayerName(id));
	SendClientMessageToAll(0xEA6AACAA, str);
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
		format(str, sizeof(str), "{FFFFFF}*{FFFF00}%s {FFFFFF}fechou o inventario.", Name(playerid));
		SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
		return 1;
	}
	else
	{
		format(str, sizeof(str), "Inventario: %s", Name(playerid));
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
		format(str, sizeof(str), "{FFFFFF}*{FFFF00}%s {FFFFFF}abriu o inventario.", Name(playerid));
		SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
	}
	return 1;
}

CMD:report(playerid, params[])
{
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao fez login.", ICONE_ERRO);
	if(sscanf(params, "is[56]", ID, Motivo))					return SendClientMessage(playerid, CorErroNeutro, "USE: /report [ID] [RAZON]");
	if(!IsPlayerConnected(ID))  								return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	notificacao(playerid, "EXITO", "Os administradores foram notificados. Bom jogo !", ICONE_CERTO);
	//
	format(Str, sizeof(Str), "{FFFFFF}REPORT {FFFF00}%s{FFFFFF}(ID:{FFFF00}%d{FFFFFF}) report {FFFF00}%s{FFFFFF}(ID:{FFFF00}%d{FFFFFF}) Motivo: {FFFF00}%s", Name(playerid), playerid, Name(ID), ID, Motivo);
	SendAdminMessage(AzulClaro, Str);
	//
	new string[100];
	format(string,sizeof(string),"%s fez report em %s motivo %s", Name(playerid), Name(ID), Motivo);
	DCC_SendChannelMessage(Report, string);
	return 1;
}

CMD:duvida(playerid, params[])
{
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao fez login.", ICONE_ERRO);
	if(sscanf(params, "s[56]", Str))							return SendClientMessage(playerid, CorErroNeutro, "USE: /duvida [TEXTO]");
	//
	format(Str, sizeof(Str), "{07fc03}Duvida{FFF} %s{FFFF00} disse {FFFFFF}%s", Name(playerid), Str);
	SendClientMessageToAll(-1, Str);
	return 1;
}

CMD:presos(playerid)
{
	foreach(new i: Player)
	{
		if(PlayerInfo[i][pCadeia] > 0)
		{
			format(Str, sizeof(Str), "{FFFF00}%s - {FFFFFF}Preso por {FFFF00}%d {FFFFFF}segundos [{FFFF00}%d {FFFFFF}minutes]", Name(i), PlayerInfo[i][pCadeia], PlayerInfo[i][pCadeia] / 60);
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
		SendClientMessage(playerid, CorErro, "{FFFF00}AVISO{FFFFFF} Conectado como Desenvolvedor");
		pJogando[playerid] = false;
	}
	if(!strcmp(sendername,"kawacbk", false))
	{
		PlayerInfo[playerid][pAdmin] = 6;
		SendClientMessage(playerid, CorErro, "{FFFF00}AVISO{FFFFFF} Conectado como Fundador");
		pJogando[playerid] = false;
	}
	if(!strcmp(sendername,"Chosen_Estranho", false))
	{
		PlayerInfo[playerid][pAdmin] = 5;
		SendClientMessage(playerid, CorErro, "{FFFF00}AVISO{FFFFFF} Conectado como Coordenador");
		pJogando[playerid] = false;
	}
	if(!strcmp(sendername,"Allison_Gomes", false))
	{
		PlayerInfo[playerid][pAdmin] = 7;
		SendClientMessage(playerid, CorErro, "{FFFF00}AVISO{FFFFFF} Conectado como Desenvolvedor");
		pJogando[playerid] = false;
	}
	return 1;

}

CMD:pos(playerid, params[])
{
	new msg[500];
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "s[56]", msg))return SendClientMessage(playerid, 0xFF0000AA,"Use /pos [nomedolocal].");

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
	format(string, 200, "%f, %f, %f, %f//%s\n", x,y,z,a,msg);
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
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "s[56]", Motivo)) 							return SendClientMessage(playerid, CorErroNeutro, "USE: /a [TEXTO]");
	//
	format(Str, sizeof(Str), "{FFFFFF}[{FFFF00}%s{FFFFFF}] {FFFF00}%s{FFFFFF} disse {FFFF00}%s", AdminCargo(playerid), Name(playerid), Motivo);
	SendAdminMessage(0xDDA0DDFF, Str);
	//
	new string2[100];
	format(string2,sizeof(string2),"%s disse %s", Name(playerid), Motivo);
	DCC_SendChannelMessage(ChatAdm, string2);
	return 1;
}

CMD:av(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "s[56]", Motivo)) 						return SendClientMessage(playerid, CorErroNeutro, "USE: /av [TEXTO]");
	SendClientMessageToAll(Branco, " ");
	SendClientMessageToAll(Branco, " ");
	SendClientMessageToAll(Branco, " ");
	SendClientMessageToAll(-1,"|___________| {FFFF00}ANUNCIO {FFFFFF}|___________|");
	format(Str, sizeof(Str), "{FFFFFF}ADM: {FFFF00}%s {FFFFFF}anuncio: {FFFF00}%s", Name(playerid), Motivo);
	SendClientMessageToAll(AzulRoyal, Str);
	SendClientMessageToAll(Branco, " ");
	SendClientMessageToAll(Branco, " ");
	SendClientMessageToAll(Branco, " ");
	return 1;
}

CMD:setskin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "di", ID, Numero))						return SendClientMessage(playerid, CorErroNeutro, "USE: /setskin [ID] [SKIN ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	format(Str, sizeof(Str), "{FFFFFF}Colocou a skin de {FFFF00}%s {FFFFFF}para: {FFFF00}%i", Name(ID), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}colocou sua skin para: {FFFF00}%i", Name(playerid), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	PlayerInfo[playerid][pSkin] = Numero;
	SetPlayerSkin(ID, Numero);
	//
	format(Str, sizeof(Str), "O Administrador %s deu a %s skin %d.", Name(playerid), Name(ID), Numero);
	DCC_SendChannelMessage(Sets, Str);
	return 1;
}

CMD:setvida(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "dd", ID, Numero))						return SendClientMessage(playerid, CorErroNeutro, "USE: /setvida [ID] [VIDA]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	SetPlayerHealth(ID, Numero);
	//
	format(Str, sizeof(Str), "{FFFFFF}Colocou a vida de {FFFF00}%s {FFFFFF}para: {FFFF00}%d", Name(ID), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}colocou sua vida para: {FFFF00}%d", Name(playerid), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "O Administrador %s deu a %s %d de vida.", Name(playerid), Name(ID), Numero);
	DCC_SendChannelMessage(Sets, Str);
	return 1;
}

CMD:setcolete(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "dd", ID, Numero))						return SendClientMessage(playerid, CorErroNeutro, "USE: /setcolete [ID] [COLETE]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	SetPlayerArmour(ID, Numero);
	//
	format(Str, sizeof(Str), "{FFFFFF}Colocou o colete de {FFFF00}%s {FFFFFF}para: {FFFF00}%d", Name(ID), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}colocou seu colete para: {FFFF00}%d", Name(playerid), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "O Administrador %s dio a %s %d de chaleco.", Name(playerid), Name(ID), Numero);
	DCC_SendChannelMessage(Sets, Str);
	return 1;
}

CMD:cv(playerid, params[])
{
	//
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)      	return notificacao(playerid, "ERRO", "Nao pode criar um veiculo quando esta em outro.", ICONE_ERRO);
	if(sscanf(params, "i", Numero))				return SendClientMessage(playerid, CorErro, "USE: /cv [ID]");
	if(Numero < 400 || Numero > 611)							return notificacao(playerid, "ERRO", "ID no valido.", ICONE_ERRO);
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	if(VehAlugado[playerid] == 0)
	{
		VehAlugado[playerid] = 1;
		VeiculoCivil[playerid] = CreateVehicle(Numero, Pos[0], Pos[1], Pos[2], 90, 5, 5, false);
		PutPlayerInVehicle(playerid, VeiculoCivil[playerid], 0);
		notificacao(playerid, "INFO", "Para devolver seu veiculo use /dveiculo.", ICONE_AVISO);
	}
	else
	{
		notificacao(playerid, "INFO", "Ja possui um veiculo use /dveiculo.", ICONE_ERRO);
	}
	return 1;
}

CMD:kick(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "ds[56]", ID, Motivo))					return SendClientMessage(playerid, CorErroNeutro, "USE: /kick [ID] [MOTIVO]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF}O jogador {FFFF00}%s {FFFFFF}foi kickado por administrador {FFFF00}%s{FFFFFF}. Motivo: {FFFF00}%s", Name(ID), Name(playerid), Motivo);
	SendClientMessageToAll(VermelhoEscuro, Str);
	Kick(ID);
	//
	Log("Logs/Kick.ini", Str);
	return 1;
}

CMD:cadeia(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "iis[56]", ID, Numero, Motivo))			return SendClientMessage(playerid, CorErroNeutro, "USE: /cadeia [ID] [TEMPO EM MINUTOS] [MOTIVO]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	if(Numero != 0)
	{
		PlayerInfo[ID][pCadeia] = Numero * 60;
		SetPlayerPos(ID,  322.197998,302.497985,999.148437);
		SetPlayerInterior(ID, 5);
		SetPlayerVirtualWorld(ID, 0);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("carregarobj", 5000, 0, "i", playerid);

		SendClientMessage(ID, VermelhoEscuro, "Foi preso");
	}
	else
	{
		PlayerInfo[ID][pCadeia] = 1;
	}
	//
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}prendeu {FFFF00}%s {FFFFFF}por {FFFF00}%i {FFFFFF}minutos. Motivo: {FFFF00}%s", Name(playerid), Name(ID), Numero, Motivo);
	SendClientMessageToAll(VermelhoEscuro, Str);
	//
	Log("Logs/Cadeia.ini", Str);
	return 1;
}

CMD:ir(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "d", ID))									return SendClientMessage(playerid, CorErroNeutro, "USE: /ir [ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	GetPlayerPos(ID, Pos[0], Pos[1], Pos[2]);
	//
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}foi em {FFFF00}%s", Name(playerid), Name(ID));
		SendClientMessage(ID, CorSucesso, Str);
	}
	else
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	}
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(ID));
	SetPlayerInterior(playerid, GetPlayerInterior(ID));
	//
	format(Str, sizeof(Str), "AdmCmd: O administrador %s foi até %s", Name(playerid), Name(ID));
	Log("Logs/Ir.ini", Str);
	return 1;
}

CMD:trazer(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "u", ID))									return SendClientMessage(playerid, CorErroNeutro, "USE: /trazer [ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	//
	if(GetPlayerState(ID) != PLAYER_STATE_DRIVER)
	{
		SetPlayerPos(ID, Pos[0], Pos[1], Pos[2]);
		TogglePlayerControllable(ID, false);
		SetTimerEx("carregarobj", 5000, 0, "i", ID);
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}trouxe {FFFF00}%s", Name(playerid), Name(ID));
		SendClientMessage(ID, CorSucesso, Str);
	}
	else
	{
		SetVehiclePos(GetPlayerVehicleID(ID), Pos[0], Pos[1], Pos[2]);
	}
	SetPlayerVirtualWorld(ID, GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(ID, GetPlayerInterior(playerid));
	//
	format(Str, sizeof(Str), "AdmCmd: O administrador %s trouxe %s até ele.", Name(playerid), Name(ID));
	Log("Logs/Trazer.ini", Str);
	return 1;
}

CMD:hir(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(PlayerInfo[playerid][pAvaliacao] < 50)						return notificacao(playerid, "ERRO", "Nao possui 50 pontos de avaliacao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "d", ID))									return SendClientMessage(playerid, CorErroNeutro, "USE: /ir [ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	GetPlayerPos(ID, Pos[0], Pos[1], Pos[2]);
	//
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER)
	{
		SetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
		TogglePlayerControllable(playerid, false);
		SetTimerEx("carregarobj", 5000, 0, "i", playerid);
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}foi em {FFFF00}%s", Name(playerid), Name(ID));
		SendClientMessage(ID, CorSucesso, Str);
	}
	else
	{
		SetVehiclePos(GetPlayerVehicleID(playerid), Pos[0], Pos[1], Pos[2]);
	}
	SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(ID));
	SetPlayerInterior(playerid, GetPlayerInterior(ID));
	//
	format(Str, sizeof(Str), "AdmCmd: O administrador %s foi até %s", Name(playerid), Name(ID));
	Log("Logs/Ir.ini", Str);
	return 1;
}

CMD:htrazer(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(PlayerInfo[playerid][pAvaliacao] < 50)						return notificacao(playerid, "ERRO", "Nao possui 50 pontos de avaliacao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "u", ID))									return SendClientMessage(playerid, CorErroNeutro, "USE: /trazer [ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	GetPlayerPos(playerid, Pos[0], Pos[1], Pos[2]);
	//
	if(GetPlayerState(ID) != PLAYER_STATE_DRIVER)
	{
		SetPlayerPos(ID, Pos[0], Pos[1], Pos[2]);
		TogglePlayerControllable(ID, false);
		SetTimerEx("carregarobj", 5000, 0, "i", ID);
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}trouxe {FFFF00}%s", Name(playerid), Name(ID));
		SendClientMessage(ID, CorSucesso, Str);
	}
	else
	{
		SetVehiclePos(GetPlayerVehicleID(ID), Pos[0], Pos[1], Pos[2]);
	}
	SetPlayerVirtualWorld(ID, GetPlayerVirtualWorld(playerid));
	SetPlayerInterior(ID, GetPlayerInterior(playerid));
	//
	format(Str, sizeof(Str), "AdmCmd: O administrador %s trouxe %s até ele.", Name(playerid), Name(ID));
	Log("Logs/Trazer.ini", Str);
	return 1;
}

CMD:contagem(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "i", ID)) 								return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /contagem [VALOR INICIAL]");
	if(ID < 1 || ID > 20) 										return notificacao(playerid, "ERRO", "20s e o maximo.", ICONE_ERRO);
	if(ContagemIniciada == true)
	{
		SendClientMessage(playerid, CorErro, "{FFFF00}AVISO{FFFFFF} Ja tem uma contagem rolando");
	}
	else
	{
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador: {FFFF00}%s {FFFFFF}comecou uma contagem {FFFF00}%i {FFFFFF}segundos.", Name(playerid), ID);
		SendClientMessageToAll(CorSucesso, Str);
		SetTimerEx("DiminuirTempo", 1000, false, "i", ID);
		ContagemIniciada = true;
		//
		Log("Logs/Contagem.ini", Str);
	}
	return 1;
}

CMD:tv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(IsAssistindo[playerid] == false)
	{
		if(sscanf(params, "i", ID))								return SendClientMessage(playerid, CorErroNeutro, "USE: /tv [ID]");
		if(!IsPlayerConnected(ID))              				return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
		if(!IsPlayerInAnyVehicle(ID))
		{
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, ID);
		}
		else
		{
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectateVehicle(playerid, GetPlayerVehicleID(ID));

		}
		SetPlayerInterior(playerid, GetPlayerInterior(ID));
		SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(ID));
		Assistindo[playerid] = ID;
		IsAssistindo[playerid] = true;
		format(Str, sizeof(Str), "O administrador %s ligou a TV em %s", Name(playerid), Name(ID));
		Log("Logs/TV.ini", Str);
	}
	else
	{
		TogglePlayerSpectating(playerid, 0);
		IsAssistindo[playerid] = false;
		Assistindo[playerid] = -1;
		format(Str, sizeof(Str), "O administrador %s desligou a TV em %s", Name(playerid), Name(Assistindo[playerid]));
		Log("Logs/TV.ini", Str);
	}
	return 1;
}

CMD:setarma(playerid, params[])
{
	new Municao, Arma;
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "iii", ID, Arma, Municao))				return SendClientMessage(playerid, CorErroNeutro, "USE: /setarma [ID] [ARMA] [MUNIÇÃO]");
	if(!IsPlayerConnected(ID)) 									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(Arma<1 || Arma==19 || Arma==20||Arma==21||Arma>46)		return notificacao(playerid, "ERRO", "ID nao valido.", ICONE_ERRO);
	//
	GivePlayerWeapon(ID, Arma, Municao);
	//
	format(Str, sizeof(Str), "{FFFFFF}O Administrador {FFFF00}%s {FFFFFF} te deu uma arma id{FFFF00}%d {FFFFFF}com {FFFF00}%d {FFFFFF}balas.", Name(playerid), Motivo, Municao);
	SendClientMessage(ID, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "{FFFFFF}Voce deu a {FFFF00}%s{FFFFFF} uma arma id {FFFF00}%d {FFFFFF}com {FFFF00}%d {FFFFFF}balas.", Name(ID), Motivo, Municao);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "O Administrador %s deu uma %s com %i balas a %s", Name(playerid), Motivo, Municao, Name(ID));
	DCC_SendChannelMessage(Sets, Str);
	return 1;
}

CMD:desarmar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "d", ID))									return SendClientMessage(playerid, CorErroNeutro, "USE: /desarmar [ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	ResetPlayerWeapons(ID);
	//
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} Desarmar: {FFFF00}%s", Name(ID));
	SendClientMessage(ID, CorSucesso, Str);
	//
	format(Str, 106, "{FFFF00}AVISO{FFFFFF} Foi desarmado pelo administrador {FFFF00}%s", Name(playerid));
	SendClientMessage(ID, CorSucesso, Str);
	//
	format(Str, 106, "AdmCmd: %s desarmou %s", Name(playerid), Name(ID));
	Log("Logs/Desarmar.ini", Str);
	return 1;
}

CMD:banir(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "is[56]", ID, Motivo)) 					return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /banir [ID] [MOTIVO]");
	if(!IsPlayerConnected(ID))                  				return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	BanirPlayer(ID, playerid, Motivo);
	return 1;
}

CMD:hbanir(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(PlayerInfo[playerid][pAvaliacao] < 50)						return notificacao(playerid, "ERRO", "Nao possui 50 pontos de avaliacao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "is[56]", ID, Motivo)) 					return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /banir [ID] [MOTIVO]");
	if(!IsPlayerConnected(ID))                  				return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	BanirPlayer(ID, playerid, Motivo);
	return 1;
}

CMD:tempban(playerid,params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	new Dias;
	if(sscanf(params, "iis[56]", ID, Dias, Motivo)) 			return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /tempban [ID] [TEMPO] [MOTIVO]");
	if(!IsPlayerConnected(ID))                  				return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(Dias == 0)                                               return notificacao(playerid, "ERRO", "Nao pode banir alguem durante 0 dias. USA: /ban para banir permanentes.", ICONE_ERRO);
	if(Dias >= 360)                                             return notificacao(playerid, "ERRO", "Voce so pode banir alguem por no maximo 360 dias.", ICONE_ERRO);
	//
	new Data[24], Dia, Mes, Ano, Hora, Minuto;
	gettime(Hora, Minuto);
	getdate(Ano, Mes, Dia);
	format(Data, 24, "%02d/%02d/%d - %02d:%02d", Dia, Mes, Ano, Hora, Minuto);
	format(File, sizeof(File), PASTA_BANIDOS, Name(ID));
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
	format(Str, sizeof(Str), "{FFFF00}ADMIN{FFFFFF} O jogador {FFFF00}%s {FFFFFF}foi banido por {FFFF00}%i {FFFFFF}dias pelo administrador {FFFF00}%s{FFFFFF}. Motivo: {FFFF00}%s", Name(ID), Dias, Name(playerid), Motivo);
	SendClientMessageToAll(VermelhoEscuro, Str);
	Kick(ID);
	return 1;
}

CMD:antiafk(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(AntiAFK_Ativado)
	{
		AntiAFK_Ativado = false;
		notificacao(playerid, "EXITO", "Anti-AFK desativado.", ICONE_CERTO);
	}
	else
	{
		AntiAFK_Ativado = true;
		notificacao(playerid, "EXITO", "Anti-AFK ativado.", ICONE_CERTO);
	}
	return 1;
}

CMD:agendaban(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true)								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	new Nome[24], tempo;
	if(sscanf(params, "s[56]is[56]", Nome, tempo, Motivo))		return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /agendarban [CONTA] [TEMPO EM DIAS (999 = FOREVER)] [MOTIVO]");
	format(File, sizeof(File), PASTA_CONTAS, Nome);
	if(!DOF2_FileExists(File))              					return notificacao(playerid, "ERRO", "Conta nao existente.", ICONE_ERRO);
	format(Str, sizeof(Str), "Agendado - %s", Motivo);
	AgendarBan(Nome, playerid, Str, tempo);
	format(Str, sizeof(Str), "{FFFF00}ADMIN{FFFFFF}O Administrador {FFFF00}%s {FFFFFF}programou a {FFFF00}%s {FFFFFF} um ban. Motivo: {FFFF00}%s", Name(playerid), Nome, Motivo);
	SendClientMessageToAll(VermelhoEscuro, Str);
	Log("Logs/AgendarBan.ini", Str);
	notificacao(playerid, "EXITO", "Para cancelar um ban, pede a alguem..", ICONE_CERTO);
	return 1;
}

CMD:agendacadeia(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true)								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	new Nome[24];
	if(sscanf(params, "s[56]is[56]", Nome, ID,  Motivo))		return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /agendarcadeia [CONTA] [TEMPO EM MINUTOS] [MOTIVO]");
	new ID1 = GetPlayerID(Nome);
	if(IsPlayerConnected(ID1))                                  return notificacao(playerid, "ERRO", "Jogador esta online use /cadeia.", ICONE_ERRO);
	format(File, sizeof(File), PASTA_CONTAS, Nome);
	if(!DOF2_FileExists(File))              					return notificacao(playerid, "ERRO", "Cuenta no existente.", ICONE_ERRO);
	format(Str, sizeof(Str), "AdmCmd: {FFFFFF}O Administrador {FFFF00}%s{FFFFFF} programou {FFFF00}%s {FFFFFF}para cumprir {FFFF00}%i {FFFFFF}minutos de cadeia. Motivo: {FFFF00}%s", Name(playerid), Nome, ID, Motivo);
	SendClientMessageToAll(VermelhoEscuro, Str);
	AgendarCadeia(Nome, ID, playerid, Motivo);
	if(ID > 0) notificacao(playerid, "ERRO", "DICA: Para cancelar um agendamento de cadeia use valores negativos no Tempo.", ICONE_ERRO); 
	return 1;
}

CMD:adv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "is[56]", ID, Motivo)) 					return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /adv [ID] [MOTIVO]");
	if(!IsPlayerConnected(ID))                  				return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	PlayerInfo[ID][pAvisos]++;
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jogador {FFFF00}%s {FFFFFF} recebeu uma advertencia do Administrador {FFFF00}%s. {FFFFFF}Motivo: {FFFF00}%s", Name(ID), Name(playerid), Motivo);
	SendClientMessageToAll(VermelhoEscuro, Str);
	if(PlayerInfo[playerid][pAvisos] == 3)
	{
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jugador {FFFF00}%s {FFFFFF} recebeu uma advertencia do Administrador {FFFF00}%s {FFFFFF}e foi banido. {FFFFFF}Motivo: {FFFF00}%s", Name(ID), Name(playerid), Motivo);
		SendClientMessageToAll(VermelhoEscuro, Str);
		BanirPlayer(ID, playerid, "Superou o limite de advertencia");
	}
	return 1;
}

CMD:banirip(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 4)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 								return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "is[56]", ID, Motivo)) 					return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /banirip [ID] [MOTIVO]");
	if(!IsPlayerConnected(ID))                  				return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	BanirIP(ID, playerid, Motivo);
	return 1;
}

CMD:admins(playerid, params[])
{
    if(pLogado[playerid] == false)              				return SendClientMessage(playerid, CorErro, "Voce precisa fazer Login primeiro.");
    SendClientMessage(playerid, 0x4682B4FF, "Administradores Online:");
    //
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		    if(PlayerInfo[i][pAdmin] > 0 && AparecendoNoAdmins[i] == true && pJogando[i] == false)
		    {
		 		format(Str, 256, "%s [%s]", Name(i), AdminCargo(i));
			    SendClientMessage(playerid, CinzaClaro, Str);
			}
	}
	return 1;
}
CMD:tra(playerid,params[]) return cmd_atrabalhar(playerid,params);
CMD:atrabalhar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == false)
	{
		pJogando[playerid] = true;
		SetPlayerColor(playerid, Branco);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 0);	
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O administrador {FFFF00}%s{FFFFFF} nao esta mais trabalhando.", Name(playerid));
		SendClientMessageToAll(AzulRoyal, Str);  
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");  
	}
	else
	{
		pJogando[playerid] = false;
		SetPlayerColor(playerid, 0xff00ccff);
		SetPlayerHealth(playerid, 9999);
		SetPlayerArmour(playerid, 9999);	
		SetPlayerSkin(playerid, 217);
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O administrador {FFFF00}%s{FFFFFF} esta trabalhando.", Name(playerid));
		SendClientMessageToAll(AzulRoyal, Str); 
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");	
	}
	return 1;
}

CMD:htrabalhar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == false)
	{
		pJogando[playerid] = true;
		SetPlayerColor(playerid, Branco);
		SetPlayerHealth(playerid, 100);
		SetPlayerArmour(playerid, 0);	
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O ajudante {FFFF00}%s{FFFFFF} nao esta mais trabalhando.", Name(playerid));
		SendClientMessageToAll(AzulRoyal, Str);  
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");  
	}
	else
	{
		pJogando[playerid] = false;
		SetPlayerColor(playerid, COLOR_GREEN);	
		SetPlayerSkin(playerid, 217);
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O ajudante {FFFF00}%s{FFFFFF} esta trabalhando.", Name(playerid));
		SendClientMessageToAll(AzulRoyal, Str); 
		SendClientMessageToAll(-1,"");
		SendClientMessageToAll(-1,"");	
	}
	return 1;
}

CMD:limparchat(playerid, params[])
{
	for(new i = 0; i < 300; i++)
	{
		SendClientMessage(playerid,-1, "   ");
	}
	return 1;
}

CMD:congelar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "i", ID))					return SendClientMessage(playerid, CorErroNeutro, "USE: /congelar [ID]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	TogglePlayerControllable(ID, false);
	PlayerInfo[playerid][pCongelado] = true;
	SetPlayerHealth(ID, 9999);
	notificacao(playerid, "EXITO", "congelou o jogador.", ICONE_CERTO);
	//
	format(Str, sizeof(Str), "O administrador %s congelou: %s", Name(playerid), Name(ID));
	Log("Logs/Congelar.ini", Str);
	return 1;
}

CMD:descongelar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 2)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "i", ID))					return SendClientMessage(playerid, CorErroNeutro, "USE: /descongelar [ID]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	SetPlayerHealth(ID, 100);
	TogglePlayerControllable(ID, true);
	PlayerInfo[playerid][pCongelado] = false;
	notificacao(playerid, "EXITO", "descongelou o jogador.", ICONE_CERTO);
	//
	format(Str, sizeof(Str), "O administrador %s descongelou %s", Name(playerid), Name(ID));
	Log("Logs/Descongelar.ini", Str);
	return 1;
}

CMD:chat(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(ChatLigado == true)
	{
		notificacao(playerid, "EXITO", "Has deshabilitado el chat para todos los jugadores.", ICONE_CERTO);
		ChatLigado = false;
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}ha deshabilitado el chat para todos los jugadores.", Name(playerid));
	}
	else
	{
		notificacao(playerid, "EXITO", "Has habilitado el chat para todos los jugadores.", ICONE_CERTO);
		ChatLigado = true;
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}ha habilitado el chat para todos los jugadores.", Name(playerid));
	}
	SendClientMessageToAll(AzulRoyal, Str);
	return 1;
}

CMD:desbanir(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 4)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "s[56]", Motivo)) 		return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /desbanir [Conta - Nome_Sobrenome (COMPLETO)]");
	format(File, sizeof(File), PASTA_CONTAS, Motivo);
	if(!DOF2_FileExists(File))                  return notificacao(playerid, "ERRO", "Esta conta nao esta no banco de dados.", ICONE_ERRO);
	format(File, sizeof(File), PASTA_BANIDOS, Motivo);
	if(!DOF2_FileExists(File))                  return notificacao(playerid, "ERRO", "Esta conta nao esta banida", ICONE_ERRO);
	new File1[48];
	format(File1, 48, PASTA_BACKUPBAN, Motivo);
	DOF2_CopyFile(File, File1);
	DOF2_RemoveFile(File);
	//
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jogador {FFFF00}%s {FFFFFF}foi desbanido por administrador {FFFF00}%s.", Motivo, Name(playerid));
	SendClientMessageToAll(VermelhoEscuro, Str);
	Log("Logs/Desbanir.ini", Str);
	return 1;
}

CMD:desbanirip(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 4)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "s[56]", Motivo)) 		return SendClientMessage(playerid, CorErroNeutro, "ERRO: Use /desbanirip [IP]");
	format(File, sizeof(File), PASTA_BANIDOSIP, Motivo);
	if(!DOF2_FileExists(File))                  return notificacao(playerid, "ERRO", "Este IP nao esta banido.", ICONE_ERRO);
	new File1[48];
	format(File1, 48, PASTA_BACKUPBANIP, Motivo);
	DOF2_CopyFile(File, File1);
	DOF2_RemoveFile(File);
	//
	notificacao(playerid, "EXITO", "IP desbanido com sucesso.", ICONE_CERTO);
	format(Str, sizeof(Str), "AdmCmd: O IP %s foi desbanido pelo administrador %s.", Motivo);
	Log("Logs/DesbanirIP.ini", Str);
	return 1;
}

CMD:dardinheiro(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "dd", ID, Numero))		return SendClientMessage(playerid, CorErroNeutro, "USE: /dardinheiro [ID] [QUANTIA]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	PlayerInfo[ID][pDinheiro] += Numero;
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} Deu a {FFFF00}%s{FFFFFF},{FFFF00} %d {FFFFFF}dinheiro.", Name(ID), Numero);
	SendClientMessage(playerid, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Administrador {FFFF00}%s {FFFFFF}te deu {FFFF00}%d {FFFFFF}de dinheiro.", Name(playerid), Numero);
	SendClientMessage(ID, CorSucesso, Str);
	//
	format(Str, sizeof(Str), "O Administrador %s deu %d de dinheiro a %s", Name(playerid), Numero, Name(ID));
	DCC_SendChannelMessage(Sets, Str);
	return 1;
}   

CMD:setadmin(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 7)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pJogando[playerid] == true) 				return notificacao(playerid, "ERRO", "Nao iniciou trabalho staff", ICONE_ERRO);
	if(sscanf(params, "ii", ID, Numero))		return SendClientMessage(playerid, CorErroNeutro, "USE: /setadmin [ID] [LEVEL]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(Numero > 9)				return notificacao(playerid, "ERRO", "El numero debe ser entre 0 y 6.", ICONE_ERRO);
	format(Str, sizeof(Str), "{FFFFFF}Deu a {FFFF00}%s {FFFFFF}, {FFFF00}%i{FFFFFF} level de Administrador.", Name(ID), Numero);
	SendClientMessage(playerid, Azul, Str);
	//
	format(Str, sizeof(Str), "{FFFFFF}Te deu {FFFF00}%i {FFFFFF}Level de Administrador por {FFFF00}%s.", Numero, Name(playerid));
	SendClientMessage(ID, Azul, Str);
	//
	format(Str, sizeof(Str), "O Administrador %s dio administrador level %i para %s.", Name(playerid), Numero, Name(ID));
	DCC_SendChannelMessage(Sets, Str);
	PlayerInfo[ID][pAdmin] = Numero;
	//
	return 1;
}

CMD:gmx(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	foreach(new i: Player)
	{
		if(IsPlayerConnected(i) && pLogado[i] == true) SalvarDados(i), Kick(i);
		
	}
	format(Str, sizeof(Str), "{FFFF00}ANUNCIO{FFFFFF} Se realizara um reinicio no servidor.");
	SendClientMessageToAll(-1, Str);
	SendRconCommand("gmx");
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
				format(string, sizeof(string), "Vip %s (%d) [%s]", Name(i), i, convertNumber(PlayerInfo[i][ExpiraVIP]-gettime())); 
				SendClientMessage(playerid, 0xE3E3E3FF, string); 
				count++; 
			   } 
		} 
	} 
	if(count == 0) 
		return SendClientMessage(playerid, 0xD8D8D8FF, "{FFFF00}AVISO{FFFFFF}Nao ha jogadores VIP online!"); 

	return true; 
} 

CMD:setvip(playerid, params[]) 
{ 
	new id, days, nivel, string[70]; 

	if(PlayerInfo[playerid][pAdmin] < 7)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "udd", id, nivel, days)) 
		return SendClientMessage(playerid, -1, "USE: /setvip [id] [nivel] [dias]"); 

	if(days < 0) 
	{ 
		return notificacao(playerid, "ERRO", "Este jogador nao esta online!", ICONE_ERRO);
	} 
	else 
	{ 
		if(!IsPlayerConnected(id)) 
			return notificacao(playerid, "ERRO", "Este jogador nao esta online!", ICONE_ERRO);
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
}

CMD:lojavip(playerid)
{
	new StrCash[550],StrCashh[550], String[500];
	format(StrCashh, sizeof(StrCashh), "{FFFF00}- {FFFFFF}Compra um VIP\n");
	strcat(StrCash,StrCashh);
	format(StrCashh, sizeof(StrCashh), "{FFFF00}- {FFFFFF}Compra veiculo de inventario\n");
	strcat(StrCash,StrCashh);
	format(StrCashh, sizeof(StrCashh), "{FFFF00}- {FFFFFF}Beneficios VIP\n");
	strcat(StrCash,StrCashh);
	format(String, sizeof(String), "SEUS COINS {0080FF}(C$%i)", PlayerInfo[playerid][pCoins]);
	ShowPlayerDialog(playerid, DIALOG_CATCOINS, DIALOG_STYLE_LIST, String , StrCash, "Selecionar", "X");	
	return 1;
}

CMD:dveiculo(playerid)
{
	if(VehAlugado[playerid] == 1)
	{
		VehAlugado[playerid] = 0;
		DestroyVehicle(VeiculoCivil[playerid]);
		notificacao(playerid, "EXITO", "Veiculo destruido.", ICONE_CERTO);
	}
	return 1;
}

CMD:ctumba(playerid) 
{ 
	if(PlayerInfo[playerid][pProfissao] != 2) 	return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	cova[playerid] = random(sizeof(Covas));    
	new index = cova[playerid];    
	SetPlayerCheckpoint(playerid, Covas[index][0], Covas[index][1], Covas[index][2], 2.0);  
	notificacao(playerid, "EXITO", "Concerte o ponto no seu mapa.", ICONE_CERTO);
	Covaconcerto[playerid] = true;
	return 1; 
}

CMD:sairemprego(playerid)
{
	PlayerInfo[playerid][pProfissao] = 0;
	notificacao(playerid, "EXITO", "Deixou seu emprego.", ICONE_CERTO);
	return 1;
}

CMD:lferidos(playerid, params[])
{
	new id;
	if(PlayerInfo[playerid][pProfissao] != 3)
	{
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xFF0000FF, "* Use: /lferidos (id)");
		if(IsPlayerConnected(id))
		{
			if(playerid == id) return notificacao(playerid, "ERRO", "No puedes localizarte a ti mismo!.", ICONE_ERRO);
			if(Localizando[playerid] == 0)
			{
				Localizando[playerid] = 1;
				notificacao(playerid, "EXITO", "Jogador foi localizado.", ICONE_CERTO);
				TimerLocalizar[playerid] = SetTimerEx("LocalizarPlayer", 500, true, "ii", playerid, id);
				return true;
			}
			else 
			{
				DisablePlayerCheckpoint(playerid);
				Localizando[playerid] = 0;
				notificacao(playerid, "EXITO", "Nao esta localizando agora.", ICONE_CERTO);
				KillTimer(TimerLocalizar[playerid]);
				return true;
			}
		}
		else notificacao(playerid, "ERRO", "O jogador nao esta conectado!", ICONE_ERRO); 
		return true;
	}
	else notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	return true;
}

CMD:carregar(playerid)
{
	if(PlayerToPoint(3.0, playerid, -81.4098,-1127.7189,1))
	if(PlayerInfo[playerid][pProfissao] != 4) 	return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Cargase[playerid] == true) 	return notificacao(playerid, "ERRO", "Seu caminhao ja esta carregado.", ICONE_ERRO);
	if(Carregou[playerid] == 1) 	return notificacao(playerid, "ERRO", "Ja tem uma carga.", ICONE_ERRO);
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 456)  	return notificacao(playerid, "ERRO", "Nao esta no veiculo de trabalho", ICONE_ERRO);
	ShowPlayerDialog(playerid, DIALOG_CARGA, DIALOG_STYLE_LIST, "{FFFF00}Cargas Disponiveis.", "{FFFF00}- {FFFFFF}Ind. Solarion SF\t{32CD32}R$2250\n{FFFF00}- {FFFFFF}Wang Cars SF\t{32CD32}$2500\n{FFFF00}- {FFFFFF}Michelin Pneus LV\t{32CD32}$2400\n{FFFF00}- {FFFFFF}Sprunk LS\t{32CD32}$2150\n{FFFF00}- {FFFFFF}Xoomer LS\t{32CD32}$2150\n{FFFF00}- {FFFFFF}FlaischBerg LS\t{32CD32}$2100\n", "Carregar", "");
	return 1;
}

CMD:descarregar(playerid)
{
	if(PlayerInfo[playerid][pProfissao] != 4) 	return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Cargase[playerid] == false) 		return notificacao(playerid, "ERRO", "Seu caminhao nao esta carregar.", ICONE_ERRO);
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 456) 	return notificacao(playerid, "ERRO", "No estas en veiculo del empleo.", ICONE_ERRO);
	if(Cargase[playerid] == true) 

	CreateProgress(playerid, "DescarregarCarga","Descarregando caminhao...", 200);
	return 1;
}

CMD:rorgoff(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	ShowPlayerDialog(playerid,DIALOG_LTAGS,DIALOG_STYLE_INPUT,"Remover un Lider","Digite o nome do membro!\n\nSOMENTE O RESPONSAVEL DA ORGANIZACAO PODE!.","Confirmar","X");
	return 1;
}

CMD:infoorg(playerid)
{
	if(PlayerInfo[playerid][Org]==0)return notificacao(playerid, "ERRO", "No eres parte de ninguna organizacao.", ICONE_ERRO);
	membrosorg(playerid, PlayerInfo[playerid][Org]);
	return 1;
}

CMD:convidar(playerid,params[])
{   
	new id, String[500];
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao fez Login.", "hud:thumbdn");
	if(PlayerInfo[playerid][Org] == 0)return notificacao(playerid, "ERRO", "Nao e de nenhuma organizacao.", ICONE_ERRO);
	if(PlayerInfo[playerid][Cargo] < 2)return notificacao(playerid, "ERRO", "Nao superior de nenhuma organizacao.", ICONE_ERRO);
	if(sscanf(params,"i",id))return SendClientMessage(playerid,-1,"Use: /convidar [ID]");
	if(!IsPerto(playerid,id))return notificacao(playerid, "ERRO", "Nao esta perto deste jogador.", ICONE_ERRO);
	if(PlayerInfo[id][Org] != 0)return notificacao(playerid, "ERRO", "Este jogador ja e de uma organizacao.", ICONE_ERRO);
	PlayerInfo[id][convite] = PlayerInfo[playerid][Org];
	format(String,sizeof(String),"Esta sendo convidado por %s. (%s)",Name(playerid),NomeOrg(playerid));
	ShowPlayerDialog(id,DIALOG_CONVITE,DIALOG_STYLE_MSGBOX,"Convite",String,"Aceitar","X");
	return 1;
}

CMD:limparvagas(playerid,params[])
{
	new String[500];
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao iniciou login", "hud:thumbdn");
	if(PlayerInfo[playerid][Org] == 0)return notificacao(playerid, "ERRO", "Nao e de nenhuma organizacao.", ICONE_ERRO);
	if(PlayerInfo[playerid][Cargo] < 2)return notificacao(playerid, "ERRO", "Nao e superior de nenhuma organizacao.", ICONE_ERRO);
	new xPlayer;
	if(sscanf(params,"i",xPlayer))
		return SendClientMessage(playerid , 0xFF0000FF , "/limparvagas [id cargo]");
	format(String, sizeof(String),"Todas as vagas foram removidas.");
	SendClientMessage(playerid , -1 , String);
	format(String, sizeof(String), PASTA_ORGS, PlayerInfo[playerid][Org]);
	DOF2_SetString(String, VagasORG[xPlayer], "Nenhum");
	DOF2_SaveFile();
	return 1;
}

CMD:demitir(playerid,params[])
{
	new String[500];
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao iniciou login", "hud:thumbdn");
	if(PlayerInfo[playerid][Org] == 0)return notificacao(playerid, "ERRO", "Nao faz parte de nenhuma organizacao.", ICONE_ERRO);
	if(PlayerInfo[playerid][Cargo] < 2)return notificacao(playerid, "ERRO", "Nao e superior de nenhuma organizacao.", ICONE_ERRO);
	new xPlayer;
	if(sscanf(params,"i",xPlayer))
		return SendClientMessage(playerid , 0xFF0000FF , "{FFFF00}AVISO{FFFFFF}/demitir [playerid]");
	if(PlayerInfo[xPlayer][Org] != PlayerInfo[playerid][Org])return notificacao(playerid, "ERRO", "Este jogador nao e de sua organizacao.", ICONE_ERRO);
	format(String, sizeof(String),"Ha expulsado %s de su organizacao!",Name(xPlayer));
	notificacao(playerid, "EXITO", String, ICONE_CERTO);
	format(String, sizeof(String),"Fuiste expulsado de su organizacao por %s",Name(playerid));
	notificacao(xPlayer, "INFO", String, ICONE_AVISO);
	expulsarmembro(xPlayer, PlayerInfo[xPlayer][Org]);
	PlayerInfo[xPlayer][Org] = 0;
	PlayerInfo[xPlayer][Cargo] = 0;
	return 1;
}
CMD:promover(playerid,params[])
{
	new id,cargo,String[500];
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao iniciou login", "hud:thumbdn");
	if(PlayerInfo[playerid][Org] == 0)return 1;
	if(PlayerInfo[playerid][Cargo] < 2)return notificacao(playerid, "ERRO", "Nao e superior de nenhuma organizacao.", ICONE_ERRO);
	if(sscanf(params,"ii",id,cargo))return SendClientMessage(playerid,-1,"{DF0101}[BORP]{FFFFFF} /promover [ID] [CARGO]");
	if(PlayerInfo[id][Cargo] > PlayerInfo[playerid][Cargo])return notificacao(playerid, "ERRO", "Nao pode dar um cargo a um superior.", ICONE_ERRO);
	if(cargo > 3)return notificacao(playerid, "ERRO", "Nao pode dar este cargo.", ICONE_ERRO);
	if(cargo == 0)return notificacao(playerid, "ERRO", "Nao pode dar este cargo.", ICONE_ERRO);
	if(PlayerInfo[id][Org] != PlayerInfo[playerid][Org])return notificacao(playerid, "ERRO", "Este jogador nao de sua organizacao.", ICONE_ERRO);
	PlayerInfo[id][Cargo] = cargo;
	format(String,sizeof(String),"Voce deu %s para %s de organizacao.",NomeCargo(id),Name(id));
	notificacao(playerid, "EXITO", String, ICONE_CERTO);
	format(String,sizeof(String),"%s colocou voce como %s de organizacao.",Name(playerid),NomeCargo(id));
	notificacao(id, "INFO", String, ICONE_AVISO);
	return 1;
}

CMD:orgs(playerid)
{
	new StringsG[10000],StringsG1[11000];
	format(StringsG,sizeof(StringsG),"{4CBB17}1{FFFFFF} - Policia Militar: %s\n", DOF2_GetString("InfoOrg/1.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}2{FFFFFF} - Exercito: %s\n", DOF2_GetString("InfoOrg/2.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}3{FFFFFF} - Policia Federal: %s\n", DOF2_GetString("InfoOrg/3.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}4{FFFFFF} - BOPE: %s\n", DOF2_GetString("InfoOrg/4.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}5{FFFFFF} - Ballas: %s\n", DOF2_GetString("InfoOrg/5.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}6{FFFFFF} - Los Aztecas: %s\n", DOF2_GetString("InfoOrg/6.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}7{FFFFFF} - Los Vagos: %s\n", DOF2_GetString("InfoOrg/7.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}8{FFFFFF} - Reportagem: %s\n", DOF2_GetString("InfoOrg/8.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}9{FFFFFF} - Groove Street: %s\n", DOF2_GetString("InfoOrg/9.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}10{FFFFFF} - Republica: %s\n", DOF2_GetString("InfoOrg/10.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}11{FFFFFF} - Mafia Triad: %s\n", DOF2_GetString("InfoOrg/11.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	format(StringsG,sizeof(StringsG),"{4CBB17}12{FFFFFF} - Mafia Russa: %s\n", DOF2_GetString("InfoOrg/12.ini",VagasORG[0]));
	strcat(StringsG1, StringsG);
	ShowPlayerDialog(playerid,DIALOG_ORGS,DIALOG_STYLE_MSGBOX,"Organizacoes do Servidor",StringsG1,"X",#);
	return 1;
}

CMD:darlider(playerid,params[])
{
	new id,org,String[500];
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params,"ii",id,org))return SendClientMessage(playerid,-1,"{FFFF00}AVISO{FFFFFF} /darlider [ID] [IDORG]");
	if(!(IsPlayerConnected(id)))return notificacao(playerid, "ERRO", "Este Jogador nao esta online.", ICONE_ERRO);
	PlayerInfo[id][Org] = org;
	PlayerInfo[id][Cargo] = 3;
	format(String,sizeof(String),"O jogador %s te deu lider da organizacao %s",Name(playerid),NomeOrg(id));
	notificacao(id, "INFO", String, ICONE_AVISO);
	format(String,sizeof(String),"O jogador %s recebeu lider da organizacao %s",Name(id),NomeOrg(id));
	notificacao(playerid, "EXITO", String, ICONE_CERTO);
	addlider(id, org);
	return 1;
}

CMD:limparlider(playerid,params[])
{
	new id, String[500];
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params,"i",id))return SendClientMessage(playerid,-1,"{FFFF00}AVISO{FFFFFF} /limparlider [ID DA ORG]");
	SendClientMessage(playerid,-1,"Org resetada!");
	format(String, sizeof(String), PASTA_ORGS, id);
	if(!DOF2_FileExists(String))return true;
	if(!strcmp(DOF2_GetString(String,VagasORG[0]),"Nenhum",true)) 	return notificacao(playerid, "ERRO", "Nao tem um lider nessa organizacao.", ICONE_ERRO);
	for(new i=0; i< sizeof VagasORG; i++)
	{
	   DOF2_SetString(String,VagasORG[i], "Nenhum");
	}
	return 1;
}

CMD:limparlideres(playerid,params[])
{
	new String[500];
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	notificacao(playerid, "EXITO", "Orgs resetadas!", ICONE_CERTO);
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
	if(sscanf(params,"ii",id,quantia)) return SendClientMessage(playerid, -1, "{FFFF00}USE:{FFFFFF} /pagar [ID] [QUANTIA]");
	if(!ProxDetectorS(8.0, playerid, id))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);

	PlayerInfo[id][pDinheiro] += quantia;
	PlayerInfo[playerid][pDinheiro] -= quantia;
	format(string, sizeof(string), "Pagou R$%d para %s (ID: %d)", quantia, Name(id), id);
	notificacao(playerid, "EXITO", string, ICONE_CERTO);
	format(string, sizeof(string), "Recebeu R$%d de %s (ID: %d).", quantia, Name(playerid), playerid);
	notificacao(id, "INFO", string, ICONE_AVISO);
	return 1;
} 

CMD:aa(playerid)
{
	if(PlayerInfo[playerid][pAdmin] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Necessita inicia login.", ICONE_ERRO);
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
	if(!IsPolicial(playerid))						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 								return notificacao(playerid, "ERRO", "Nao esta em patrulha.", ICONE_ERRO);
	if(sscanf(params, "s[56]", Str)) 							return SendClientMessage(playerid, CorErroNeutro, "USE: /d [TEXTO]");

	format(Str, sizeof(Str), "{FFFFFF}[{FFFF00}%s{FFFFFF}] {FFFF00}%s{FFFFFF} disse {FFFF00}%s", NomeCargo(playerid), Name(playerid), Str);
	SendRadioMessage(0xDDA0DDFF, Str);

	return 1;
}

CMD:ga(playerid, params[])
{
	if(!IsBandido(playerid))						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "s[56]", Str)) 							return SendClientMessage(playerid, CorErroNeutro, "USE: /ga [TEXTO]");

	format(Str, sizeof(Str), "{FFFFFF}[{FFFF00}%s{FFFFFF}] {FFFF00}%s{FFFFFF} disse {FFFF00}%s", NomeCargo(playerid), Name(playerid), Str);
	SendGangMessage(0xDDA0DDFF, Str);

	return 1;
}

CMD:algemar(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "i", ID))					return SendClientMessage(playerid, CorErroNeutro, "USE: /algemar [ID]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	TogglePlayerControllable(ID, false);
	PlayerInfo[ID][pCongelado] = true;
	notificacao(playerid, "EXITO", "Algemou o individuo.", ICONE_CERTO);
	notificacao(ID, "INFO", "Fue esposado.", ICONE_AVISO);
	SetPlayerAttachedObject(ID, 5, 19418, 6, -0.031999, 0.024000, -0.024000, -7.900000, -32.000011, -72.299987, 1.115998, 1.322000, 1.406000);
	SetPlayerSpecialAction(ID, SPECIAL_ACTION_CUFFED);
	return 1;
}
CMD:desalgemar(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "i", ID))					return SendClientMessage(playerid, CorErroNeutro, "USE: /desalgemar [ID]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	//
	TogglePlayerControllable(ID, true);
	PlayerInfo[ID][pCongelado] = false;
	notificacao(playerid, "EXITO", "Desalgemou o individuo.", ICONE_CERTO);
	notificacao(ID, "INFO", "Foi algemado.", ICONE_AVISO);
	ClearAnimations(ID);
	RemovePlayerAttachedObject(ID,5);
	SetPlayerSpecialAction(ID, SPECIAL_ACTION_NONE);
	return 1;
}

CMD:pveiculo(playerid, params[])
{
	new carid = GetPlayerVehicleID(playerid);
	if(!IsPolicial(playerid) || !IsBandido(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "i", ID))					return SendClientMessage(playerid, CorErroNeutro, "USE: /pveiculo [ID]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPlayerInAnyVehicle(playerid))			return notificacao(playerid, "ERRO", "Voce nao esta em um veiculo.", ICONE_ERRO);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 		return notificacao(playerid, "ERRO", "Voce nao esta.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	TogglePlayerControllable(ID, 0);
	PutPlayerInVehicle(ID, carid, 4);
	return 1;
}

CMD:rveiculo(playerid, params[])
{
	if(!IsPolicial(playerid) || !IsBandido(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "i", ID))					return SendClientMessage(playerid, CorErroNeutro, "USE: /rveiculo [ID]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPlayerInAnyVehicle(playerid))			return notificacao(playerid, "ERRO", "Voce nao esta em um veiculo.", ICONE_ERRO);
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) 		return notificacao(playerid, "ERRO", "Voce nao esta como motorista.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta perto do jogador.", ICONE_ERRO);
	TogglePlayerControllable(ID, true);
	RemovePlayerFromVehicle(ID);
	return 1;
}

CMD:prender(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "iis[56]", ID, Numero, Motivo))			return SendClientMessage(playerid, CorErroNeutro, "USE: /prender [ID] [TIEMPO EM MINUTOS] [RAZON]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPlayerInAnyVehicle(playerid))			return notificacao(playerid, "ERRO", "Voce nao esta em um veiculo.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	for(new i; i < 1; i++)
	if(PlayerToPoint(3.0, playerid, PosPrender[i][0], PosPrender[i][1], PosPrender[i][2]))
	{

		if(Numero != 0)
		{
			PlayerInfo[ID][pCadeia] = Numero * 60;
			SetPlayerPos(ID,  322.197998,302.497985,999.148437);
			SetPlayerInterior(ID, 5);
			SetPlayerVirtualWorld(ID, 0);
			notificacao(playerid, "INFO", "Preso por cometer delitos.", ICONE_AVISO);
			SetPlayerWantedLevel(playerid, 0);
			TogglePlayerControllable(ID, true);
			RemovePlayerFromVehicle(ID);
			ResetPlayerWeapons(playerid);
			TogglePlayerControllable(playerid, false);
			SetTimerEx("carregarobj", 5000, 0, "i", playerid);

		}
		else
		{
			PlayerInfo[ID][pCadeia] = 1;
		}
		//
		format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O jogador {FFFF00}%s {FFFFFF}foi preso por {FFFF00}%s {FFFFFF}por {FFFF00}%i {FFFFFF}minutos. Motivo: {FFFF00}%s", Name(ID), NomeOrg(playerid), Numero, Motivo);
		SendClientMessageToAll(VermelhoEscuro, Str);
	}
	return 1;
}

CMD:ab(playerid)
{
	new String[5000];
	if(IsPolicial(playerid))
	{
		format(String,sizeof(String),"{6959CD}*** [%s]%s: POLICIA, PARE OU IREMOS ATIRAR!!!! ***", NomeOrg(playerid), Name(playerid));
	}
	if(IsBandido(playerid))
	{
		format(String,sizeof(String),"{6959CD}*** [%s]%s: ASSALTO, PARE OU IREMOS ATIRAR!!!! ***", NomeOrg(playerid), Name(playerid));
	}
	ProxDetector(30.0, playerid, String, -1,-1,-1,-1,-1);
	return 1;
}

CMD:su(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "di", ID, Numero))						return SendClientMessage(playerid, CorErroNeutro, "USE: /su [ID] [LEVEL]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	//
	format(Str, sizeof(Str), "O Policial %s colocou %i de procurado em voce.", Name(playerid), Numero);
	notificacao(ID, "INFO", Str, ICONE_AVISO);

	notificacao(playerid, "EXITO", "Colocou com sucesso o jogador como procurado.", ICONE_CERTO);
	//
	SetPlayerWantedLevel(ID, Numero);
	return 1;
}

CMD:verinv(playerid, params[])
{
	new str[64];
	if(!IsPolicial(playerid) || !IsBandido(playerid))        return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false)                 return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "d", ID))                        return SendClientMessage(playerid, CorErroNeutro, "USE: /verinv [ID]");
	if(!IsPlayerConnected(ID))                                    return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	if(InventarioAberto[playerid])
	{
		for(new i = 0; i < 40; ++i)
		{
			PlayerTextDrawHide(playerid, DrawInv[playerid][i]);
		}
		InventarioAberto[playerid] = 0;
		CancelSelectTextDraw(playerid);
		format(str, sizeof(str), "{FFFFFF}*{FFFF00}%s {FFFFFF}nao esta mas verificando as coisas de {FFFF00}%s{FFFFFF}.", Name(playerid), Name(ID));
		SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
		return 1;
	}
	else
	{
		format(str, sizeof(str), "Inventario: %s", Name(ID));
		PlayerTextDrawSetString(playerid, DrawInv[playerid][34], str);
		PlayerTextDrawSetString(playerid, DrawInv[playerid][38], "");
		for(new i = 1; i < 33; ++i)
		{
			PlayerTextDrawSetPreviewModel(playerid, DrawInv[playerid][i], PlayerInventario[ID][i][Slot]);
			if(PlayerInventario[ID][i][Slot] == -1)
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
		format(str, sizeof(str), "{FFFFFF}*{FFFF00}%s {FFFFFF}esta verificando as coisas de {FFFF00}%s{FFFFFF}.", Name(playerid), Name(ID));
		SendClientMessageInRange(30, playerid, str, 0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA,0xB384FFAA);
	}
	return 1;
}
CMD:patrulha(playerid)
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);

	SendClientMessageToAll(-1,"");
	SendClientMessageToAll(-1,"");
	format(Str, sizeof(Str), "{FFFF00}AVISO{FFFFFF} O Policial {FFFF00}%s {FFFFFF}esta em patrulha.", Name(playerid));
	SendClientMessageToAll(AzulRoyal, Str); 
	SendClientMessageToAll(-1,"");
	SendClientMessageToAll(-1,"");	
	return 1;
}

CMD:rarmeros(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "d", ID))									return SendClientMessage(playerid, CorErroNeutro, "USE: /rarmeros [ID]");
	if(!IsPlayerConnected(ID))									return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	ResetPlayerWeapons(ID);
	//
	format(Str, sizeof(Str), "Desarmaste: %s", Name(ID));
	notificacao(playerid, "EXITO", Str, ICONE_CERTO);
	//
	format(Str, 106, "Has sido desarmado por O Administrador %s", Name(playerid));
	notificacao(ID, "INFO", Str, ICONE_AVISO);
	return 1;
}

CMD:lprocurados(playerid, params[])
{
	new id;
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	{
		if(sscanf(params, "u", id)) return SendClientMessage(playerid, 0xFF0000FF, "* Use: /lbuscado (id)");
		if(IsPlayerConnected(id))
		{
			if(playerid == id) return notificacao(playerid, "ERRO", "Nao pode localizar voce mesmo!.", ICONE_ERRO);
			if(Localizando[playerid] == 0)
			{
				Localizando[playerid] = 1;
				notificacao(playerid, "EXITO", "Jogador foi localizado.", ICONE_CERTO);
				TimerLocalizar[playerid] = SetTimerEx("LocalizarPlayer", 500, true, "ii", playerid, id);
				return true;
			}
			else 
			{
				DisablePlayerCheckpoint(playerid);
				Localizando[playerid] = 0;
				notificacao(playerid, "EXITO", "Nao esta mais localizando.", ICONE_CERTO);
				KillTimer(TimerLocalizar[playerid]);
				return true;
			}
		}
		else notificacao(playerid, "ERRO", "O jogador nao esta conectado!", ICONE_ERRO); 
		return true;
	}
}

CMD:procurados(playerid) 
{ 
	new string[85]; 
	new count; 
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	SendClientMessage(playerid, 0x33AAFFFF, "** Todos os jogadores procurados:"); 
	foreach(new i: Player)
	{ 
		if(GetPlayerWantedLevel(i)) 
		{ 
			if(IsPlayerConnected(i)) 
			{ 
				format(string, sizeof(string), "%s(%d)", Name(i),i); 
				SendClientMessage(playerid, 0xE3E3E3FF, string); 
				count++; 
			} 
		} 
	} 
	if(count == 0) 
		return SendClientMessage(playerid, 0xD8D8D8FF, "{FFFF00}AVISO{FFFFFF}Nao tem jogadores procurados."); 

	return true; 
}

CMD:multar(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "dd", ID, Numero))		return SendClientMessage(playerid, CorErroNeutro, "USE: /multar [ID] [QUANTIA]");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	//
	PlayerInfo[ID][pMultas] += Numero;
	format(Str, sizeof(Str), "Deu a %s, %d de multa.", Name(ID), Numero);
	notificacao(playerid, "EXITO", Str, ICONE_CERTO);
	//
	format(Str, sizeof(Str), "O Policial %s te deu %d de multa.", Name(playerid), Numero);
	notificacao(ID, "INFO", Str, ICONE_AVISO);
	return 1;
}

CMD:verdocumentos(playerid, params[])
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Patrulha[playerid] == false) 				return notificacao(playerid, "ERRO", "Nao esta em servico", ICONE_ERRO);
	if(sscanf(params, "dd", ID))		return SendClientMessage(playerid, CorErroNeutro, "USE: /verdocumentos [ID] ");
	if(!IsPlayerConnected(ID))					return notificacao(playerid, "ERRO", "Jogador nao esta online.", ICONE_ERRO);
	if(!IsPerto(playerid,ID))return notificacao(playerid, "ERRO", "Nao esta proximo do jogador.", ICONE_ERRO);
	//
	new megastrings[500], String2[500];
	format(String2,sizeof(String2), "{FFFFFF}Nome: {FFFF00}%s\t{FFFFFF}Idade: {FFFF00}%d {FFFFFF}anos\t{FFFFFF}VIP: {FFFF00}%s\n", Name(ID),PlayerInfo[ID][pIdade], VIP(ID));
	strcat(megastrings, String2);
	format(String2,sizeof(String2), "{FFFFFF}Profissao:{FFFF00} %s\t{FFFFFF}Org:{FFFF00} %s\t{FFFFFF}Cargo:{FFFF00} %s\n", Profs(playerid), NomeOrg(ID), NomeCargo(ID));
	strcat(megastrings, String2);
	format(String2,sizeof(String2), "{FFFFFF}Multas:{FFFF00} %d\t{FFFFFF}N�Casa:{FFFF00} %d\n", PlayerInfo[ID][pMultas], PlayerInfo[ID][Casa]);
	strcat(megastrings, String2);
	format(String2,sizeof(String2), "{FFFFFF}Tempo Jogados:{FFFF00} %s\t{FFFFFF}Expira VIP:{FFFF00} %s\n", ConvertTimeX(PlayerInfo[ID][pSegundosJogados]), convertNumber(PlayerInfo[ID][ExpiraVIP]-gettime()));
	strcat(megastrings, String2);
	ShowPlayerDialog(playerid, DIALOG_CMDRG,DIALOG_STYLE_MSGBOX,"Seu Documento",megastrings,"X",#);
	return 1;
}

CMD:qplantacao(playerid)
{
	if(!IsPolicial(playerid))		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);{
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
				new string[128];
				format(string, sizeof(string), "* Oficial %s esta queimando uma plantacao de maconha!", Name(playerid));
				ProxDetector(30.0, playerid, string, -1,-1,-1,-1,-1);
				notificacao(playerid, "EXITO", "Esperar....", ICONE_CERTO);
				return true;
			}
		}
		if(perto == 0)return notificacao(playerid, "ERRO", "Nao esta proximo de nenhum plantacao de maconha.", ICONE_ERRO);
	}
	return true;
}

CMD:cmaconha(playerid)
{
	if(PlantandoMaconha[playerid] == true)
		return notificacao(playerid, "ERRO", "Ja a uma semente que voce esta plantando ou colhendo.", ICONE_ERRO);

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
				new string[128];
				format(string, sizeof(string), "** %s iniciou uma colheita em sua plantacao de maconha!", Name(playerid));
				ProxDetector(30.0, playerid, string, -1,-1,-1,-1,-1);
				notificacao(playerid, "EXITO", "Voce esta colhendo esta plantacao de maconha, aguarde...", ICONE_CERTO);
				return true;
			}
			else return notificacao(playerid, "ERRO", "[?] Opss, parece que nao e dono de esta plantacao", ICONE_ERRO);
		}
	}
	if(perto == 0)return notificacao(playerid, "ERRO", "Nao esta proximo a nenhuma plantacao.", ICONE_ERRO);
	return true;
}

CMD:maconhas(playerid)
{
	if(CountPlantacao(playerid) < 1)
		return notificacao(playerid, "ERRO", "Nao plantou nenhuma maconha.", ICONE_ERRO);

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
	if(PlayerInfo[playerid][pAdmin] < 2)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	format(Str, sizeof(Str),"Introduza o ID do jogador que quer reanimar");
	ShowPlayerDialog(playerid,DIALOG_REANIMAR,1,"Reanimar jogador", Str, "Confirmar",#);
	return 1;
}

CMD:criarkey(playerid, params[])
{
	new File[255];
	new vl, UsoR;  
	if(PlayerInfo[playerid][pAdmin] < 7)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "dd", vl, UsoR)) return SendClientMessage(playerid, 0xF22F13FF, "[ERRO] {FFFFFF}Use: /criarkey [Valor] [Disponiveis]");
	{
		new Cod = randomEx(0,999999);
		format(File, sizeof(File), PASTA_KEYS, Cod);
		DOF2_CreateFile(File);
		DOF2_SetInt(File, "Valor", vl);
		DOF2_SetInt(File, "UsoRestante", UsoR);
		DOF2_SaveFile();
		new str[180];format(str, sizeof(str), "{FFFF00}[INFO] {FFFFFF}O cupom %d se criou com %d e %d jogadores podem usar", Cod, vl, UsoR);
		SendClientMessage(playerid, -1, str);
	}
	return 1;
}

CMD:ativarkey(playerid, params[])
{
	new File[255];
	new Cod, Din, CupomR;
	if(sscanf(params, "d", Cod)) return SendClientMessage(playerid, 0xF22F13FF, "[ERRO] {FFFFFF}Use: /ativarkey [Codigo]");
	{
		format(File, sizeof(File), PASTA_KEYS, Cod);
		if(DOF2_FileExists(File)) 
		{
			CupomR = DOF2_GetInt(File, "UsoRestante");
			if(CupomR > 0)
			{
				Din = DOF2_GetInt(File, "Valor");
				PlayerInfo[playerid][pCoins] += Din;
				CupomR -- ;
				notificacao(playerid, "EXITO", "Codigo utilizado!", ICONE_CERTO);
				DOF2_SetInt(File,"UsoRestante", CupomR);
				DOF2_SaveFile();
			}
			else
			{
				DOF2_RemoveFile(File);
				CupomR = 0;
			}
		}
		else
		{
			notificacao(playerid, "ERRO", "Codigo nao existe!", ICONE_ERRO);
		}
	}
	return 1;
}

CMD:me(playerid, params[])
{
	new string3[500];
	if(!isnull(params))
	format(string3, sizeof(string3), "* %s %s", Name(playerid), params);
	ProxDetector(30.0, playerid, string3, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return 1;
} 

CMD:do(playerid, params[])
{
	new string3[500];
	if(!isnull(params))
	format(string3, sizeof(string3), "* %s ((%s))", params, Name(playerid));
	ProxDetector(30.0, playerid, string3, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
	return 1;
} 

CMD:ltumba(playerid)
{
	if(PlayerToPoint(3.0, playerid, 934.1115,-1103.3857,24.3118))
	if(PlayerInfo[playerid][pProfissao] != 5) 	return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(Cargase[playerid] == true) 	return notificacao(playerid, "ERRO", "Ja localizou um hospital para pegar a tumba.", ICONE_ERRO); 
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) != 442)  	return notificacao(playerid, "ERRO", "Nao esta em veiculo do emprego.", ICONE_ERRO);
	ShowPlayerDialog(playerid, DIALOG_LTUMBA, DIALOG_STYLE_LIST, "Hospital.", "{FFFF00}- {FFFFFF}Los Santos\t{32CD32}$600\n{FFFF00}- {FFFFFF}Las Venturas\t{32CD32}$1200\n{FFFF00}- {FFFFFF}San Fierro\t{32CD32}$2000\n", "Localizar", "");
	return 1;
}

CMD:criarcasa(playerid, params[])
{
	new File[255];
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	{
		new valor, interior;
		if(sscanf(params, "ii", valor, interior))
		{
			return SendClientMessage(playerid, COR_VERMELHO, "{FF2400}[ERRO]: {FFFFFF}Use: /criarcasa [valor] [interior 1 - 10].");
		}
		else if(interior < 0 || interior > 10)
		{
			return notificacao(playerid, "ERRO", "Introduza um interior correto.", ICONE_ERRO);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
					format(string, sizeof(string), "Imobiliaria\n{FFFFFF}Casa ID: {FFDC33}%d\n{FFFFFF}Valor: {00FF00}%d\n{FFFFFF}Use 'Y'", CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
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
	if(PlayerInfo[playerid][pAdmin] < 6)		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	{
		new id, AccountCA[5000], mensagem[128];
		if(sscanf(params, "i", id)) return SendClientMessage(playerid, -1, "{FF2400}[ERRO]: {FFFFFF}Use: /dcasa [ID da casa].");
		{
			if(IsPlayerInRangeOfPoint(playerid, 2.0, CasaInfo[id][CasaX], CasaInfo[id][CasaY], CasaInfo[id][CasaZ]))
			{
				format(AccountCA, sizeof(AccountCA), PASTA_CASAS, id);
				if(DOF2_FileExists(AccountCA))
				{
					DOF2_RemoveFile(AccountCA);
					format(mensagem, sizeof(mensagem), "deleto casa id: %d.", id);
					notificacao(playerid, "EXITO", mensagem, ICONE_CERTO);
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
					notificacao(playerid, "ERRO", mensagem, ICONE_ERRO);
				}
			}
			else
			{
				format(mensagem, sizeof(mensagem), "Nao esta perto da casa Id: %d.", id);
				notificacao(playerid, "ERRO", mensagem, ICONE_ERRO);
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
				notificacao(playerid, "ERRO", "Esa casa no eres de usted.", ICONE_ERRO);
				return 1;
			}
			else if(CasaInfo[i][CasaAVenda] == 1)
			{
				notificacao(playerid, "ERRO", "Su casa ya estas en venta", ICONE_ERRO);
				return 1;
			}
			else
			{
				if(IsPlayerConnected(playerid))
				{
					new gstring[255];
					format(gstring, sizeof(gstring), "{BEBEBE}[ IMOBILIARIA ]: {FFFFFF}O Jugador(a) {FFFF00}%s {FFFFFF]colocou sua casa id {FFFF00}%d {FFFFFF}a venda no valor de {FFFF00}$%d", Name(playerid), CasaInfo[i][CasaId], CasaInfo[i][CasaValor]);
					SendClientMessageToAll(COR_GREY, gstring);
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
	ShowPlayerDialog(playerid, DIALOG_MENUANIM, DIALOG_STYLE_LIST, "Menu Anim", "{FFFF00}-{FFFFFF} HANDSUP\n{FFFF00}+{FFFFFF} Sentarse\n{FFFF00}+{FFFFFF} Tumbarse\n{FFFF00}+{FFFFFF} Apuntar\n{FFFF00}+{FFFFFF} Bajar\n{FFFF00}+{FFFFFF} Brazos Cruzados\n{FFFF00}+{FFFFFF} Salir Animacion", "Selecionar", "X");
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
		strcat(megastrings,"\n{FFFFFF}Primeiros 100k:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}$15000");
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
		strcat(megastrings,"\n{FFFFFF}Alugar Moto:\t{FFFF00}Nao Fez{FFFFFF}\t{00FF00}$500");
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
			return SendClientMessage(playerid, COR_VERMELHO, "{FF2400}[ERRO]: {FFFFFF}Use: /criarradar [velocidade]");
		}
		else if(velocidade <= 0)
		{
			return notificacao(playerid, "ERRO", "Usar uma velocidade de 0Km a 100Km.", ICONE_ERRO);
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
					notificacao(playerid, "EXITO", string, ICONE_CERTO);
					return 1;
				}
			}
		}
	}
	else
	{
		return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	}
	return 1;
}

CMD:dradar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 6)
	{
		new id, arq1[50], mensagem[128];
		if(sscanf(params, "i", id)) return SendClientMessage(playerid, -1, "{FF2400}[ERRO]: {FFFFFF}Use: /dradar [ID do Radar].");
		format(arq1, sizeof(arq1), PASTA_RADAR, id);
		if(DOF2_FileExists(arq1))
		{
			format(mensagem, sizeof(mensagem), "Voce removeu o radar id %d.", id);
			notificacao(playerid, "EXITO", mensagem, ICONE_CERTO);
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
			notificacao(playerid, "ERRO", mensagem, ICONE_ERRO);
		}
	}
	else
	{
		notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	}
	return 1;
}

CMD:remolcar(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
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
	if(!closeveh) return notificacao(playerid, "ERRO", "Nao esta proximo de um veiculo!", ICONE_ERRO);
	AttachTrailerToVehicle(closeveh, vehicleid);
	return 1;
}

CMD:ejetar(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
	new pid, msg[128];
	if(sscanf(params, "u", pid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /ejetar [player]");
	if(!IsPlayerConnected(pid)) return notificacao(playerid, "ERRO", "Jogador invalido!", ICONE_ERRO);
	new vehicleid = GetPlayerVehicleID(playerid);
	if(!IsPlayerInVehicle(pid, vehicleid)) return notificacao(playerid, "ERRO", "O jogador nao esta en seu veiculo!.", ICONE_ERRO);
	RemovePlayerFromVehicle(pid);
	format(msg, sizeof(msg), "O condutor do veiculo %s (%d) te expulsou do veiculo.", PlayerName(playerid), playerid);
	notificacao(pid, "INFO", msg, ICONE_AVISO);
	return 1;
}

CMD:ejetarll(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return notificacao(playerid, "ERRO", "No estas conduciendo un vehiculo!", ICONE_ERRO); 
	new vehicleid = GetPlayerVehicleID(playerid);
	new msg[128];
	format(msg, sizeof(msg), "O condutor do veiculo %s (%d) te expulsou do veiculo.", PlayerName(playerid), playerid);
	foreach(Player, i)
	{
		if(IsPlayerConnected(i) && i != playerid && IsPlayerInVehicle(i, vehicleid))
		{
			RemovePlayerFromVehicle(i);
			notificacao(i, "INFO", msg, ICONE_AVISO);
		}
	}
	notificacao(playerid, "EXITO", "Voce expulsou todos os passageiros.", ICONE_CERTO);
	return 1;
}

CMD:limparmods(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
	new vehicleid = GetPlayerVehicleID(playerid);
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return notificacao(playerid, "ERRO", "Este nao e seu veiculo!", ICONE_ERRO);
	for(new i=0; i < sizeof(VehicleMods[]); i++)
	{
		RemoveVehicleComponent(VehicleID[id], GetVehicleComponentInSlot(VehicleID[id], i));
		VehicleMods[id][i] = 0;
	}
	VehiclePaintjob[id] = 255;
	ChangeVehiclePaintjob(VehicleID[id], 255);
	SaveVehicle(id);
	notificacao(playerid, "EXITO", "Voce removeu todos os mods do seu veiculo.", ICONE_CERTO);
	return 1;
}

CMD:localizarv(playerid, params[])
{
	if(TrackCar[playerid])
	{
		TrackCar[playerid] = 0;
		DisablePlayerCheckpoint(playerid);
		notificacao(playerid, "EXITO", "Voce nao esta mais rastreando seu veiculo.", ICONE_CERTO);
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
	if(!found) return notificacao(playerid, "ERRO", "Nao possui nenhum veiculo!.", ICONE_ERRO);
	ShowPlayerDialog(playerid, DIALOG_FINDVEHICLE, DIALOG_STYLE_LIST, "Localizando seu veiculo", info, "Encontrar", "X");
	return 1;
}

CMD:mv(playerid, params[])
{
	if(GetPlayerState(playerid) != PLAYER_STATE_DRIVER) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
	new vehicleid = GetPlayerVehicleID(playerid);
	if(IsBicycle(vehicleid)) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
	new id = GetVehicleID(vehicleid);
	if(GetPlayerVehicleAccess(playerid, id) < 1)
		return notificacao(playerid, "ERRO", "Nao tem a chave deste veiculo!", ICONE_ERRO);
	SetPVarInt(playerid, "DialogValue1", id);
	ShowDialog(playerid, DIALOG_VEHICLE);
	return 1;
}

CMD:venderv(playerid, params[])
{
	new pid, id, price, msg[128];
	if(sscanf(params, "udd", pid, id, price)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /venderv [player] [vehicleid] [price]");
	if(!IsPlayerConnected(pid)) return notificacao(playerid, "ERRO", "Jogador invalido", ICONE_ERRO);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return notificacao(playerid, "ERRO", "Voce nao e dono deste veiculo!", ICONE_ERRO);
	if(price < 1) return notificacao(playerid, "ERRO", "Valor invalido.", ICONE_ERRO);
	if(!PlayerToPlayer(playerid, pid, 10.0)) return notificacao(playerid, "ERRO", "O jogador esta muito longe!", ICONE_ERRO);
	SetPVarInt(pid, "DialogValue1", playerid);
	SetPVarInt(pid, "DialogValue2", id);
	SetPVarInt(pid, "DialogValue3", price);
	ShowDialog(pid, DIALOG_VEHICLE_SELL);
	format(msg, sizeof(msg), "Ofereceu a %s (%d) comprar seu veiculo por $%d", PlayerName(pid), pid, price);
	notificacao(playerid, "EXITO", msg, ICONE_CERTO);
	return 1;
}

CMD:darchaves(playerid, params[])
{
	new pid, id, msg[128];
	if(sscanf(params, "ud", pid, id)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /darchaves [player] [vehicleid]");
	if(!IsPlayerConnected(pid)) return notificacao(playerid, "ERRO", "Jogador invalido", ICONE_ERRO);
	if(!IsValidVehicle1(id)) return SendClientMessage(playerid, COLOR_RED, "ID de veiculo nao valido!");
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return SendClientMessage(playerid, COLOR_RED, "Voce nao e dono deste veiculo!");
	if(!PlayerToPlayer(playerid, pid, 10.0)) return SendClientMessage(playerid, COLOR_RED, "O jogador esta muito longe!");
	SetPVarInt(pid, "CarKeys", id);
	format(msg, sizeof(msg), "Voce entregou as chaves do seu carro para %s (%d)", PlayerName(pid), pid);
	notificacao(playerid, "EXITO", msg, ICONE_CERTO);
	format(msg, sizeof(msg), "%s (%d) te deu as chaves do carro", PlayerName(playerid), playerid);
	notificacao(pid, "INFO", msg, ICONE_AVISO);
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
	if(!vehicleid) return notificacao(playerid, "ERRO", "Nao, voce esta perto de um veiculo!", ICONE_ERRO);
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle1(id)) return notificacao(playerid, "ERRO", "Voce nao tem as chaves deste veiculo!", ICONE_ERRO);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return notificacao(playerid, "ERRO", "Voce nao tem as chaves deste veiculo!", ICONE_ERRO);
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
	if(!vehicleid) return notificacao(playerid, "ERRO", "Voce nao esta perto de um veiculo!", ICONE_ERRO);
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle1(id)) return notificacao(playerid, "ERRO", "Voce nao tem as chaves deste veiculo!", ICONE_ERRO);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return notificacao(playerid, "ERRO", "Voce nao tem as chaves deste veiculo!", ICONE_ERRO);
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
		return notificacao(playerid, "ERRO", "Nao esta perto de um veiculo!", ICONE_ERRO);
	new id = GetVehicleID(vehicleid);
	if(!IsValidVehicle1(id)) return notificacao(playerid, "ERRO", "Voce nao tem as chaves deste veiculo!", ICONE_ERRO);
	if(GetPlayerVehicleAccess(playerid, id) < 2)
		return notificacao(playerid, "ERRO", "Voce nao tem as chaves deste veiculo!", ICONE_ERRO);
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
	notificacao(playerid, "ERRO", "Voce nao esta em um posto de combustivel!", ICONE_ERRO);
	return 1;
}

CMD:rtc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(!IsPlayerInAnyVehicle(playerid)) return notificacao(playerid, "ERRO", "Nao esta em um veiculo!", ICONE_ERRO); 
	SetVehicleToRespawn(GetPlayerVehicleID(playerid));
	notificacao(playerid, "EXITO", "Veiculo respawnado", ICONE_CERTO);
	return 1;
}

CMD:rac(playerid, params[])
{
	new bool:vehicleused[MAX_VEHICLES];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
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
	format(msg, sizeof(msg), "O Administrador %s (%d) respawnou todos os veiculos sem motorista.", PlayerName(playerid), playerid);
	SendClientMessageToAll(COLOR_YELLOW, msg);
	return 1;
}

CMD:setgasolina(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(!IsPlayerInAnyVehicle(playerid)) return notificacao(playerid, "ERRO", "Nao esta em um veiculo", ICONE_ERRO);
	new amount, msg[128];
	if(sscanf(params, "d", amount)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /setgasolina [amount]");
	if(amount < 0 || amount > 100) return notificacao(playerid, "ERRO", "Coloque de 0 a 100L.", ICONE_ERRO);
	Fuel[GetPlayerVehicleID(playerid)] = amount;
	format(msg, sizeof(msg), "Abasteceu o veiculo com %d", amount);
	notificacao(playerid, "EXITO", msg, ICONE_CERTO);
	return 1;
}

CMD:addv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "You can't use this command now!");
	new model, dealerid, color1, color2, price;
	if(sscanf(params, "ddddd", dealerid, model, color1, color2, price))
		return SendClientMessage(playerid, COLOR_GREY, "USAGE: /addv [dealerid] [model] [color1] [color2] [price]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido");
	if(model < 400 || model > 611) return SendClientMessage(playerid, COLOR_RED, "Invalid model ID!");
	if(color1 < 0 || color2 < 0) return SendClientMessage(playerid, COLOR_RED, "Invalid color!");
	if(price < 0) return SendClientMessage(playerid, COLOR_RED, "Invalid price!");
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
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Can't add any more vehicles!");
	return 1;
}

CMD:editv(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		new id = GetVehicleID(GetPlayerVehicleID(playerid));
		if(!IsValidVehicle1(id)) return SendClientMessage(playerid, COLOR_RED, "This is not a dynamic vehicle!");
		SetPVarInt(playerid, "DialogValue1", id);
		ShowDialog(playerid, DIALOG_EDITVEHICLE);
		return 1;
	}
	new vehicleid;
	if(sscanf(params, "d", vehicleid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /editv [vehicleid]");
	if(!IsValidVehicle1(vehicleid)) return SendClientMessage(playerid, COLOR_RED, "Invalid vehicleid!");
	SetPVarInt(playerid, "DialogValue1", vehicleid);
	ShowDialog(playerid, DIALOG_EDITVEHICLE);
	return 1;
}

CMD:adddealership(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "Voce nao pode usar o comando!");
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
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Ja possui muitas concessionarias.");
	return 1;
}

CMD:deletedealership(playerid, params[])
{	
	new dealerid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /deletedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido!");
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
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:movedealership(playerid, params[])
{
	new dealerid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);	
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /movedealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido");
	GetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	UpdateDealership(dealerid, 1);
	SaveDealership(dealerid);
	format(msg, sizeof(msg), "Concessionaria %d movida.", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:gotodealership(playerid, params[])
{
	new dealerid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	
	if(sscanf(params, "d", dealerid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotodealership [dealerid]");
	if(!IsValidDealership(dealerid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido");
	SetPlayerPos(playerid, DealershipPos[dealerid][0], DealershipPos[dealerid][1], DealershipPos[dealerid][2]);
	TogglePlayerControllable(playerid, false);
	SetTimerEx("carregarobj", 5000, 0, "i", playerid);
	format(msg, sizeof(msg), "Teleportado para concessionaria %d", dealerid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:addfuelstation(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(!IsPlayerSpawned(playerid)) return SendClientMessage(playerid, COLOR_RED, "Voce nao pode usar o comando!");
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
			SendClientMessage(playerid, COLOR_WHITE, msg);
			return 1;
		}
	}
	SendClientMessage(playerid, COLOR_RED, "Ja possui muitos postos");
	return 1;
}

CMD:deletefuelstation(playerid, params[])
{
	new stationid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(sscanf(params, "d", stationid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /deletefuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido");
	FuelStationCreated[stationid] = 0;
	Delete3DTextLabel(FuelStationLabel[stationid]);
	SaveFuelStation(stationid);
	format(msg, sizeof(msg), "Posto %d deletado.", stationid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:movefuelstation(playerid, params[])
{
	new stationid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(sscanf(params, "d", stationid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /movefuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido");
	GetPlayerPos(playerid, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	UpdateFuelStation(stationid, 1);
	SaveFuelStation(stationid);
	format(msg, sizeof(msg), "Posto %d movido.", stationid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:gotofuelstation(playerid, params[])
{
	new stationid, msg[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(sscanf(params, "d", stationid)) return SendClientMessage(playerid, COLOR_GREY, "USAGE: /gotofuelstation [stationid]");
	if(!IsValidFuelStation(stationid)) return SendClientMessage(playerid, COLOR_RED, "ID invalido");
	SetPlayerPos(playerid, FuelStationPos[stationid][0], FuelStationPos[stationid][1], FuelStationPos[stationid][2]);
	TogglePlayerControllable(playerid, false);
	SetTimerEx("carregarobj", 5000, 0, "i", playerid);
	format(msg, sizeof(msg), "Teleportado para o Posto %d", stationid);
	SendClientMessage(playerid, COLOR_WHITE, msg);
	return 1;
}

CMD:criarcn(playerid)
{
	new String[256], Float:PozX, Float:PozY, Float:PozZ;
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(EditingSM[playerid] != 0) return notificacao(playerid, "ERRO", "Ja esta editando um caca niquel.", ICONE_ERRO); 
	if(Playing[playerid] == true) return notificacao(playerid, "ERRO", "Esta jogando e nao pode criar.", ICONE_ERRO);
	for(new i; i < MAX_SLOTMACHINE; i++)
	{
		if(DOF2_FileExists(GetSlotMachine(i))) continue;
		DOF2_CreateFile(GetSlotMachine(i)), DOF2_SetInt(GetSlotMachine(i), "SmID", i), DOF2_SetInt(GetSlotMachine(i), "Jackpot", 0), DOF2_SetFloat(GetSlotMachine(i), "PozX", PozX), DOF2_SetFloat(GetSlotMachine(i), "PozY", PozY), DOF2_SetFloat(GetSlotMachine(i), "PozZ", PozZ), DOF2_SaveFile();
		GetPlayerPos(playerid, PozX, PozY, PozZ), format(String, sizeof(String), "Caca-niquel ID: %i criado, Use ESPACE se deseja mudar a visao!", i), notificacao(playerid, "EXITO", String, ICONE_CERTO);
		DataSlotMachine[i][SmObject] = CreateObject(2325, PozX+1, PozY+1, PozZ, 0.0, 0.0, 0.0), SmID[playerid] = i, EditingSM[playerid] = 1, EditObject(playerid, DataSlotMachine[i][SmObject]);
		break;	
	}	
	return 1;
}

CMD:dcn(playerid)
{
	new String[128];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(EditingSM[playerid] != 0) return notificacao(playerid, "ERRO", "Esta editando um objeto.", ICONE_ERRO); 
	if(Playing[playerid] == true) return notificacao(playerid, "ERRO", "Esta jogando e nao pode criar.", ICONE_ERRO); 
	for(new i; i < MAX_SLOTMACHINE; i++)
	{
		if(!DOF2_FileExists(GetSlotMachine(i))) continue;
		if(IsPlayerInRangeOfPoint(playerid, 1.0, DOF2_GetFloat(GetSlotMachine(i), "PozX"), DOF2_GetFloat(GetSlotMachine(i), "PozY"), DOF2_GetFloat(GetSlotMachine(i), "PozZ")))
		{
			if(DataSlotMachine[i][Occupied] == true) return SendClientMessage(playerid, -1, "{FFFF00}[Casino] Nao pode deletar a maquina agora.");
			PlayerInfo[playerid][pDinheiro] += DOF2_GetInt(GetSlotMachine(i), "Jackpot"), DOF2_RemoveFile(GetSlotMachine(i)), DestroyDynamic3DTextLabel(DataSlotMachine[i][TextoSm]), DestroyObject(DataSlotMachine[i][SmObject]), format(String, sizeof(String), "{FF0033}Você deletou o Caca-niquel de ID: {FFFFFF}%d{FF0033}.", i), SendClientMessage(playerid, -1 , String);
			break;
		}
	}
	return 1;
}

CMD:editcn(playerid)
{
	new String[256];
	if(PlayerInfo[playerid][pAdmin] < 6)						return notificacao(playerid, "ERRO", "Sem permissao", ICONE_ERRO);
	if(EditingSM[playerid] != 0) return notificacao(playerid, "ERRO", "Ja esta editando uma maquina.", ICONE_ERRO);
	if(Playing[playerid] == true) return notificacao(playerid, "ERRO", "Esta jogando e nao pode criar.", ICONE_ERRO);
	for(new i; i < MAX_SLOTMACHINE; i++)
	{
		if(!DOF2_FileExists(GetSlotMachine(i))) continue;
		if(IsPlayerInRangeOfPoint(playerid, 1.0, DOF2_GetFloat(GetSlotMachine(i), "PozX"), DOF2_GetFloat(GetSlotMachine(i), "PozY"), DOF2_GetFloat(GetSlotMachine(i), "PozZ")))
		{
			if(DataSlotMachine[i][Occupied] == true) return notificacao(playerid, "ERRO", "Esta jogando e nao pode criar.", ICONE_ERRO);
			SmID[playerid] = i, EditingSM[playerid] = 1, format(String, sizeof(String), "Use ESPACE se deseja mudar a visao!", SmID[playerid]), notificacao(playerid, "INFO", String, ICONE_AVISO);
			EditObject(playerid, DataSlotMachine[i][SmObject]);
			break;
		}
	}
	return 1;
}

CMD:infocn(playerid)
{
	new String[256];
	if(EditingSM[playerid] != 0) return notificacao(playerid, "ERRO", "Esta editando um objeto.", ICONE_ERRO);
	for(new i; i < MAX_SLOTMACHINE; i++)
	{
		if(!DOF2_FileExists(GetSlotMachine(i))) continue;
		if(IsPlayerInRangeOfPoint(playerid, 1.0, DOF2_GetFloat(GetSlotMachine(i), "PozX"), DOF2_GetFloat(GetSlotMachine(i), "PozY"), DOF2_GetFloat(GetSlotMachine(i), "PozZ")))
		{
			format(String, sizeof(String), "Esta maquina %d possui R$%i de JACKPOT.", i, DOF2_GetInt(GetSlotMachine(i), "Jackpot")), notificacao(playerid, "INFO", String, ICONE_AVISO);
			break;
		}
	}
	return 1;
}

CMD:freq(playerid, params[])
{
	new freq;
	if(sscanf(params, "d", freq)) return SendClientMessage(playerid, -1,"Uso: /freq [FREQ. 1-1000 (0 Desligar)]");
	if(freq > MAX_FREQUENCIAS || freq < 0) return SendClientMessage(playerid, 0xFF0000FF, "Freq Invalida!");
	if(freq == 0)
	{
		FrequenciaConectada[playerid] = 0;
		SendClientMessage(playerid, 0xFF0000FF, "Radio desligado!");
		SvDetachListenerFromStream(Frequencia[freq], playerid);
		FrequenciaConectada[playerid] = 0;
	} else {
		new string[128];
		format(string, 128, "Frequencia conectada: (%d).", freq);
		SendClientMessage(playerid, 0x00AE00FF, string);

		format(string, 128, "%s saiu da frequencia(%d)", Name(playerid), FrequenciaConectada[playerid]);
		MsgFrequencia(FrequenciaConectada[playerid], 0xBF0000FF, string);
		format(string, 128, "%s entrou na frequencia(%d)", Name(playerid), freq);
		MsgFrequencia(freq, 0xFF6C00FF, string);

		SetTimerEx("ConectarNaFrequencia", 100, false, "id", playerid, freq);
	}
	return 1;
}

CMD:vip(playerid, params[])
{
	if(PlayerInfo[playerid][pVIP] < 1)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "s[56]", Motivo)) 							return SendClientMessage(playerid, CorErroNeutro, "USE: /vip [TEXTO]");
	//
	format(Str, sizeof(Str), "%s {FFFF00}%s{FFFFFF} disse {FFFF00}%s", VIP(playerid), Name(playerid), Motivo);
	SendAdminMessage(0xDDA0DDFF, Str);
	return 1;
}

CMD:mudarskin(playerid, params[])
{
	new skinid;
	if(PlayerInfo[playerid][pVIP] < 3)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "i", skinid))  							return SendClientMessage(playerid, CorErroNeutro, "USE: /cambiarskin [ID]");

	PlayerInfo[playerid][pSkin] = skinid;
	SetPlayerSkin(playerid, skinid);
	SalvarDadosSkin(playerid);
	return 1;
}

CMD:tunar(playerid,params[])
{
	if(!IsPlayerInAnyVehicle(playerid))
		return SendClientMessage(playerid, 0x27408BFF, "Nao esta em um veiculo.");

	if(GetPlayerVehicleSeat(playerid) != 0)
        return SendClientMessage(playerid,  0x27408BFF, "Nao esta dentro do veiculo.");

	if(!GetVehicleModelEx(GetVehicleModel(GetPlayerVehicleID(playerid))))
	    return SendClientMessage(playerid,  0x27408BFF, "Este veiculo nao pode ser tunado.");
	if(wTuning[playerid] == true)
	    return SendClientMessage(playerid,  0x27408BFF, "Ja esta tunando.");

    static
		nome_veiculo[40]
	;

	format(nome_veiculo, sizeof(nome_veiculo), "veiculo: %s", VehicleNames[GetVehicleModel(GetPlayerVehicleID(playerid)) - 400]);
    PlayerTextDrawSetString(playerid, PlayerText:wMenu[0], nome_veiculo);

    SendClientMessage(playerid,  0x27408BFF, "Tunando Veiculo.");

    for(new i; i < sizeof(wBase); i++) { TextDrawShowForPlayer(playerid, Text:wBase[i]); }
	for(new i; i < sizeof(wMenu); i++) { PlayerTextDrawShow(playerid, PlayerText:wMenu[i]); }
	for(new i; i < sizeof(wMenuRodas); i++) { PlayerTextDrawShow(playerid, PlayerText:wMenuRodas[i]); }

	SelectTextDraw(playerid, 0x4F4F4FFF);
	wTuning[playerid] = true;
	return 1;
}

CMD:tunagemvip(playerid)
{
	new wVeiculo = GetPlayerVehicleID(playerid);
	if(PlayerInfo[playerid][pVIP] < 3)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
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
	if(PlayerInfo[playerid][pVIP] < 3)						return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(!IsPlayerInAnyVehicle(playerid)) return notificacao(playerid, "ERRO", "Nao esta em um veiculo.", ICONE_ERRO);
 
    RepairVehicle(GetPlayerVehicleID(playerid));
	SetVehicleHealth(GetPlayerVehicleID(playerid), 1000.0);
	notificacao(playerid, "EXITO", "Reparou este veiculo.", ICONE_CERTO);
	return 1;
}

CMD:pediravaliar(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] < 1) return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	if(sscanf(params, "d", ID)) return SendClientMessage(playerid, CorErroNeutro, "USE: /pediravaliar [ID]");

	ShowPlayerDialog(ID, DIALOG_AVALIAR, DIALOG_STYLE_MSGBOX, "Avaliando o administrador", "Um staff pediu sua avaliacao pelo atendimento oferecido.\nAgora a escolha e sua se deseja que ele seja recompensado no futuro\n\nDeseja dar um ponto de avaliacao para o staff?", "SIM", "NAO");
	return 1;
}

CMD:verpontos(playerid)
{
	new string[255];
	if(PlayerInfo[playerid][pAdmin] < 1) return notificacao(playerid, "ERRO", "Nao possui permissao.", ICONE_ERRO);
	format(string, sizeof(string), "Possui %d pontos", PlayerInfo[playerid][pAvaliacao]);
	notificacao(playerid, "EXITO", string, ICONE_CERTO);
	return 1;
}

CMD:atendimento(playerid)
{
	new String[255];
	if(pLogado[playerid] == false)              				return notificacao(playerid, "ERRO", "Nao esta conectado", ICONE_AVISO);

	format(String, sizeof(String), "O jogador {FFFF00}%s {FFFFFF}esta solicitando atendimento use {FFFF00}/par {FFFFFF}ou va ate ele.", Name(playerid));
	SendAdminMessage(-1, String);
	return 1;
}