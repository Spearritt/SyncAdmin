
--      @Description: Synchronized Admin Commands
--      @Author: VolcanoINC, DataSynchronized
--      @Date of Creation: 30th, April, 2016

local command = {}
command.PermissionLevel = 0
command.Shorthand = {"cmderr"}
command.Params = { "Optional:String" }
command.Usage = "CommandErrors"
command.Description = [[Displays a list of errors that commands have experienced]] 

--// Now to the actual command
command.Init = function(main)
end

function getModuleName(i,main,mainModule)
	local iName = i.Name
	local inst = i
	
	if (i:IsDescendantOf(main)) then
		while (inst:IsDescendantOf(main.Plugins)) do iName = inst.Name .. "." .. iName inst = inst.Parent end
		return "Plugins." .. iName
	else
		while (inst:IsDescendantOf(mainModule.CorePlugins)) do iName = inst.Name .. "." .. iName inst = inst.Parent end
		return "Core." .. iName
	end
end

command.Run = function(main,user)
	local text = ""
	if (filter == nil) then filter = "" end
	local showAll = (filter:lower() == "show-core")
	
	local errors = CoreAPI.GetPluginErrors()
	local mainModule = CoreAPI.GetMainModule()
	
	local text = ""
	for k,v in pairs(errors) do
		if (not v.IsCore or showAll) then
			local colorStr = "255,150,0"
			local icon = "rbxassetid://156507320"
			
			if (v.IsCritical) then 
				colorStr = "255,0,0" 
				icon = "rbxassetid://751603341"
			end
			
			text = text .. "<textbox color=" .. colorStr .. " image=" .. icon .. ">\n"
			text = text .. "<font size=18>\n" .. v.Title .. "\n</font>\n"
			text = text .. "<hr color=" .. colorStr .. ">\n"
			text = text .. v.Error .. "\n"
			if (v.Module) then
				if (v.OtherModule) then
					text = text .. "Modules: \n" .. getModuleName(v.Module,main,mainModule) .. "\n" .. getModuleName(v.OtherModule,main,mainModule) .. "\n"
				else
					text = text .. "Module: \n" .. getModuleName(v.Module,main,mainModule) .. "\n"
				end
			end
			text = text .. "</textbox>\n"
		end
	end
	SyncAPI.DisplayScrollMessage(user,"COMMAND ERROR LIST",text)
end

return command
