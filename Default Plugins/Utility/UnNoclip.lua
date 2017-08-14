
--      @Description: Disables noclip of selected user(s).
--      @Author: AmbientOcclusion

--//	jeez the name for it, (un-no-clip, the un-no, unno, aaaaaaaaAAaAaAaAaAAAAAA)
--//	still better than nonoclip tho

local command = {};
command.PermissionLevel = 1;
command.Shorthand = "unclip";
command.Params = {"Optional:PlayerList"};
command.Usage = "unnoclip Player1,Player2,...";
command.Description = [[Removes noclip from the specified user(s).]];

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (users == nil or #users == 0) then
		users = {user};
	end
	
	local list = {};
	for _,plr in next, users do
		if plr.Character then
			local noclipScript = plr.Character:FindFirstChild'NoclipScript';
			if noclipScript then
				if noclipScript:FindFirstChild'UnNoclip' then
					local result = noclipScript:FindFirstChild'UnNoclip':InvokeClient(plr);
					if result then
						table.insert(list, plr.Name);
					end
				end
			end
		end
	end
	return true,"Removed noclip from the user(s): " .. table.concat(list,", "),list,user.Name .. " removed your noclip";
end

return command;
