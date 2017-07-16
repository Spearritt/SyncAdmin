
--[[
									Verified SyncAdmin Command
	======================================================================================
	Authors 				Sam [Spearritt]
	Description				Steal the tools of a target player
	--------------------------------------------------------------------------------------
--]]

local command = {}
command.PermissionLevel = 2
command.Shorthand = "steal"
command.Params = {"Player"}
command.Usage = "stealtools Player"
command.Description = [[Steals the target players tools.]] 

command.Init = function(main)
end

command.Run = function(main,user,ply)
	for _,content in pairs(ply.Backpack:GetChildren()) do
		if content:IsA("Tool") or content:IsA("HopperBin") then
			content.Parent = user.Backpack
		end
	end
	return true,"You have stolen "..ply.Name.."'s tools!"
end

return command