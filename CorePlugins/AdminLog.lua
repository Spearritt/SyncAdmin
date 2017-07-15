local command = {}
command.PermissionLevel = 1
command.Shorthand = {"logs","alog"}
command.Params = {"Optional:String","..."}
command.Usage = "adminlog"
command.Description = [[Displays a log of all commands that were run. Currently
the only available option is "search".]] 

local rstore = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local ssvc = game:GetService("ServerScriptService")

command.Init = function(main)
end

command.Run = function(main,user,option,...)
	local adminlog = SyncAPI.GetAdminLog()
	local nChatlog = {}
	if (option == "search") then
		nChatlog = {}
		local search = table.concat({...}," ")
		for _,ln in pairs(adminlog) do
			if (string.find(ln:lower(),search:lower())) then table.insert(nChatlog,ln) end
		end
	else
		for a = math.max(1,#adminlog-500),#adminlog do
			table.insert(nChatlog,adminlog[a])
		end
	end
	local final = {}
	for a = #nChatlog,1,-1 do
		table.insert(final,nChatlog[a])
	end
	SyncAPI.DisplayScrollMessage(user,"Admin Log",table.concat(final,"\n"))
end

return command
