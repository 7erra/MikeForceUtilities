class ctrlStaticBackground;
class ctrlStaticTitle;
class ctrlEdit;
class ctrlStructuredText;
class ctrlToolbox;
class ctrlControlsGroup;
class ctrlButtonClose;
class ScrollBar;
class ctrlControlsGroupNoScrollbars;
class ctrlCombo;
class ctrlButtonToolbar;
class ctrlListbox;
class ctrlButton;
class ctrlTree;
class ctrlButtonPicture;
class ctrlStaticBackgroundDisable;
class ctrlStaticBackgroundDisableTiles;
class ctrlControlsTable
{
	idc = -1;
	x = 0;
	y = 0;
	w = 0;
	h = 0;
	
	type = CT_CONTROLS_TABLE;
	style = SL_TEXTURES;
	 
	lineSpacing = 0;
	rowHeight = 5 * GRID_H;
	headerHeight = 5 * GRID_H;
	 
	firstIDC = 9000;
	lastIDC = 9999;
	 
	// Colours which are used for animation (i.e. change of colour) of the selected line.
	selectedRowColorFrom[]  = {0,0,0,0};
	selectedRowColorTo[]	= {0,0,0,0};
	// Length of the animation cycle in seconds.
	selectedRowAnimLength = 0;
	 
	class VScrollBar: ScrollBar
	{
		width = 0.021;
		autoScrollEnabled = 0;
		autoScrollDelay = 1;
		autoScrollRewind = 1;
		autoScrollSpeed = 1;
	};
 
	class HScrollBar: ScrollBar
	{
		height = 0.028;
	};
	 
	// Template for selectable rows
	class RowTemplate
	{
	};
	 
	// Template for headers (unlike rows, cannot be selected)
	class HeaderTemplate
	{
	};
};
class ctrlGroupLog: ctrlControlsGroup
{
	idc = IDC_TERMFU_GROUPLOG;
	x = X_DISPLAY + 1 * GRID_W;
	y = Y_DISPLAY + H_DISPLAY - 17 * GRID_H;
	w = (W_DISPLAY - 2) * GRID_W;
	h = 10 * GRID_H;
	class Controls
	{
		class Log: ctrlStructuredText
		{
			idc = IDC_TERMFU_GROUPLOG_LOG;
			text = "--- Start of log ---";
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