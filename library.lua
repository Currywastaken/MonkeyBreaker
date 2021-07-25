local Credits = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local Logo = Instance.new("ImageLabel")
local Powerd = Instance.new("TextLabel")
local By = Instance.new("TextLabel")

--Properties:

Credits.Name = "Credits"
Credits.Parent = game.CoreGui
Credits.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Frame.Parent = Credits
Frame.AnchorPoint = Vector2.new(0.5, 0.5)
Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Frame.Position = UDim2.new(0.49999997, 0, 0.499312252, 0)
Frame.Size = UDim2.new(0, 151, 0, 144)

Logo.Name = "Logo"
Logo.Parent = Frame
Logo.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Logo.BackgroundTransparency = 1.000
Logo.Position = UDim2.new(0.00662255287, 0, 0, 0)
Logo.Size = UDim2.new(0, 147, 0, 144)
Logo.Image = "rbxassetid://7151908854"

Powerd.Name = "Powerd"
Powerd.Parent = Frame
Powerd.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
Powerd.BackgroundTransparency = 1.000
Powerd.Position = UDim2.new(0.315450639, 0, 0, 0)
Powerd.Size = UDim2.new(0, 308, 0, 53)
Powerd.Font = Enum.Font.SourceSans
Powerd.Text = ""
Powerd.TextColor3 = Color3.fromRGB(255, 170, 0)
Powerd.TextScaled = true
Powerd.TextSize = 14.000
Powerd.TextWrapped = true

By.Name = "By"
By.Parent = Frame
By.BackgroundColor3 = Color3.fromRGB(255, 170, 0)
By.BackgroundTransparency = 1.000
By.Position = UDim2.new(0.401287556, 0, 0.50000006, 0)
By.Size = UDim2.new(0, 192, 0, 42)
By.Font = Enum.Font.SourceSans
By.Text = ""
By.TextColor3 = Color3.fromRGB(255, 170, 0)
By.TextScaled = true
By.TextSize = 14.000
By.TextWrapped = true

-- Scripts:

local function VWZPO_fake_script() -- Frame.LocalScript 
	local script = Instance.new('LocalScript', Frame)
	wait(0.5)
	--Functions
	local function typeWrite(msg, obj)
		for i = 1, #msg do
			obj.Text = string.sub(msg, 1, i)
			wait(0.05)
		end
	end
	script.Parent:TweenSize(UDim2.new(0, 466,0, 144))
	wait(2)
	local powerdText = "Powerd by Monkey breaker"
	local byText = "By Kuri#1686"
	
	typeWrite(powerdText, script.Parent.Powerd)
	wait(1)
	typeWrite(byText, script.Parent.By)
	wait(2)
	script.Parent:Destroy()
end
coroutine.wrap(VWZPO_fake_script)()


local res = {}
local MonkeyBreaker = {}
MonkeyBreaker.Doors = {}
MonkeyBreaker.Weapons = {}
MonkeyBreaker.Vehicles = {}
MonkeyBreaker.Misc = {}
MonkeyBreaker.Advanced = {}

for i, v in pairs(getgc(true)) do
    if type(v) == "table" then
        if rawget(v, "Event") and rawget(v, "Fireworks") then
            MonkeyBreaker.Misc.em = v.em
            MonkeyBreaker.Advanced.Network = v.Event
            MonkeyBreaker.Misc.Fireworks = v.Fireworks
            res.GetVehiclePacket = v.GetVehiclePacket
        elseif rawget(v, "State") and rawget(v, "OpenFun") then
            table.insert(MonkeyBreaker.Doors, v)
        end
    elseif type(v) == "function" then
        if getfenv(v).script == game:GetService("Players").LocalPlayer.PlayerScripts.LocalScript then
            local con = getconstants(v)
            if table.find(con, "SequenceRequireState") then
                MonkeyBreaker.Misc.OpenDoor = v
            elseif table.find(con, "Play") and table.find(con, "Source") and table.find(con, "FireServer") then
                MonkeyBreaker.Misc.PlaySound = v
            elseif table.find(con, "PlusCash") then
                MonkeyBreaker.Misc.AddCash = v
            elseif table.find(con, "Punch") then
                MonkeyBreaker.Misc.GuiFunc = v
            end
        end
    end
