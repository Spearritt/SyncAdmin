local command = {};
command.PermissionLevel = 1;
command.Shorthand = {"rhats","remhats"};
command.Params = {"PlayerList"};
command.Usage = "removehats Player1,Player2,...";
command.Description = [[Removes all hats from players' character]];


command.Init = function()
end

command.Run = function(main,user,users)
	local list = {};
	for _,plr in pairs(users) do
		if (plr.Character) then
			for _,acc in pairs(plr.Character:children()) do
				if acc:IsA'Accessory' then
					acc:Destroy();
				end
			end
			table.insert(list, plr.Name);
		end
	end
	return true,"Removed hats from " .. table.concat(list,", "),list,user.Name .. " removed your hats.";
end

return command