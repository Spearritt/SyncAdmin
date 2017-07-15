--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to unban users from your game.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"pardon"}
command.Params = {"String"}
command.Usage = "unban [Username or UserId]"
command.Description = [[Unbans the player with the given username.]] 

function strSplit(inputstr,sep)
	local t,i = {},1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

command.Init = function(main)
end

command.Run = function(main,user,query)
	if (user == nil) then return false,"No user found" end
	
	if (users == nil) then
		return false,"No users specified"
	else
		local count = 0
		local banned = SyncAPI.GetBannedUsers()
		
		for _,ban in pairs(banned) do
			if (string.sub(ban.Username,1,#query) == query or string.sub(tostring(ban.UserId),1,#query) == query) then
				SyncAPI.Unban(ban.UserId,true)
				return true,"Unbanned user " .. ban.Username
			end
		end
		
		return false,"Can't find any bans for that user"
	end
end

return command