end
--Weapons
MonkeyBreaker.Weapons.SetFireRate = function(rate)
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.ItemConfig:GetChildren()) do
        local weapon = require(v)
        weapon.FireFreq = rate
    end
end

MonkeyBreaker.Weapons.MakeAutomatic = function(onOff) 
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.ItemConfig:GetChildren()) do
        local weapon = require(v)
        weapon.FireAuto = onOff
    end
end

MonkeyBreaker.Weapons.SetBulletSpread = function(SpreadRate) 
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.ItemConfig:GetChildren()) do
        local weapon = require(v)
        weapon.BulletSpread = SpreadRate
    end
end

MonkeyBreaker.Weapons.SetReloadTime = function(Time)
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.ItemConfig:GetChildren()) do
        local weapon = require(v)
        weapon.ReloadTime = Time
    end
end

MonkeyBreaker.Weapons.SetAmmo = function(Ammo)
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.ItemConfig:GetChildren()) do
        local weapon = require(v)
        weapon.MagSize = Ammo
    end 
end

MonkeyBreaker.Weapons.SetCamRecoil = function(Recoil)
    for i,v in pairs(game:GetService("ReplicatedStorage").Game.ItemConfig:GetChildren()) do
        local weapon = require(v)
        weapon.CamShakeMagnitude = Recoil
    end 
end

--Vehicles

MonkeyBreaker.Vehicles.SetVehicleHeight = function(HeightVal) 
    res.GetVehiclePacket().Height = HeightVal
end

MonkeyBreaker.Vehicles.SetVehicleSpeed = function(SpeedVal)
    res.GetVehiclePacket().GarageEngineSpeed = SpeedVal
end

MonkeyBreaker.Vehicles.SetVehicleTurnSpeed = function(turnSpeed) 
    res.GetVehiclePacket().TurnSpeed = turnSpeed
end

MonkeyBreaker.Vehicles.SetTirePopDuration = function(Dur)
    res.GetVehiclePacket().TirePopDuration = Dur
end

MonkeyBreaker.Vehicles.ToggleInjanHorn = function(onOff) 
    local id = game:GetService("Players").LocalPlayer.UserId
    require(game:GetService("ReplicatedStorage").Resource.Settings).Perm.InjanHorn.Id[tostring(id)] = onOff
end

--Misc

MonkeyBreaker.Misc.SendMessage = function(Message, Dur)
    if Dur == 0 then
        Dur = 3
    end
    require(game:GetService("ReplicatedStorage").Game.Notification).new({
        Text = Message,
        Duration = Dur
    })
end

MonkeyBreaker.Misc.SetTeanSwitchDelay = function(Delay)
    require(game:GetService("ReplicatedStorage").Resource.Settings).Time.BetweenTeamChange = Delay
end

MonkeyBreaker.Misc.ToggleNoWait = function(onOff) 
    for i,v in pairs(require(game:GetService("ReplicatedStorage").Module.UI).CircleAction.Specs) do
        v.Timed = onOff;
    end
end

MonkeyBreaker.Misc.BypassWalkSpeed = function()
    local gmt = getrawmetatable(game)
    setreadonly(gmt, false)
    local oldIndex = gmt.__index
    gmt.__index = newcclosure(function(self, b)
        if b == "WalkSpeed" then 
            return 16    
        end
        return oldIndex(self,b)
    end)
end

MonkeyBreaker.Misc.BypassJumpPower = function()
    local gmt = getrawmetatable(game)
    setreadonly(gmt, false)
    local oldIndex = gmt.__index
    gmt.__index = newcclosure(function(self, b)
        if b == "JumpPower" then 
            return 50    
        end 
        return oldIndex(self,b)
    end)
end

MonkeyBreaker.Misc.SetWalkSpeed = function(Speed)
    game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Speed
end

MonkeyBreaker.Misc.SetJumpPower = function(Power)
    game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Power
end

return MonkeyBreaker;
