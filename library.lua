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
