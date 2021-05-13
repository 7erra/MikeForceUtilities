#define CT_CONTROLS_TABLE 19

#define W_DISPLAY 140
#define H_DISPLAY (WINDOW_HAbs - 15 * GRID_H)
#define X_DISPLAY CENTER_X - 0.5 * W_DISPLAY * GRID_W
#define Y_DISPLAY CENTER_Y - 0.5 * WINDOW_HAbs + 10 * GRID_H
#define _W_CLASSNAME 32
#define _W_COMBO (0.25 * (W_DISPLAY - 2 - 44))
class ctrlWhitelistedArsenalItemGroup: ctrlControlsGroupNoScrollbars
{
	idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM;
	show = 0;
	x = 0;
	y = 0; // set by script
	w = (W_DISPLAY - 2) * GRID_W;
	h = 5 * GRID_H;
	class Controls
	{
		class Classname: ctrlEdit
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_CLASS;
			tooltip = "Classname";
			text = "--classname--";
			x = 1 * GRID_W;
			y = 0;
			w = _W_CLASSNAME * GRID_W;
			h = 5 * GRID_H;
		};
		class RankEast: ctrlCombo
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKEAST;
			tooltip = "Rank East";
			x = (_W_CLASSNAME + 2) * GRID_W;
			y = 0;
			w = _W_COMBO * GRID_W;
			h = 5 * GRID_H;
			class Items
			{
				class None
				{
					text = "NONE";
					value = -1;
					default = 1;
				};
				class Private
				{
					text = "PRIVATE";
					value = 0;
				};
				class Corporal
				{
					text = "CORPORAL";
					value = 1;
				};
				class Sergeant
				{
					text = "SERGEANT";
					value = 2;
				};
				class Lieutenant
				{
					text = "LIEUTENANT";
					value = 3;
				};
				class Captain
				{
					text = "CAPTAIN";
					value = 4;
				};
				class Major
				{
					text = "MAJOR";
					value = 5;
				};
				class Colonel
				{
					text = "COLONEL";
					value = 6;
				};
			};
		};
		class RankWest: RankEast
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKWEST;
			tooltip = "Rank West";
			x = (_W_CLASSNAME + _W_COMBO + 3) * GRID_W;
		};
		class RankIndependent: RankEast
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKINDEPENDENT;
			tooltip = "Rank Independent";
			x = (_W_CLASSNAME + 2 * _W_COMBO + 4) * GRID_W;
		};
		class RankCivillian: RankEast
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_RANKCIVILIAN;
			tooltip = "Rank Civillian";
			x = (_W_CLASSNAME + 3 * _W_COMBO + 5) * GRID_W;
		};
		class Delete: ctrlButtonPicture
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP_GROUPITEM_DELETE;
			text = "\a3\3den\Data\ControlsGroups\Tutorial\close_ca.paa";
			tooltip = "Delete this entry.";
			x = (_W_CLASSNAME + 4 * _W_COMBO + 6) * GRID_W;
			y = 0;
			w = 5 * GRID_W;
			h = 5 * GRID_H;
			colorBackground[] = {0.7,0,0,1};
		};
	};
};
class RscDisplayWhiteListedArsenal
{
	idd = IDD_RSCDISPLAYWHITELISTEDARSENAL;
	INIT_DISPLAY(RscDisplayWhiteListedArsenal,TER_MFU)
	script = UI_SCRIPT(RscDisplayWhiteListedArsenal);
	class ControlsBackground
	{
		class BackgroundDisable: ctrlStaticBackgroundDisable {};
		class BackgroundTiles: ctrlStaticBackgroundDisableTiles {};
		class Title: ctrlStaticTitle
		{
			text = "Whitelisted Arsenal Editor";
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
		class BackgroundList: Background
		{
			y = Y_DISPLAY + 19 * GRID_H;
			h = 6 * GRID_H;
			colorBackground[] = {0.1,0.1,0.1,1};
		};
	};
	class Controls
	{
		class Toolbar: ctrlControlsGroupNoScrollbars
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR;
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 1 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_W;
			h = 5 * GRID_H;
			class Controls
			{
				class New: ctrlButtonToolbar
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_NEW;
					text = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\new_ca.paa";
					tooltip = "New";
					x = 0 * 6 * GRID_W;
					y = 0;
					w = 5 * GRID_W;
					h = 5 * GRID_H;
				};
				class Open: New
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_OPEN;
					text = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\open_ca.paa";
					tooltip = "Open";
					x = 1 * 6 * GRID_W;
					y = 0;
					w = 5 * GRID_W;
					h = 5 * GRID_H;
				};
				class Save: New
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_SAVE;
					text = "\a3\3DEN\Data\Displays\Display3DEN\ToolBar\save_ca.paa";
					tooltip = "Save";
					x = 2 * 6 * GRID_W;
				};
				class Export: New
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_TOOLBAR_EXPORT;
					text = ICON(clipboard_ca.paa);
					tooltip = "Copy to clipboard";
					x = 3 * 6 * GRID_W;
				};
			};
		};
		class ConfignameLabel: ctrlStructuredText
		{
			text = "Config name:";
			x = X_DISPLAY;
			y = Y_DISPLAY + 7 * GRID_H;
			w = 0.5 * W_DISPLAY * GRID_W;
			h = 5 * GRID_H;
			class Attributes
			{
				font = "RobotoCondensedLight";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "right";
				shadow = 1;
				size = 1;
			};
		};
		class Configname: ctrlEdit
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_CONFIGNAME;
			x = X_DISPLAY + 0.5 * W_DISPLAY * GRID_W;
			y = Y_DISPLAY + 7 * GRID_H;
			w = (0.5 * W_DISPLAY - 1) * GRID_W;
			h = 5 * GRID_H;
		};
		class DisplaynameLabel: ConfignameLabel
		{
			text = "Displayed name:";
			y = Y_DISPLAY + 13 * GRID_H;
		};
		class DisplayNameEditbox: Configname
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_DISPLAYNAMEEDITBOX;
			y = Y_DISPLAY + 13 * GRID_H;
		};
		class Sections: ctrlToolbox
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_SECTIONS;
			strings[] = {"weapons", "magazines", "items", "backpacks", "vehicles"};
			values[] = {1,2,3,4,5};
			columns = 5;
			rows = 1;
			colorBackground[] = {0,0,0,0};
			colorSelectedBg[] = {0.2,0.2,0.2,1};
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 20 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_W;
			h = 5 * GRID_H;
		};
		class HeaderClassname: ctrlStaticTitle
		{
			idc = -1;
			text = "Classname";
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 26 * GRID_H;
			w = _W_CLASSNAME * GRID_W;
			h = 5 * GRID_H;
			delete colorBackground;//[] = {0.1,0.1,0.1,1};
			class Attributes
			{
				font = "RobotoCondensedLight";
				color = "#ffffff";
				colorLink = "#D09B43";
				align = "center";
				shadow = 1;
				size = 1;
			};
		};
		class HeaderRankEast: HeaderClassname
		{
			text = "Rank East";
			x = X_DISPLAY + (_W_CLASSNAME + 2) * GRID_W;
			w = _W_COMBO * GRID_W;
		};
		class HeaderRankWest: HeaderRankEast
		{
			text = "Rank West";
			x = X_DISPLAY + (_W_CLASSNAME + _W_COMBO + 3) * GRID_W;
		};
		class HeaderRankIndependent: HeaderRankEast
		{
			text = "Rank Indep.";
			x = X_DISPLAY + (_W_CLASSNAME + 2 * _W_COMBO + 4) * GRID_W;
		};
		class HeaderRankCivillian: HeaderRankEast
		{
			text = "Rank Civillian";
			x = X_DISPLAY + (_W_CLASSNAME + 3 * _W_COMBO + 5) * GRID_W;
		};
		class HeaderEmpty: HeaderClassname
		{
			text = "";
			x = X_DISPLAY + (_W_CLASSNAME + 4 * _W_COMBO + 6) * GRID_W;
			w = 7 * GRID_W;
		};
		class Group: ctrlControlsGroup
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUP;
			x = X_DISPLAY;
			y = Y_DISPLAY + 32 * GRID_H;
			w = (W_DISPLAY - 1) * GRID_W;
			h = H_DISPLAY - 50 * GRID_H);
			colorBackground[] = {1,0,0,0.2};
		};
		class GroupLog: ctrlControlsGroup
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPLOG;
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + H_DISPLAY - 17 * GRID_H;
			w = (W_DISPLAY - 2) * GRID_W;
			h = 10 * GRID_H;
			class Controls
			{
				class Log: ctrlStructuredText
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPLOG_LOG;
					x = 0;
					y = 0;
					w = (W_DISPLAY - 4) * GRID_W;
					h = 10 * GRID_H;
					colorBackground[] = {0.1,0.1,0.1,1};
					class Attributes
					{
						font = "EtelkaMonospacePro";
						color = "#ffffff";
						colorLink = "#D09B43";
						align = "left";
						shadow = 1;
						size = 0.7;
					};
				};
			};
		};
		class Add: ctrlButton
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_ADD;
			text = "Add";
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + H_DISPLAY - 6 * GRID_H;
			w = 25 * GRID_W;
			h = 5 * GRID_H;
		};
		class CopyLog: Add
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_COPYLOG;
			text = "Copy Log";
			x = X_DISPLAY + 27 * GRID_W;
		};
		class Close: ctrlButtonClose
		{
			x = X_DISPLAY + (W_DISPLAY - 26) * GRID_W;
			y = Y_DISPLAY + H_DISPLAY - 6 * GRID_H;
			w = 25 * GRID_W;
			h = 5 * GRID_H;
		};

		class GroupOpen: ctrlControlsGroupNoScrollbars
		{
			idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPOPEN;
			show = 0;
			x = X_DISPLAY + 1 * GRID_W;
			y = Y_DISPLAY + 0.25 * H_DISPLAY;
			w = (W_DISPLAY - 2) * GRID_W;
			h = 50 * GRID_H;
			class Controls
			{
				class Title: ctrlStaticTitle
				{
					text = "Open";
					x = 0;
					y = 0;
					w = (W_DISPLAY - 2) * GRID_W;
					h = 5 * GRID_H;
				};
				class Background: ctrlStaticBackground
				{
					x = 0;
					y = 5 * GRID_H;
					w = (W_DISPLAY - 2) * GRID_W;
					h = 45 * GRID_H;
					colorBackground[] = {0.1,0.1,0.1,1};
				};
				class List: ctrlTree
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPOPEN_LIST;
					x = 1 * GRID_W;
					y = 6 * GRID_H;
					w = (W_DISPLAY - 4) * GRID_W;
					h = 37 * GRID_H;
				};
				class Info: ctrlStructuredText
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPOPEN_INFO;
					x = 1 * GRID_W;
					y = 44 * GRID_H;
					w = 0.5 * W_DISPLAY * GRID_W;
					h = 5 * GRID_H;
					colorBackground[] = COLOR_DEBUG;
				};
				class Load: ctrlButton
				{
					idc = IDC_RSCDISPLAYWHITELISTEDARSENAL_GROUPOPEN_LOAD;
					text = "Load";
					x = (W_DISPLAY - 28 - 26) * GRID_W;
					y = 44 * GRID_H;
					w = 25 * GRID_W;
					h = 5 * GRID_H;
				};
				class Close: Load
				{
					text = "Close";
					onButtonClick = "(ctrlParentControlsGroup (_this select 0)) ctrlShow false;";
					x = (W_DISPLAY - 28) * GRID_W;
				};
			};
		};
	};
};
