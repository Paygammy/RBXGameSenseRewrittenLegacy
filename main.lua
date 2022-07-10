shared.gamesense = shared.gamesense or {}

for index, value in pairs(shared.gamesense) do
	if typeof(value) == "RBXScriptConnection" then
		value:Disconnect()
	end
end

local CFnew = CFrame.new
local fromRGB = Color3.fromRGB
local fromHSV = Color3.fromHSV
local Vec2new = Vector2.new
local Vec3new = Vector3.new
local UDnew = UDim.new
local UD2new = UDim2.new
local deg = math.deg
local atan2 = math.atan2
local currentCamera = workspace.CurrentCamera
local s_gsub = string.gsub
table.insert(shared.gamesense, workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() currentCamera = workspace.CurrentCamera end))

local setting = {}

setting.uianim = false
setting.aba = true
setting.cha = true
setting.esp = true
setting.box = true
setting.trace = false
setting.hideui = false
setting.hidename = false
setting.bbls = 1
setting.ffa = false

setting.fov = 4
setting.sens = 0.2
setting.drop = 0

setting.hudtheme = {
	tlockedcol = fromRGB(0, 172, 255),
	tinviewcol = fromRGB(38, 255, 99),
	toutviewcol = fromRGB(255, 37, 40)
}

setting.keybinds = {}
setting.keybinds.vctogkey = Enum.KeyCode.RightAlt
setting.keybinds.abtogkey = Enum.KeyCode.LeftAlt
setting.keybinds.partselecttoggledelay	= Enum.KeyCode.Pipe
setting.keybinds.chfontkey = Enum.KeyCode.F1
setting.keybinds.uivisiblekey = Enum.KeyCode.F6
setting.keybinds.esptogkey = Enum.KeyCode.End
setting.keybinds["FreeForAllToggleKey"]		=
	setting.keybinds["FreeForAllToggleKey"] or
	Enum.KeyCode.Home
setting.keybinds["SensIncreaseKey"]			=
	setting.keybinds["SensIncreaseKey"] or 
	Enum.KeyCode.RightBracket
setting.keybinds["SensDecreaseKey"]			=
	setting.keybinds["SensDecreaseKey"] or 
	Enum.KeyCode.LeftBracket
setting.keybinds["FOVIncreaseKey"]			= 
	setting.keybinds["FOVIncreaseKey"] or
	Enum.KeyCode.KeypadPlus
setting.keybinds["FOVDecreaseKey"]			= 
	setting.keybinds["FOVDecreaseKey"] or
	Enum.KeyCode.KeypadMinus

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local GameSense = setmetatable({}, {
	__call = function(self, ...)
		return {
			["Version"] = "1.3.01-a",
			["Build Creator"] = {
				["Name"] = Players:GetNameFromUserIdAsync(1708043824),
				["UserId"] = 1708043824
			},
			["Contributers"] = {
	
			},
			["Donors"] = {
	
			},
		}
	end
})

local getregistry = getreg or debug.registry
local getupvalues = getupvalues or debug.getupvalues
local islocalclosure = isourclosure or isexecutorclosure or is_synapse_function

local function getvariablefromregistry(parameters)
	if not _registryCache then _registryCache = getregistry() end

	local variable

	for _, f in pairs(_registryCache) do
		if typeof(f) == "function" and not islocalclosure(f) then
			for _, t in pairs(getupvalues(f)) do
				if type(t) == "table" then
					local c = 0
					for _, v in pairs(parameters) do
						if rawget(t, v) then
							c += 1
						end
					end
					if c == #parameters then
						variable = t
					end
				end
			end
		end
	end

	return variable
end

local placeid = game["PlaceId"]
local town
local phantomforces

if table.find({299659045, 292439477, 3568020459}, placeid) then
	local function getfuncs(retries)
		if retries and retries > 10 then return end

		phantomforces = {
			network = getvariablefromregistry({"add", "send", "fetch"}),
			camera = getvariablefromregistry({"currentcamera", "setfirstpersoncam", "setspectate"}),
			replication = getvariablefromregistry({"getbodyparts"}),
			hud = getvariablefromregistry({"getplayerpos", "isplayeralive"}),
			characters = {},
		}

		if not phantomforces.network or not phantomforces.camera or not phantomforces.replication or not phantomforces.hud then
			_registryCache = getregistry()
			
			return task.wait(1) and getfuncs(retries and retries + 1 or 1)
		end

		phantomforces.characters = debug.getupvalue(phantomforces.replication.getbodyparts, 1)
	end
end

local localplayer

while not (typeof(localplayer) == 'Instance' and localplayer:IsA('Player')) do
	localplayer = Players.LocalPlayer
end

local playermouse = localplayer and localplayer:GetMouse() or (plugin and plugin:GetMouse()) or nil

