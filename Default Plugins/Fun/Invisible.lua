--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to make the selected user invisible.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "vanish"
command.Params = {"Optional:PlayerList"}
command.Usage = "invisible Player"
command.Description = [[Makes the selected users invisible.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	if (users == nil or #users == 0) then users = {user} end
	
	local name = table.concat({}," ")
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		function hi (x)
		    for _,i in pairs (x:children()) do
		        hi (i)
		        if i:IsA("BasePart") or i:IsA("Decal") then
		            i.Transparency = 1
		        end
			end
		end
		hi (player.Character)
	end
	return true,"Made the following users invisible: " .. table.concat(list,", "),list,user.Name .. " has made you invisible."
end

return command