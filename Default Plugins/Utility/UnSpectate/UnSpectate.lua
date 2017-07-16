local command = {}
command.PermissionLevel = 1
command.Shorthand = "unspec"
command.Params = {}
command.Usage = "unspectate"
command.Description = [[Returns the camera back to your character]] 

command.Init = function(main)
end

command.Run = function(main,user)
	if (user and user.Character) then
		local hum = user.Character:findFirstChild("Humanoid")
		if (hum) then
			local sscript = script.SA_Spectate:clone()
			sscript.Target.Value = hum
			sscript.Disabled = false
			sscript.Parent = user.Character
			return true,"Camera returned to you."
		end
	end
	return false,"Cannot attach camera to your character at this time. No character found."
end

return command