local MouseButtonsDown = {
	["MouseButton2"] = false
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Archivable = false
ScreenGui.AutoLocalize = false
ScreenGui.DisplayOrder = 5
ScreenGui.Enabled = true
ScreenGui.IgnoreGuiInset = false
ScreenGui.Name = string.format("GameSense %s", GameSense().Version)
table.insert(shared.gamesense, ScreenGui)

if syn and syn.protect_gui then
	syn.protect_gui(ScreenGui)
end

ScreenGui.Parent = CoreGui
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Global

local Frame = Instance.new("Frame")
Frame.Active = false
Frame.AnchorPoint = Vec2new(0, 0)
Frame.Archivable = false
Frame.AutoLocalize = false
Frame.AutomaticSize = Enum.AutomaticSize.None
Frame.BackgroundColor3 = fromRGB(248, 248, 248)
Frame.BackgroundTransparency = 1
Frame.BorderColor3 = fromRGB(17, 17, 17)
Frame.BorderMode = Enum.BorderMode.Outline
Frame.BorderSizePixel = 0
Frame.ClipsDescendants = false
Frame.Name = "Bottom"
Frame.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Active = false
TextLabel.AnchorPoint = Vec2new(0.5, 0.5)
TextLabel.Archivable = false
TextLabel.AutoLocalize = false
TextLabel.BackgroundColor3 = fromRGB(248, 248, 248)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = fromRGB(17, 17, 17)
TextLabel.BorderMode = Enum.BorderMode.Outline
TextLabel.BorderSizePixel = 0
TextLabel.ClipsDescendants = false
TextLabel.Font = Enum.Font.SourceSans
TextLabel.LayoutOrder = 6
TextLabel.LineHeight = 1
TextLabel.MaxVisibleGraphemes = -1
TextLabel.Name = "Status"
TextLabel.Position = UD2new(0.5, 0, 1, -125)
TextLabel.RichText = false
TextLabel.Rotation = 0
TextLabel.Selectable = false
TextLabel.Size = UD2new(0, 500, 0, 50)
TextLabel.Text = "On Standby"
TextLabel.TextColor3 = fromRGB(248, 248, 248)
TextLabel.TextScaled = true
TextLabel.TextSize = 24
TextLabel.TextStrokeColor3 = fromRGB(17, 17, 17)
TextLabel.TextStrokeTransparency = 0.6
TextLabel.TextTruncate = Enum.TextTruncate.None
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Center
TextLabel.TextYAlignment = Enum.TextYAlignment.Center
TextLabel.Visible = true
TextLabel.ZIndex = 50
TextLabel.Parent = ScreenGui

function GameSense:DisplayMessage(Text, Duration, ExtraData)
	coroutine.resume(coroutine.create(function()
		local Clone = Instance.new("TextLabel")
		Clone.Active = false
		Clone.AnchorPoint = Vec2new(0.5, 0.5)
		Clone.Archivable = false
		Clone.AutoLocalize = false
		Clone.BackgroundColor3 = fromRGB(248, 248, 248)
		Clone.BackgroundTransparency = 1
		Clone.BorderColor3 = fromRGB(17, 17, 17)
		Clone.BorderMode = Enum.BorderMode.Outline
		Clone.BorderSizePixel = 0
		Clone.ClipsDescendants = false
		Clone.Font = Enum.Font.SourceSans
		Clone.LayoutOrder = 6
		Clone.LineHeight = 1
		Clone.MaxVisibleGraphemes = -1
		Clone.Name = "CloneLabel"
		Clone.Position = UD2new(0.5, 0, 0.5, 0)
		Clone.RichText = true
		Clone.Rotation = 0
		Clone.Selectable = false
		Clone.Size = UD2new(1, 0, 1, 0)
		Clone.Text = Text
		Clone.TextColor3 = fromRGB(248, 248, 248)
		Clone.TextScaled = true
		Clone.TextSize = 24
		Clone.TextStrokeColor3 = fromRGB(17, 17, 17)
		Clone.TextStrokeTransparency = 0.6
		Clone.TextTruncate = Enum.TextTruncate.None
		Clone.TextWrapped = true
		Clone.TextXAlignment = Enum.TextXAlignment.Center
		Clone.TextYAlignment = Enum.TextYAlignment.Center
		Clone.Visible = true
		Clone.ZIndex = 50
		Clone.Parent = ScreenGui["Status"]

		if ExtraData and typeof(ExtraData) == "table" then
			for propertyindex, propertyvalue in pairs(ExtraData) do
				Clone[propertyindex] = propertyvalue
			end
		end

		local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
		UITextSizeConstraint.Archivable = false
		UITextSizeConstraint.MaxTextSize = Clone.TextSize
		UITextSizeConstraint.MinTextSize = 1
		UITextSizeConstraint.Name = "UITextSizeConstraint"
		UITextSizeConstraint.Parent = Clone
		game:GetService("Debris"):AddItem(Clone, Duration)

		ScreenGui["Status"].TextTransparency = 1
		ScreenGui["Status"].TextStrokeTransparency = 1

		local function GetTextLabels()
			local TextLabels = {}
			for _, GuiObject in pairs(ScreenGui["Status"]:GetChildren()) do
				if GuiObject and GuiObject:IsA("TextLabel") then
					table.insert(TextLabels, GuiObject)
				end
			end
			return TextLabels
		end

		for _, TextLabel in pairs(GetTextLabels()) do
			if TextLabel ~= Clone then
				TextLabel:Destroy()
			end
		end

		repeat
			task.wait(0)
		until table.getn(GetTextLabels()) == 0

		ScreenGui["Status"].TextTransparency = 0
		ScreenGui["Status"].TextStrokeTransparency = 0.6
	end))
end

local function AntiAim()
	if localplayer.Character then
		local Character = localplayer.Character
		local Torso = Character:FindFirstChild("Torso") or Character:FindFirstChild("UpperTorso")
		local BodyGyro = Instance.new("BodyGyro")
		BodyGyro.D = 0
		BodyGyro.P = 5e3
		BodyGyro.MaxTorque = Vec3new(0, BodyGyro.P, 0)
		BodyGyro.Parent = Torso
		BodyGyro.CFrame = CFnew(BodyGyro:FindFirstAncestorWhichIsA("BasePart").CFrame.Position, (currentCamera.CFrame * CFnew(0, 0, 0)).Position)
		RunService.Heartbeat:Wait()
		BodyGyro:Destroy()
	end
end

GameSense:DisplayMessage("Thank you for using GameSense Rewritten!\nSend bug reports to shawnjbragdon#0001", 5, {
	["TextSize"] = 16,
	["TextColor3"] = fromRGB(255, 192, 64),
	["TextStrokeColor3"] = fromRGB(17, 17, 17),
	["TextStrokeTransparency"] = 0.75,
	["Font"] = Enum.Font.GothamBold,
})

GameSense.Target = {
	["Player"] = nil ,
	["Character"] = nil ,
}

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextLabel

local TextLabel = Instance.new("TextLabel")
TextLabel.AnchorPoint = Vec2new(0.5, 0.5)
TextLabel.Active = false
TextLabel.Archivable = false
TextLabel.AutoLocalize = false
TextLabel.BackgroundColor3 = fromRGB(248, 248, 248)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = fromRGB(17, 17, 17)
TextLabel.BorderMode = Enum.BorderMode.Outline
TextLabel.BorderSizePixel = 0
TextLabel.ClipsDescendants = false
TextLabel.Font = Enum.Font.SourceSans
TextLabel.LayoutOrder = 6
TextLabel.LineHeight = 1
TextLabel.MaxVisibleGraphemes = -1
TextLabel.Name = "Credits"
TextLabel.Position = UD2new(0.5, 0, 1, -100)
TextLabel.RichText = false
TextLabel.Rotation = 0
TextLabel.Selectable = false
TextLabel.Size = UD2new(0.401, 0, 0.061, 0)
TextLabel.Text = string.format("GameSense Rewritten [%s] | shawnjbragdon#0001", GameSense().Version)
TextLabel.TextColor3 = fromRGB(248, 248, 248)
TextLabel.TextScaled = true
TextLabel.TextSize = 16
TextLabel.TextStrokeColor3 = fromRGB(17, 17, 17)
TextLabel.TextStrokeTransparency = 0.6
TextLabel.TextTruncate = Enum.TextTruncate.None
TextLabel.TextWrapped = true
TextLabel.TextXAlignment = Enum.TextXAlignment.Center
TextLabel.TextYAlignment = Enum.TextYAlignment.Center
TextLabel.Visible = true
TextLabel.ZIndex = 50
TextLabel.Parent = ScreenGui

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextLabel

local ImageLabel = Instance.new("ImageLabel")
ImageLabel.Active = false
ImageLabel.AnchorPoint = Vec2new(0.5, 0.5)
ImageLabel.Archivable = false
ImageLabel.AutoLocalize = false
ImageLabel.AutomaticSize = Enum.AutomaticSize.None
ImageLabel.BackgroundColor3 = fromRGB(248, 248, 248)
ImageLabel.BackgroundTransparency = 1
ImageLabel.BorderColor3 = fromRGB(17, 17, 17)
ImageLabel.BorderMode = Enum.BorderMode.Outline
ImageLabel.BorderSizePixel = 0
ImageLabel.ClipsDescendants = false
ImageLabel.Image = "rbxassetid://324848180"
ImageLabel.ImageRectOffset = Vec2new(0, 0)
ImageLabel.ImageColor3 = fromRGB(255, 64, 64)
ImageLabel.ImageRectSize = Vec2new(0, 0)
ImageLabel.ImageTransparency = 0.9
ImageLabel.LayoutOrder = 6
ImageLabel.Name = "FovGui"
ImageLabel.Position = UD2new(0.5, 0, 0.5, 0)
ImageLabel.Rotation = 0
ImageLabel.ScaleType = Enum.ScaleType.Fit
ImageLabel.Selectable = false
ImageLabel.Size = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2)
ImageLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
ImageLabel.Visible = true
ImageLabel.ZIndex = 100
ImageLabel.Parent = ScreenGui

