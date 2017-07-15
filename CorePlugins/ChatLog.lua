local command = {}
command.PermissionLevel = 1
command.Shorthand = {"chatlogs","chatl","clog"}
command.Params = {"Optional:String","..."}
command.Usage = "chatlog [Option] [Parameters]"
command.Description = [[Displays a chatlog, newest message first. Currently
the only available option is "search".]] 

local rstore = game:GetService("ReplicatedStorage")
local players = game:GetService("Players")
local ssvc = game:GetService("ServerScriptService")

command.Init = function(main)
end

command.Run = function(main,user,option,...)
	local chatlog = SyncAPI.GetChatLog()
	local nChatlog = {}
	if (option == "search") then
		nChatlog = {}
		local search = table.concat({...}," ")
		for _,ln in pairs(chatlog) do
			if (string.find(ln:lower(),search:lower())) then table.insert(nChatlog,ln) end
		end
	else
		for a = math.max(1,#chatlog-500),#chatlog do
			table.insert(nChatlog,chatlog[a])
		end
	end
	local final = {}
	for a = #nChatlog,1,-1 do
		table.insert(final,nChatlog[a])
	end
	SyncAPI.DisplayScrollMessage(user,"Chatlog",table.concat(final,"\n"))
end

return command
