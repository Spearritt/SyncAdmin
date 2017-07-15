
--      @Description: Synchronized Admin Commands
--      @Author: VolcanoINC, DataSynchronized
--      @Date of Creation: 30th, April, 2016

local command = {}
command.PermissionLevel = 0
command.Shorthand = {"cmds","help"}
command.Params = {"Optional:String"}
command.Usage = "commands [show-all]"
command.Description = [[Displays a list of commands available to the user.]] 

--// Now to the actual command
command.Init = function(main)
end

command.Run = function(main,user,filter)
	local text = ""
	if (filter == nil) then filter = "" end
	local showAll = (filter:lower() == "show-all")
	
	local commands = CoreAPI.GetCommands()
	local settings = CoreAPI.RetrieveSettings()
	
	local tblClone = {}
	for k,v in pairs(commands) do 
		tblClone[k] = v 
		v.AlreadyShown = false
	end
	
	local permlevel = 0
	local function customIterator()
		for k,v in pairs(tblClone) do
			if (v.AlreadyShown or v[3]) then
				tblClone[k] = nil
			elseif (v[1] == nil) then
				if (permlevel == 3) then
					tblClone[k] = nil
					v.AlreadyShown = true
					return k,nil,v[4]
				end
			elseif (v[1].PermissionLevel <= permlevel) then
				tblClone[k] = nil
				v.AlreadyShown = true
				return k,v[1],v[4]
			end
		end
		permlevel = permlevel + 1
		if (permlevel > 6) then
			return nil,nil,nil
		else
			return customIterator()
		end
	end
	
	local isDonator = CoreAPI.IsDonator(user)
	
	for key,value,isOk in customIterator do
		if (showAll or value == nil or CoreAPI.CheckIsAllowedToRun(user,value,isDonator)) then 
			local colorstr = "255,255,255"
			if (value) then
				if (value.PermissionLevel == 0) then colorstr = "253,79,56" end
				if (value.PermissionLevel == 1) then colorstr = "0,221,73" end
				if (value.PermissionLevel == 2) then colorstr = "11,158,255" end
				if (value.PermissionLevel == 3) then colorstr = "165,68,221" end
				if (value.PermissionLevel == 4) then colorstr = "255,165,62" end
				if (value.PermissionLevel == 5) then colorstr = "50,50,50" end
				
				if (value.PermissionLevel > CoreAPI.GetPermissionLevel(user) 
						and value.AllowDonators and settings.AllowDonatorPermissions) then 
					colorstr = "0,255,255" 
				end
			else
				colorstr = "255,0,0"
			end
			
			local img = ""
			local pretext
			if (not isOk) then
				if (value) then
					img = "rbxassetid://156507320"
					pretext = "This command had an error during initialization and may not work correctly."
				else
					img = "rbxassetid://751603341"
					pretext = "This command had an error during loading and does not function."
				end
			else
				img = value.Image
			end
			
			text = text .. "<textbox color=" .. colorstr .. " image=" .. tostring(img) .. ">\n"
			
			text = text .. "<font size=18>\n"
			
			if (value) then
				if (value.Usage) then
					text = text .. settings.CmdPrefix .. value.Usage .. "\n"
				else
					text = text .. settings.CmdPrefix .. key .. " [No usage info]\n"
				end
				text = text .. "</font>\n<hr color=" .. colorstr .. ">\n"
				if (pretext) then text = text .. pretext .. "\n" end
				
				if (value.Shorthand) then
					if (type(value.Shorthand) == "string") then
						text = text .. "Shorthand: " .. value.Shorthand .. "\n"
					elseif (type(value.Shorthand) == "table" and #value.Shorthand > 0) then
						text = text .. "Shorthands: " .. table.concat(value.Shorthand,", ") .. "\n"
					end
				end
				
				text = text .. "Command permission level: " .. value.PermissionLevel .. "\n"
				text = text .. "Your permission level: "    .. CoreAPI.GetPermissionLevel(user) .. "\n"
				if (value.Description) then
					text = text .. value.Description .. "\n</textbox>\n"
				else
					text = text .. "No description available\n</textbox>\n"
				end
			else
				text = text .. settings.CmdPrefix .. key .. " [No usage info]\n"
				text = text .. "</font>\n<hr color=" .. colorstr .. ">\n"
				if (pretext) then text = text .. pretext .. "\n" end
				text = text .. "</textbox>\n"
			end
		else
			break
		end
	end
	SyncAPI.DisplayScrollMessage(user,"COMMAND LIST",text)
end

return command
