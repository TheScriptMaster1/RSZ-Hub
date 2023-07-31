pcall(function()
	workspace:FindFirstChild("kill",true).Parent:Destroy()
end)


local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local Window = OrionLib:MakeWindow({Name = "Zyer Hub v1.1 | "..gamename, HidePremium = false, SaveConfig = false})

--  CONFIGS

local highlights = {}


local function enableESP()
	for _, player in ipairs(game.Players:GetPlayers()) do
		if player ~= game.Players.LocalPlayer then
			local highlight = Instance.new("Highlight")
			highlight.Parent = player.Character
			highlights[player] = highlight
		end
	end
end

local function disableESP()
	for _, highlight in pairs(highlights) do
		highlight:Destroy()
	end
	highlights = {}
end

getgenv().antivoid = false

local ANTI_VOID = Instance.new("Part",workspace)
ANTI_VOID.CFrame = CFrame.new(14.5383425, 195.975098, -210.753754)
ANTI_VOID.Anchored = true
ANTI_VOID.Transparency = 1
ANTI_VOID.Size = Vector3.new(2048,.5,2048)
ANTI_VOID.CanCollide = false

local SAFE_SPOT = Instance.new("Part",workspace)
SAFE_SPOT.CFrame = CFrame.new(14.5383425, 195.975098, -2000.753754)
SAFE_SPOT.Anchored = true
SAFE_SPOT.Transparency = .5
SAFE_SPOT.Size = Vector3.new(100,50,100)
SAFE_SPOT.CanCollide = true
SAFE_SPOT.Name = "SafeSpot"

local function glove()
	local glove = game:GetService("Players").LocalPlayer.Backpack:FindFirstChildOfClass("Tool") or game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass("Tool") or nil

	return glove
end

local portal = game:GetService("Workspace"):WaitForChild("Map"):WaitForChild("Portals"):WaitForChild("Normal Portal"):WaitForChild("a").CFrame

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

local DUMMY_TAB = Window:MakeTab({
	Name = "Dummy",
	Icon = "rbxassetid://14253489478",
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

MAIN_TAB:AddToggle({
	Name = "ESP",
	Default = false,
	Callback = function(Value)
		getgenv().esp = Value

		if getgenv().esp == true then
			enableESP()
		else
			disableESP()
		end
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

MISC_TAB:AddToggle({
	Name = "Hide Name",
	Default = false,
	Callback = function(Value)
		getgenv().antinametag = Value

		if getgenv().antinametag == true then
			game:GetService("Players").LocalPlayer.Character.Head.NameTag.UpperText.TextTransparency = 1
		else
			game:GetService("Players").LocalPlayer.Character.Head.NameTag.UpperText.TextTransparency = 0
		end
	end    
})

MISC_TAB:AddButton({
	Name = "TP To Safe-Spot",
	Callback = function()
      	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = workspace.SafeSpot.CFrame * CFrame.new(0,53,0)
  	end    
})

MISC_TAB:AddButton({
	Name = "TP to Arena",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(17.4133415, 196.587753, -202.145111)
	  end    
})

MISC_TAB:AddButton({
	Name = "TP to Lobby",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-40, 645, -281)
	  end    
})

local antibreak = true

MISC_TAB:AddButton({
	Name = "Get Slapples (ONE TIME USE)",
	Callback = function()
		if antibreak == true then
			antibreak = false
			for i,v in pairs(game.Workspace.FruitGloves:GetDescendants()) do
				task.wait()
				pcall(function()
					game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = v.CFrame
				end)
			end
			antibreak = true
		end
	  end    
})

MISC_TAB:AddButton({
	Name = "Rejoin",
	Callback = function()
			game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
	  end    
})

local character = game.Players.LocalPlayer.Character

DUMMY_TAB:AddToggle({
	Name = "Become Dummy",
	Default = false,
	Callback = function(Value)
		getgenv().becomedummy = Value

		if getgenv().becomedummy == true and workspace:FindFirstChild("Dummy") ~= nil then
			character.HumanoidRootPart.CFrame = workspace.Dummy.HumanoidRootPart.CFrame
			game.Players.LocalPlayer.Character = workspace.Dummy
			ANTI_VOID.CanCollide = true
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
			workspace.Dummy.Humanoid.Died:Connect(function()
				if game.Players.LocalPlayer.Character == workspace.Dummy then
				game:GetService("TeleportService"):TeleportToPlaceInstance(game.PlaceId, game.JobId)
				end
			end)
		elseif getgenv().becomedummy == false and workspace:FindFirstChild("Dummy") ~= nil then
			game.Players.LocalPlayer.Character = character
			repeat
			task.wait()
			character.HumanoidRootPart.CFrame = CFrame.new(18.5813675, 210, -207.809937)
			until character.HumanoidRootPart.CFrame == CFrame.new(18.5813675, 210, -207.809937)
			ANTI_VOID.CanCollide = getgenv().antivoid
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", true)
		end
		while getgenv().becomedummy == true and workspace:FindFirstChild("Dummy") ~= nil do
			task.wait()
			game:GetService("StarterGui"):SetCore("ResetButtonCallback", false)
			ANTI_VOID.CanCollide = true
			character.HumanoidRootPart.CFrame = workspace.Dummy.HumanoidRootPart.CFrame * CFrame.new(0,-7,0)
		end
	end    
})

-- credits

CREDITS_TAB:AddLabel("Scripting - ScriptMaster & Zyer;");
CREDITS_TAB:AddLabel("Testing - RoShowcaser")
CREDITS_TAB:AddLabel("Owner - Zyer")

-- notification

OrionLib:MakeNotification({
	Name = "Successfully Executed Zyer Hub",
	Content = "Successfully Executed Zyer Hub in "..gamename.."!",
	Image = "rbxassetid://1202200114",
	Time = 3
})

game.Players.LocalPlayer.Chatted:Connect(function(msg)
	if msg == "//devmode" then
		local DEV_MODE = Window:MakeTab({
			Name = "Developer Mode",
			Icon = "rbxassetid://11860859170",
			PremiumOnly = false
		})
		
		DEV_MODE:AddButton({
			Name = "Print CFrame",
			Callback = function()
					  print(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
			  end    
		})

		OrionLib:MakeNotification({
			Name = "Developer Mode Successfully Loaded!",
			Content = "helo - ScriptMaster",
			Image = "rbxassetid://11860859170",
			Time = 3
		})
		end
	end)
