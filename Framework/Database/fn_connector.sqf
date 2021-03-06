#include "..\..\script_common_macros.hpp"
/*
 * Author:  flaver
 * Connector for database
 *
 * Arguments:
 * NONE
 *
 * Return Value:
 * _result
 *
 */

_return = false;
if (isNil {uiNamespace getVariable "extDB_SQL_CUSTOM_ID"}) then {

    //Check if exdb is loaded
    _result = DB "9:VERSION";
    diag_log format["[PROJECT-TACOMA] VERSION %1", _result];
    if (_result == "") exitWith {diag_log "[PROJECT-TACOMA] extDB3 faild to load"; false};

    //connect to db
    _result = parseSimpleArray (DB "9:ADD_DATABASE:TacomaLocal");
    if(_result select 0 isEqualTo 0) exitWith { diag_log format["[PROJECT-TACOMA] Error setting up db connection: %1", _result]; false};

	   _random_number = round(random(999999));
	   _extDB_SQL_CUSTOM_ID = str(_random_number);
	   extDB_SQL_CUSTOM_ID = compileFinal _extDB_SQL_CUSTOM_ID;

     //Set up protocol
    _result = parseSimpleArray (DB "9:ADD_DATABASE_PROTOCOL:TacomaLocal:SQL_CUSTOM:sql:pt.ini");
	   if ((_result select 0) isEqualTo 0) exitWith {diag_log format ["[PROJECT-TACOMA] Error Database Setup: %1", _result]; false};

    diag_log format["[PROJECT-TACOMA] init done with Protocol"];

    //Lock db
    DB "9:LOCK";
	   diag_log "extDB3: Locked";

     //set id
     uiNamespace setVariable ["extDB_SQL_CUSTOM_ID", extDB_SQL_CUSTOM_ID];
     _return = true;
} else {
    extDB_SQL_CUSTOM_ID = compileFinal str(uiNamespace getVariable "extDB_SQL_CUSTOM_ID");
    diag_log "[PROJECT-TACOMA] Already Setup";
    _return = true;
};

_return