local TextLabel = Instance.new("TextLabel")
TextLabel.Active = false
TextLabel.AnchorPoint = Vec2new(0, 0)
TextLabel.AutoLocalize = Enum.AutomaticSize.None
TextLabel.BackgroundColor3 = fromRGB(17, 17, 17)
TextLabel.BackgroundTransparency = 1
TextLabel.BorderColor3 = fromRGB(17, 17, 17)
TextLabel.BorderMode = Enum.BorderMode.Outline
TextLabel.BorderSizePixel = 0
TextLabel.LayoutOrder = 6
TextLabel.Name = "Indicator"
TextLabel.Position = UD2new(0.5, 0, 0.75, 0)
TextLabel.Rotation = 0
TextLabel.Selectable = false
TextLabel.Size = UD2new(0, 0, 0, 0)
TextLabel.SizeConstraint = Enum.SizeConstraint.RelativeXY
TextLabel.Visible = true
TextLabel.ZIndex = 1
TextLabel.Archivable = false
TextLabel.ClipsDescendants = false
TextLabel.Font = Enum.Font.SourceSans
TextLabel.LineHeight = 1
TextLabel.MaxVisibleGraphemes = -1
TextLabel.RichText = false
TextLabel.Text = "{Sensitivity}"
TextLabel.TextColor3 = fromRGB(255, 255, 255)
TextLabel.TextScaled = false
TextLabel.TextSize = 14
TextLabel.TextStrokeColor3 = fromRGB(17, 17, 17)
TextLabel.TextStrokeTransparency = 0.75
TextLabel.TextTransparency = 0
TextLabel.TextTruncate = Enum.TextTruncate.None
TextLabel.TextWrapped = false
TextLabel.TextXAlignment = Enum.TextXAlignment.Center
TextLabel.TextYAlignment = Enum.TextYAlignment.Center
TextLabel.AutoLocalize = false
TextLabel.Parent = ScreenGui:WaitForChild("FovGui")

