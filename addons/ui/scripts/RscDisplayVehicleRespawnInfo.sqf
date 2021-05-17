#include "script_component.hpp"
#define SELF UI_SCRIPT(RscDisplayVehicleRespawnInfo)
params ["_mode", "_params"];
private _cfgVehicleRespawnInfo = missionConfigFile >> "gamemode" >> "vehicle_respawn_info";
switch _mode do {
	case "onLoad":{
		_params params ["_display"];
		[_display, "Display loading..."] call FNC_DISPLAY_LOG;

		// _ctrlNew

		_ctrlOpen = _display displayCtrl IDC_RSCDISPLAYVEHICLERESPAWNINFO_OPEN;
		_ctrlOpen ctrlAddEventHandler ["ButtonClick", {
			with uiNamespace do {
				["Open", _this] call SELF
			};
		}];

		//--- Set default hashmap
		_display setVariable ["_hmap", createHashMap];

		[_display, "Display loaded."] call FNC_DISPLAY_LOG;
	};
	case "Open": {
		_params params ["_ctrlOpen"];
		_display = ctrlParent _ctrlOpen;
		_ctrlGroupRespawns = _display displayCtrl IDC_RSCDISPLAYVEHICLERESPAWNINFO_GROUPRESPAWNS;
		[_display, format ["Loading config from %1", _cfgVehicleRespawnInfo]] call FNC_DISPLAY_LOG;
		private _count = {
			["AddItem", [_display, configName _x]] call SELF;
			_forEachIndex
		} forEach ("true" configClasses _cfgVehicleRespawnInfo);
		[_display, format["Loaded %1 entries.", _count]] call FNC_DISPLAY_LOG;
	};
	case "AddItem":{
		_params params ["_display", "_class"];
		//--- Update hashmap
		_hmap = _display getVariable "_hmap";
		_cfgItem = _cfgVehicleRespawnInfo >> _class;
		_hmap set [_class, createHashMapFromArray [
			["respawnType", getText(_cfgItem >> "respawnType")],
			["time", getNumber(_cfgItem >> "time")]
		]];
		_parent = inheritsFrom _cfgItem;
		_isParentValid = isClass (_cfgVehicleRespawnInfo >> configName _parent);
		if (_isParentValid) then {
			_hmap get _class set ["parent", _parent];
		};

		//--- Update UI
		_itemCount = count (["GetItemControls", [_display]] call SELF);
		_ctrlItem = _display ctrlCreate ["ctrlVehicleRespawnInfoItem", -1, _ctrlGroupRespawns];
		_ctrlItem ctrlSetPositionY (_itemCount * 6 * GRID_H);
		_ctrlItem ctrlCommit 0.1;
		allControls _ctrlItem params ["_ctrlClass", "_ctrlParent", "_ctrlType", "_ctrlTime"];
		_ctrlClass ctrlSetText configName _x;
		private _type = getText(_x >> "respawnType");
		_ctrlType lbSetCurSel (["RESPAWN", "WRECK"] findIf {_x == _type});
		_ctrlTime ctrlSetText str (getNumber(_x >> "time"));
		_ctrlParent ctrlSetBackgroundColor ([[0.5,0,0,1], [0,0.5,0,1]] select (_isParentValid));
		_ctrlParent ctrlAddEventHandler ["ButtonClick", {
			with uiNamespace do {["SelectParent", _this] spawn SELF;};
		}];
	};
	case "GetItemControls":{
		_params params ["_display"];
		_ctrlGroupRespawns = _display displayCtrl IDC_RSCDISPLAYVEHICLERESPAWNINFO_GROUPRESPAWNS;
		allControls _ctrlGroupRespawns select {ctrlParentControlsGroup _x == _ctrlGroupRespawns}
	};
	case "SelectParent":{
		_params params ["_ctrlParent"];
		_display = ctrlParent _ctrlParent;
		_ctrlItem = ctrlParentControlsGroup _ctrlParent;
		allControls _ctrlItem params ["_ctrlClass", "", "_ctrlType", "_ctrlTime"];
		private _class = ctrlText _ctrlClass;

		private _keys = [_display, _display getVariable "_hmap", true, nil, nil, "Select Parent"] call (missionNamespace getVariable "TER_MFU_fnc_hashmapViewer");
		private _newParent = _keys param [0, ""];
		if (_newParent == "") exitWith {
			[_display, "No new parent selected."] call FNC_DISPLAY_LOG;
		};
		private _hmap = _display getVariable "_hmap";
		_hmap get (ctrlText _ctrlClass) set ["parent", _newParent];
		[_display, format ["New parent (%1) selected for %2", _newParent, _class]] call FNC_DISPLAY_LOG;
		
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};
