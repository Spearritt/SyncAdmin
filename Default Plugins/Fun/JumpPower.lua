--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to change the selected players jump power [Default 50].
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "jp"
command.Params = {"PlayerList","Number"}
command.Usage = "jumppower Player1,Player2,Player2,... JumpPower"
command.Description = [[Changes the Players' JumpPower]] 

command.Init = function(main)
end

command.Run = function(main,user,users,jumppower)

	local _minlimit = 1
	local _maxlimit = 1000
	
	if jumppower > _maxlimit then
		return false,"Cannot set jump power higher than " ..  _maxlimit .. "."
	elseif jumppower < _minlimit then
		return false,"Cannot set jump power less than " ..  _minlimit .. "."
	end	
	
	local list = {}
	for _,player in pairs(users) do
		local char = player.Character
		if (char and char:findFirstChild("Humanoid") and tonumber(jumppower)) then
			char.Humanoid.JumpPower = jumppower
		end
		table.insert(list,player.Name)
	end
	return true,"Set jump power of " .. table.concat(list,", ") .. " to " .. jumppower,list,user.Name .. " has set your jump power to " .. jumppower
end

return command