local TextBox = Instance.new("TextBox")
TextBox.Name = "SensAdjust"
TextBox.Font = Enum.Font.SourceSans
TextBox.TextScaled = true
TextBox.TextWrapped = true
TextBox.BackgroundTransparency = 0.75
TextBox.BackgroundColor3 = fromRGB(17, 17, 17)
TextBox.BorderColor3 = fromRGB(248, 248, 248)
TextBox.Size = UD2new(0, 50, 0, 20)
TextBox.TextTransparency = 0
TextBox.TextStrokeTransparency = 0.6
TextBox.TextColor3 = fromRGB(248, 248, 248)
TextBox.TextSize = 14
TextBox.PlaceholderText = "#"
TextBox.Text = tonumber(setting.sens)
TextBox.Position = UD2new(0.5, 0, 1, -80)
TextBox.Parent = ScreenGui

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextBox.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextBox

local TextLabel = Instance.new("TextLabel")
TextLabel.Name = "SensLabel"
TextLabel.Font = Enum.Font.SourceSans
TextLabel.TextScaled = true
TextLabel.TextWrapped = true
TextLabel.Size = UD2new(1, 0, 1, 0)
TextLabel.BackgroundTransparency = 1
TextLabel.TextSize = 14
TextLabel.TextColor3 = fromRGB(248, 248, 248)
TextLabel.TextStrokeColor3 = fromRGB(17, 17, 17)
TextLabel.TextStrokeTransparency = 0.6
TextLabel.Text = "Sens:"
TextLabel.Position = UD2new(-1, 0, 0, 0)
TextLabel.TextXAlignment = Enum.TextXAlignment.Left
TextLabel.Parent = TextBox

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextLabel

local TextBox = TextBox:Clone()
TextBox.PlaceholderText = "FOV"
TextBox.Name = "FovAdjust"
TextBox.Text = tonumber(setting.fov)
TextBox.Position = ScreenGui.SensAdjust.Position + UD2new(0, 0, 0, 20)
TextBox["SensLabel"].Name = "FovLabel"
TextBox["FovLabel"].Text = "Fov:"
TextBox.Parent = ScreenGui

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextBox

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextBox:FindFirstChildWhichIsA("TextLabel")

local TextBox = TextBox:Clone()
TextBox.PlaceholderText = "Drop"
TextBox.Name = "DropAdjust"
TextBox.Text = tonumber(setting.drop)
TextBox.Position = ScreenGui.FovAdjust.Position + UD2new(0, 0, 0, 20)
TextBox["FovLabel"].Name = "DropLabel"
TextBox["DropLabel"].Text = "Drop:"
TextBox.Parent = ScreenGui

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextBox

local UITextSizeConstraint = Instance.new("UITextSizeConstraint")
UITextSizeConstraint.Archivable = false
UITextSizeConstraint.MaxTextSize = TextLabel.TextSize
UITextSizeConstraint.MinTextSize = 1
UITextSizeConstraint.Name = "UITextSizeConstraint"
UITextSizeConstraint.Parent = TextBox:FindFirstChildWhichIsA("TextLabel")

