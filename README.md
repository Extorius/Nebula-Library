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
- `Luau` (0.533)
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
- `Comet v3 GameKit` - unsure about this one
- `WeAreDevs API v6.4`

## Booting

To boot Nebula, all you have to do is call a loadstring with a few passed parameters;
```lua
local Nebula = loadstring(game:HttpGet("https://raw.githubusercontent.com/Extorius/Nebula-Library/main/src/library.lua"))({
	["Developer-Mode"] = true, -- set this to false and Nebula will automatically load in a universal script
  ["Auto-Optimize"] = true, -- a really basic optimization system that replaces commonly known deprecated functions with their new counterparts, nothing fancy
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
These are functions that don't rely on Roblox specific utilities

#### Print
This is a testing function, don't use it lol
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
This is just a shortened version of Nebula.Http:JSONEncode()
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
This is just a shortened version of Nebula.Http:JSONDecode()
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
This provides the descendants of a table
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

####

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
