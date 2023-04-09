local success, response = pcall(function()
    print(Nebula.Version)	
end)

if not success then
	Nebula =
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Extorius/Nebula-Library/main/src/library.lua"))({
			["Developer-Mode"] = true,
			["Anti-Cheat"] = {
				["Spoof"] = {
					["Position"] = false,
					["CFrame"] = false,
					["WalkSpeed"] = true,
					["JumpPower"] = true,
					["Gravity"] = true,
				},
				["Disable-Connections"] = {
					["DescendantAdded"] = true,
					["ChildAdded"] = true,
					["ChildRemoved"] = true,
					["DescendantRemoving"] = true,
					["WalkSpeed"] = true,
					["JumpPower"] = true,
				},
			},
		})
end

local defaults = {
	WalkSpeed = Nebula.F:Humanoid().WalkSpeed,
	JumpPower = Nebula.F:Humanoid().JumpPower,
	Gravity = Nebula.Workspace.Gravity,
}

local Settings = {
	Aimbot = {
		Range = 1000,
		FOV = 250,
		ClosestMethod = "character",
		WallCheck = true,
		FriendCheck = true,
		TeamCheck = true,
		FOVCircle = nil,
		AimingMethod = "smooth",
		MagPrediction = false,
		GravityPrediction = true,
	},
	ESP = {
		From = "bottom",
		TeamCheck = true,
		FriendCheck = true,
		Color = Color3.fromRGB(255, 0, 0),
	},
	InfiniteJump = {
		Enabled = false,
	},
}

local function CreateFOV()
	local Circle = Drawing.new("Circle")
	Circle.Radius = Settings.Aimbot.FOV
	Circle.Thickness = 1
	Circle.NumSides = 32
	Circle.Visible = true
	Circle.Color = Color3.fromRGB(255, 255, 255)
	Settings.Aimbot.FOVCircle = Circle
end

local function UpdateFOV()
	if not Settings.Aimbot.FOVCircle then
		CreateFOV()
	end

	local Circle = Settings.Aimbot.FOVCircle
	Circle.Position = Vector2.new(Nebula.Mouse.X, Nebula.Mouse.Y)
	Circle.Radius = Settings.Aimbot.FOV
end

local function DestroyFOV()
	if Settings.Aimbot.FOVCircle then
		Settings.Aimbot.FOVCircle:Destroy()
		Settings.Aimbot.FOVCircle = nil
	end
end

local function Aimbot()
	local Closest = Nebula.F:GetClosest(
		Settings.Aimbot.TeamCheck,
		Settings.Aimbot.FriendCheck,
		Settings.Aimbot.WallCheck,
		Settings.Aimbot.ClosestMethod,
		Settings.Aimbot.FOV,
		Settings.Aimbot.Range
	)

	if Closest then
		local Head = Closest.Character.Head
		local AimAt = Head.Position

		if Settings.Aimbot.MagPrediction then
			AimAt = AimAt + Head.Velocity / (Nebula.F:Root().Position - AimAt).Magnitude
		end

		if Settings.Aimbot.AimingMethod == "snap" then
			Nebula.Camera.CFrame = CFrame.new(Nebula.Camera.CFrame.Position, Closest.Character.Head.Position)
		else
			local Delay = (Nebula.Camera.CFrame.Position - Closest.Character.Head.Position).Magnitude
			local Tween = Nebula.Tween:Create(
				Nebula.Camera,
				TweenInfo.new(Delay / 400),
				{ CFrame = CFrame.new(Nebula.Camera.CFrame.Position, Closest.Character.Head.Position) }
			)
			Tween:Play()
		end
	end
end

local Tracers = {}
local function ESP()
	for i, v in pairs(Nebula.Players:GetPlayers()) do
		if v ~= Nebula.LocalPlayer then
			local CanContinue = true

			if Settings.ESP.FriendCheck and Nebula.LocalPlayer:IsFriendsWith(v.UserId) then
				CanContinue = false
			end

			if Settings.ESP.TeamCheck and v.Team == Nebula.LocalPlayer.Team and CanContinue then
				CanContinue = false
			end

			if CanContinue then -- i know pretty much all of this is bad practice but i made this part in a rush
				local Tracer = Nebula.ESP:CreateTracer(Settings.ESP.Color)
				pcall(function()
					Nebula.ESP:UpdateTracer(Tracer, Settings.ESP.From, v)
					Nebula.RunService.RenderStepped:Wait()
				end)

				Tracer:Destroy()
			end
		end
	end
