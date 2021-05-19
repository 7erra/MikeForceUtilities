#include "script_component.hpp"
#define SELF UI_SCRIPT(ctrlHashmapViewer)
params ["_mode", "_params"];
switch _mode do {
	case "onLoad":{
		_params params ["_ctrlHashmapViewer"];
		_display = ctrlParent _ctrlHashmapViewer;
		_ctrlOk = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_OK;
		_ctrlOk ctrlAddEventHandler ["ButtonClick",{
			with uiNamespace do {["OK", _this] call SELF;};
		}];
		_ctrlCancel = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_CANCEL;
		_ctrlCancel ctrlAddEventHandler ["ButtonClick",{
			["Cancel", _this] call SELF;
		}];
		_ctrlTitleDummy = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_TITLEDUMMY;
		[_ctrlTitleDummy] call (missionnamespace getVariable "TER_MFU_fnc_makeCtrlGroupMoveable");
		_display displayAddEventHandler ["KeyDown",{
			with uiNamespace do {["KeyDown", _this] call SELF;};
		}];
	};
	case "OK":{
		_params params ["_ctrlOk"];
		_ctrlHashmapViewer = ctrlParentControlsGroup _ctrlOk;
		_ctrlHashmap = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_HASHMAP;
		//--- Return the currently selected entry as a path of keys
		private _hmap = _ctrlhashmapViewer getVariable "_hmap";
		private _path = [];
		_keys = tvCurSel _ctrlHashmap apply {
			_path pushBack _x;
			_ctrlHashmap tvData _path
		};
		_ctrlHashmapViewer setVariable ["_return", _keys];
		_ctrlHashmapViewer ctrlShow false;
	};
	case "Cancel":{
		_params params ["_ctrlCancel"];
		_ctrlHashmapViewer = ctrlParentControlsGroup _ctrlCancel;
		_ctrlHashmapViewer setVariable ["_return", []];
		_ctrlHashmapViewer ctrlShow false;
	};
	case "Load":{
		_params params ["_ctrlHashmapViewer", "_hmap"];
		private _ctrlHashmap = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_HASHMAP;
		tvClear _ctrlHashmap;
		_ctrlHashmap setVariable ["_hmap", _hmap];
		{
			["AddItem", [_ctrlHashmapViewer, [_x, _y]]] call SELF;
		} forEach _hmap;
	};
	case "AddItem":{
		_params params ["_ctrlHashmapViewer", "_keyValuePair", ["_path", []]];
		_keyValuePair params ["_key", "_value"];
		private _ctrlHashmap = _ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_HASHMAP;
		_valueIsHashmap = _value isEqualType createHashMap;
		private _text = [format ["%1: %2", _key, str _value], str _key] select _valueIsHashmap;
		private _ind = _ctrlHashmap tvAdd [_path, _text];
		private _newPath = _path + [_ind];
		_ctrlHashmap tvSetData [_newPath, _key];
		if (_valueIsHashmap) then {
			{
				["AddItem", [_ctrlHashmapViewer, [_x, _y], _newPath]] call SELF;
			} forEach _value;
		};
	};
	case "KeyDown":{
		_params params ["_display", "_key"];
		diag_log _this;
		_ctrlHashmapViewer = _display displayCtrl IDC_CTRLHASHMAPVIEWER;
		if (_key == DIK_ESCAPE && ctrlShown _ctrlHashmapViewer) exitWith {
			//--- Override default behaviour, don't close display
			["Cancel", [_ctrlHashmapViewer controlsGroupCtrl IDC_CTRLHASHMAPVIEWER_CANCEL]] call SELF;
			true
		};
		false
	};
	case "onUnload":{
		_params params ["_ctrlHashmapViewer", "_exitCode"];
	};
};
