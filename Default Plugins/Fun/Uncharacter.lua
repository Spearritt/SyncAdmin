--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to restore the selected players original character appreance.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList"}
command.Usage = "unchar Player1,Player2,..."
command.Description = [[Reset the selected players character appearance to their normal character.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	local list = {}
	for _,player in pairs(users) do
		local char = player.CharacterAppearance
		if (char) then
			player.CharacterAppearance = "http://assetgame.roblox.com/Asset/CharacterFetch.ashx?userId="
			wait()
			player:LoadCharacter()
		end
		table.insert(list,player.Name)
	end
	return true,"Reset character appearance for: " .. table.concat(list,", "),list,user.Name .. " has reset your character appearance."
end

return command
