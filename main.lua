local supported_games = {
	game.PlaceId -- Slap Battles but bad
}

if table.find(supported_games, game.PlaceId) then

local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Zyer Hub | "..gamename, HidePremium = false, SaveConfig = false})

--  CONFIGS

getgenv().antivoid = false

local ANTI_VOID = Instance.new("Part",workspace)
ANTI_VOID.CFrame = CFrame.new(14.5383425, 195.975098, -210.753754)
ANTI_VOID.Anchored = true
ANTI_VOID.Transparency = 1
ANTI_VOID.Size = Vector3.new(2048,.5,2048)
ANTI_VOID.CanCollide = false

--  TABS

local MAIN_TAB = Window:MakeTab({
	Name = "Main",
	Icon = "rbxassetid://4034483344",
	PremiumOnly = false
})

local MISC_TAB = Window:MakeTab({
	Name = "Misc",
	Icon = "rbxassetid://484211948",
	PremiumOnly = false
})

local CREDITS_TAB = Window:MakeTab({
	Name = "Credits",
	Icon = "rbxassetid://5107183916",
	PremiumOnly = false
})

--  FEATURES

MAIN_TAB:AddSlider({
	Name = "Walkspeed",
	Min = 16,
	Max = 170,
	Default = 16,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "WS",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = Value
	end    
})

MAIN_TAB:AddSlider({
	Name = "Reach",
	Min = 1,
	Max = 1000,
	Default = 1,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "REACH",
	Callback = function(Value)
		pcall(function()
			local hitbox = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool").Hitbox or game.Players.LocalPlayer.Backpack:FindFirstChildOfClass("Tool").Hitbox or nil
			if hitbox ~= nil then
				hitbox.Size = Vector3.new(Value,Value,Value)
				hitbox.Transparency = .5
			else
				warn("Hitbox not found.")
			end
		end)
	end    
})

MISC_TAB:AddToggle({
	Name = "Anti Void",
	Default = false,
	Callback = function(val)
		getgenv().antivoid = val

		if getgenv().antivoid == true then
			ANTI_VOID.CanCollide = true
			ANTI_VOID.Transparency = .7
		else
			ANTI_VOID.CanCollide = false
			ANTI_VOID.Transparency = 1
		end
	end    
})

MISC_TAB:AddButton({
	Name = "Anti Dummies (useful for reach)",
	Callback = function()
      	pcall(function()
			workspace["Anchored Dummy"]:Destroy()
			workspace["Attacking Dummy"]:Destroy()
			workspace.Dummy:Destroy()
		end)
  	end    
})

-- credits

CREDITS_TAB:AddLabel("Scripting - ScriptMaster and Zyer");
CREDITS_TAB:AddLabel("Testing - RoShowcaser")
CREDITS_TAB:AddLabel("Owner - Zyer")

-- notification

OrionLib:MakeNotification({
	Name = "Successfully Executed Zyer Hub",
	Content = "Successfully Executed Zyer Hub in "..gamename.."!",
	Image = "rbxassetid://1202200114",
	Time = 3
})

end