local fovgui = ScreenGui["FovGui"]
local indicator = fovgui["Indicator"]
local rainbow = fromRGB(0, 0, 0)

table.insert(shared.gamesense, ScreenGui.SensAdjust.Focused:Connect(function()
	ScreenGui.SensAdjust:SetAttribute("LastTextValue", ScreenGui.SensAdjust.Text)	
end))

table.insert(shared.gamesense, ScreenGui.SensAdjust.FocusLost:Connect(function()
	if tonumber(ScreenGui.SensAdjust.Text) then
		ScreenGui.SensAdjust.Text = tonumber(ScreenGui.SensAdjust.Text)
		setting.sens = tonumber(ScreenGui.SensAdjust.Text)
		game:GetService("TweenService"):Create(fovgui, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
			["Size"] = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2) ;
		}):Play()
		GameSense:DisplayMessage(string.format("Adjusted Sensitivity to %s", setting.sens), 2)
		return
	end
	ScreenGui.SensAdjust.Text = ScreenGui.SensAdjust:GetAttribute("LastTextValue")
end))

table.insert(shared.gamesense, ScreenGui.FovAdjust.Focused:Connect(function()
	ScreenGui.FovAdjust:SetAttribute("LastTextValue", ScreenGui.FovAdjust.Text)	
end))

table.insert(shared.gamesense, ScreenGui.FovAdjust.FocusLost:Connect(function()
	if tonumber(ScreenGui.FovAdjust.Text) then
		ScreenGui.FovAdjust.Text = tonumber(ScreenGui.FovAdjust.Text)
		setting.fov = tonumber(ScreenGui.FovAdjust.Text)
		coroutine.wrap(function()
			local Tween = game:GetService("TweenService"):Create(fovgui, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
				["Size"] = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2) ;
			})
			Tween:Play()
			Tween.Completed:Wait()
		end)()
		return
	end
	ScreenGui.FovAdjust.Text = ScreenGui.FovAdjust:GetAttribute("LastTextValue")
end))

table.insert(shared.gamesense, ScreenGui["DropAdjust"].Focused:Connect(function()
	ScreenGui["DropAdjust"]:SetAttribute("LastTextValue", ScreenGui["DropAdjust"].Text)	
end))

table.insert(shared.gamesense, ScreenGui["DropAdjust"].FocusLost:Connect(function()
	if tonumber(ScreenGui["DropAdjust"].Text) then
		ScreenGui["DropAdjust"].Text = tonumber(ScreenGui["DropAdjust"].Text)
		setting.drop = tonumber(ScreenGui["DropAdjust"].Text)
		return
	end
	ScreenGui["DropAdjust"].Text = ScreenGui["DropAdjust"]:GetAttribute("LastTextValue")
end))

local SoundGroup = Instance.new("SoundGroup")
SoundGroup.Name = "GameSenseSoundEffects"
SoundGroup.Parent = ScreenGui

function GameSense:PlayLocalSound(SoundId)
	if setting.hideui == false then
		local Sound = Instance.new("Sound")
		Sound.Archivable = false
		Sound.Looped = false
		Sound.Name = "Sound"
		Sound.Parent = CoreGui
		Sound.PlaybackSpeed = 1
		Sound.Playing = false
		Sound.PlayOnRemove = true
		Sound.SoundGroup = SoundGroup
		Sound.SoundId = string.format("rbxassetid://%s", tostring(SoundId))
		Sound.Volume = 1
		Sound:Destroy()
	end
end

GameSense:PlayLocalSound(1168009121)
local DefaultIcon = playermouse and playermouse.Icon or ""

table.insert(shared.gamesense, RunService.RenderStepped:Connect(function()
	if setting.hideui == true then
		ScreenGui.Enabled = false
		SoundGroup.Volume = 0
		if playermouse then
			playermouse.Icon = DefaultIcon
		end
		UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.None
	else
		ScreenGui.Enabled = true
		if playermouse then
			playermouse.Icon = string.format("rbxassetid://%s", "18671553")
		end
		SoundGroup.Volume = 0.5
		UserInputService.OverrideMouseIconBehavior = Enum.OverrideMouseIconBehavior.ForceShow
	end
end))

local function getenemychars()
	local l = {}
	if setting.ffa then
		for _, player in pairs(Players:GetPlayers()) do
			if player ~= localplayer then
				local character = player.Character
				local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
				if not phantomforces and humanoid and humanoid.Health > 0 then
					table.insert(l, character)
				elseif phantomforces and phantomforces.hud:getplayerhealth(player) > 0 then
					table.insert(l, character)
				end
			end
		end
	else
		local lt = localplayer.Team
		for _, player in pairs(Players:GetPlayers()) do
			local character
			if phantomforces then
				local char = phantomforces.characters[player]
				if char and typeof(rawget(char, "head")) == "Instance" then
					character = char.head.Parent
				end
			end
			local team = player.Team
			if not character then
				character = player.Character
			end
			local humanoid = character and character:FindFirstChildWhichIsA("Humanoid")
			if lt ~= team then
				if not phantomforces and humanoid and humanoid.Health > 0 then
					table.insert(l, character)
				elseif phantomforces and phantomforces.hud:getplayerhealth(player) > 0 then
					table.insert(l, character)
				end
			end
		end
	end
	return l
