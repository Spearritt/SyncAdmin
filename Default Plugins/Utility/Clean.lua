--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to clear the game of dropped tools and hats.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Usage = "clean"
command.Description = [[Cleans up dropped hats and tools.]] 

local settings = {
	["auto-clean"]  = true;
	["clean-delay"] = 60;
}

command.Init = function(main)
	workspace.ChildAdded:connect(function(item)
		if (item:IsA("Tool") or item:IsA("Hat") or item:IsA("Accoutrement")) then
			local t = 0
			local done,delete = false,true
			wait(0.5)
			item.AncestryChanged:connect(function() done = true delete = false end)
			
			while (t < settings["clean-delay"] and not done and settings["auto-clean"]) do
				t = t + wait()
			end
			
			if (delete and settings["auto-clean"]) then item:Destroy() end
		end
	end)
end

command.Run = function(main,user,setting,value)
	if (setting == "" or setting == nil) then
		local count = 0
		for _,b in pairs(workspace:children()) do
			if (b:IsA("Tool") or b:IsA("Hat") or b:IsA("Accoutrement")) then
				b:Destroy()
				count = count + 1
			end
		end
		return true,"Cleaned up " .. count .. " items"
	elseif (settings[setting] ~= nil) then
		local stype = type(settings[setting])
		if (stype == "boolean") then
			if (value == "true") then
				settings[setting] = true
			elseif (value == "false") then
				settings[setting] = false
			else
				return false,tostring(value) .. " is not a valid value for type boolean"
			end
		elseif (stype == "number") then
			local n = tonumber(value)
			if (n) then
				settings[setting] = n
			else
				return false,tostring(value) .. " is not a valid value for type number"
			end
		end
	else
		return false,tostring(setting) .. " is not a valid setting for clean"
	end
end

return command
