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