end

local function getnearest()
	if not playermouse then
		return
	end
	local Nearest = {
		["Distance"] = 999 ;
		["Character"] = nil ;
	}
	GameSense.Target.Character = nil
	for _, character in pairs(getenemychars()) do
		if localplayer.Character and character and character:FindFirstChild("Head") then
			local Position = currentCamera:WorldToScreenPoint(character["Head"].Position)
			local Distance = (Vec2new(playermouse.X, playermouse.Y) - Vec2new(Position.X, Position.Y)).Magnitude
			if Distance <= currentCamera.ViewportSize.X / (90 / setting.fov) and Distance < Nearest.Distance then
				local Humanoid = character:FindFirstChildWhichIsA("Humanoid")
				if Humanoid then
					if Humanoid.Health <= 0 then
						continue
					end
				end
				local hit = workspace:FindPartOnRayWithIgnoreList(Ray.new(currentCamera.CFrame.Position, (character["Head"].CFrame.Position - currentCamera.CFrame.Position).Unit * 2048), {
					workspace.CurrentCamera,
					localplayer.Character,
				})
				if hit and typeof(hit) == "Instance" and hit:IsDescendantOf(character) then
					Nearest.Distance = Distance
					Nearest.Character = character
				end
			end
		end
	end
	return Nearest
end

task.spawn(function()
	while true do
		task.wait(1 / 30)
		if setting.uianim == true then
			rainbow = fromHSV(tick() % 5 / 5, 0.65, 1)
		else
			rainbow = fromRGB(255, 255, 255)
		end
		indicator.TextColor3 = rainbow
		fovgui.ImageColor3 = rainbow
		if ScreenGui["Status"]:GetAttribute("UsingDisplayMessage") ~= true then
			if phantomforces and GameSense.Target and GameSense.Target.Character and setting.aba and MouseButtonsDown.MouseButton2 then
				ScreenGui["Status"].Text = string.format("Aiming @ %s", GameSense.Target.Character:GetFullName())
				ScreenGui["Status"].TextColor3 = setting.hudtheme.tlockedcol
			elseif phantomforces and GameSense.Target and GameSense.Target.Player and GameSense.Target.Character and setting.aba and MouseButtonsDown.MouseButton2 then
				ScreenGui["Status"].Text = string.format("Aiming @ %s", GameSense.Target.Player.DisplayName)
				ScreenGui["Status"].TextColor3 = setting.hudtheme.tlockedcol
			else
				ScreenGui["Status"].Text = ("On Standby")
				ScreenGui["Status"].TextColor3 = rainbow
			end
		end
	end
end)

playermouse.Move:Connect(function()
	local Cursor = ScreenGui:FindFirstChild("Cursor") or Instance.new("Frame", ScreenGui)
	Cursor.AnchorPoint = Vec2new(0.5, 0.5)
	Cursor.Name = "Cursor"
	Cursor.BackgroundColor3 = rainbow or fromRGB(248, 248, 248)
	Cursor.BackgroundTransparency = 0.5
	Cursor.BorderSizePixel = 1
	Cursor.BackgroundColor3 = fromRGB(248, 248, 248)
	Cursor.Rotation = 45
	Cursor.Size = UD2new(0, 2, 0, 2)
	Cursor.Position = UD2new(UDnew(0, playermouse.X), UDnew(0, playermouse.Y))

	fovgui.Position = UD2new(UDnew(0, playermouse.X), UDnew(0, playermouse.Y))
end)

