# KingsUI
A Roblox UI Library with a bunch of features.

![image](https://github.com/alvin677/KingsUI/assets/112005397/e43274c4-2575-44a2-b8df-0187ad4169d3)


I am very aware that there could be bugs because of scaling and other stuff. If you find anything, please report to me on Discord: cedric0591 <br />
I recommend you joining our Discord server for help with coding: https://discord.gg/altgen

Will add:

* dropdown element
* key input element
* more general functions for each element

# Documentation

Importing the library (should work with loadstring as well):
```lua
local Kings = require(script.Parent.KingsLib);
```

Making a new window:
```lua
local firstWindow = Kings.newWindow("A new window.", {
	["windowColor"] = {10, 10, 255}, -- color of the window
	["noCloseButton"] = false, -- can be used to disable/enable 'x' button
	["draggable"] = true, -- allow the window to be dragged around
  ["hide"] = false, -- if true, hide on creation
	["showShadows"] = true, -- shadow around the ui
	["pattern"] = true, -- pattern (sort of like a background)
	["sidebar"] = true -- enable sidebar
});
```
