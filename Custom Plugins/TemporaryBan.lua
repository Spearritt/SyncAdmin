--[[  ____                      _       _           _
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/

	@Description: SyncAdmin plugin to ban users from your game
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]

	Temporary Ban [Remade]

	This should be a better version for the temporary ban.

	Notes;
	Banning without a reason will only display the time left for a person to be unbanned

	This uses tick() yes.
	All the bans are stored on the game's datastore.

	Credits go to lukezammit and AmbientOcclusion.

	Note from luke,
	I've added some webhook support for those who need it.

	Max time is years.
]]--

local Players = game:GetService("Players");
local DataStore = game:GetService("DataStoreService");

local function TimeFormat(TimeInSeconds)
	local Rounded = math.ceil(TimeInSeconds);
	local Calculated do
		if Rounded >= 3.154e+7 then -- Time in seconds of a year
			Calculated = {math.ceil(Rounded/3.154e+7), "year(s)"};
		elseif Rounded >= 2.628e+6 then -- Time in seconds of a month
			Calculated = {math.ceil(Rounded/2.628e+6), "month(s)"};
		elseif Rounded >=604800 then -- Time in seconds of a week
			Calculated = {math.ceil(Rounded/1.65344e-6), "week(s)"};
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
			if ( TimeInSeconds > 0 and TimeInSeconds - tick() <= 0 ) then
				--If you have a webhook you could use the format below to be sent to your webhook
				local format = 	TimeFormat(TimeInSeconds - tick());-->This will return a table, format[1] --> Time left, format[2] --> The time format
				local display = format[1]..format[2];
				local reason;
				if ( ReasonForTBan == nil or ReasonForTBan == "" ) then
					reason = "Unspecified";
				else
					reason = ReasonForTBan;
				end
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
			if (Suffix[1]:match("%d+")~=nil) then
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
		            Time = Time * 2.628e+6;
		        elseif (Argument == "y" or Argument == "year" or Argument == "years") then
		            Time = Time * 3.154e+7;
				else
					error("Invalid second argument.");
				end

				TimeLength = TimeFormat(Suffix[1])[1].." "..TimeFormat(Suffix[1])[2];

				if Suffix[3]~=nil then
					Reason = Suffix[3] else Reason = "Unspecified";
				end
			else
				error("Invalid first argument.");
			end
		else
			error("Invalid amount of arguments.");
		end

		for _,player in pairs (players) do
			if not (SyncAPI.GetPermissionLevel(user) > SyncAPI.GetPermissionLevel(player)) then
				return false, "You cannot run this command on someone with a higher permission level than you.";
			else
				local Storage = DataStore:GetDataStore(player.UserId.."_SyncAdminTempBan");
				local TimeStorage = Storage:GetAsync("TimeLeft");
				local ReasonStorage = Storage:GetAsync("Reason");
				local Reason = game:GetService("Chat"):FilterStringForBroadcast(Reason, user);

				Storage:SetAsync("TimeLeft", Time + tick());
				Storage:SetAsync("Reason", Reason);
				player:Kick("You have been kicked from the server.\nReason: "..Reason..".\n Time left until ban is lifted: "..TimeLength..".");
			end
		end
		return true,"Temporary banned "..table.concat(players, ", ").." for: "..TimeLength..", Reason: "..Reason..".";
	end
end

return command;
