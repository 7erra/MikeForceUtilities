/*
	Author: Terra

	Description:
		__DESCRIPTION___

	Parameter(s):
		0:	__TYPE__ - __EXPLANATION__
		Optional:
		N:	__TYPE___ - __EXPLANATION__
			Default: __DEFAULT___

	Returns:
		ARRAY - Path of the selected entry

	Example(s):
		[_display, createHasmapFromArray [["entry1", 0], ["entry2", 1]]] call TER_MFU_hashmapViewer; //-> ["entry1"]
*/
#include "script_component.hpp"
params [
	"_parentDisplay",
	"_hashmap",
	["_waitForReturn", false],
	"",
	"",
	["_header", "Hashmap Viewer"]
];
//--- User called function, load display
//--- Check if the hashmapviewer already exists:
private _ctrlHashmapViewer = _parentDisplay displayCtrl IDC_CTRLHASHMAPVIEWER;
if (isNull _ctrlHashmapViewer) then {
	//--- Otherwise create it
	_ctrlHashmapViewer = _parentDisplay ctrlCreate ["ctrlHashmapViewer", IDC_CTRLHASHMAPVIEWER];
};
_ctrlTitle = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_TITLE;
_ctrlTitle ctrlSetText _header;
_ctrlHashmapViewer ctrlShow true;
ctrlSetFocus _ctrlHashmapViewer;
with uiNamespace do {
	isNil {["Load", [_ctrlHashmapViewer, _hashmap]] call UI_SCRIPT(ctrlHashmapViewer)};
};
if (!_waitForReturn) exitWith {nil};
waitUntil {!ctrlShown _ctrlHashmapViewer || isNull _ctrlHashmapViewer};
_ctrlHashmapViewer getVariable ["_return", []]
