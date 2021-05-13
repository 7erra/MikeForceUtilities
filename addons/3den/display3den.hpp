class ctrlMenuStrip;
class display3DEN
{
	class Controls
	{
		class MenuStrip: ctrlMenuStrip
		{
			class Items
			{
				class Tools
				{
					items[] += {"MFU_Tools"};
				};
				class MFU_Tools
				{
					text = "Mike Force Utilities";
					picture = "\z\TER_MFU\addons\3den\data\mfu_open_ca.paa";
					items[] = {"MFU_ArsenalEditor"};
				};
				class MFU_ArsenalEditor
				{
					text = "Whitelisted Arsenal Editor";
					picture = "\a3\3den\Data\Displays\Display3DEN\EntityMenu\arsenal_ca.paa";
					action = "findDisplay 313 createDisplay 'RscDisplayWhiteListedArsenal';";
					opensNewWindow = 1;
				};
			};
		};
	};
};
