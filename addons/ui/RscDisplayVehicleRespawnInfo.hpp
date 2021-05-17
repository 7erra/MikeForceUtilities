class ctrlVehicleRespawnInfoItem: ctrlControlsGroupNoScrollbars
{
	idc = -1;
	x = 0;
	y = 0;
	w = (W_DISPLAY - 2) * GRID_W;
	h = 5 * GRID_H;
	class Controls
	{
		#define _W_CLASS (0.5 * W_DISPLAY)
		class Class: ctrlEdit
		{
			idc = -1;
			style = ST_NO_RECT;
			x = 1 * GRID_W;
			y = 0;
			w = (_W_CLASS - 6) * GRID_W;
			h = 5 * GRID_H;
		};
		#define _W_PARENT 5
		class Parent: ctrlButton
		{
			idc = -1;
			show = 1;
			text = "P";
			tooltip = "Set a parent config to inherit from.";
			x = (_W_CLASS - 4) * GRID_W;
			y = 0;
			w = _W_PARENT * GRID_W;
			h = 5 * GRID_H;
			colorBackground[] = {0.5,0,0,1};
			colorFocused[] = {1, 0.5, 0, 1};
			colorFocused2[] = {1, 0.5, 0, 1};
		};
		#define _W_RESPAWNTYPE 32
		class RespawnType: ctrlCombo
		{
			idc = -1;
			x = (_W_CLASS + 2) * GRID_W;
			y = 0;
			w = _W_RESPAWNTYPE * GRID_W;
			h = 5 * GRID_H;
			class Items
			{
				class Respawn
				{
					text = "RESPAWN";
					default = 1;
				};
				class Wreck
				{
					text = "WRECK";
				};
			};
		};
		#define _W_TIME 25
		class Time: Class
		{
			idc = -1;
			x = (_W_CLASS + _W_RESPAWNTYPE + 3) * GRID_W;
			w = _W_TIME * GRID_W;
		};
		class Delete: ctrlButtonPicture
		{
			idc = -1;
			text = "\a3\3den\Data\ControlsGroups\Tutorial\close_ca.paa";
			tooltip = "Delete this entry.";
			x = (_W_CLASS + _W_RESPAWNTYPE + _W_TIME + 4) * GRID_W;
			y = 0;
			w = 5 * GRID_W;
			h = 5 * GRID_H;
			colorBackground[] = {0.7,0,0,1};
		};
	};
};
class RscDisplayVehicleRespawnInfo
{
	idd = IDD_RSCDISPLAYVEHICLERESPAWNINFO;
	INIT_DISPLAY(RscDisplayVehicleRespawnInfo,TER_MFU)
	class ControlsBackground
	{
		class BackgroundDisable: ctrlStaticBackgroundDisable {};
		class BackgroundTiles: ctrlStaticBackgroundDisableTiles {};
		class Title: ctrlStaticTitle
		{
			text = "Vehicle Respawn Info Editor";
			x = X_DISPLAY;
			y = Y_DISPLAY - 5 * GRID_H;
			w = W_DISPLAY * GRID_W;
			h = 5 * GRID_H;
		};
		class Background: ctrlStaticBackground
		{
			x = X_DISPLAY;
			y = Y_DISPLAY;
			w = W_DISPLAY * GRID_W;
			h = H_DISPLAY;
		};
	};
	class Controls
	{
		class Toolbar: ctrlControlsGroupNoScrollbars
		{
			idc = -1;
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 1 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_W;
			h = 5 * GRID_H;
			class Controls
			{
				class New: ctrlButtonToolbar
				{
					idc = IDC_RSCDISPLAYVEHICLERESPAWNINFO_NEW;
					text = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\new_ca.paa";
					tooltip = "New";
					x = 0 * 6 * GRID_W;
					y = 0;
					w = 5 * GRID_W;
					h = 5 * GRID_H;
				};
				class Open: New
				{
					idc = IDC_RSCDISPLAYVEHICLERESPAWNINFO_OPEN;
					text = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\open_ca.paa";
					tooltip = "Open";
					x = 1 * 6 * GRID_W;
					y = 0;
					w = 5 * GRID_W;
					h = 5 * GRID_H;
				};
				class Export: New
				{
					idc = IDC_RSCDISPLAYVEHICLERESPAWNINFO_EXPORT;
					text = ICON(clipboard_ca.paa);
					tooltip = "Copy to clipboard";
					x = 2 * 6 * GRID_W;
				};
			};
		};
		class GroupHeaders: ctrlControlsGroupNoScrollbars
		{
			x = X_DISPLAY;
			y = Y_DISPLAY + 7 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_H;
			h = 5 * GRID_H;
			class Controls
			{
				class HeaderClass: ctrlStaticTitle
				{
					text = "Classname";
					x = 1 * GRID_W;
					y = 0;
					w = _W_CLASS * GRID_W;
					h = 5 * GRID_H;
				};
				delete HeaderTRespawnType;
				class HeaderRespawnType: HeaderClass
				{
					text = "Respawn Type";
					x = (_W_CLASS + 2) * GRID_W;
					w = _W_RESPAWNTYPE * GRID_W;
				};
				class HeaderTime: HeaderClass
				{
					text = "Respawn Time / s";
					x = (_W_CLASS + _W_RESPAWNTYPE + 3) * GRID_W;
					w = 25 * GRID_W;
				};
				class HeaderEmpty: HeaderClass
				{
					text = "";
					x = (_W_CLASS + _W_RESPAWNTYPE + _W_TIME + 4) * GRID_W;
					w = 7 * GRID_W;
				};
			};

		};
		class GroupRespawns: ctrlControlsGroup
		{
			idc = IDC_RSCDISPLAYVEHICLERESPAWNINFO_GROUPRESPAWNS;
			x = X_DISPLAY;
			y = Y_DISPLAY + 13 * GRID_H;
			w = (W_DISPLAY - 1) * GRID_W;
			h = H_DISPLAY - 31 * GRID_H;
			class Controls
			{
			};
		};
		
		class GroupLog: ctrlGroupLog {};
		class HashmapViewer: ctrlHashmapViewer
		{
			show = 0;
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 20 * GRID_H;
		};
		class Close: ctrlButtonClose
		{
			x = X_DISPLAY + (W_DISPLAY - 26) * GRID_W;
			y = Y_DISPLAY + H_DISPLAY - 6 * GRID_H;
			w = 25 * GRID_W;
			h = 5 * GRID_H;
		};
	};
};
