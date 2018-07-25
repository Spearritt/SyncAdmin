--stillunt1tled
local command = {};
command.PermissionLevel = 2;
command.Shorthand = "csm";
command.Params = {"..."};
command.Usage = "chatsystemmessage Your text here";
command.Description = [[Displays the given message to all users anonymously inside of the chat.]];

command.Init = function(main)
end

command.Run = function(main,user,...)
	local message = "[SYSTEM]: "..game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user);
	local createMessage = script:FindFirstChild("createMessage"); 
	for _,player in pairs(game:GetService("Players"):GetPlayers()) do
		if (createMessage ~= nil) then
			local cmc = createMessage:Clone();
			cmc.Parent = player.PlayerGui;
			cmc.Disabled = false;
			cmc.Name = message;
		else
			return false,"Dependency createMessage missing!"			
		end
	end
	return true,"Shown system message in chat."
end

return command;