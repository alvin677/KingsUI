# KingsUI
A Roblox UI Library with a bunch of features.

![image](https://github.com/alvin677/KingsUI/assets/112005397/e43274c4-2575-44a2-b8df-0187ad4169d3)


Will add:

* slider
* dropdown
* key input
* more general functions for each element

# Example
```lua
wait(1)
local Kings = require(script.Parent.KingsLib)

local gg = Kings.newWindow("sigma", {
	["windowColor"] = {10, 10, 255},
	["noCloseButton"] = false,
	["draggable"] = true,
	["hide"] = false,
	["showShadows"] = true,
	["pattern"] = true,
	["sidebar"] = true
});


Kings.newCategory(gg, "main", "template elements");
local newBtn2 = Kings.newButtonElement(gg, "main", "press me!!");
newBtn2.onclick(function()
	print("gg 2!");
end)

local label = Kings.newTextElement(gg, "main", "What's up guys gg!");
label.setText("hey");
--print(label.getText());
--label.setBackgroundColor(Color3.fromRGB(200, 200, 200));
--label.setOutlineColor(Color3.fromRGB(127, 255, 164));
--label.setTransparency(0.9);

local cat = Kings.newCategory(gg, "main", "player stuff");
local newBtn = Kings.newButtonElement(gg, "main", "press me!!");

local anotherWindow = Kings.newWindow("player list", {
	["windowColor"] = {150, 150, 150},
	["noCloseButton"] = true,
	["draggable"] = true,
	["hide"] = true,
	--["windowSize"] = UDim2.new(0, 600, 0, 400),
	["windowSize"] = UDim2.new(0, 600, 0, 600),
	["windowPosition"] = UDim2.new(0.20, 0, 0.15, 0),
	["pattern"] = true,
});

newBtn.onclick(function()
	anotherWindow.toggleVisibility();
	anotherWindow.clear();
	
	for i, v in pairs(game.Players:GetChildren()) do
		local newUser = Kings.newButtonElement(anotherWindow, "main", v.Name, 1);
		--newUser.setOutlineColor(Color3.fromRGB(math.random(1, 255), math.random(1, 255), math.random(1, 255)));
		newUser.onclick(function()
			print(v.Name);
			anotherWindow.setWindowName(v.Name);
		end)
	end
end)

newBtn.setOutlineColor(Color3.fromRGB(127, 255, 164));

local newSWITCH = Kings.newSwitchElement(gg, "main", "speedhack", false);
newSWITCH.onclick(function() 
	newSWITCH.switch();
	if newSWITCH.getState() == true then
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 64;
	else 
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = 16;
	end
end)

local username = Kings.newInputElement(gg, "main", "name", "abow");
local usernameButton = Kings.newButtonElement(gg, "main", "kill player");
usernameButton.onclick(function()
	game.Players[username.getInput()].Character.Humanoid.Health = 0;
end)

local gggg = Kings.newWindow("sigma2", {
	["windowColor"] = {255, 10, 10},
	["noCloseButton"] = false
});
gggg.setWindowLight(255);

local newWIN = Kings.newWindow("new", {["draggable"] = true, ["hideWindowTitle"] = true, ["sidebar"] = true, ["sidebarMainName"] = "Home"});
Kings.newButtonElement(newWIN, "main", "hej");

local newTAB = Kings.newTab(gg, "home")
local newTAB2 = Kings.newTab(gg, "scripts")
local newTABOP = Kings.newSidebarOption(gg, newTAB, "Home");
local newTABOP2 = Kings.newSidebarOption(gg, newTAB2, "Scripts", {"rbxassetid://3926307971", Vector2.new(804, 284), Vector2.new(36, 36)});

Kings.newSliderElement(gg, "scripts", "coolest slider", 50);
Kings.newSliderElement(gg, "scripts", "coolest slider2", 0).maxValue(1);

Kings.newButtonElement(gg, "scripts", "hej");
local newstuff = Kings.newTab(gg, "bruh");
--local newBUTTONGG = Kings.newButtonElement(newWIN, newstuff, "test");
```
