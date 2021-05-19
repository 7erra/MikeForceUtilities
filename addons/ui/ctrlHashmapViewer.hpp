#define _H_HASHMAPVIEWER 100
#define _W_HASHMAPVIEWER (W_DISPLAY - 2)
class ctrlHashmapViewer: ctrlControlsGroupNoScrollbars
{
	idc = IDC_CTRLHASHMAPVIEWER;
	INIT_CONTROL(ctrlHashmapViewer,TER_MFU)
	x = 0;
	y = 0;
	w = (W_DISPLAY - 2) * GRID_W;
	h = _H_HASHMAPVIEWER * GRID_H;
	class Controls
	{
		class Title: ctrlStaticTitle
		{
			idc = IDC_CTRLHASHMAPVIEWER_TITLE;
			text = "Hashmap Viewer";
			x = 0;
			y = 0;
			w = _W_HASHMAPVIEWER * GRID_W;
			h = 5 * GRID_H;
		};
		class TitleDummy: ctrlStructuredText
		{
			idc = IDC_CTRLHASHMAPVIEWER_TITLEDUMMY;
			x = 0;
			y = 0;
			w = _W_HASHMAPVIEWER * GRID_W;
			h = 5 * GRID_H;
		};
		class Edge: ctrlStaticBackground
		{
			x = 0;
			y = 5 * GRID_H;
			w = _W_HASHMAPVIEWER * GRID_W;
			h = (_H_HASHMAPVIEWER - 5) * GRID_H;
			colorBackground[] = {0,0,0,1};
		};
		class Background: ctrlStaticBackground
		{
			x = pixelW;
			y = 5 * GRID_H + pixelH;
			w = _W_HASHMAPVIEWER * GRID_W - 2 * pixelW;
			h = (_H_HASHMAPVIEWER - 5) * GRID_H - 2 * pixelH;
		};
		class Hashmap: ctrlTree
		{
			idc = IDC_CTRLHASHMAPVIEWER_HASHMAP;
			x = 1 * GRID_W;
			y = 6 * GRID_H;
			w = (_W_HASHMAPVIEWER - 2) * GRID_W;
			h = (_H_HASHMAPVIEWER - 13) * GRID_H;
		};
		class Ok: ctrlButton
		{
			idc = IDC_CTRLHASHMAPVIEWER_OK;
			text = "OK";
			x = (_W_HASHMAPVIEWER - 52) * GRID_W;
			y = (_H_HASHMAPVIEWER - 6) * GRID_H;
			w = 25 * GRID_W;
			h = 5 * GRID_H;
		};
		class Cancel: Ok
		{
			idc = IDC_CTRLHASHMAPVIEWER_CANCEL;
			text = "Cancel";
			x = (_W_HASHMAPVIEWER - 26) * GRID_W;
		};
	};
};
