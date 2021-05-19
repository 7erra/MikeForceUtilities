/*
	Author: Terra

	Description:
		Adds a message to the display's log window. The log windows consists of
		a CT_CONTROLS_GROUP with idc = IDC_TERMFU_GROUPLOG and a CT_STRUCTURED_TEXT
		control with idc = IDC_TERMFU_GROUPLOG_LOG as a child controls of the
		first mentioned one. The log is saved to the display as "_log".

	Parameter(s):
		0:	DISPLAY - Display on which to write the log.
		1:	STRING - The message (supports structured text syntax).
		Optional:
		2:	STRING - Severity of the event. One of: "ERROR" (aka. "FAIL"), "WARNING" (aka. "WARN") or "INFO"
			Default: "INFO"

	Returns:
		STRING - Full preformatted log.

	Example(s):
		[_display, "Info message."] call TER_MFU_fnc_displayLog; //-> "00:00:00 [INFO] Info message."
		[_display, "Warning message!", "WARNING"] call TER_MFU_fnc_displayLog; // -> "00:00:00 [WARN] Warning message."
*/
#include "script_component.hpp"
params ["_display", "_message", ["_level", "INFO"]];
if (isNull _display) exitWith {
	["Display is null!"] call BIS_fnc_error;
};
private _ctrlGroupLog = _display displayCtrl IDC_TERMFU_GROUPLOG;
private _ctrlLog = _ctrlGroupLog controlsGroupCtrl IDC_TERMFU_GROUPLOG_LOG;
private _metaParams = switch toUpper _level do {
	case "ERROR";
	case "FAIL": {["#FF0000", "FAIL"]};
	case "WARNING";
	case "WARN": {["#FFFF00", "WARN"]};
	default {["#0080FF", "INFO"]};
};
_metaParams params ["_colorLevel", "_level"];
// Using an array to conserve structured text formatting
if (isNil {_display getVariable "_log"}) then {
	_display setVariable ["_log", [ctrlText _ctrlLog]];
};
private _log = _display getVariable "_log";
_message = format [
	"%1 <t color='%2'>[%3]</t> %4",
	(systemTime apply {if (_x < 10) then {"0" + str _x} else {str _x}}) select [3, 3] joinString ":",
	_colorLevel,
	_level,
	_message
];
_log pushBack _message; // Also updates the display variable

private _fullLog = _log joinString "<br/>";
_ctrlLog ctrlSetStructuredText parseText _fullLog;
_ctrlLog ctrlSetPositionH (ctrlTextHeight _ctrlLog);
_ctrlLog ctrlCommit 0;

_ctrlGroupLog spawn {uiSleep 0.01; _this ctrlSetScrollValues [1,1];};

_fullLog
