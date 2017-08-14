--//	@Description: SyncAdmin plugin command to make users unfly.
--//	@Author: AmbientOcclusion

local command = {};
command.PermissionLevel = 1;
command.Shorthand = "nofly";
command.Params = {"Optional:PlayerList"};
command.Usage = "unfly Player1,Player2,...";
command.Description = [[Removes fly from the user(s).]];

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then
		users = {user}
	end
	
	local list = {}
	for _,player in pairs(users) do
		if player.Character then
			local flyScript = player.Character:FindFirstChild'SA_FlyScript';
			if flyScript then
				if flyScript:FindFirstChild'UnFly' then
					if flyScript:FindFirstChild'UnFly':InvokeClient(player) then
						table.insert(list, player.Name);
					end
				end
			end
		end
	end
	return true,"Removed fly from the user(s): " .. table.concat(list,", "),list,user.Name .. " has removed your fly."
end

return command;
