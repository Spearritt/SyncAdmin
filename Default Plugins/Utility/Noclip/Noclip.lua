
--      @Description: Allows people to noclip through solid BaseParts. Toggled with C.
--      @Author: AmbientOcclusion (using the Fly plugin as a template.)

local command = {}
command.PermissionLevel = 1
command.Shorthand = "clip"
command.Params = {"Optional:PlayerList"}
command.Usage = "noclip Player1,Player2,..."
command.Description = [[Allows the selected players to noclip. Use C to toggle noclip mode after using this command.]] 

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then
		users = {user}
	end
	
	local list = {}
	for _,plr in next, users do --next is technically same as pairs, but pairs calls next, dunno why Lua did that.
		local noclipScript = script.NoclipScript:clone()
		noclipScript.Disabled = false
		noclipScript.Parent = plr.Character
		table.insert(list,plr.Name)
	end
	return true,"Made the following users noclip: " .. table.concat(list,", "),list,user.Name .. " has made you noclip, press C to toggle."
end

return command
