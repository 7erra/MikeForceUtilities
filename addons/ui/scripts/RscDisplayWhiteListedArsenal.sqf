#include "script_component.hpp"
#define SELF UI_SCRIPT(RscDisplayWhiteListedArsenal)
params ["_mode", "_params"];
switch _mode do {
	case "onLoad":{
		_params params ["_display"];
		_ctrlNew = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_NEW;
		_ctrlNew ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["New", _this] call SELF;};
		}];
		_ctrlOpen = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_OPEN;
		_ctrlOpen ctrlAddEventHandler ["ButtonClick", {
			with uiNamespace do {["Open", _this] spawn SELF;};
		}];
		_ctrlExport = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_EXPORT;
		_ctrlExport ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["Export", _this] call SELF;};
		}];
		_ctrlSections = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_SECTIONS;
		_ctrlSections ctrlAddEventHandler ["ToolBoxSelChanged", {
			with uiNamespace do {["SelectSection", _this] call SELF;};
		}];
		_ctrlAdd = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_ADD;
		_ctrlAdd ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["Add", _this] spawn SELF;};
		}];
		_ctrlCopyLog = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_COPYLOG;
		_ctrlCopyLog ctrlAddEventHandler ["ButtonClick", {
			with uiNamespace do {["CopyLog", _this] call SELF;};
		}];
		["Reset", [_display]] call SELF;
		_display setVariable ["_log", ["--- Start of Log ---"]];
		["Log", [_display, "Display loaded."]] call SELF;
	};
	case "Reset":{
		_params params ["_display"];
		//--- Reset everything
		_ctrlConfigName = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_CONFIGNAME;
		_ctrlConfigName ctrlSetText "";
		_ctrlDisplayNameEditBox = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_DISPLAYNAMEEDITBOX;
		_ctrlDisplayNameEditBox ctrlSetText "";
		_display setVariable ["_hmapArsenal", ["DefaultHashmap"] call SELF];
		_display setVariable ["_cfgArsenalEntry", nil];
	};
	case "New":{
		_params params ["_ctrlNew"];
		_display = ctrlParent _ctrlNew;
		["Reset", [_display]] call SELF;
		["Fill", [_display]] call SELF;
		["Log", [_display, "Cleared everything."]] call SELF;
	};
	case "DefaultHashmap":{
		createHashMapFromArray [
			["displayName", ""],
			["weapons", createHashMap],
			["magazines", createHashMap],
			["items", createHashMap],
			["backpacks", createHashMap],
			["vehicles", createHashMap]
		];
	};
	case "Open":{
		_params params ["_ctrlOpen"];
		_display = ctrlParent _ctrlOpen;
		_cfgArsenalEntry = [
			_display,
			missionConfigFile >> "vn_whitelisted_arsenal_loadouts",
			true,
			nil,
			nil,
			"Choose Config"
		] call BIS_fnc_configViewer;
		_cfgArsenalEntry params [["_cfgArsenalEntry", configNull]];
		if (isNull _cfgArsenalEntry) exitWith {
			["Log", [_display, "No config selected.", "WARN"]] call SELF;
		};

		_display setVariable ["_cfgArsenalEntry", _cfgArsenalEntry];
		["Log", [_display, format["Set %1 as arsenal config.", configName _cfgArsenalEntry]]] call SELF;

		//--- Set Config name
		_ctrlConfigName = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_CONFIGNAME;
		_ctrlConfigName ctrlSetText configName _cfgArsenalEntry;

		//--- Set Display name
		_ctrlDisplayNameEditBox = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_DISPLAYNAMEEDITBOX;
		_ctrlDisplayNameEditBox ctrlSetText (getTextRaw(_cfgArsenalEntry >> "displayName"));

		//--- Hashmap the config
		_hmapArsenal = createHashMapFromArray [
			["displayName", getText(_cfgArsenalEntry >> "displayName")]
		];
		//--- Create the hashmaps for the sections
		["weapons", "magazines", "items", "backpacks", "vehicles"] apply {
			_classes = getArray(_cfgArsenalEntry >> _x) apply {
				_x params ["_class", "_ranks"];
				_ranks params ["_rankEast", "_rankWest", "_rankIndep", "_rankCiv"];
				_hmapRanks = createHashMapFromArray [
					["east", _rankEast],
					["west", _rankWest],
					["independent", _rankIndep],
					["civilian", _rankCiv]
				];
				[_class, _hmapRanks]
			};
			_hmapArsenal set [_x, createHashmapFromArray _classes];
		};

		_display setVariable ["_hmapArsenal", _hmapArsenal];
		//--- Fill List, unscheduled
		isNil {["Fill", [_display, _cfgArsenalEntry]] call SELF;};
		nil
	};
	case "Fill":{
		_params params ["_display"];
		_cfgArsenalEntry = _params param [1, _display getVariable ["_cfgArsenalEntry", configNull]];
		_ctrlGroup = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP;
		_ctrlSections = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_SECTIONS;
		_section = ["GetSection", _display] call SELF;
		_hmapArsenal = _display getVariable ["_hmapArsenal", createHashMap];
		_data = _hmapArsenal getOrDefault [_section, createHashMap];
		//--- Clear previous controls
		(allControls _ctrlGroup select {ctrlParentControlsGroup _x == _ctrlGroup}) apply {
			ctrlDelete _x;
		};
		
		["Log", [_display, format["Loading %1 entries...", count _data]]] call SELF;
		{
			["AddItem",[_display, createHashMapFromArray[[_x,_y]]]] call SELF;
		} forEach _data;
		["Log", [_display, "Entries loaded."]] call SELF;
	};
	case "GetSection":{
		// Workaround for broken lbText command not working with CT_TOOLBOX
		_params params ["_display"];
		_ctrlSections = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_SECTIONS;
		getArray(configFile >> "RscDisplayWhiteListedArsenal" >> "controls" >> "Sections" >> "strings") select lbCurSel _ctrlSections
	};
	case "SelectSection":{
		_params params ["_ctrlSections", "_ind"];
		_display = ctrlParent _ctrlSections;
		_cfgArsenalEntry = _display getVariable "_cfgArsenalEntry";
		["Fill", [_display]] call SELF; // Maybe spawn for performance?
	};
	case "Add":{
		_params params ["_ctrlAdd"];
		_display = ctrlParent _ctrlAdd;
		_section = ["GetSection", _display] call SELF;
		_configViewerParams = switch _section do {
			// Format of _condition: [Config, Condition to show in config viewer, Title]
			case "weapons":{
				[
					configFile >> "CfgWeapons",
					{
						getNumber(_cfg >> 'scope') == 2 &&
						{
							getNumber(_cfg >> "type") in [1,2,4] && // primary, secondary, handgun weapons
							{!isClass (_cfg >> "LinkedItems") OR getText(_cfg >> "baseWeapon") == configName _cfg} // only base weapons, no accesories
						}
					},
					"Select Weapon"
				]
			};
			case "magazines":{
				[
					configFile >> "CfgMagazines",
					{
						getNumber(_cfg >> 'scope') == 2 &&
						{getNumber(_cfg >> "type") == 256}
					},
					"Select Magazine"
				]
			};
			case "items":{
				[
					configFile,
					{
						(["CfgGlasses", "CfgWeapons"] apply { // Only show items from these configs
							_allowedParentCfg = configFile >> _x;
							_cfgName = configName _cfg;
							_allowedParentCfg == _cfg || // initial adding of parent configs has to be enabled
							(
								getNumber(_cfg >> "scope") == 2 &&
								{_allowedParentCfg in configHierarchy _cfg} && // entries that are part of the allowed configs
								{
									getNumber(_cfg >> "ItemInfo" >> "type") in [605, 701, 801] || // Headgear, Vest, Uniform
									getNumber(_cfg >> "Type") == 131072 || // Item (Map, Radio, ...)
									(configFile >> "CfgGlasses") in configHierarchy _cfg // facewear
								}
							)
						}) findIf {_x} > -1

					},
					"Select Item"
				]
			};
			case "backpacks":{
				[
					configFile >> "CfgVehicles",
					{
						getNumber(_cfg >> 'scope') == 2 &&
						{getNumber(_cfg >> "isBackpack") == 1}
					},
					"Select Backpack"
				]
			};
			case "vehicles":{
				[
					configFile >> "CfgVehicles",
					{
						getNumber(_cfg >> 'scope') == 2 &&
						{["Car", "Tank", "Air"] apply {
							configName _cfg isKindOf [_x, configFile >> "CfgVehicles"]
						} findIf {_x} > -1}
					},
					"Select Vehicle"
				]
			};
		};
		_configViewerParams params ["_baseConfig", "_condition", "_title"];
		_cfgSelected = [
			_display,
			_baseConfig,
			true,
			nil,
			compile format ["
				params ['_cfg'];
				if (true && %1) exitWith {
					[_cfg] call BIS_fnc_displayName;
				};
				''
			", _condition], // "muuh compile bad" shut up i'm lazy ;)
			"Select Weapon"
		] call BIS_fnc_configViewer;
		_cfgSelected params [["_cfgSelected", configNull]];
		if (
			(["CfgVehicles", "CfgWeapons", "CfgMagazines", "CfgGlasses"] apply {
				isClass(configFile >> _x >> configName _cfgSelected)
			}) findIf {_x} == -1
		) exitWith {
			//--- Not a valid config
			["Log", [_display, format["%1 is not a valid config for %2!", configName _cfgSelected, _section], "FAIL"]] call SELF;
		};
		_defaultEntry = createHashMapFromArray[
			[configName _cfgSelected, createHashMapFromArray[
				["east", -1],
				["west", -1],
				["independent", -1],
				["civilian", -1]
			]]
		];
		["AddItem", [_display, _defaultEntry, true]] call SELF;

	};
	case "AddItem":{
		_params params ["_display", "_data", ["_checkIfNew", false]];
		_ctrlGroup = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP;
		//--- Check if the entry already exists
		_hmapArsenal = _display getVariable ["_hmapArsenal", createHashMap];
		_section = ["GetSection", [_display]] call SELF;
		_class = keys _data select 0;
		if (_checkIfNew && {(_class in (keys (_hmapArsenal get _section)))}) exitWith {
			["Log", [_display, format["""%1"" already used! Modify the existing entry instead.", _class], "FAIL"]] call SELF;
		};

		_ranks = _data get _class;
		//--- Add the item to the UI
		_ctrlItem = _display ctrlCreate ["ctrlWhitelistedArsenalItemGroup", -1, _ctrlGroup];
		_yPos = (1 + (6 * (({ctrlParentControlsGroup _x == _ctrlGroup} count allControls _ctrlGroup) - 1))) * GRID_H;
		_ctrlItem ctrlSetPositionY _yPos;
		_ctrlItem ctrlCommit 0;
		allControls _ctrlItem params [
			"_ctrlClassname",
			"_ctrlRankEast",
			"_ctrlRankWest",
			"_ctrlRankIndep",
			"_ctrlRankCiv",
			"_ctrlDelete"
		];
		_ctrlClassname ctrlSetText _class;
		[
			[_ctrlRankEast, _ranks get "east"],
			[_ctrlRankWest, _ranks get "west"],
			[_ctrlRankIndep, _ranks get "independent"],
			[_ctrlRankCiv, _ranks get "civilian"]
		] apply {
			_x params ["_ctrl", "_rank"];
			_ctrl lbSetCurSel (_rank - 1);
			_ctrl ctrlAddEventHandler ["LBSelChanged",{
				with uiNamespace do {["ChangeRank", _this] call SELF;};
			}];
		};
		_ctrlDelete ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["DeleteItem", _this] spawn SELF;}; // call here to crash the game
		}];
		_ctrlItem ctrlShow true;
		//--- Add the item to the hashmap
		_hmapArsenal get _section merge _data;
		_ctrlGroup spawn {uiSleep 0.01; _this ctrlSetScrollValues [1,0];};

		if (_checkIfNew) then {
			["Log", [_display, format["""%1"" added to %2.", _class, _section]]] call SELF;
		};

	};
	case "DeleteItem":{
		_params params ["_ctrlDelete"];
		_display = ctrlParent _ctrlDelete;
		_ctrlItem = ctrlParentControlsGroup _ctrlDelete;
		_ctrlGroup = ctrlParentControlsGroup _ctrlItem;
		//--- Remove from Hashmap
		_hmapArsenal = _display getVariable ["_hmapArsenal", createHashMap];
		_section = ["GetSection", [_display]] call SELF;
		_class = ctrlText(_ctrlItem controlsGroupCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_CLASS);
		_hmapArsenal getOrDefault [_section, createHashMap] deleteAt _class;
		//--- Remove from UI
		ctrlDelete _ctrlItem;
		{
			_x ctrlSetPositionY (_forEachIndex * 6 * GRID_H);
			_x ctrlCommit 0.1;
		} forEach (allControls _ctrlGroup select {ctrlParentControlsGroup _x == _ctrlGroup});
		["Log", [_display, format["Entry %1 removed from %2.", _class, _section]]] call SELF;
	};
	case "ChangeRank":{
		_params params ["_ctrlRank"];
		_display = ctrlParent _ctrlRank;
		_ctrlItem = ctrlParentControlsGroup _ctrlRank;

		_rank = _ctrlRank lbValue (lbCurSel _ctrlRank);
		_ctrlClass = _ctrlItem controlsGroupCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_CLASS;
		_class = ctrlText _ctrlClass;
		_side = switch (ctrlIDC _ctrlRank) do {
			case IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKEAST: {"east"};
			case IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKWEST: {"west"};
			case IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKINDEPENDENT: {"independent"};
			case IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKCIVILIAN: {"civilian"};
		};
		_section = ["GetSection", [_display]] call SELF;

		["Log", [_display, format["Changing required rank for ""%1"" for side %2 to %3.", _class, _side, _rank]]] call SELF;

		_hmapArsenal = _display getVariable ["_hmapArsenal", createHashMap];
		_hmapArsenal get _section get _class set [_side, _rank];
	};
	case "Export":{
		_params params ["_ctrlExport"];
		_display = ctrlParent _ctrlExport;
		_hmapArsenal = _display getVariable ["_hmapArsenal", createHashMap];
		_lines = [];
		_tab = toString[9];
		_tabs = 0;
		_ranks = ["NONE", "PRIVATE", "CORPORAL", "SERGEANT", "LIEUTENANT", "CAPTAIN", "MAJOR", "COLONEL"];
		_fncNewLine = {
			params ["_line"];
			for "_i" from 1 to _tabs do {
				_line = _tab + _line;
			};
			_lines pushBack _line;
		};
		_fncRankToMacro = {
			params ["_number"];
			format ["RANK_%1", _ranks select (_number +1)]
		};
		//--- Macros
		{
			format ["#define RANK_%1 %2", _x, _foreachindex -1] call _fncNewLine;
		} forEach _ranks;
		"" call _fncNewLine;
		//--- Open main class
		"class vn_whitelisted_arsenal_loadouts" call _fncNewLine;
		"{" call _fncNewLine;
		_tabs = 1;
		//--- Add subclass
		_cfgname = ctrlText(_display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_CONFIGNAME);
		format ["class %1", _cfgname] call _fncNewLine;
		"{" call _fncNewLine;
		_tabs = 2;
		//--- Add displayname property
		_displayName = ctrlText(_display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_DISPLAYNAMEEDITBOX);
		format ["displayName = ""%1"";", _displayName] call _fncNewLine;

		//--- Convert the hashmap back to a functional config
		_ctrlSections = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_SECTIONS;
		_keys = getArray(configFile >> "RscDisplayWhitelistedArsenal" >> "controls" >> "Sections" >> "strings");
		{
			format["%1[] = {", _x] call _fncNewLine;
			_tabs = 3;
			{
				_class = _x;
				_rankEast = _y get "east" call _fncRankToMacro;
				_rankWest = _y get "west" call _fncRankToMacro;
				_rankIndep = _y get "independent" call _fncRankToMacro;
				_rankCiv = _y get "civilian" call _fncRankToMacro;
				_rankMacros = ["east", "west", "independent", "civilian"] apply {
					_y get _x call _fncRankToMacro;
				};
				format ([
					"{""%1"", {%2, %3, %4, %5}}",
					_class
				] + _rankMacros) call _fncNewLine;
			} forEach (_hmapArsenal get _x);

			_tabs = 2;
			"};" call _fncNewLine;
		} forEach _keys;

		//--- Close subclass
		_tabs = 1;
		"};" call _fncNewLine;

		//--- Close main class
		_tabs = 0;
		"};" call _fncNewLine;
		//--- Undefine macros
		"" call _fncNewLine;
		_ranks apply {
			format ["#undef RANK_%1", _x] call _fncNewLine;
		};
		//--- Export to clipboard
		copyToClipboard(_lines joinString endl);
		["Log", [_display, "Exported to clipboard."]] call SELF;
	};
	case "Log":{
		_params params ["_display", "_message", ["_level", "INFO"]];
		_ctrlGroupLog = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPLOG;
		_ctrlLog = _display displayCtrl IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPLOG_LOG;
		_colorLevel = switch _level do {
			case "FAIL": {"#FF0000"};
			case "WARN": {"#FFFF00"};
			default {"#0080FF"};
		};
		// Using an array to conserve structured text formatting
		_log = _display getVariable ["_log", [ctrlText _ctrlLog]];
		_message = format [
			"%1 <t color='%2'>[%3]</t> %4",
			(systemTime apply {if (_x < 10) then {"0" + str _x} else {str _x}}) select [3, 3] joinString ":",
			_colorLevel,
			_level,
			_message
		];
		_log pushBack _message; // Also updates the display variable

		_ctrlLog ctrlSetStructuredText parseText (_log joinString "<br/>");
		_ctrlLog ctrlSetPositionH (ctrlTextHeight _ctrlLog);
		_ctrlLog ctrlCommit 0;

		_ctrlGroupLog spawn {uiSleep 0.01; _this ctrlSetScrollValues [1,1];};
	};
	case "CopyLog":{
		_params params ["_ctrlCopyLog"];
		_display = ctrlParent _ctrlCopyLog;
		_log = _display getVariable ["_log", []];
		copyToClipboard((_log apply {str parseText _x}) joinString endl);
	};
	case "onUnload":{
		_params params ["_display", "_exitCode"];
	};
};

/* 
	Hasmap format:
	{
		Section: {
			Class: {
				Rank East: Value,
				Rank West: Value,
				Rank Independent: Value,
				Rank Civillian: Value,
			}
		},
		// eg:
		"weapons": {
			"classname1": {
				"east": 0,
				"west": 1,
				"independent": 2,
				"civillian": 3
			},
			"classname2": {
				"east": 4,
				"west": 5,
				"independent": 6,
				"civillian": -1
			}
		}
	}
*/