end

local function Noclip()
	local Character = Nebula.F:Character()()
	for i, v in pairs(Character:GetChildren()) do
		if v:IsA("BasePart") then
			v.CanCollide = false
		end
	end
end

local function Jump()
	local Humanoid = Nebula.F:Humanoid()
	Humanoid.Jump = true
end

local function Spin(int)
	local Root = Nebula.F:Root()
	local Bodythrust = Root:FindFirstChildOfClass("BodyThrust")
	if int > 1 then
		if not Bodythrust then
			Bodythrust = Instance.new("BodyThrust")
		end

		Bodythrust.Parent = Root
		Bodythrust.Location = Root.Position
		Bodythrust.Force = Vector3.new(int, 0, 0)
	else
		if Bodythrust then
			Bodythrust:Destroy()
		end
	end
end

Nebula.UserInput.JumpRequest:Connect(function()
	if Settings.InfiniteJump.Enabled then
		Nebula.F:Humanoid():ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

local AimbotLoop = Nebula.L:CreateLoop(Aimbot)
local FOVLoop = Nebula.L:CreateLoop(UpdateFOV, CreateFOV, DestroyFOV)
local ESPLoop = Nebula.L:CreateLoop(ESP)
local NoclipLoop = Nebula.L:CreateLoop(Noclip)
local BhopLoop = Nebula.L:CreateLoop(Jump)

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/shlexware/Rayfield/main/source"))()
local Window = Rayfield:CreateWindow({
	Name = "Nebula",
	LoadingTitle = "Nebula Development Library",
	LoadingSubtitle = "by Extorius Scripts",
	ConfigurationSaving = {
		Enabled = false,
		FolderName = nil, -- Create a custom folder for your hub/game
		FileName = "Big Hub",
	},
	Discord = {
		Enabled = false,
		Invite = "noinvitelink", -- The Discord invite code, do not include discord.gg/. E.g. discord.gg/ABCD would be ABCD.
		RememberJoins = true, -- Set this to false to make them join the discord every time they load it up
	},
	KeySystem = false, -- Set this to true to use our key system
	KeySettings = {
		Title = "Sirius Hub",
		Subtitle = "Key System",
		Note = "Join the discord (discord.gg/sirius)",
		FileName = "SiriusKey",
		SaveKey = true,
		GrabKeyFromSite = false, -- If this is true, set Key below to the RAW site you would like Rayfield to get the key from
		Key = "Hello",
	},
})

local Tab = Window:CreateTab("Aimbot")
local Section = Tab:CreateSection("Configure")
local Keybind = Tab:CreateKeybind({
	Name = "Enable",
	CurrentKeybind = "Q",
	HoldToInteract = false,
	Flag = "Keybind1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Keybind)
		AimbotLoop:toggle()
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "See FOV",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		FOVLoop:toggle()
	end,
})

local Slider = Tab:CreateSlider({
	Name = "FOV",
	Range = { 50, 1000 },
	Increment = 10,
	Suffix = "Pixels",
	CurrentValue = 250,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.Aimbot.FOV = Value
	end,
})
local Slider = Tab:CreateSlider({
	Name = "Range",
	Range = { 0, 1000 },
	Increment = 10,
	Suffix = "Studs",
	CurrentValue = 1000,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.Aimbot.Range = Value
	end,
})

local Dropdown = Tab:CreateDropdown({
	Name = "Closest Method",
	Options = { "character", "cursor" },
	CurrentOption = "character",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Option)
		Settings.Aimbot.ClosestMethod = Option
	end,
})
local Dropdown = Tab:CreateDropdown({
	Name = "Aiming Method",
	Options = { "smooth", "snap" },
	CurrentOption = "smooth",
	Flag = "Dropdown1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Option)
		Settings.Aimbot.AimingMethod = Option
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Team Check",
	CurrentValue = true,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.Aimbot.TeamCheck = Value
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Friend Check",
	CurrentValue = true,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.Aimbot.FriendCheck = Value
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Wall Check",
	CurrentValue = true,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.Aimbot.WallCheck = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Magnitude Prediction",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.Aimbot.MagPrediction = Value
	end,
})

local Tab = Window:CreateTab("ESP")
local Section = Tab:CreateSection("Tracers")

