#include "..\..\script_common_macros.hpp"

params["_player"];

call compile (DB format["0:sql:savePlayer:%1:%2", name _player, getPlayerUID _player]);
diag_log "WE HAVE NOT THE PLAYER ALREADY!";
_player setVariable ["PT_PLAYER_UID", getPlayerUID _player, true];
