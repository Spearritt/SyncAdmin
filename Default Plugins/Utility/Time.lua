local command = {}
command.PermissionLevel = 1
command.Shorthand = {"timeofday","tod"}
command.Params = {"String"}
command.Usage = "time String"
command.Description = [[Changes the game time to the selected time]] 

command.Init = function()
end

command.Run = function(main,user,timeofday)
	game:GetService("Lighting").TimeOfDay = timeofday
	return true,"Set the game time to: " .. tostring(timeofday) .. "."
end

return command
