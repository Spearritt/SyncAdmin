--[[  ____                      _       _           _
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/

	@Description: SyncAdmin plugin to ban users from your game
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]

	Credits go to lukezammit and AmbientOcclusion.
]]--

local Players = game:GetService("Players");
local DataStore = game:GetService("DataStoreService");

local function TimeFormat(TimeInSeconds)
	local Rounded = math.ceil(TimeInSeconds);
	local Calculated do
		if Rounded >= 31104000 then -- Time in seconds of a year
			Calculated = {math.ceil(Rounded/31104000), "year(s)"};
		elseif Rounded >= 604800 then -- Time in seconds of a month
			Calculated = {math.ceil(Rounded/2592000), "month(s)"};
		elseif Rounded >=604800 then -- Time in seconds of a week
			Calculated = {math.ceil(Rounded/604800), "week(s)"};
		elseif Rounded >= 86400 then -- Time in seconds of a day
			Calculated = {math.ceil(Rounded/86400), "day(s)"};
		elseif Rounded >= 3600 then -- Time in seconds of an hour
			Calculated = {math.ceil(Rounded/3600), "hour(s)"};
		elseif Rounded >= 60 then -- Time in seconds of an minute
			Calculated = {math.ceil(Rounded/60), "minute(s)"};
		else
			Calculated = {math.ceil(Rounded), "second(s)"};
		end
	end
	return Calculated
end

local command = {};
command.PermissionLevel = 2;
command.Shorthand = {"tban"};
command.Params = {"PlayerList","..."};
command.Usage = "tempban Player1,Player2 Number Minutes/Days Reason";
command.Description = [[Temporary bans someone for a certain amount of time. Acceptable time types: seconds, minutes, hours, days, weeks, years]];
command.Init = function(main)
	Players.PlayerAdded:connect(function(player)
		local Data = DataStore:GetDataStore(player.UserId.."_SyncAdminTempBan")--UserId is static, Name isn't.
		local TimeInSeconds = Data:GetAsync("TimeLeft")
		local ReasonForTBan = Data:GetAsync("Reason")
		if TimeInSeconds == nil then
			Data:SetAsync("TimeLeft", 0)
		else
			TimeInSeconds = tonumber(TimeInSeconds)
			if ( TimeInSeconds > 0 and TimeInSeconds - os.time() > 0 ) then
				local format = 	TimeFormat(TimeInSeconds - os.time());-->This will return a table, format[1] --> Time left, format[2] --> The time format
				local display = format[1]..format[2];
				local reason = ReasonForTBan
				player:Kick("You have been kicked from the server.\nReason: "..reason..".\n Time left until ban is lifted: "..display..".");
			end
		end
	end)
end

command.Run = function(main,user,players,...)
	if user == nil then error("No user found.") else
		local Suffix = {...}
		local TimeLength;
		local Time;
		local Reason;
		if Suffix[1] ~= nil and Suffix[2] ~= nil then
			if (Suffix[1]:match("%d+")) then
				Time = tonumber(Suffix[1]:match("%d+"))
				local Argument = Suffix[2]:lower()
				if (Argument == "s" or Argument == "sec" or Argument == "second" or Argument == "seconds") then
		            Time = Time;
		        elseif (Argument == "m" or Argument == "min" or Argument == "minute" or Argument == "minutes") then
		            Time = Time * 60;
		        elseif (Argument == "h" or Argument == "hour" or Argument == "hours") then
		            Time = Time * 3600;
		        elseif (Argument == "d" or Argument == "day" or Argument == "days") then
		            Time = Time * 86400;
		        elseif (Argument == "w" or Argument == "week" or Argument == "weeks") then
		            Time = Time * 604800;
		        elseif (Argument == "mt" or Argument == "month" or Argument == "months") then
		            Time = Time * 2592000;
		        elseif (Argument == "y" or Argument == "year" or Argument == "years") then
		            Time = Time * 31104000;
				else
					error("Invalid second argument.");
				end
				print(Time)
				TimeLength = TimeFormat(Time)[1].." "..TimeFormat(Time)[2];--Time instead of Suffix[1] Weird.
				Reason = table.concat(Suffix, " ", 3) or "Unspecified";
			else
				error("Invalid first argument.");
			end
		else
			error("Invalid amount of arguments.");
		end

		local plrnames = {};
		for _,player in pairs (players) do
			if not (SyncAPI.GetPermissionLevel(user) > SyncAPI.GetPermissionLevel(player)) then
				return false, "You cannot run this command on someone with a higher permission level than you.";
			else
				local Storage = DataStore:GetDataStore(player.UserId.."_SyncAdminTempBan");
				local TimeStorage = Storage:GetAsync("TimeLeft");
				local ReasonStorage = Storage:GetAsync("Reason");
				local Reason = game:GetService("Chat"):FilterStringForBroadcast(Reason, user);
				local TimeLeftUntilLift = Time + os.time()

				Storage:SetAsync("TimeLeft", TimeLeftUntilLift);
				Storage:SetAsync("Reason", Reason);
				player:Kick("You have been kicked from the server.\nReason: "..Reason..".\n Time left until ban is lifted: "..TimeLength..".");
				table.insert(plrnames, player.Name);
			end
		end
		return true,"Temporary banned "..table.concat(plrnames, ", ").." for: "..TimeLength..", Reason: "..Reason..".";
	end
end

return command;
