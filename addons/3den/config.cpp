#include "script_component.hpp"

class CfgPatches {
    class ADDON {
        name = QUOTE(COMPONENT);
        units[] = {};
        weapons[] = {};
        requiredVersion = REQUIRED_VERSION;
        requiredAddons[] = {"A3_3DEN"};
        author = "Terra";
        VERSION_CONFIG;
    };
};

#include "display3den.hpp"
