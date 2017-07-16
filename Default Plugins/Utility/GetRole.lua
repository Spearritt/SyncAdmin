
--[[
									Verified SyncAdmin Plugin
	======================================================================================
	Authors 				Sam [Spearritt]
	Description				Get the players role within a group.
	--------------------------------------------------------------------------------------
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"Player","Number"}
command.Usage = "role Player groupID"
command.Description = [[Views the players role within a group.]] 

command.Init = function(main)
end

command.Run = function(main,user,player,group)
	if player:IsInGroup(group) then
		return true,player.Name .. "'s role in " .. game:GetService("GroupService"):GetGroupInfoAsync(group).Name .. " is "..player:GetRoleInGroup(group) 
	else
		return false,"The player is not a member of the group "..game:GetService("GroupService"):GetGroupInfoAsync(group).Name.."."
	end
end

return command
