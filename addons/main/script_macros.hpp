#define BREAKPOINT if (true) exitWith {nil}
#define PATH(SUBPATH) QUOTE(\z\TER_MFU\addons\COMPONENT\SUBPATH)
#ifdef DEBUG_MODE_FULL
	#define PATH(SUBPATH) QUOTE(z\TER_MFU\addons\COMPONENT\SUBPATH)
#endif