table.insert(shared.gamesense, UserInputService.InputBegan:Connect(function(InputObject, GameProcessedEvent)
	if InputObject.UserInputType == Enum.UserInputType.Keyboard then
		if InputObject.KeyCode == setting.keybinds.abtogkey then
			setting.aba = not setting.aba
			GameSense:PlayLocalSound(140910211)
			if setting.aba == true then
				GameSense:DisplayMessage("Aimbot <b>Enabled</b>", 2, {
					["TextColor3"] = fromRGB(94, 255, 94),
					["TextStrokeColor3"] = fromRGB(18, 49, 18),
				})
			else
				GameSense:DisplayMessage("Aimbot <b>Disabled</b>", 2, {
					["TextColor3"] = fromRGB(255, 94, 89),
					["TextStrokeColor3"] = fromRGB(49, 18, 18),
				})
			end
		elseif InputObject.KeyCode == setting.keybinds["FreeForAllToggleKey"] then
			setting.ffa = not setting.ffa
			GameSense:PlayLocalSound(140910211)
			if setting.ffa == true then
				GameSense:DisplayMessage("Targeting players on <b>all teams</b>.", 2, {
					["TextColor3"] = fromRGB(255, 200, 90),
					["TextStrokeColor3"] = fromRGB(49, 47, 17),
				})
			else
				GameSense:DisplayMessage("Targeting players on <b>opposing teams</b>.", 2, {
					["TextColor3"] = fromRGB(255, 200, 90),
					["TextStrokeColor3"] = fromRGB(49, 47, 17),
				})
			end
		elseif InputObject.KeyCode == setting.keybinds.esptogkey then
			setting.esp = not setting.esp
			GameSense:PlayLocalSound(140910211)
			if setting.esp == true then
				if setting.esp == true then
					GameSense:DisplayMessage("Extra-Sensory Perception is tracking <b>all players</b>.", 2, {
						["TextColor3"] = fromRGB(94, 255, 94),
						["TextStrokeColor3"] = fromRGB(18, 49, 18),
					})
				else
					GameSense:DisplayMessage("Extra-Sensory Perception is tracking <b>opposing teams</b>.", 2, {
						["TextColor3"] = fromRGB(94, 255, 94),
						["TextStrokeColor3"] = fromRGB(18, 49, 18),
					})
				end
			else
				GameSense:DisplayMessage("You\'re no longer tracking players.", 2, {
					["TextColor3"] = fromRGB(255, 94, 89),
					["TextStrokeColor3"] = fromRGB(49, 18, 18),
				})
			end
		elseif InputObject.KeyCode == setting.keybinds.chfontkey then
			local i = ScreenGui:GetAttribute("CurrentFont") or Enum.Font.SourceSans.Value
			for _, GuiObject in pairs(ScreenGui:GetDescendants()) do
				if GuiObject:IsA("TextLabel") or GuiObject:IsA("TextBox") then
					GuiObject.Font = Enum.Font:GetEnumItems()[i + 1]
				end
			end
			ScreenGui:SetAttribute("CurrentFont", i)
		elseif InputObject.KeyCode == setting.keybinds.uivisiblekey then
			setting.hideui = not setting.hideui
		elseif InputObject.KeyCode == setting.keybinds["SensIncreaseKey"] then
			setting.sens = setting.sens + 0.05
			ScreenGui.SensAdjust.Text = tonumber(setting.sens)
			GameSense:DisplayMessage(string.format("Added <b>%s</b> to overall sensitivity.", 0.05), 2, {
				["TextColor3"] = fromRGB(255, 200, 90),
				["TextStrokeColor3"] = fromRGB(49, 47, 17),
			})
		elseif InputObject.KeyCode == setting.keybinds["SensDecreaseKey"] then
			setting.sens = setting.sens - 0.05
			ScreenGui.SensAdjust.Text = tonumber(setting.sens)
			GameSense:DisplayMessage(string.format("Subtracted <b>%s</b> to overall sensitivity.", 0.05), 2, {
				["TextColor3"] = fromRGB(255, 200, 90),
				["TextStrokeColor3"] = fromRGB(49, 47, 17),
			})
		elseif InputObject.KeyCode == setting.keybinds["FOVIncreaseKey"] then
			setting.fov = setting.fov + 0.05
			ScreenGui.FovAdjust.Text = tonumber(setting.fov)
			coroutine.wrap(function()
				local Tween = game:GetService("TweenService"):Create(fovgui, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
					["Size"] = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2) ;
				})
				Tween:Play()
				Tween.Completed:Wait()
			end)()
			GameSense:DisplayMessage(string.format("Added <b>%s</b> to overall field of view.", 0.05), 2, {
				["TextColor3"] = fromRGB(255, 200, 90),
				["TextStrokeColor3"] = fromRGB(49, 47, 17),
			})
		elseif InputObject.KeyCode == setting.keybinds["FOVDecreaseKey"] then
			setting.fov = setting.fov - 0.05
			ScreenGui.FovAdjust.Text = tonumber(setting.fov)
			coroutine.wrap(function()
				local Tween = game:GetService("TweenService"):Create(fovgui, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
					["Size"] = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2) ;
				})
				Tween:Play()
				Tween.Completed:Wait()
			end)()
			GameSense:DisplayMessage(string.format("Subtracted <b>%s</b> from overall field of view.", 0.05), 2, {
				["TextColor3"] = fromRGB(255, 200, 90),
				["TextStrokeColor3"] = fromRGB(49, 47, 17),
			})
		end
		return
	elseif InputObject.UserInputType == Enum.UserInputType.MouseButton1 then
		if fovgui.Visible then
			coroutine.wrap(function()
				local Tween = game:GetService("TweenService"):Create(fovgui, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
					["Size"] = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2.35, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2.35) ;
				})
				Tween:Play()
				Tween.Completed:Wait()
				local Tween = game:GetService("TweenService"):Create(fovgui, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.In, 0, false, 0), {
					["Size"] = UD2new(0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2, 0, (currentCamera.ViewportSize.X / (90 / setting.fov)) * 2) ;
				})
				Tween:Play()
				Tween.Completed:Wait()
			end)()
		end
		return
	elseif InputObject.UserInputType == Enum.UserInputType.MouseButton2 then
		MouseButtonsDown.MouseButton2 = true
	end
