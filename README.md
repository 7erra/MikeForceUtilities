# Mike Force Utilities

**Mike Force Utilities** is a mod for [Arma 3](https://arma3.com/). It provides tools for modders of the [Mike Force mission](https://github.com/Savage-Game-Design/Mike-Force) made by SGD as part of their [S.O.G. Prairie Fire](https://www.sogpf.com/) CDLC.

## Installation
The mod can be installed via the Steam Workshop.

## Usage
### Whitelisted Arsenal Editor (WAE)
The [Whitelisted Arsenal](https://wiki.sogpf.com/index.php/Whitelisted_Arsenal) Editor can be accessed via the Toolbar in [Eden](https://community.bistudio.com/wiki/Category:Eden_Editor). A folder called "Mike Force Utilities" can be found under the "Tools" section of the Eden Editor which contains all currently available tools.<br/>
#### Interface ####
![](images\WAE.jpg)
- New: Blank your current project. Any unsaved changes to the previous project are lost!
- Open: Open an already started project. WAE will search the mission config for a valid Whitelisted Arsenal config.
- Save: Currently does nothing. All changes are saved to the display. Closing the display will wipe any progress.
- Export: The current project is copied to the clipboard as a valid config for the whitelisted arsenal.
- Config name: System name of the subclass used under the main class `vn_whitelisted_arsenal_loadouts`. Could be understood as the project name.
- Displayed name: A human readable version of the project name. Supports [localization](https://community.bistudio.com/wiki/Stringtable.xml).
- Sections: The whitelisted arsenal consists of 5 categories: weapons, magazines, items, backpacks and vehicles. You can select the correct category in the UI.
- List: The list contains all config entries of the currently selected category.
	- A list item consists of the classname, the ranks for each side (east, west, independent and civillian) and a button to remove the item from the category.
- Log: The window below the List displays information in case something goes wrong.
- Add: This button opens the [Splendid Config Viewer](https://community.bistudio.com/wiki/Arma_3:_Splendid_Config_Viewer) which is restricted to only configs that can be used in the Arsenal. Furthermore, instead of displaying the config name, the display name is used. To add the item you have to confirm by clicking the "Ok" button.
- Copy Log: The content of the Log window is copied to the clipboard.
- Close: Does what it says. Progress that is not saved to the clipboard is lost!

## Contributing
You are very welcome to contribute! You don't have to provide code, ideas are also very valuable.

## License
The license can be found [here](LICENSE.md).<br/>
I have opted for a strong copy left license. Feel free to improve this project!
