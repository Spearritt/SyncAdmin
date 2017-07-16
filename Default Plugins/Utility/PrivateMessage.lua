local command = {}
command.PermissionLevel = 1
command.Shorthand = "pm"
command.Params = {"PlayerList","..."}
command.Usage = "privatemessage Player1,Player2,Player3,... Your text here"
command.Description = [[Displays the given message to the given players for 5 
seconds.]] 

local rstore = game:GetService("ReplicatedStorage")
command.Init = function(main)
end

local options = {
	{ Color = Color3.new(1,0,0); Text = "Close"; },
	{ Color = Color3.new(0,1,0); Text = "Reply"; },
}

local roptions = {
	{ Color = Color3.new(1,0,0); Text = "Cancel"; },
	{ Color = Color3.new(0,1,0); Text = "Send"; },
}

command.Run = function(main,user,users,...)
	if (user == nil) then error("No user found") end
	local message = table.concat({...}," ")
	local list = {}
	for _,player in pairs(users) do
		do
			local p = player
			local msg = game:GetService("Chat"):FilterStringAsync(message,user,p)
			if (game:GetService("Chat"):CanUsersChatAsync(user.UserId,p.UserId)) then
				spawn(function()
					local notify = SyncAPI.DisplayNotification(p,"Private message from " .. user.Name .."! Click here to view.","Exclamation",120)
					notify.Clicked:connect(function() 
						local response = SyncAPI.DisplayQuestionMessage(p,"PM from " .. user.Name,msg,"Exclamation",options)
						if (response == "Reply") then
							local btn,msg = SyncAPI.DisplayTextInput(player,"Reply to " .. user.Name,"Type a reply to " .. p.Name,"Check",roptions)
							if (btn == "Send") then
								command.Run(main,p,{user},msg)
							end
						end
					end)
				end)
			end
		end
		table.insert(list,player.Name)
	end
	return true,"Shown message to users: " .. table.concat(list,", ")
end

return command
