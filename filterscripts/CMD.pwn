#include <a_samp>
#include <zcmd>

CMD:ir(playerid){
    SetPlayerPos(playerid,  963.418762,2108.292480,1011.030273	);
	SetPlayerInterior(playerid, 1);
	SetPlayerVirtualWorld(playerid, 0);
    return 1;
}