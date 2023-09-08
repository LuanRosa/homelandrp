#include <a_samp>
#include <zcmd>

CMD:ir(playerid){
    SetPlayerPos(playerid,1800.504150, -1245.274780, 14.635800);
    SetPlayerInterior(playerid, 0);
    return 1;
}