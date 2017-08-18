--[[  ____                      _       _           _
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/
	@Description: SyncAdmin plugin to unban a user from your game
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
	
	Credits go to lukezammit.
]]--

local Players = game:GetService("Players");
local DataStore = game:GetService("DataStoreService");

local command = {};
command.PermissionLevel = 2;
command.Shorthand = {"tunban"};
command.Params = {"..."};
command.Usage = "tempunban UsedId";
command.Description = [[Unbans a person from the Temporary ban from it's UserId.]];
command.Init = function(main)
end

command.Run = function(main,user,...)
	if (user == nil) then error("No user found") end
	local UserId = {...};
	local succ, err = pcall(function() local player = Players:GetNameFromUserIdAsync(tonumber(UserId[1])) end);
	if (succ) then
		local Storage = DataStore:GetDataStore(UserId[1].."_SyncAdminTempBan")	;
		local TimeStorage = Storage:GetAsync("TimeLeft");
		local ReasonStorage = Storage:GetAsync("Reason");
		Storage:SetAsync("TimeLeft", 0);
		Storage:SetAsync("Reason", "")	;
		return true,"Unbanned "..Players:GetNameFromUserIdAsync(tonumber(UserId)).." from the temporary ban.";
	else
		return false,"This user does not exist.";
	end
end

return command
