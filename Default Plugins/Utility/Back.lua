--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to return to the last point of death.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {}
command.Usage = "back"
command.Description = [[Teleports you back to the last location you were before you died]] 

local recentPositions = {}

function onCharacterAdded(player,char)
	local hum = char:WaitForChild("Humanoid")
	local rootPart = char:WaitForChild("HumanoidRootPart")
	
	hum.Died:connect(function()
		recentPositions[player.Name] = rootPart.CFrame
	end)
end

function onPlayerAdded(player)
	player.CharacterAdded:connect(function(char)
		onCharacterAdded(player,char)
	end)
end

command.Init = function(main)
	local players = game:GetService("Players")
	for _,pl in pairs(players:GetPlayers()) do
		onPlayerAdded(pl)
	end
	
	players.PlayerAdded:connect(onPlayerAdded)
end

command.Run = function(main,user)
	if (user.Character and user.Character:findFirstChild("HumanoidRootPart") and user.Character.HumanoidRootPart:IsA("BasePart")) then
		if (recentPositions[user.Name]) then
			user.Character.HumanoidRootPart.CFrame = recentPositions[user.Name]
			return true,"Teleported you to your last known location"
		else
			return false,"There are no recent positions saved for you"
		end
	else
		return false,"Cannot teleport at this time. You do not have a HumanoidRootPart"
	end
end

return command
