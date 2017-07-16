local command = {}
command.PermissionLevel = 1
command.Shorthand = "h"
command.Params = {"..."}
command.Usage = "hint Your text here"
command.Description = [[Displays the given hint to all players for 60 seconds.]] 

command.Init = function(main)
end

command.Run = function(main,user,...)
	if (user == nil) then error("No user found") end
	local message = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	
	for _,pl in pairs(game:GetService("Players"):GetPlayers()) do
		SyncAPI.DisplayHint(pl,message,"Info",60)
	end
end

return command
