include <a_samp>
#include <DOF2>
#include <sscanf2>
#include <zcmd>

enum PlayerInfo
{
   pDSujo
}
enum xEmpNewx
{
    xSedexNW,//52
 xAletGeral
};
new xEmpNewsX[MAX_PLAYERS][xEmpNewx];
new Float:xPosSedex[20][3] =
{//52
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
    {829.1451,-1553.7571,12.4845}
};
new pInfo[MAX_PLAYERS][PlayerInfo];

public OnPlayerConnect(playerid)
{
    if(!DOF2_FileExists(DSujo(playerid)))
    {
    DOF2_SetInt(DSujo(playerid), "pDSujo", 0);
    DOF2_CreateFile(DSujo(playerid));
    }
    CarregarConta(playerid);
    SendClientMessage(playerid, -1, "Filterscripter Criado Por Rosascript = Contato: luanrosabnh@gmail.com");
    SendClientMessage(playerid, -1, "Contato Wpp: 21 99612-1994 - Discord: SrLuan™#4755");
    return 1;
}
public OnFilterScriptInit()
{
    return 1;
}
public OnFilterScriptExit()
{
    DOF2_Exit();
    return 1;
}
public OnPlayerSpawn(playerid)
{
    return 1;
}
stock CarregarConta(playerid)
{
    pInfo[playerid][pDSujo] = DOF2_GetInt(DSujo(playerid), "pDSujo", pInfo[playerid][pDSujo]);
    GivePlayerMoney(playerid, pInfo[playerid][pDSujo]);
    return 1;
}
stock SalvarConta(playerid)
{
    DOF2_SetInt(DSujo(playerid), "pDSujo", pInfo[playerid][pDSujo]);
    DOF2_SaveFile();
    return 1;
}
public OnPlayerDisconnect(playerid, reason)
{
    SalvarConta(playerid);
    return 1;
}
public OnPlayerUpdate(playerid)
{
    return 1;
}
stock DSujo(playerid)
{
    new arquivo[44], nome[MAX_PLAYER_NAME];
    GetPlayerName(playerid, nome, 44);
    format(arquivo, 44, "DSujo/%s.ini", nome);
    return arquivo;
}
CMD:dards(playerid, params[])
{
       new id;
       new Quantidade;
       new stg[256];
       if(sscanf(params, "ui", id, Quantidade)) return SendClientMessage(playerid, -1, "[ x ] Digite: /dards [ playerid ] [ Quantidade ]");
       format(stg, sizeof(stg), "[ > ] Você recebeu do Administrador %s, %i de Dinheiro Sujo", PlayerName(playerid), Quantidade);
       SendClientMessage(id, -1, stg);
       pInfo[id][pDSujo] += Quantidade;
       return 1;
}
CMD:dsujo(playerid, params[])
{
    new stf[256];
    format(stf, sizeof(stf), "[ > ] Você tem %i de Dinheiro Sujo!", pInfo[playerid][pDSujo]);
    SendClientMessage(playerid, -1, stf);
    return 1;
}

CMD:rota(playerid, params[])
 {
         if(xEmpNewsX[playerid][xSedexNW] != 0) return SendClientMessage(playerid, 0xFF0000FF, "Você já pegou uma entrega!");
      DisablePlayerCheckpoint(playerid);
      new Alt = random(9);
      xEmpNewsX[playerid][xSedexNW] = 1;
      xEmpNewsX[playerid][xAletGeral] = Alt;
      SetPlayerCheckpoint(playerid, xPosSedex[Alt][0],xPosSedex[Alt][1],xPosSedex[Alt][2], 3.0);
      SendClientMessage(playerid, 0xFFFF00FF, "Você pegou a entrega! Vá até o local entrega-lá");
      SendClientMessage(playerid, 0xFFFF00FF, "Quando chega no local marcado de /entregari");
            return 1;
 }
CMD:entregari(playerid, params[])
 {
         if(xEmpNewsX[playerid][xSedexNW] == 0) return SendClientMessage(playerid, 0xFF0000FF, "Você não pegou uma entrega!");
      new PosAlet = xEmpNewsX[playerid][xAletGeral];
      if(!IsPlayerInRangeOfPoint(playerid,2.0,xPosSedex[PosAlet][0],xPosSedex[PosAlet][1],xPosSedex[PosAlet][2])) return SendClientMessage(playerid, 0xFF0000FF, "Você não está no local!");
         DisablePlayerCheckpoint(playerid);
            new AletMt = 2000 + random(5000);
            new oi[100];
         pInfo[playerid][pDSujo] += AletMt;
         xEmpNewsX[playerid][xSedexNW] = 0;
      format(oi, sizeof(oi), "Entrega realizada! Recompensa {33CC33}R$%i", AletMt);
        SendClientMessage(playerid, 0xFFFF00FF, oi);
            return 1;
 }

stock PlayerName(playerid)
{
    new Nome[MAX_PLAYER_NAME];
    GetPlayerName(playerid, Nome, 44);
    return Nome;
}