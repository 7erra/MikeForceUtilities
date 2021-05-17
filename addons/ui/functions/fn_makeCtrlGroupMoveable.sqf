/*
	Author: Terra

	Description:
		Makes a CT_CONTROLS_GROUP control moveable by dragging the given control.

	Parameter(s):
		0:	CONTROL - The control by which the controls group is dragged. Has to be interactable, ie. no a CT_STATIC control.

	Returns:
		ARRAY - Array of UIEH IDs in format [MouseButtonDown, MouseButtonUp, MouseMoving]

	Example(s):
		[_ctrl] call TER_MFU_fnc_makeCtrlGroupMoveable; //-> [0,0,0]
*/
params ["_ctrl"];
_ctrlGroup = ctrlParentControlsGroup _ctrl;
_eh1 = _ctrl ctrlAddEventHandler ["MouseButtonDown", {
	params ["_ctrl", "_button", "_downX", "_downY"];
	if (_button != 0) exitWith {};
	_ctrl setVariable ["TER_MFU_makeCtrlGroupMoveable_downXY", [_downX, _downY]];
	TER_MFU_makeCtrlGroupMoveable_mouseDown = true;
}];
_eh2 = _ctrl ctrlAddEventHandler ["MouseButtonUp", {
	params ["_ctrl", "_button", "_xp", "_yp"];
	TER_MFU_makeCtrlGroupMoveable_mouseDown = nil;
}];
_eh3 = _ctrl ctrlAddEventHandler ["MouseMoving", {
	params ["_ctrl", "_xp", "_yp"];
	if (!isNil "TER_MFU_makeCtrlGroupMoveable_mouseDown") then {
		_ctrlGroup = ctrlParentControlsGroup _ctrl;
		getMousePosition params ["_mouseX", "_mouseY"];
		(_ctrl getVariable ["TER_MFU_makeCtrlGroupMoveable_downXY", [0,0]]) params [
			"_downX",
			"_downY"
		];
		_ctrlGroup ctrlSetPosition [
			_mouseX - _downX,
			_mouseY - _downY
		];
		_ctrlGroup ctrlCommit 0;
	};
}];

[_eh1, _eh2, _eh3]
