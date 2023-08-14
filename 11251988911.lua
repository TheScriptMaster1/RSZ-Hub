local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Unknownkellymc1/Orion/main/source')))()

local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local started = tick()

local version = game:HttpGet("https://raw.githubusercontent.com/TheScriptMaster1/RSZ-Hub/main/version")

local currentVersion = "1.2"

if not currentVersion == version then

   OrionLib:MakeNotification({
      Name = "Not Updated",
      Content = "You're using an older version of RSZ Hub.",
      Image = "rbxassetid://5107154082",
      Time = 5
   })

end



local Window = OrionLib:MakeWindow({Name = "RSZ Hub v1.2 | "..gamename, HidePremium = false, SaveConfig = false})

-- CONFIGS

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

local antiacid = Instance.new("Part",workspace)
antiacid.Anchored = true
antiacid.CFrame = CFrame.new(664, 2, -4)
antiacid.Size = Vector3.new(200,1,200)
antiacid.Transparency = 1
antiacid.CanCollide = false

local antilava = Instance.new("Part",workspace)
antilava.Anchored = true
antilava.CFrame = CFrame.new(927, 32, -155.12)
antilava.Size = Vector3.new(100,10,100)
antilava.Transparency = 1
antilava.CanCollide = false

-- TABS

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

-- FEATURES

MAIN_TAB:AddSlider({
	Name = "Walkspeed",
	Min = 20,
	Max = 300,
	Default = 5,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "WS",
	Callback = function(Value)
		game:GetService("Players").LocalPlayer.Character:WaitForChild("Humanoid").WalkSpeed = Value
	end    
})

MAIN_TAB:AddSlider({
	Name = "Reach",
	Min = 1,
	Max = 250,
	Default = 1,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "REACH",
	Callback = function(Value)
		pcall(function()
			local hitbox = game.Players.LocalPlayer.Character:FindFirstChild("Hitbox",true) or game.Players.LocalPlayer.Backpack:FindFirstChild("Hitbox",true) or nil
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

MAIN_TAB:AddSlider({
	Name = "FOV",
	Min = 70,
	Max = 120,
	Default = 70,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "FOV",
	Callback = function(Value)
		workspace.CurrentCamera.FieldOfView = Value
	end    
})

MAIN_TAB:AddSlider({
	Name = "HipHeight",
	Min = 0,
	Max = 50,
	Default = 0,
	Color = Color3.fromRGB(0,255,0),
	Increment = 1,
	ValueName = "HH",
	Callback = function(Value)
		game.Players.LocalPlayer.Character.Humanoid.HipHeight = Value
	end    
})

MAIN_TAB:AddToggle({
	Name = "Auto Slap",
	Default = false,
	Callback = function(Value)
		getgenv().autoslap = Value

		while getgenv().autoslap == true do
			task.wait(.05)
			pcall(function()
				game.Players.LocalPlayer.Character:FindFirstChild("Hitbox",true).Parent:Activate()
			end)
		end
	end    
})

MISC_TAB:AddToggle({
	Name = "Anti Acid",
	Default = false,
	Callback = function(Value)
		getgenv().antiacid = Value

      if getgenv().antiacid == true then
         antiacid.CanCollide = true
         antiacid.Transparency = .5
      else
         antiacid.CanCollide = false
         antiacid.Transparency = 1
      end
	end    
})

MISC_TAB:AddToggle({
	Name = "Anti Lava",
	Default = false,
	Callback = function(Value)
		getgenv().antilava = Value

      if getgenv().antilava == true then
		antilava.CanCollide = true
		antilava.Transparency = .5
      else
		antilava.CanCollide = false
		antilava.Transparency = 1
      end
	end    
})

MISC_TAB:AddToggle({
	Name = "Auto Items",
	Default = false,
	Callback = function(Value)
		getgenv().items = Value

		while getgenv().items == true do
			task.wait(.05)
			for i,v in pairs(workspace:GetChildren()) do
				if v:IsA("Tool") then
					game.Players.LocalPlayer.Character.Humanoid:EquipTool(v)
				end
			end
		end
	end    
})

MISC_TAB:AddButton({
	Name = "TP To Lobby",
	Callback = function()
      	game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(6, 866, 13)
  	end    
})

MISC_TAB:AddButton({
	Name = "TP To Map",
	Callback = function()
		game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(459, 5, 87)
	end    
})

OrionLib:MakeNotification({
	Name = "RSZ Hub v1.2",
	Content = "RSZ Hub has been executed in "..tick() - started.." seconds.",
	Image = "rbxassetid://6710785372",
	Time = 3
})

game.Players.LocalPlayer.Chatted:Connect(function(msg)
   if msg == "//c" then
      print(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
   end
end)
