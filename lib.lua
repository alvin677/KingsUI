local Kings = {};
local UIAnimationSpeed : number = 0.1;
local TweenService = game:GetService("TweenService")

-- init
local ScreenGui = script.Parent.Parent;
ScreenGui["Parent"] = game:GetService("Players").LocalPlayer:FindFirstChildWhichIsA("PlayerGui")
ScreenGui["Name"] = "cofsSKID";
ScreenGui["ResetOnSpawn"] = false;
ScreenGui["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

function Kings.newWindow(windowName, windowSettings)
	if windowName == nil then
		windowName = "Window";
	end

	-- the new window frame
	local newWindow = Instance.new("Frame", ScreenGui);
	newWindow["BorderSizePixel"] = 0;
	newWindow["BackgroundColor3"] = Color3.fromRGB(50, 50, 50);
	newWindow["Size"] = UDim2.new(0, 300, 0, 400);
	newWindow["Position"] = UDim2.new(0.07388179004192352, 0, 0.15295256674289703, 0);
	newWindow["Name"] = windowName;

	local function setWindowLight(integer)
		newWindow["BackgroundColor3"] = Color3.fromRGB(integer, integer, integer);
	end

	if windowSettings["windowSize"] then
		newWindow["Size"] = windowSettings["windowSize"];
	end

	if windowSettings["windowPosition"] then
		newWindow["Position"] = windowSettings["windowPosition"];
	end

	if windowSettings["draggable"] == true then
		local UserInputService = game:GetService("UserInputService")
		local runService = (game:GetService("RunService"));

		local gui = ScreenGui[windowName];

		local dragging
		local dragInput
		local dragStart
		local startPos

		local function Lerp(a, b, m)
			return a + (b - a) * m
		end;

		local lastMousePos
		local lastGoalPos
		local DRAG_SPEED = (8); -- // The speed of the UI darg.
		local function Update(dt)
			if not (startPos) then return end;
			if not (dragging) and (lastGoalPos) then
				gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, lastGoalPos.X.Offset, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, lastGoalPos.Y.Offset, dt * DRAG_SPEED))
				return 
			end;

			local delta = (lastMousePos - UserInputService:GetMouseLocation())
			local xGoal = (startPos.X.Offset - delta.X);
			local yGoal = (startPos.Y.Offset - delta.Y);
			lastGoalPos = UDim2.new(startPos.X.Scale, xGoal, startPos.Y.Scale, yGoal)
			gui.Position = UDim2.new(startPos.X.Scale, Lerp(gui.Position.X.Offset, xGoal, dt * DRAG_SPEED), startPos.Y.Scale, Lerp(gui.Position.Y.Offset, yGoal, dt * DRAG_SPEED))
		end;

		gui.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
				dragging = true
				dragStart = input.Position
				startPos = gui.Position
				lastMousePos = UserInputService:GetMouseLocation()

				input.Changed:Connect(function()
					if input.UserInputState == Enum.UserInputState.End then
						dragging = false
					end
				end)
			end
		end)

		gui.InputChanged:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
				dragInput = input
			end
		end)

		runService.Heartbeat:Connect(Update)
	end 

	local function toggleVisibility() 
		-- optimized lmao
		newWindow["Visible"] = not newWindow["Visible"]
	end

	if windowSettings["hide"] == true then
		newWindow["Visible"] = false;
	end

	local newTitle = Instance.new("TextLabel", newWindow);
	newTitle["BorderSizePixel"] = 0;
	newTitle["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newTitle["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newTitle["TextSize"] = 17;
	newTitle["TextColor3"] = Color3.fromRGB(221, 221, 221);
	newTitle["Size"] = UDim2.new(0, 238, 0, 25);
	newTitle["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newTitle["Text"] = windowName;
	newTitle["Name"] = "windowTitle";
	newTitle["BackgroundTransparency"] = 1;
	newTitle["Position"] = UDim2.new(0.10333333164453506, 0, 0.014999999664723873, 0);

	local function setWindowName(name)
		newTitle["Text"] = name;
	end

	-- window title
	if windowSettings["hideWindowTitle"] == true then
		newTitle["Visible"] = false;
	end

	-- window top right corner button
	if windowSettings["noCloseButton"] ~= true then

		local newWindowButton = Instance.new("ImageButton", newWindow);
		newWindowButton["Image"] = [[rbxassetid://3926305904]];
		newWindowButton["ImageRectSize"] = Vector2.new(24, 24);
		newWindowButton["Size"] = UDim2.new(0, 25, 0, 25);
		newWindowButton["Name"] = "windowButton";
		newWindowButton["ImageRectOffset"] = Vector2.new(284, 4);
		newWindowButton["Position"] = UDim2.new(0.8966666460037231, 0, 0.014999999664723873, 0);
		newWindowButton["BackgroundTransparency"] = 1;

		newWindowButton.MouseButton1Click:connect(function()
			newWindow:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, UIAnimationSpeed, true);
			for i, v in pairs(newWindow:GetDescendants()) do
				pcall(function()
					v:TweenSize(UDim2.new(0,0,0,0), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, UIAnimationSpeed, true);
				end)
			end
			task.wait(0.04);
			newWindow:Destroy();
		end)
	end

	local newWindowUICorner = Instance.new("UICorner", newWindow);
	newWindowUICorner["CornerRadius"] = UDim.new(0, 7);

	local newWindowUIGradient = Instance.new("UIGradient", newWindow);
	newWindowUIGradient["Rotation"] = 90;
	newWindowUIGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(50, 50, 50)),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(50, 50, 50))};
	if (windowSettings["windowColor"]) then
		newWindowUIGradient["Color"] = ColorSequence.new{ColorSequenceKeypoint.new(0.000, Color3.fromRGB(windowSettings["windowColor"][1], windowSettings["windowColor"][2], windowSettings["windowColor"][3])),ColorSequenceKeypoint.new(1.000, Color3.fromRGB(0, 0, 0))};
	end

	-- window content
	local newWindowContent = Instance.new("ScrollingFrame", newWindow);
	newWindowContent["Active"] = true;
	newWindowContent["BorderSizePixel"] = 0;
	newWindowContent["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowContent["BackgroundTransparency"] = 1;
	newWindowContent["Size"] = UDim2.new(0, 300, 0, 369);
	newWindowContent["ScrollBarImageColor3"] = Color3.fromRGB(71, 71, 71);
	newWindowContent["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowContent["ScrollBarThickness"] = 6;
	newWindowContent["Position"] = UDim2.new(0, 0, 0.07750000059604645, 0);
	newWindowContent["Name"] = "main";

	local function automaticHeight()
		local canvSize = 0;

		for i, v in pairs(newWindowContent:GetChildren()) do
			if v:IsA("Frame") then
				canvSize = canvSize + v.Size.Y.Offset + 7;
			end
		end

		newWindowContent.CanvasSize = UDim2.new(0, 0, 0, canvSize)
		task.wait(5)
		automaticHeight()
	end
	-- dear god dont use spawn pls use task.spawn
	task.spawn(automaticHeight);

	if windowSettings["windowSize"] then
		newWindowContent["Size"] = windowSettings["windowSize"];
		newWindowContent["Size"] = newWindowContent["Size"] + UDim2.new(0, 0, 0, -31)
	end

	local function clear()
		for i, v in pairs(newWindowContent:GetChildren()) do
			if v:IsA("Frame") then 
				v:Destroy();
			end
		end
	end

	local newWindowContentUIPadding = Instance.new("UIPadding", newWindowContent);
	newWindowContentUIPadding["PaddingTop"] = UDim.new(0, 8);

	local newWindowContentUIListLayout = Instance.new("UIListLayout", newWindowContent);
	newWindowContentUIListLayout["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
	newWindowContentUIListLayout["Padding"] = UDim.new(0, 7);
	newWindowContentUIListLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;

	if windowSettings["showShadows"] == true then

		local newWindowShadowHolder = Instance.new("Frame", newWindow);
		newWindowShadowHolder["ZIndex"] = 0;
		newWindowShadowHolder["BackgroundTransparency"] = 1;
		newWindowShadowHolder["Size"] = UDim2.new(1.056666612625122, 0, 1.037500023841858, 0);
		newWindowShadowHolder["Position"] = UDim2.new(-0.02666666731238365, 0, -0.015999999552965164, 0);
		newWindowShadowHolder["Name"] = "shadowHolder";

		local newWindowUmbraShadow = Instance.new("ImageLabel", newWindowShadowHolder);
		newWindowUmbraShadow["ZIndex"] = 0;
		newWindowUmbraShadow["SliceCenter"] = Rect.new(10, 10, 118, 118);
		newWindowUmbraShadow["ScaleType"] = Enum.ScaleType.Slice;
		newWindowUmbraShadow["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowUmbraShadow["ImageTransparency"] = 0.8600000143051147;
		newWindowUmbraShadow["AnchorPoint"] = Vector2.new(0.5, 0.5);
		newWindowUmbraShadow["Image"] = [[rbxassetid://1316045217]];
		newWindowUmbraShadow["Size"] = UDim2.new(1, 2, 1, 2);
		newWindowUmbraShadow["Name"] = [[umbraShadow]];
		newWindowUmbraShadow["BackgroundTransparency"] = 1;
		newWindowUmbraShadow["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		local newWindowPenumbraShadow = Instance.new("ImageLabel", newWindowShadowHolder);
		newWindowPenumbraShadow["ZIndex"] = 0;
		newWindowPenumbraShadow["SliceCenter"] = Rect.new(10, 10, 118, 118);
		newWindowPenumbraShadow["ScaleType"] = Enum.ScaleType.Slice;
		newWindowPenumbraShadow["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowPenumbraShadow["ImageTransparency"] = 0.8799999952316284;
		newWindowPenumbraShadow["AnchorPoint"] = Vector2.new(0.5, 0.5);
		newWindowPenumbraShadow["Image"] = [[rbxassetid://1316045217]];
		newWindowPenumbraShadow["Size"] = UDim2.new(1, 2, 1, 2);
		newWindowPenumbraShadow["Name"] = [[penumbraShadow]];
		newWindowPenumbraShadow["BackgroundTransparency"] = 1;
		newWindowPenumbraShadow["Position"] = UDim2.new(0.5, 0, 0.5, 0);

		local newWindowAmbientShadow = Instance.new("ImageLabel", newWindowShadowHolder);
		newWindowAmbientShadow["ZIndex"] = 0;
		newWindowAmbientShadow["SliceCenter"] = Rect.new(10, 10, 118, 118);
		newWindowAmbientShadow["ScaleType"] = Enum.ScaleType.Slice;
		newWindowAmbientShadow["ImageColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowAmbientShadow["ImageTransparency"] = 0.8799999952316284;
		newWindowAmbientShadow["AnchorPoint"] = Vector2.new(0.5, 0.5);
		newWindowAmbientShadow["Image"] = [[rbxassetid://1316045217]];
		newWindowAmbientShadow["Size"] = UDim2.new(1, 2, 1, 2);
		newWindowAmbientShadow["Name"] = [[ambientShadow]];
		newWindowAmbientShadow["BackgroundTransparency"] = 1;
		newWindowAmbientShadow["Position"] = UDim2.new(0.5, 0, 0.5, 0);

	end

	if windowSettings["pattern"] == true then
		local newWindowBackground = Instance.new("ImageLabel", newWindow);
		newWindowBackground["SliceCenter"] = Rect.new(0, 256, 0, 256);
		newWindowBackground["ScaleType"] = Enum.ScaleType.Tile;
		newWindowBackground["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		newWindowBackground["ImageTransparency"] = 0.6000000238418579;
		newWindowBackground["Image"] = [[rbxassetid://2151741365]];
		newWindowBackground["TileSize"] = UDim2.new(0, 250, 0, 250);
		newWindowBackground["Size"] = newWindow["Size"];
		newWindowBackground["Name"] = [[background]];
		newWindowBackground["BackgroundTransparency"] = 1;
	end

	if windowSettings["sidebar"] == true then
		local newWindowSidebar = Instance.new("Frame", newWindow);
		newWindowSidebar["BorderSizePixel"] = 0;
		newWindowSidebar["BackgroundColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowSidebar["Size"] = UDim2.new(0, 130, 0, 400);
		newWindowSidebar["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowSidebar["Name"] = [[windowSidebar]];
		newWindowSidebar["Visible"] = false;
		newWindowSidebar["ZIndex"] = 2;

		local newWindowSidebarUICorner = Instance.new("UICorner", newWindowSidebar);
		newWindowSidebarUICorner["CornerRadius"] = UDim.new(0, 7);

		local newWindowSidebarTabs = Instance.new("ScrollingFrame", newWindowSidebar);
		newWindowSidebarTabs["Active"] = true;
		newWindowSidebarTabs["BorderSizePixel"] = 0;
		newWindowSidebarTabs["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		newWindowSidebarTabs["BackgroundTransparency"] = 1;
		newWindowSidebarTabs["Size"] = UDim2.new(0, 130, 0, 355);
		newWindowSidebarTabs["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowSidebarTabs["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowSidebarTabs["Position"] = UDim2.new(0, 0, 0.11249999701976776, 0);
		newWindowSidebarTabs["Name"] = [[Tabs]];
		newWindowSidebarTabs["ZIndex"] = 2;

		local newWindowSidebarTabsUIListLayout = Instance.new("UIListLayout", newWindowSidebarTabs);
		newWindowSidebarTabsUIListLayout["Padding"] = UDim.new(0, 4);
		newWindowSidebarTabsUIListLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;

		local newWindowSidebarTabsUIPadding = Instance.new("UIPadding", newWindowSidebarTabs);
		newWindowSidebarTabsUIPadding["PaddingLeft"] = UDim.new(0, 4);

		local newWindowSidebarButton = Instance.new("ImageButton", newWindow);
		newWindowSidebarButton["LayoutOrder"] = 6;
		newWindowSidebarButton["Image"] = [[rbxassetid://3926307971]];
		newWindowSidebarButton["ImageRectSize"] = Vector2.new(36, 36);
		newWindowSidebarButton["Size"] = UDim2.new(0, 25, 0, 25);
		newWindowSidebarButton["Name"] = [[windowIcon]];
		newWindowSidebarButton["ImageRectOffset"] = Vector2.new(404, 44);
		newWindowSidebarButton["Position"] = UDim2.new(0.019611308351159096, 0, 0.013276862911880016, 0);
		newWindowSidebarButton["BackgroundTransparency"] = 1;
		newWindowSidebarButton["ZIndex"] = 2;

		newWindowSidebar:SetAttribute("prevSize", newWindowSidebar.Size)
		newWindowSidebarButton.MouseButton1Click:connect(function()
			if newWindowSidebar.Visible == false then
				newWindowSidebar["Size"] = UDim2.new(0, 0, 0, 0);
				newWindowSidebar.Visible = true
				newWindowSidebar:TweenSize(newWindowSidebar:GetAttribute("prevSize"), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, UIAnimationSpeed, true);

				local Object = newWindowSidebarButton -- The object you want to tween.
				local tweenInfo = TweenInfo.new(UIAnimationSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
				local Tween = TweenService:Create(Object, tweenInfo, {Rotation = -90})
				Tween:Play()

			elseif newWindowSidebar.Visible == true then
				local Object = newWindowSidebarButton -- The object you want to tween.
				local tweenInfo = TweenInfo.new(UIAnimationSpeed, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
				local Tween = TweenService:Create(Object, tweenInfo, {Rotation = 0})
				Tween:Play()

				newWindowSidebar:TweenSize(UDim2.new(0, 0, 0, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Sine, UIAnimationSpeed, true);
				task.wait(0.04)
				newWindowSidebar.Visible = false
			end
		end)

		if windowSettings["sidebarMainName"] == nil then
			windowSettings["sidebarMainName"] = "main";
		end

		local newWindowSidebarTab = Instance.new("TextButton", newWindowSidebarTabs);
		newWindowSidebarTab["BorderSizePixel"] = 0;
		newWindowSidebarTab["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
		newWindowSidebarTab["TextSize"] = 16;
		newWindowSidebarTab["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		newWindowSidebarTab["TextColor3"] = Color3.fromRGB(221, 221, 221);
		newWindowSidebarTab["Size"] = UDim2.new(0, 124, 0, 40);
		newWindowSidebarTab["Name"] = [[tab]];
		newWindowSidebarTab["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowSidebarTab["Text"] = windowSettings["sidebarMainName"];
		newWindowSidebarTab["Position"] = UDim2.new(0.04525686427950859, 0, 0.09749999642372131, 0);
		newWindowSidebarTab["BackgroundTransparency"] = 1;
		newWindowSidebarTab["ZIndex"] = 2;
		newWindowSidebarTab.MouseButton1Click:connect(function() 
			for i, v in pairs(newWindow:GetChildren()) do
				if v:IsA("ScrollingFrame") then
					v.Visible = false
				end
			end

			newWindowContent.Visible = true;
		end)

		local newWindowSidebarTabUnderline = Instance.new("Frame", newWindowSidebarTab);
		newWindowSidebarTabUnderline["BorderSizePixel"] = 0;
		newWindowSidebarTabUnderline["BackgroundColor3"] = Color3.fromRGB(151, 151, 151);
		newWindowSidebarTabUnderline["Size"] = UDim2.new(0, 110, 0, 1);
		newWindowSidebarTabUnderline["BorderColor3"] = Color3.fromRGB(0, 0, 0);
		newWindowSidebarTabUnderline["Position"] = UDim2.new(0.03846153989434242, 0, 1, 0);
		newWindowSidebarTabUnderline["Name"] = [[underline]];
		newWindowSidebarTabUnderline["ZIndex"] = 2;

		local newWindowSidebarTabIcon = Instance.new("ImageButton", newWindowSidebarTab);
		newWindowSidebarTabIcon["ImageTransparency"] = 0.10000000149011612;
		newWindowSidebarTabIcon["Image"] = [[rbxassetid://3926305904]];
		newWindowSidebarTabIcon["ImageRectSize"] = Vector2.new(36, 36);
		newWindowSidebarTabIcon["Size"] = UDim2.new(0, 25, 0, 25);
		newWindowSidebarTabIcon["Name"] = [[home]];
		newWindowSidebarTabIcon["ImageRectOffset"] = Vector2.new(964, 204);
		newWindowSidebarTabIcon["Position"] = UDim2.new(0.04615384712815285, 0, 0.15000000596046448, 0);
		newWindowSidebarTabIcon["BackgroundTransparency"] = 1;
		newWindowSidebarTabIcon["ZIndex"] = 2;
	end

	return {
		newWindow;
		toggleVisibility = toggleVisibility;
		clear = clear;

		setWindowLight = setWindowLight;
		setWindowName = setWindowName;
	}
end

function Kings.newTextElement(window, tab, text)
	local newWindowElementText = Instance.new("Frame", window[1][tab]);
	newWindowElementText["BorderSizePixel"] = 0;
	newWindowElementText["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementText["BackgroundTransparency"] = 0.9;
	newWindowElementText["Size"] = UDim2.new(0, 274, 0, 80);
	newWindowElementText["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementText["Position"] = UDim2.new(0.04333333298563957, 0, 0.13019390404224396, 0);
	newWindowElementText["Name"] = "windowElementText";

	local newWindowElementTextUICorner = Instance.new("UICorner", newWindowElementText);
	newWindowElementTextUICorner["CornerRadius"] = UDim.new(0, 7);

	local newWindowElementTextUIStroke = Instance.new("UIStroke", newWindowElementText);
	newWindowElementTextUIStroke["Color"] = Color3.fromRGB(20, 20, 20);
	newWindowElementTextUIStroke["Thickness"] = 0.51;

	local newWindowElementTextTextLabel = Instance.new("TextLabel", newWindowElementText);
	newWindowElementTextTextLabel["TextWrapped"] = true;
	newWindowElementTextTextLabel["BorderSizePixel"] = 0;
	newWindowElementTextTextLabel["TextYAlignment"] = Enum.TextYAlignment.Top;
	newWindowElementTextTextLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementTextTextLabel["TextXAlignment"] = Enum.TextXAlignment.Left;
	newWindowElementTextTextLabel["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newWindowElementTextTextLabel["TextSize"] = 15;
	newWindowElementTextTextLabel["TextColor3"] = Color3.fromRGB(221, 221, 221);
	newWindowElementTextTextLabel["Size"] = UDim2.new(0, 253, 0, 68);
	newWindowElementTextTextLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementTextTextLabel["Text"] = text;
	newWindowElementTextTextLabel["BackgroundTransparency"] = 1;
	newWindowElementTextTextLabel["Position"] = UDim2.new(0.040145985782146454, 0, 0.09500000298023224, 0);

	-- element functions
	local function setText(text)
		newWindowElementTextTextLabel["Text"] = text;
	end

	local function destroy()
		newWindowElementText:Destroy()	
	end
	
	local function getText()
		return newWindowElementTextTextLabel["Text"];
	end

	local function setOutlineColor(color)
		newWindowElementTextUIStroke["Color"] = color;
	end

	local function setBackgroundColor(color)
		newWindowElementText["BackgroundColor3"] = color;
	end

	local function setTransparency(integer) 
		newWindowElementText["BackgroundTransparency"] = integer;
	end

	return {
		newWindowElementText;
		setText = setText;
		getText = getText;
		setOutlineColor = setOutlineColor;
		setBackgroundColor = setBackgroundColor;
		setTransparency = setTransparency;
		destroy = destroy;
	}
end

function Kings.newButtonElement(window, tab, text, buttonType)
	--window = window[1];

	local buttonIconId, buttonIconOffset, buttonIconSize, buttonIconColor;

	if buttonType == nil or buttonType == 0 then
		buttonIconId = "rbxassetid://3926305904";
		buttonIconOffset = Vector2.new(604, 764);
		buttonIconSize = Vector2.new(36, 36);
		buttonIconColor = Color3.fromRGB(126, 255, 163);

	elseif buttonType == 1 then
		buttonIconId = "rbxassetid://3926305904";
		buttonIconOffset = Vector2.new(644, 724);
		buttonIconSize = Vector2.new(36, 36);
		buttonIconColor = Color3.fromRGB(220, 80, 80);

	elseif buttonType == 2 then
		buttonIconId = "rbxassetid://3926305904";
		buttonIconOffset = Vector2.new(116, 4);
		buttonIconSize = Vector2.new(24, 24);
		buttonIconColor = Color3.fromRGB(206, 220, 53);
	end

	local newWindowElementButton = Instance.new("Frame", window[1][tab]);
	newWindowElementButton["BorderSizePixel"] = 0;
	newWindowElementButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementButton["BackgroundTransparency"] = 0.8999999761581421;
	newWindowElementButton["Size"] = UDim2.new(window[1]["Size"].X.Scale, window[1]["Size"].X.Offset -26, 0, 40);
	newWindowElementButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementButton["Position"] = UDim2.new(0.04333333298563957, 0, 0.0379403792321682, 0);
	newWindowElementButton["Name"] = "windowElementButton";

	local newWindowElementButtonUIStroke = Instance.new("UIStroke", newWindowElementButton);
	newWindowElementButtonUIStroke["Color"] = Color3.fromRGB(20, 20, 20);
	newWindowElementButtonUIStroke["Thickness"] = 0.5099999904632568;

	local newWindowElementButtonImage = Instance.new("ImageButton", newWindowElementButton);
	newWindowElementButtonImage["ImageColor3"] = buttonIconColor;
	newWindowElementButtonImage["LayoutOrder"] = 7;
	newWindowElementButtonImage["Image"] = buttonIconId;
	newWindowElementButtonImage["ImageRectSize"] = buttonIconSize;
	newWindowElementButtonImage["Size"] = UDim2.new(0, 25, 0, 25);
	newWindowElementButtonImage["Name"] = [[icon]];
	newWindowElementButtonImage["ImageRectOffset"] = buttonIconOffset;
	newWindowElementButtonImage["Position"] = UDim2.new(0.8722627758979797, 0, 0.17499999701976776, 0);
	newWindowElementButtonImage["BackgroundTransparency"] = 1;

	local newWindowElementButtonButton = Instance.new("TextButton", newWindowElementButton);
	newWindowElementButtonButton["TextWrapped"] = true;
	newWindowElementButtonButton["BorderSizePixel"] = 0;
	newWindowElementButtonButton["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementButtonButton["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newWindowElementButtonButton["TextSize"] = 15;
	newWindowElementButtonButton["TextColor3"] = Color3.fromRGB(221, 221, 221);
	--newWindowElementButtonButton["Size"] = UDim2.new(0, 274, 0, 40);
	newWindowElementButtonButton["Size"] = UDim2.new(window[1]["Size"].X.Scale, window[1]["Size"].X.Offset -26, 0, 40);
	newWindowElementButtonButton["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementButtonButton["Text"] = text;
	newWindowElementButtonButton["BackgroundTransparency"] = 1;

	local newWindowElementButtonUICorner = Instance.new("UICorner", newWindowElementButton);
	newWindowElementButtonUICorner["CornerRadius"] = UDim.new(0, 7);

	-- element functions
	local function onclick(func)
		newWindowElementButtonButton.MouseButton1Click:connect(func)
		newWindowElementButtonImage.MouseButton1Click:connect(func)
	end
	
	local function destroy()
		newWindowElementButton:Destroy()
	end

	local function setText(text)
		newWindowElementButtonButton["Text"] = text;
	end

	local function getText()
		return newWindowElementButtonButton["Text"];
	end

	local function setOutlineColor(color)
		newWindowElementButtonUIStroke["Color"] = color;
	end

	local function setBackgroundColor(color)
		newWindowElementButton["BackgroundColor3"] = color;
	end

	local function setTransparency(integer) 
		newWindowElementButton["BackgroundTransparency"] = integer;
	end	

	return {
		newWindowElementButton;
		onclick = onclick;

		setText = setText;
		getText = getText;
		setOutlineColor = setOutlineColor;
		setBackgroundColor = setBackgroundColor;
		setTransparency = setTransparency;
		
		destroy = destroy;
	}
end

function Kings.newCategory(window, tab, name)
	local newWindowCategory = Instance.new("Frame", window[1][tab]);
	newWindowCategory["BorderSizePixel"] = 0;
	newWindowCategory["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowCategory["BackgroundTransparency"] = 1;
	newWindowCategory["Size"] = UDim2.new(0, 275, 0, 40);
	newWindowCategory["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowCategory["Position"] = UDim2.new(0.0416666679084301, 0, 0.4487534761428833, 0);
	newWindowCategory["Name"] = [[Category]];

	local newWindowCategoryTextLabel = Instance.new("TextLabel", newWindowCategory);
	newWindowCategoryTextLabel["BorderSizePixel"] = 0;
	newWindowCategoryTextLabel["TextYAlignment"] = Enum.TextYAlignment.Bottom;
	newWindowCategoryTextLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowCategoryTextLabel["TextXAlignment"] = Enum.TextXAlignment.Left;
	newWindowCategoryTextLabel["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newWindowCategoryTextLabel["TextSize"] = 16;
	newWindowCategoryTextLabel["TextColor3"] = Color3.fromRGB(91, 91, 91);
	newWindowCategoryTextLabel["Size"] = UDim2.new(0, 274, 0, 40);
	newWindowCategoryTextLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowCategoryTextLabel["Text"] = name;
	newWindowCategoryTextLabel["BackgroundTransparency"] = 1;

	return {
		newWindowCategory;
	}
end

function Kings.newSwitchElement(window, tab, text, state)
	local stateColor, stateIcon, stateOffset;

	stateColor = Color3.fromRGB(116, 116, 116);
	stateIcon = "rbxassetid://3926307971";
	stateOffset = Vector2.new(804, 124);

	if state == true then
		stateColor = Color3.fromRGB(118, 150, 255);
		stateIcon = "rbxassetid://3926307971";
		stateOffset = Vector2.new(764, 244);
	end

	local newWindowElementSwitch = Instance.new("Frame", window[1][tab]);
	newWindowElementSwitch["BorderSizePixel"] = 0;
	newWindowElementSwitch["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementSwitch["BackgroundTransparency"] = 0.8999999761581421;
	newWindowElementSwitch["Size"] = UDim2.new(0, 274, 0, 40);
	newWindowElementSwitch["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementSwitch["Position"] = UDim2.new(0.04333333298563957, 0, 0.0379403792321682, 0);
	newWindowElementSwitch["Name"] = [[windowElementSwitch]];

	local newWindowElementSwitchUICorner = Instance.new("UICorner", newWindowElementSwitch);
	newWindowElementSwitchUICorner["CornerRadius"] = UDim.new(0, 7);

	local newWindowElementSwitchUIStroke = Instance.new("UIStroke", newWindowElementSwitch);
	newWindowElementSwitchUIStroke["Color"] = Color3.fromRGB(20, 20, 20);
	newWindowElementSwitchUIStroke["Thickness"] = 0.5099999904632568;

	local newWindowElementSwitchTextLabel = Instance.new("TextButton", newWindowElementSwitch);
	newWindowElementSwitchTextLabel["TextWrapped"] = true;
	newWindowElementSwitchTextLabel["BorderSizePixel"] = 0;
	newWindowElementSwitchTextLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementSwitchTextLabel["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newWindowElementSwitchTextLabel["TextSize"] = 15;
	newWindowElementSwitchTextLabel["TextColor3"] = Color3.fromRGB(221, 221, 221);
	newWindowElementSwitchTextLabel["Size"] = UDim2.new(0, 274, 0, 40);
	newWindowElementSwitchTextLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementSwitchTextLabel["Text"] = text;
	newWindowElementSwitchTextLabel["BackgroundTransparency"] = 1;

	local newWindowElementSwitchState = Instance.new("ImageButton", newWindowElementSwitch);
	newWindowElementSwitchState["ImageColor3"] = stateColor;
	newWindowElementSwitchState["LayoutOrder"] = 20;
	newWindowElementSwitchState["Image"] = stateIcon;
	newWindowElementSwitchState["ImageRectSize"] = Vector2.new(36, 36);
	newWindowElementSwitchState["Size"] = UDim2.new(0, 25, 0, 25);
	newWindowElementSwitchState["Name"] = "off";
	newWindowElementSwitchState["ImageRectOffset"] = stateOffset;
	newWindowElementSwitchState["Position"] = UDim2.new(0.8722627758979797, 0, 0.17499999701976776, 0);
	newWindowElementSwitchState["BackgroundTransparency"] = 1;
	newWindowElementSwitchState["Visible"] = true;

	-- element functions
	local function switch()
		if state == true then
			state = false;

			newWindowElementSwitchState["ImageColor3"] = Color3.fromRGB(116, 116, 116);
			newWindowElementSwitchState["Image"] = "rbxassetid://3926307971";
			newWindowElementSwitchState["ImageRectOffset"] = Vector2.new(804, 124);
		elseif state == false then
			state = true;

			newWindowElementSwitchState["ImageColor3"] = Color3.fromRGB(118, 150, 255);
			newWindowElementSwitchState["Image"] = "rbxassetid://3926307971";
			newWindowElementSwitchState["ImageRectOffset"] = Vector2.new(764, 244);

		end
	end

	local function onclick(func)
		newWindowElementSwitchTextLabel.MouseButton1Click:connect(func)
		newWindowElementSwitchState.MouseButton1Click:connect(func)
	end

	local function setText(text)
		newWindowElementSwitchTextLabel["Text"] = text;
	end

	local function getText()
		return newWindowElementSwitchTextLabel["Text"];
	end

	local function setOutlineColor(color)
		newWindowElementSwitchUIStroke["Color"] = color;
	end

	local function setBackgroundColor(color)
		newWindowElementSwitch["BackgroundColor3"] = color;
	end

	local function setTransparency(integer) 
		newWindowElementSwitch["BackgroundTransparency"] = integer;
	end	

	if state == true then
		newWindowElementSwitchState["ImageColor3"] = Color3.fromRGB(118, 150, 255);
		newWindowElementSwitchState["Image"] = "rbxassetid://3926307971";
		newWindowElementSwitchState["ImageRectOffset"] = Vector2.new(764, 244);
	elseif state == false then
		newWindowElementSwitchState["ImageColor3"] = Color3.fromRGB(116, 116, 116);
		newWindowElementSwitchState["Image"] = "rbxassetid://3926307971";
		newWindowElementSwitchState["ImageRectOffset"] = Vector2.new(804, 124);
	end

	local function getState()
		return state;
	end

	local function setState(newState)
		state = newState;

		if state == true then
			newWindowElementSwitchState["ImageColor3"] = Color3.fromRGB(118, 150, 255);
			newWindowElementSwitchState["Image"] = "rbxassetid://3926307971";
			newWindowElementSwitchState["ImageRectOffset"] = Vector2.new(764, 244);
		elseif state == false then
			newWindowElementSwitchState["ImageColor3"] = Color3.fromRGB(116, 116, 116);
			newWindowElementSwitchState["Image"] = "rbxassetid://3926307971";
			newWindowElementSwitchState["ImageRectOffset"] = Vector2.new(804, 124);
		end
	end

	return {
		newWindowElementSwitch;
		onclick = onclick;

		setText = setText;
		getText = getText;
		setOutlineColor = setOutlineColor;
		setBackgroundColor = setBackgroundColor;
		setTransparency = setTransparency;
		getState = getState;
		setState = setState;
		switch = switch;
	}
end

function Kings.newInputElement(window, tab, text, placeholder)
	local newWindowElementInput = Instance.new("Frame", window[1][tab]);
	newWindowElementInput["BorderSizePixel"] = 0;
	newWindowElementInput["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementInput["BackgroundTransparency"] = 0.8999999761581421;
	newWindowElementInput["Size"] = UDim2.new(0, 274, 0, 60);
	newWindowElementInput["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementInput["Position"] = UDim2.new(0.04333333298563957, 0, 0.5817174315452576, 0);
	newWindowElementInput["Name"] = [[windowElementInput]];

	local newWindowElementInputUIStroke = Instance.new("UIStroke", newWindowElementInput);
	newWindowElementInputUIStroke["Color"] = Color3.fromRGB(20, 20, 20);
	newWindowElementInputUIStroke["Thickness"] = 0.5099999904632568;

	local newWindowElementInputTextLabel = Instance.new("TextLabel", newWindowElementInput);
	newWindowElementInputTextLabel["TextWrapped"] = true;
	newWindowElementInputTextLabel["BorderSizePixel"] = 0;
	newWindowElementInputTextLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementInputTextLabel["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newWindowElementInputTextLabel["TextSize"] = 15;
	newWindowElementInputTextLabel["TextColor3"] = Color3.fromRGB(221, 221, 221);
	newWindowElementInputTextLabel["Size"] = UDim2.new(0, 274, 0, 35);
	newWindowElementInputTextLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementInputTextLabel["Text"] = text;
	newWindowElementInputTextLabel["BackgroundTransparency"] = 1;

	local newWindowElementInputIcon = Instance.new("ImageButton", newWindowElementInput);
	newWindowElementInputIcon["ImageColor3"] = Color3.fromRGB(189, 72, 255);
	newWindowElementInputIcon["Image"] = [[rbxassetid://3926305904]];
	newWindowElementInputIcon["ImageRectSize"] = Vector2.new(36, 36);
	newWindowElementInputIcon["Size"] = UDim2.new(0, 25, 0, 25);
	newWindowElementInputIcon["Name"] = [[icon]];
	newWindowElementInputIcon["ImageRectOffset"] = Vector2.new(764, 84);
	newWindowElementInputIcon["Position"] = UDim2.new(0.8705109357833862, 0, 0.16999968886375427, 0);
	newWindowElementInputIcon["BackgroundTransparency"] = 1;

	local newWindowElementInputTextBox = Instance.new("TextBox", newWindowElementInput);
	newWindowElementInputTextBox["BorderSizePixel"] = 0;
	newWindowElementInputTextBox["TextSize"] = 15;
	newWindowElementInputTextBox["BackgroundColor3"] = Color3.fromRGB(101, 101, 101);
	newWindowElementInputTextBox["TextColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementInputTextBox["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Regular, Enum.FontStyle.Italic);
	newWindowElementInputTextBox["BackgroundTransparency"] = 1;
	newWindowElementInputTextBox["PlaceholderText"] = placeholder;
	newWindowElementInputTextBox["Size"] = UDim2.new(0, 274, 0, 25);
	newWindowElementInputTextBox["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementInputTextBox["Text"] = [[]];
	newWindowElementInputTextBox["Position"] = UDim2.new(0, 0, 0.5833333134651184, 0);

	local newWindowElementInputTextBoxUICorner = Instance.new("UICorner", newWindowElementInputTextBox);
	newWindowElementInputTextBoxUICorner["CornerRadius"] = UDim.new(0, 7);

	local newWindowElementInputUICorner = Instance.new("UICorner", newWindowElementInput);
	newWindowElementInputUICorner["CornerRadius"] = UDim.new(0, 7);

	local function setInput(inp)
		newWindowElementInputTextBox["Text"] = inp;
	end
	
	local function destroy()
		newWindowElementInput:Destroy()
	end

	local function getInput()
		return newWindowElementInputTextBox["Text"];
	end

	local function setText(text)
		newWindowElementInputTextLabel["Text"] = text;
	end

	local function setOutlineColor(color)
		newWindowElementInputUIStroke["Color"] = color;
	end

	local function setBackgroundColor(color)
		newWindowElementInput["BackgroundColor3"] = color;
	end

	local function setTransparency(integer) 
		newWindowElementInput["BackgroundTransparency"] = integer;
	end	

	return {
		newWindowElementInput;

		setInput = setInput;
		getInput = getInput;
		setText = setText;
		setOutlineColor = setOutlineColor;
		setBackgroundColor = setBackgroundColor;
		setTransparency = setTransparency;
		destroy = destroy;
	}
end

function Kings.newTab(window, name)
	local newWindowContent = Instance.new("ScrollingFrame", window[1]);
	newWindowContent["Active"] = true;
	newWindowContent["BorderSizePixel"] = 0;
	newWindowContent["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowContent["BackgroundTransparency"] = 1;
	newWindowContent["Size"] = UDim2.new(0, 300, 0, 369);
	newWindowContent["Size"] = newWindowContent["Size"] + UDim2.new(0, 0, 0, -31);
	newWindowContent["ScrollBarImageColor3"] = Color3.fromRGB(71, 71, 71);
	newWindowContent["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowContent["ScrollBarThickness"] = 6;
	newWindowContent["Position"] = UDim2.new(0, 0, 0.07750000059604645, 0);
	newWindowContent["Name"] = name;
	newWindowContent["Visible"] = false;

	local function automaticHeight()
		local canvSize = 0;

		for i, v in pairs(newWindowContent:GetChildren()) do
			if v:IsA("Frame") then
				canvSize = canvSize + v.Size.Y.Offset + 7;
			end
		end

		newWindowContent.CanvasSize = UDim2.new(0, 0, 0, canvSize)
		task.wait(5)
		automaticHeight()
	end
	spawn(automaticHeight);

	local function clear()
		for i, v in pairs(newWindowContent:GetChildren()) do
			if v:IsA("Frame") then 
				v:Destroy();
			end
		end
	end

	local newWindowContentUIPadding = Instance.new("UIPadding", newWindowContent);
	newWindowContentUIPadding["PaddingTop"] = UDim.new(0, 8);

	local newWindowContentUIListLayout = Instance.new("UIListLayout", newWindowContent);
	newWindowContentUIListLayout["HorizontalAlignment"] = Enum.HorizontalAlignment.Center;
	newWindowContentUIListLayout["Padding"] = UDim.new(0, 7);
	newWindowContentUIListLayout["SortOrder"] = Enum.SortOrder.LayoutOrder;	

	local function destroy()
		newWindowContent:Destroy()
	end
	
	return {
		newWindowContent;
		clear = clear;
		destroy = destroy;
	}
end

function Kings.newSidebarOption(window, tabToView, text, icon)
	window = window[1];

	local newWindowSidebarTab = Instance.new("TextButton", window["windowSidebar"]["Tabs"]);
	newWindowSidebarTab["BorderSizePixel"] = 0;
	newWindowSidebarTab["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowSidebarTab["TextSize"] = 16;
	newWindowSidebarTab["FontFace"] = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
	newWindowSidebarTab["TextColor3"] = Color3.fromRGB(221, 221, 221);
	newWindowSidebarTab["Size"] = UDim2.new(0, 124, 0, 40);
	newWindowSidebarTab["Name"] = [[tab]];
	newWindowSidebarTab["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowSidebarTab["Text"] = text;
	newWindowSidebarTab["Position"] = UDim2.new(0.04525686427950859, 0, 0.09749999642372131, 0);
	newWindowSidebarTab["BackgroundTransparency"] = 1;
	newWindowSidebarTab["ZIndex"] = 2;
	newWindowSidebarTab.MouseButton1Click:connect(function()
		for i, v in pairs(window:GetChildren()) do
			if v:IsA("ScrollingFrame") then
				v.Visible = false
			end
		end

		tabToView[1].Visible = true;
	end)


	local newWindowSidebarTabUnderline = Instance.new("Frame", newWindowSidebarTab);
	newWindowSidebarTabUnderline["BorderSizePixel"] = 0;
	newWindowSidebarTabUnderline["BackgroundColor3"] = Color3.fromRGB(151, 151, 151);
	newWindowSidebarTabUnderline["Size"] = UDim2.new(0, 110, 0, 1);
	newWindowSidebarTabUnderline["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowSidebarTabUnderline["Position"] = UDim2.new(0.03846153989434242, 0, 1, 0);
	newWindowSidebarTabUnderline["Name"] = [[underline]];
	newWindowSidebarTabUnderline["ZIndex"] = 2;



	local newWindowSidebarTabIcon = Instance.new("ImageButton", newWindowSidebarTab);
	newWindowSidebarTabIcon["ImageTransparency"] = 0.10000000149011612;

	if icon == nil then
		newWindowSidebarTabIcon["Image"] = [[rbxassetid://3926305904]];
		newWindowSidebarTabIcon["ImageRectOffset"] = Vector2.new(964, 204);
		newWindowSidebarTabIcon["ImageRectSize"] = Vector2.new(36, 36);
	else
		newWindowSidebarTabIcon["Image"] = icon[1];
		newWindowSidebarTabIcon["ImageRectOffset"] = icon[2];
		if icon[3] ~= nil then
			newWindowSidebarTabIcon["ImageRectSize"] = icon[3];
		end
	end


	newWindowSidebarTabIcon["Size"] = UDim2.new(0, 25, 0, 25);
	newWindowSidebarTabIcon["Name"] = [[home]];
	newWindowSidebarTabIcon["Position"] = UDim2.new(0.04615384712815285, 0, 0.15000000596046448, 0);
	newWindowSidebarTabIcon["BackgroundTransparency"] = 1;
	newWindowSidebarTabIcon["ZIndex"] = 2;



	local function onclick(func)
		newWindowSidebarTab.MouseButton1Click:connect(func)
		newWindowSidebarTabIcon.MouseButton1Click:connect(func)
	end
	
	local function destroy()
		newWindowSidebarTab:Destroy()
	end

	return {
		newWindowSidebarTab;
		onclick = onclick;
		destroy = destroy;
	}
end

function Kings.newSliderElement(window, tab, text, defaultValue)
	local newWindowElementSlider = Instance.new("TextButton", window[1][tab]);
	newWindowElementSlider["BorderSizePixel"] = 0;
	newWindowElementSlider["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementSlider["BackgroundTransparency"] = 0.8999999761581421;
	newWindowElementSlider["Size"] = UDim2.new(0, 274, 0, 60);
	newWindowElementSlider["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementSlider["Position"] = UDim2.new(0.04333333298563957, 0, 0.31855955719947815, 0);
	newWindowElementSlider["Name"] = [[windowElementSlider]];
	newWindowElementSlider["Text"] = "";

	local newWindowElementSliderUIStroke = Instance.new("UIStroke", newWindowElementSlider);
	newWindowElementSliderUIStroke["Color"] = Color3.fromRGB(20, 20, 20);
	newWindowElementSliderUIStroke["Thickness"] = 0.5099999904632568;

	local newWindowElementSliderTextLabel = Instance.new("TextLabel", newWindowElementSlider);
	newWindowElementSliderTextLabel["TextWrapped"] = true;
	newWindowElementSliderTextLabel["BorderSizePixel"] = 0;
	newWindowElementSliderTextLabel["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementSliderTextLabel["FontFace"] = Font.new([[rbxasset://fonts/families/GothamSSm.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
	newWindowElementSliderTextLabel["TextSize"] = 15;
	newWindowElementSliderTextLabel["TextColor3"] = Color3.fromRGB(221, 221, 221);
	newWindowElementSliderTextLabel["Size"] = UDim2.new(0, 274, 0, 40);
	newWindowElementSliderTextLabel["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementSliderTextLabel["Text"] = text;
	newWindowElementSliderTextLabel["BackgroundTransparency"] = 1;
	newWindowElementSliderTextLabel["Position"] = UDim2.new(0, 0, -0.014285714365541935, 0);

	local newWindowElementSliderIcon = Instance.new("ImageButton", newWindowElementSlider);
	newWindowElementSliderIcon["ImageColor3"] = Color3.fromRGB(255, 161, 98);
	newWindowElementSliderIcon["LayoutOrder"] = 5;
	newWindowElementSliderIcon["Image"] = [[rbxassetid://3926305904]];
	newWindowElementSliderIcon["ImageRectSize"] = Vector2.new(36, 36);
	newWindowElementSliderIcon["Size"] = UDim2.new(0, 25, 0, 25);
	newWindowElementSliderIcon["Name"] = [[icon]];
	newWindowElementSliderIcon["ImageRectOffset"] = Vector2.new(4, 124);
	newWindowElementSliderIcon["Position"] = UDim2.new(0.8722627758979797, 0, 0.10357142984867096, 0);
	newWindowElementSliderIcon["BackgroundTransparency"] = 1;

	local newWindowElementSliderSlider = Instance.new("Frame", newWindowElementSlider);
	newWindowElementSliderSlider["BorderSizePixel"] = 0;
	newWindowElementSliderSlider["BackgroundColor3"] = Color3.fromRGB(255, 161, 98);
	newWindowElementSliderSlider["BackgroundTransparency"] = 0.10000000149011612;
	newWindowElementSliderSlider["Size"] = UDim2.new(0, 0, 0, 8);
	newWindowElementSliderSlider["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementSliderSlider["Position"] = UDim2.new(0.06526785343885422, 0, 0.6976191401481628, 0);
	newWindowElementSliderSlider["Name"] = "slider";

	local newWindowElementSliderSliderOutline = Instance.new("Frame", newWindowElementSlider);
	newWindowElementSliderSliderOutline["BorderSizePixel"] = 0;
	newWindowElementSliderSliderOutline["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
	newWindowElementSliderSliderOutline["BackgroundTransparency"] = 0.8999999761581421;
	newWindowElementSliderSliderOutline["Size"] = UDim2.new(0, 238, 0, 8);
	newWindowElementSliderSliderOutline["BorderColor3"] = Color3.fromRGB(0, 0, 0);
	newWindowElementSliderSliderOutline["Position"] = UDim2.new(0.06526785343885422, 0, 0.6976191401481628, 0);
	newWindowElementSliderSliderOutline["Name"] = [[sliderOutline]];

	local minSliderValue = 0
	local maxSliderValue = 100

	local dragging = false
	local inputChangedConnection

	local sliderWidth = newWindowElementSliderSliderOutline.AbsoluteSize.X;
	local val = 0;

	local title = newWindowElementSliderTextLabel["Text"];
	newWindowElementSliderTextLabel["Text"] = title.." ["..defaultValue.."]";

	newWindowElementSlider.MouseButton1Down:Connect(function()
		dragging = true
		inputChangedConnection = game:GetService("UserInputService").InputChanged:Connect(function(input)
			if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
				local sliderPosition = input.Position.X - newWindowElementSliderSliderOutline.AbsolutePosition.X
				sliderPosition = math.clamp(sliderPosition, 0, sliderWidth)
				local newValue = sliderPosition / sliderWidth * (maxSliderValue - minSliderValue) + minSliderValue
				newWindowElementSliderTextLabel["Text"] = title.." ["..tostring(math.floor(newValue)).."]";
				val = tostring(math.floor(newValue))
				newWindowElementSliderSlider["Size"] = UDim2.new(0, sliderPosition, 0, 8);
			end
		end)
	end)

	newWindowElementSlider.MouseButton1Up:Connect(function()
		dragging = false
		if inputChangedConnection then
			inputChangedConnection:Disconnect()
		end
	end)

	local function getValue()
		return val;
	end

	local function minValue(val)
		minSliderValue = val;
	end

	local function maxValue(val)
		maxSliderValue = val;
	end

	local newWindowElementSliderSliderOutlineUICorner = Instance.new("UICorner", newWindowElementSliderSliderOutline);
	newWindowElementSliderSliderOutlineUICorner["CornerRadius"] = UDim.new(0, 7);

	local newWindowElementSliderSliderOutlineUIStroke = Instance.new("UIStroke", newWindowElementSliderSliderOutline);
	newWindowElementSliderSliderOutlineUIStroke["Color"] = Color3.fromRGB(255, 161, 98);
	newWindowElementSliderSliderOutlineUIStroke["Thickness"] = 0.5099999904632568;

	local newWindowElementSliderSliderUICorner = Instance.new("UICorner", newWindowElementSliderSlider);
	newWindowElementSliderSliderUICorner["CornerRadius"] = UDim.new(0, 7);

	local newWindowElementSliderSliderUIStroke = Instance.new("UIStroke", newWindowElementSliderSlider);
	newWindowElementSliderSliderUIStroke["Color"] = Color3.fromRGB(255, 161, 98);
	newWindowElementSliderSliderUIStroke["Thickness"] = 0.5099999904632568;

	return {
		newWindowElementSlider;
		getValue = getValue;
		minValue = minValue;
		maxValue = maxValue;

	}
end

return Kings;