end))

table.insert(shared.gamesense, UserInputService.InputEnded:Connect(function(InputObject)
	if InputObject and InputObject.UserInputType == Enum.UserInputType.MouseButton2 then
		MouseButtonsDown.MouseButton2 = false
	end
end))

local headlockframe
local currentcolor = fromRGB(248, 248, 248)
local highlights = {}
local hfolder = Instance.new('Folder', ScreenGui)

RunService.Heartbeat:Connect(function()
	if setting["AimPriority"] == 1 then
		indicator.Text = ("{Sensitivity}\n{Aiming}")
	elseif setting["AimPriority"] == 2 then
		indicator.Text = string.format("FOV: %s\n{Sensitivity}\n{Aiming}", tostring(setting.fov))
	end
	indicator.Text = s_gsub(indicator.Text, "{Sensitivity}", string.format("Sensitivity: %s", tostring(setting.sens)))
	if MouseButtonsDown.MouseButton2 == true and setting.aba == true then
		local Nearest = getnearest()
		if Nearest and typeof(Nearest) == "table" and Nearest.Character then
			local Head = Nearest.Character:FindFirstChild("Head") or Nearest.Character:FindFirstChild("Torso") or Nearest.Character:FindFirstChild("HumanoidRootPart")
			local HeadPosition, IsInBounds = currentCamera:WorldToScreenPoint(Nearest.Character["Head"].Position + Vec3new(0, Nearest.Distance / (100 / setting.drop), 0))
			local PredictedMousePosition = Vec2new((HeadPosition.X - playermouse.X) * setting.sens, (HeadPosition.Y - playermouse.Y) * setting.sens)
			if IsInBounds == true then
				pcall(function()
					if setting.hideui ~= true then
						headlockframe = ScreenGui:FindFirstChild("AimPos") or Instance.new('Frame')
						if not ScreenGui:FindFirstChild("AimPos") then
							headlockframe.Name = "AimPos"
							headlockframe.BorderSizePixel = 1
							headlockframe.BorderColor3 = fromRGB(17, 17, 17)
							headlockframe.BackgroundTransparency = 0
							headlockframe.BackgroundColor3 = fromRGB(248, 248, 248)
							headlockframe.Rotation = 45
							headlockframe.ZIndex = 4
							headlockframe.Size = UD2new(0, 3, 0, 3)
							headlockframe.Parent = ScreenGui
						end
						headlockframe.Position = UD2new(0, HeadPosition.X - headlockframe.AbsoluteSize.X / 2, 0, HeadPosition.Y - headlockframe.AbsoluteSize.Y / 2)
						headlockframe.Visible = true
					end
				end)
				mousemoverel(PredictedMousePosition.X, PredictedMousePosition.Y)
				GameSense.Target.Character = Nearest.Character
			end
		end
		indicator.Text = s_gsub(indicator.Text, "\n{Aiming}", "\nAiming")
	else
		GameSense.Target.Character = nil
		if headlockframe then headlockframe.Visible = false end
		indicator.Text = s_gsub(indicator.Text, "\n{Aiming}", "")
	end
	if setting.esp and setting.hideui ~= true then
		local enemies = getenemychars()
		for i, highlight in pairs(highlights) do
			if table.find(enemies, highlight.Adornee) then
				continue
			end
			highlight:Destroy()
			highlights[i] = nil
		end
		for _, character in pairs(enemies) do
			local head = character:FindFirstChild('Head')
			if typeof(head) == 'Instance' and head:IsA('BasePart') then
				local obscuringparts = {}
				local x = currentCamera:GetPartsObscuringTarget({currentCamera.CFrame.Position, head.Position}, {character, localplayer.Character, currentCamera})
				if typeof(phantomforces) ~= 'nil' then
					for _, part in pairs(x) do
						if typeof(part) == 'Instance' and part:IsA('BasePart') and part.Name ~= 'Window' then
							table.insert(obscuringparts, part)
						end
					end
				else
					obscuringparts = x
				end
				currentcolor = (GameSense.Target.Character == character and setting.hudtheme.tlockedcol) or ((#obscuringparts <= 0 and setting.hudtheme.tinviewcol) or (#obscuringparts > 0 and setting.hudtheme.toutviewcol))
			end
			local debugid = character:GetDebugId()
			local h = highlights[debugid]
			if h then
				h.FillColor = currentcolor
				h.OutlineColor = currentcolor
			else
				h = Instance.new('Highlight')
				h.Name = debugid
				h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
				h.Adornee = character
				h.FillColor = currentcolor
				h.OutlineColor = currentcolor
				h.Enabled = true
				h.Parent = hfolder
				highlights[debugid] = h
			end
		end
	else
		for i, highlight in pairs(highlights) do
			highlight:Destroy()
			highlights[i] = nil
		end
	end
end)
