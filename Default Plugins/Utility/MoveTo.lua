
--[[
									Verified SyncAdmin Plugin
	======================================================================================
	Authors 				Hannah Jane [DataSynchronized], Dominik [VolcanoINC]
	Description				Move selected users to a vector3 position on the map.
	--------------------------------------------------------------------------------------
--]]

local command = {}
command.PermissionLevel = 2 
command.Shorthand = nil
command.Params = {"PlayerList","Vector3"}
command.Usage = "moveto Player Vector3"
command.Description = [[Move the selected players to an X Y Z position. ]] 

--// Now to the actual command
command.Init = function(main)
end

command.Run = function(main,user,users,position)
	if (user == nil) then error("No user found") end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		if player.Character then
			player.Character:MoveTo(position)
		end
	end
	return true,"Moved the following players: " .. table.concat(list,", "),list,user.Name .. " has moved your character."
end

return command
