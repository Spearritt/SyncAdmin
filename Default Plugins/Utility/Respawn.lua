
--[[
									Verified SyncAdmin Command
	======================================================================================
	Authors 				Hannah Jane [DataSynchronized], Dominik [VolcanoINC]
	Description				Respawns selected a user.
	--------------------------------------------------------------------------------------
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = "rs"
command.Params = {"PlayerList"}
command.Usage = "respawn [Player1,Player2,Player3,...]"
command.Description = [[Respawns the players specified. If no players are given
it will respawn you.]] 

--// Now to the actual command
command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	local list = {}
	for _,player in pairs(users) do
		player:LoadCharacter()
		table.insert(list,player.Name)
	end
	return true,"Respawned users: " .. table.concat(list,", "),list,user.Name .. " has respawned you."
end

return command
