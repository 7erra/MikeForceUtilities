#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_Ui_F"};
        author = "Terra";
        VERSION_CONFIG;
    };
};

#include "CfgFunctions.hpp"

#include "CfgScriptPaths.hpp"
#include "RscControls.hpp"
#include "ctrlHashmapViewer.hpp"
#include "RscDisplayWhiteListedArsenal.hpp"
#include "RscDisplayVehicleRespawnInfo.hpp"
