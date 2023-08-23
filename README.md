# KingsUI
A Roblox UI Library with a bunch of features.

![image](https://github.com/alvin677/KingsUI/assets/112005397/e43274c4-2575-44a2-b8df-0187ad4169d3)
<video src = "https://media.discordapp.net/attachments/1021829850736115783/1142911946438488185/2023-08-20_21-59-03.mp4" />



I am very aware that there could be bugs because of scaling and other stuff. If you find anything, please report to me on Discord: cedric0591 <br />
I recommend you joining our Discord server for help with coding: https://discord.gg/altgen

Will add:

* dropdown element
* key input element
* more general functions for each element

# Documentation

New windows that you create will contain a default tab called `main` (string). <br />
If you are not using the sidebar feature, put `"main"` as the `tab` argument.

Importing the library by creating a new ModuleScript with the `lib.lua` code inside (it should work with loadstring as well):
```lua
local Kings = require(script.Parent.KingsLib);
```

Making a new window:
```lua
-- .newWindow(title, settings)
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

Making a "section" for elements, on the window.
It is basically just a space with a more transparent text:
```lua
-- .newCategory(window, tab, title)
Kings.newCategory(gg, "main", "template elements");
```
(Put `"main"` as the `tab` argument if you have not yet created a new tab. This is the default name of the first tab that is automatically created when making a new window)

Creating a button element:
```lua
-- .newButtonElement(window, tab, text)
local newBtn = Kings.newButtonElement(firstWindow, "main", "click here");
newBtn.onclick(function()
	print("button clicked");
end)
```
