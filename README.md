# Info
Nebula is a LuaU Handicapped library designed for developers of all levels. With Nebula, you can easily reuse code across multiple scripts, minimize lines of code, and save time. Our intuitive functions and variables make it easy to write challenging code you enjoy, without having to memorize tons of names or syntax.

Nebula's all-in-one package includes features like GetClosest(), which can help you implement Aimbot in just 6 lines of code, and CreateTracer(), which simplifies ESP by allowing you to implement it in just 26 lines or less.

By using Nebula, you can focus on building great projects instead of writing easy and redundant code. Try Nebula today and see how it can help you take your LuaU Handicapped projects to the next level.

# Docs
## Environment

Nebula requires a LuaU Handicapped environment - more commonly known as a executor environment ([Synapse X](https://x.synapse.to), [Script-Ware](https://script-ware.com/), [Krnl](https://krnl.place/), [etc](https://whatexploitsare.online/))

This is because of the functions used by Nebula, and the general nature of the program. This means Nebula will **NOT** work in the following environments;

- `Lua 5.1` (5.1.5)
- `Lua 5.2` (5.2.4)
- `Lua 5.3` (5.3.6)
- `Lua 5.4` (5.4.4)
- `LuaU / Roblox Lua` (0.533)
- `Lua JIT` (2.0.5 & 2.1.0)
- `Etc`

Nebula **WILL** however work with the following environments;

- `Synapse X v2.0`
- `Synapse X v3.0`
- `Script-Ware Windows v2.0`
- `Script-Ware Mac v2.3`
- `Krnl Beta`
- `Krnl Legacy`
- `Fluxus v7.2`
- `Oxygen U v2.0`
- `Comet v3 GameKit` - not sure

## Booting

To boot Nebula, all you have to do is call a loadstring with a few passed parameters;
```lua
local Nebula = loadstring(game:HttpGet("https://raw.githubusercontent.com/Extorius/Nebula-Library/main/src/library.lua"))({
	["Developer-Mode"] = true, -- set this to false and Nebula will automatically load in a universal script
  	["Auto-Optimize"] = true, -- a really basic optimization system that replaces commonly known deprecated functions with their new counterparts, nothing fancy
	["Anti-Cheat"] = {
		["Spoof"] = { -- this spoofs values to always show as their original value
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
```

## Variables
### Services
```lua
Nebula.Players -- Players service
Nebula.Workspace -- Workspace service
Nebula.ReplicatedStorage -- ReplicatedStorage service
Nebula.Http -- Http service
Nebula.Tween -- Tween service
Nebula.CoreGui -- CoreGui service
Nebula.Pathfinding -- Pathfinding service
Nebula.RunService -- Run service
Nebula.Teleport -- Teleport service
Nebula.Network -- Network settings
Nebula.UserInput -- UserInput service
```

### Misc
```lua
Nebula.LocalPlayer -- The LocalPlayer
Nebula.HWID -- The HWID assigned to the user
Nebula.Camera -- Workspace's CurrentCamera
Nebula.Mouse -- LocalPlayer's Mouse
Nebula.Version -- The current version of Nebula
```

## Functions
### Core Lua Functions
These are functions that don't rely on Roblox specific utilities.

#### Print
This is just used for testing and debugging, and would be much more inefficient to use then a normal print().
```lua
Nebula.F:Print('Hello Nebula!')
--[[
Arguments:
> The argument to print (str, int, tbl, func, etc.)
   Required: ✅

Returns:
> Nothing
]]--
```

#### ClearCache
This function clears the Nebula cache.
```lua
Nebula.F:ClearCache()
--[[
Arguments:
> None

Returns:
> Nothing
]]--
```

#### JsonEncode
This is just a shortened version of Nebula.Http:JSONEncode().
```lua
Nebula.F:JsonEncode({[1] = 'I love Nebula!'})
--[[
Arguments:
> The table to convert to JSON (tbl)
   Required: ✅

Returns:
> The JSON encoded version of the table
]]--
```

#### JsonDecode
This is just a shortened version of Nebula.Http:JSONDecode().
```lua
Nebula.F:JsonDecode({'Nebula': 'Cool': true})
--[[
Arguments:
> The JSON to convert to table (json)
   Required: ✅

Returns:
> The JSON decoded version of the JSON
]]--
```

#### Descendants
This provides the descendants of a table.
```lua
Nebula.F:Descendants({
  ['First'] = {
    ['Second'] = {
      [1] = true,
      [2] = 'Nebula isa  great way to reduce lines and improve coding speed!'
    }
  }
})
--[[
Arguments:
> The table to get the descendants of (tbl)
   Required: ✅

Returns:
> The descendants of the table specified
]]--
```

#### CreateTimer
This function creates a timer for you that's useful for benchmarking and timing events.
```lua
local Timer = Nebula.F:CreateTimer()
Timer:Start() -- starts the timer
task.wait(1)
Timer:Pause() -- pauses the timer
task.wait(0.5)
Timer:Start() -- unpauses the timer
task.wait(1)
print(Timer:Elapsed()) -- prints the elapsed time
Timer:Stop() -- stops the timer (Timer:Start() can be used to start it again)
--[[
Arguments:
> None

Returns:
> A timer (tbl)
]]--
```

#### Round
This function rounds a number down to a specific decimal point.
```lua
Nebula.F:Round(1.234567890, 2) -- 1.23
--[[
Arguments:
> The number to round (int)
   Required: ✅

Returns:
> The rounded number (int)
]]--
```

#### FunctionSpy
Hooks a function so you can keep track of information such as when it was called and what arguments were passed.
```lua
Nebula.F:FunctionSpy(warn, true, true, print)
--[[
Arguments:
> The function to spy on (func)
   Required: ✅
> Whether to log the name or not (bool)
   Required: ❌
   Defaults to: true
> Whether to log the args or not (bool)
   Required: ❌
   Defaults to: true
> What function to call on during logs (func)
   Required: ❌
   Defaults to: print

Returns:
> Nothing
]]--
```

#### Compare
Compares two strings for matching characters and then returns the % of matching characters (1-100%).
```lua
Nebula.F:Compare('Hello', 'world!')
--[[
Arguments:
> The first string to compare (str)
   Required: ✅
> The second string to compare (str)
   Required: ✅

Returns:
> The % of matching characters (int)
]]--
```

#### Gaurded Call
Clones a function and attempts to dehook it before calling it. It is not recommended to use this for anything that requires much security.
```lua
Nebula.F:GuardedCall(print, table.unpack({1, 'Hello world!', 2, 'Goodbye world!'}))
--[[
Arguments:
> The function to call (func)
   Required: ✅
> The arguments to pass (args)
   Required: ✅
   
Returns:
> Whatever the function returns after being called (args)
]]--
```

#### RandomString
Generates a random string with your specified length and characters.
```lua
Nebula.F:RandomString(100, true, true, true, true)
--[[
Arguments:
> The length of the string (int)
   Required: ❌
   Defaults To: 10
> Use lowercase letters? (bool)
   Required: ❌
   Defaults To: true
> Use uppercase letters? (bool)
   Required: ❌
   Defaults To: true
> Use numbers? (bool)
   Required: ❌
   Defaults To: true
> Use special characters? (bool)
   Required: ❌
   Defaults To: true
   
Returns:
> A random string (str)
]]--
```

### Roblox-Related Functions
#### Character
This function returns the Character model of the player specified (or LocalPlayer).
```lua
Nebula.F:Character(Nebula.Players.NebulaOnTop)
--[[
Arguments:
> The player to return the character of (plr instance)
   Required: ❌
   Defaults To: LocalPlayer

Returns:
> The character model
]]--
```

#### Humanoid
This function returns the Humanoid of the player specified (or LocalPlayer).
```lua
Nebula.F:Humanoid(Nebula.Players.NebulaOnTop)
--[[
Arguments:
> The player to return the Humanoid of (plr instance)
   Required: ❌
   Defaults To: LocalPlayer

Returns:
> The Humanoid instance
]]--
```

#### Root
This function returns the HumanoidRootPart of the player specified (or LocalPlayer).
```lua
Nebula.F:Root(Nebula.Players.NebulaOnTop)
--[[
Arguments:
> The player to return the HumanoidRootPart of (plr instance)
   Required: ❌
   Defaults To: LocalPlayer

Returns:
> The HumanoidRootPart instance
]]--
```

#### TweenTo
This function tweens the HumanoidRootPart to a specified CFrame with a specified speed.
```lua
Nebula.F:TweenTo(CFrame.new(100,100,100), 100)
--[[
Arguments:
> The CFrame to tween to (cframe)
   Required: ✅
> The speed to move at (studs/second) (int)
   Required: ✅

Returns:
> The created Tween
]]--
```

#### ChangeWalkSpeed
This function changes the Humanoid's WalkSpeed to the passed number.
```lua
Nebula.F:ChangeWalkSpeed(100)
--[[
Arguments:
> The speed to change it to (int)
   Required: ✅

Returns:
> Nothing
]]--
```

#### ChangeJumpPower
This function changes the Humanoid's JumpPower to the passed number.
```lua
Nebula.F:ChangeJumpPower(100)
--[[
Arguments:
> The power to change it to (int)
   Required: ✅

Returns:
> Nothing
]]--
```

#### GetClosest
This function will return the closest player after a few optional checks.
```lua
Nebula.F:GetClosest(false, true, true, 'character', 200, 1000)
--[[
Arguments:
> Teamcheck? (bool)
   Required: ❌
   Defaults To: false
> Friendcheck?
   Required: ❌
   Defaults To: false
> Wallcheck?
   Required: ❌
   Defaults To: false
> Mode? ('character' or 'cursor', if character returns closest to character, if cursor returns closest to cursor) (str)
Required: ❌
   Defaults To: 'character'
> FOV (for when mode is set to 'cursor') (int)
   Required: ❌
   Defaults To: 200
> Range (for when mode is set to 'character') (int)
   Required: ❌
   Defaults To: math.huge
   
Returns:
> The closest player (player instance)
]]--
```

#### Circle
This function will return a circle that can be used for Vector3's / CFrame's.
```lua
local Circle = Nebula.F:Circle(32, 16)
for i,v in pairs(Circle) do
    local Part = Instance.new('Part', Nebula.Workspace)
    Part.Anchored = true
    Part.Position = Nebula.F:Root().Position + Vector3.new(v.X, 0, v.Y)
    Part.CanCollide = false
    Part.Transparency = 0.5
end
--[[
Arguments:
> Radius (int)
   Required: ✅
> Number of sides (int)
   Required: ✅

Returns:
> A table containing X and Z values (tbl)
]]--
```

#### God
This function will temporarily give you godmode, at the expense of refreshing your character.
```lua
Nebula.F:God()
--[[
Arguments:
> None

Returns:
> Nothing
]]--
```

#### ClickButton
Simulates LocalPlayer pressing a button on a GUI.
```lua
Nebula.F:ClickButton(Nebula.LocalPlayer.PlayerGui.ScreenGui.TextButton)
--[[
Arguments:
> The button to press (textbutton / imagebutton instance)
   Required: ✅

Returns:
> Nothing
]]--
```

#### AntiIdle
Disables or enables Anti Idle for the LocalPlayer, which can prevent kicks for being inactive for 20 minutes.
```lua
Nebula.F:AntiIdle(true)
--[[
Arguments:
> The state to set it to (true to enable, false to disable) (bool)
   Required: ✅
   
Returns:
> Nothing
]]--
```

#### RandomPlayer
A function that returns a random player instance from the current players in the game. (Skips LocalPlayer)
```lua
Nebula.F:RandomPlayer()
--[[
Arguments:
> None

Returns:
> Nothing
]]--
```

#### SetPing
Adds amount*1000 to the user's latency.
```lua
Nebula.F:SetPing(1)
task.wait(1)
Nebula.F:SetPing(0)
--[[
Arguments:
> The number to add to the user's latency (int)
   Required: ✅

Returns:
> Nothing
]]--
```

#### Serverhop
Rejoins the game to a random server.
```lua
Nebula.F:Serverhop([[print('Hello world!')]])
--[[
Arguments:
> The queue on teleport to run after rejoining (Lua as str)
   Required: ❌
   Defaults To: Loading in Nebula Library

Returns:
> Nothing
]]--
```

#### Chat
Forces the user to send the specified message. Will not work in games with custom chat systems, or games with the modern chat access.
```lua
Nebula.F:Chat('Hello world!')
--[[
Arguments:
> The username to send the message to (str)
   Required: ❌
   Defaults To: 'All' (everyone)

Returns:
> Nothing
]]--
```

#### Refresh
Refreshes the user's character, and will drop and take back any items in the inventory.
```lua
Nebula.F:Refresh()
--[[
Arguments:
> None

Returns:
> Nothing
]]--
```

#### Raycast
Raycasts from one point to the other.
```lua
Nebula.F:Raycast(Vector3.new(0,-100,0), Vector3.new(0,100,0))
--[[
Arguments:
> The first point to raycast from (vector3)
   Required: ✅
> The second point to raycast to (vector3)
   Required: ✅
   
Returns:
> The results, if any (raycast result or nil)
]]--
```

#### CreateGrid
Raycasts a 3 dimensional grid around a selected point.
```lua
Nebula.F:CreateGrid(Vector3.new(0,100,0), 10, 10, 10)
--[[
Arguments:
> The point to create a grid around (vector3)
   Required: ✅
> The size (x) (int)
   Required: ✅
> The size (y) (int)
   Required: ✅
> The size (z) (int)
   Required: ✅
   
Returns:
> Any objects inside that grid (tbl)
]]--
```

### Misc Functions
#### AddFunction
Adds a function to the Nebula.F library
```lua
Nebula.F:AddFunction(function(self, p1, p2)
    return p1 + p2
end, 'AddNumbers')

print(Nebula.F:AddNumbers(1, 2))
--[[
Arguments:
> The function itself (make sure to put self as the first parameter) (func)
   Required: ✅
> The name for the function (str)
   Required: ✅
   
Returns:
> Nothing
]]--
```

## Events
### Usage
#### CreateEvent
```lua
local CacheEvent = Nebula.E:CreateEvent()
CacheEvent:Connect(function()
	print("There's currently " .. tostring(#Nebula.F:Descendants(Nebula.__cache)) .. " objects in the cache.")
end)

CacheEvent:Connect(function()
	table.foreach(Nebula.F:Descendants(Nebula.__cache), function(i, v)
		if type(v) == "function" then
			print(i, getinfo(v).name, type(v))
		else
			print(i, tostring(v), type(v))
		end
	end)
end)

CacheEvent:Connect(function()
	print("Clearing cache..")
end)

CacheEvent:Connect(Nebula.ClearCache)

CacheEvent:Connect(function()
	print("Now there's currently " .. tostring(#Nebula.__cache) .. " objects in the cache.")
end)

CacheEvent:Fire()
--[[
Arguments:
> None

Returns:
> A event (tbl)
]]--
```

### Built In
#### Disconnect
```lua
DisconnectEvent:Connect(print) -- will print the disconnect reason for every player disconnect / kick
```

## Loops
### Usage
#### CreateLoop
```lua
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

local FOVLoop = Nebula.L:CreateLoop(UpdateFOV, CreateFOV, DestroyFOV)
print(FOVLoop.Enabled) -- false
FOVLoop:Toggle()
print(FOVLoop.Enabled) -- true
--[[
Arguments:
> The function to loop (func)
   Required: ✅
> The function to call immediately before starting the loop (func)
   Required: ❌
> The function to call immediately after ending the loop (func)
   Required: ❌

Returns:
> A loop (tbl)
]]--
```

## ESP
### Usage
#### CreateTracer
```lua
local Tracer = Nebula.F:CreateTracer(Color3.fromRGB(255, 0, 0))
--[[
Arguments:
> The color to assign to the tracer
   Required: ✅

Returns:
> The tracer (drawing instance)
]]--
```

#### UpdateTracer
```lua
Nebula.F:UpdateTracer(Tracer, 'bottom', Nebula.Players.NebulaOnTop)
--[[
Arguments:
> The tracer instance to update (drawing instance)
   Required: ✅
> The origin position of the tracer ('bottom', 'top', or 'middle') (str)
   Required: ✅
> The player to set the end position of the tracer to (player instance)
   Required: ✅
   
Returns:
> Nothing
]]--
```

## Anti-Cheat
### Usage
#### Spoof
```lua
Nebula.AC:Spoof(Nebula.F:Humanoid(), Nebula.F:Humanoid().WalkSpeed, 16)
--[[
Arguments:
> The object to spoof (instance)
   Required: ✅
> The property to spoof (property)
   Required: ✅
> The value to spoof it to (?)
   Required: ✅
   
Returns:
> Nothing
]]--
```

#### Unspoof
```lua
Nebula.AC:Unspoof(Nebula.F:Humanoid(), Nebula.F:Humanoid().WalkSpeed)
--[[
Arguments:
> The object to unspoof (instance)
   Required: ✅
> The property to unspoof (property)
   Required: ✅

Returns:
> Nothing
]]--
```
