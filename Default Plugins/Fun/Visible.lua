--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to make the selected player visable.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "vis" 
command.Params = {"PlayerList"}
command.Usage = "visible Player"
command.Description = [[Makes the selected users visible.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		
		function hi (x)
		    for _,i in pairs (x:children()) do
		        hi (i)
		        if i:IsA("BasePart") or i:IsA("Decal") then
		            i.Transparency = 0
		        end
			end
		end
		hi (player.Character)
		player.Character.HumanoidRootPart.Transparency = 1 -- Fix a bug regarding torso being blue
	end
	return true,"Made the following users visible " .. table.concat(list,", "),list,user.Name .. " has made you visible."
end

return command