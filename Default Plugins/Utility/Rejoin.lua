local command = {}
command.PermissionLevel = 0
command.Shorthand = "rj"
command.Usage = "rejoin"
command.Description = [[Makes you rejoin the game.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	
	local ts = game:GetService("TeleportService")
	ts:Teleport(game.PlaceId,user)
end

return command