local Toggle = Tab:CreateToggle({
	Name = "Enable",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		ESPLoop:toggle()
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Team Check",
	CurrentValue = true,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.ESP.TeamCheck = Value
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Friend Check",
	CurrentValue = true,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.ESP.FriendCheck = Value
	end,
})
local ColorPicker = Tab:CreateColorPicker({
	Name = "Color",
	Color = Color3.fromRGB(255, 0, 0),
	Flag = "ColorPicker1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.ESP.Color = Value
	end,
})

local Tab = Window:CreateTab("Character")
local Section = Tab:CreateSection("Sliders")

local current = defaults
current.SpinBot = 0

local function UpdateSliders()
	local Humanoid = Nebula.F:Humanoid()
	Humanoid.WalkSpeed = current.WalkSpeed
	Humanoid.JumpPower = current.JumpPower
	Nebula.Workspace.Gravity = current.Gravity
	Spin(current.Spinbot)
end

local UpdateLoop = Nebula.L:CreateLoop(UpdateSliders)

local Slider = Tab:CreateSlider({
	Name = "Walk Speed",
	Range = { math.round(defaults.WalkSpeed), math.round(defaults.WalkSpeed * 20) },
	Increment = math.round(defaults.WalkSpeed),
	Suffix = "Studs / Second",
	CurrentValue = math.round(defaults.WalkSpeed),
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		current.WalkSpeed = Value
		Nebula.F:Humanoid().WalkSpeed = Value
	end,
})
local Slider = Tab:CreateSlider({
	Name = "Jump Power",
	Range = { math.round(defaults.JumpPower), math.round(defaults.JumpPower * 5) },
	Increment = math.round(defaults.JumpPower),
	Suffix = "Jumping Power",
	CurrentValue = math.round(defaults.JumpPower),
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		current.JumpPower = Value
		Nebula.F:Humanoid().JumpPower = Value
	end,
})
local Slider = Tab:CreateSlider({
	Name = "Gravity",
	Range = { 0, math.round(math.abs(defaults.Gravity) * 10) },
	Increment = math.round(defaults.Gravity),
	Suffix = "Gravity Power",
	CurrentValue = math.round(defaults.Gravity),
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		current.Gravity = Value
		Nebula.Workspace.Gravity = Value
	end,
})
local Slider = Tab:CreateSlider({
	Name = "Spin Bot",
	Range = { 0, 150 },
	Increment = 10,
	Suffix = "Spin Speed",
	CurrentValue = 0,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Spin(Value)
		current.Spinbot = Value
	end,
})

local Toggle = Tab:CreateToggle({
	Name = "Loop Sliders",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		UpdateLoop:toggle()
	end,
})

local Section = Tab:CreateSection("Other")

local Toggle = Tab:CreateToggle({
	Name = "Infinite Jump",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Settings.InfiniteJump.Enabled = Value
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		NoclipLoop:toggle()
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Bhop",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		BhopLoop:toggle()
	end,
})

local Tab = Window:CreateTab("Misc")
local Section = Tab:CreateSection("Servers")

local Button = Tab:CreateButton({
	Name = "Serverhop",
	Callback = function()
		Nebula.F:Serverhop()
	end,
})

local Button = Tab:CreateButton({
	Name = "Rejoin",
	Callback = function()
		queue =
			"loadstring(game:HttpGet('https://raw.githubusercontent.com/Extorius/Nebula-Library/main/src/library.lua'))("
		queue = queue .. "{['Developer-Mode'] = false, ['Anti-Cheat'] = false})"

		local qot = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)

		qot(queue)
		Nebula.LocalPlayer:Kick("Rejoining")
		Nebula.Teleport:Teleport(game.PlaceId, Nebula.LocalPlayer, game.JobId)
	end,
})

local Section = Tab:CreateSection("Convenience")

local Toggle = Tab:CreateToggle({
	Name = "Anti Idle",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Nebula.F:AntiIdle(Value)
	end,
})
local Slider = Tab:CreateSlider({
	Name = "FPS Cap",
	Range = { 30, 240 },
	Increment = 10,
	Suffix = "Frames Per Second",
	CurrentValue = 60,
	Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		setfpscap(Value)
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Reduced Lag",
	CurrentValue = false,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Nebula.Workspace.StreamingEnabled = not Value
	end,
})
local Toggle = Tab:CreateToggle({
	Name = "Rendering Enabled",
	CurrentValue = true,
	Flag = "Toggle1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
	Callback = function(Value)
		Nebula.RunService:Set3dRenderingEnabled(Value)
	end,
})
