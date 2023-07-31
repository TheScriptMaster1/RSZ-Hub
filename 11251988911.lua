local OrionLib = loadstring(game:HttpGet(('https://raw.githubusercontent.com/shlexware/Orion/main/source')))()

local gamename = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId).Name

local started = tick()

local version = game:HttpGet("https://raw.githubusercontent.com/TheScriptMaster1/zyer-hub/main/version")

local currentVersion = "1.1"

if not currentVersion == version then

   OrionLib:MakeNotification({
      Name = "Not Updated",
      Content = "You're using an older version of Zyer Hub.",
      Image = "rbxassetid://5107154082",
      Time = 5
   })

end



local Window = OrionLib:MakeWindow({Name = "Zyer Hub v1.1 | "..gamename, HidePremium = false, SaveConfig = false})

-- CONFIGS

local antiacid = Instance.new("Part",workspace)
antiacid.Anchored = true
antiacid.CFrame = CFrame.new(664, 2, -4)
antiacid.Size = Vector3.new(200,1,200)
antiacid.Transparency = 1
antiacid.CanCollide = false

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
	Max = 1000,
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

OrionLib:MakeNotification({
	Name = "Zyer Hub v1.1",
	Content = "Zyer Hub has been executed in "..tick() - started.." seconds.",
	Image = "rbxassetid://6710785372",
	Time = 3
})

game.Players.LocalPlayer.Chatted:Connect(function(msg)
   if msg == "//c" then
      print(game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame)
   end
end)
