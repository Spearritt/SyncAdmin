local command = {}
command.PermissionLevel = 1
command.Shorthand = "m"
command.Params = {"..."}
command.Usage = "message Your text here"
command.Description = [[Displays the given message to all players.]] 

command.Init = function(main)
end

command.Run = function(main,user,...)
	if (user == nil) then error("No user found") end
	local message = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	
	for _,pl in pairs(game:GetService("Players"):GetPlayers()) do
		SyncAPI.DisplayMessage(pl,user.Name,message)
	end
end

return command
