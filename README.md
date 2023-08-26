# KingsUI
A Roblox UI Library with a bunch of features.

![image](https://github.com/alvin677/KingsUI/assets/112005397/e43274c4-2575-44a2-b8df-0187ad4169d3) <br />


https://github.com/alvin677/KingsUI/assets/112005397/4425bb5a-33c3-4b93-903a-32059c326daa




I am very aware that there could be bugs because of scaling and other stuff. If you find anything, please report to me on Discord: cedric0591 <br />
I recommend you joining our Discord server for help with coding: https://discord.gg/altgen

Will add:

* dropdown element
* key input element
* more general functions for each element

# Documentation

New windows that you create will contain a default tab called `main` (string). <br />
If you are not using the sidebar feature, put `"main"` as the `tab` argument.

Importing the library by creating a new ModuleScript (rename it to KingsLib or something) with the `lib.lua` code inside (it should work with loadstring as well):
```lua
local Kings = require(script.Parent.KingsLib);
```

**Making a new window:**
```lua
-- .newWindow(title, settings)
local firstWindow = Kings.newWindow("A new window.", {
	["windowColor"] = {10, 10, 255}, -- color of the window
	["windowSize"] = UDim2.new(0, 600, 0, 600), -- size of window (300, 400 is defualt)
	["windowPosition"] = UDim2.new(0.20, 0, 0.15, 0), -- position of window
	["noCloseButton"] = false, -- can be used to disable/enable 'x' button
	["draggable"] = true, -- allow the window to be dragged around
  	["hide"] = false, -- if true, hide on creation
	["showShadows"] = true, -- shadow around the ui
	["pattern"] = true, -- pattern (sort of like a background)
	["sidebar"] = true -- enable sidebar
});
```

Windows has got a couple of useful functions/methods:
```lua
firstWindow.toggleVisibility();
firstWindow.clear();
firstWindow.setWindowName("new title");
```

**Making a category (sort of section) for elements, on the window.**
It is basically just a space with a more transparent text:
```lua
-- .newCategory(window, tab, title)
Kings.newCategory(gg, "main", "template elements");
```
(Put `"main"` as the `tab` argument if you have not yet created a new tab. This is the default name of the first tab that is automatically created when making a new window)

**Creating a button element:**
```lua
-- .newButtonElement(window, tab, text, icon)
-- the icon argument is default 1, there's 1-3 available (pointer, trashcan, star)
local newBtn = Kings.newButtonElement(firstWindow, "main", "click here");
newBtn.onclick(function()
	print("button clicked");
end)
```

Methods/functions for the button element:
```lua
newBtn.onclick(function() end)
newBtn.setOutlineColor(Color3.fromRGB(127, 255, 164));
```


**Creating a text label element:**
```lua
-- .newTextElement(window, tab, text)
local newLabel = Kings.newTextElement(firstWindow, "main", "Hello World!");
newLabel.setText("Hello World 2!");
```

**Creating a switch/checkbox/toggle:**
```lua
-- .newSwitchElement(window, tab, text, state);
local newSwitch = Kings.newSwitchElement(firstWindow, "main", "Walkspeed", false);
newSwitch.onclick(function() 
	newSwitch.switch();
	if newSwitch.getState() == true then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 64;
	else 
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16;
	end
end)
```

Methods for switches:
```lua
.getState() -- returns state, true/false
.switch() -- change state
.onclick(function() end)
```

**Input element:**
```lua
-- .newInputElement(window, tab, text, placeholder)
local username = Kings.newInputElement(firstWindow, "main", "Kill player:", "who?");
local usernameButton = Kings.newButtonElement(firstWindow, "main", "kill player");
usernameButton.onclick(function()
	game.Players[username.getInput()].Character.Humanoid.Health = 0;
end)
```

Methods for input element:
```lua
.getInput() -- returns written input
.onclick(function() end)
```
