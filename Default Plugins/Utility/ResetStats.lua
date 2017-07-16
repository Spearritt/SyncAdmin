
--      @Description: Synchronized Admin Plugin
--      @Author: skeletonarcher12

local command = {}
command.PermissionLevel = 1 -- Set the plugin permission level
command.Shorthand = nil -- Set the plugin shorthand
command.Params = {"PlayerList","String"} -- Set the plugin parameters
command.Usage = "resetstats player leaderstat/all" -- Set the plugin usage
command.Description = [[Resets the player's leaderstat(s). Only accepts IntValue, NumberValue, BoolValue, and StringValue]]  -- Set the plugin description

command.Init = function(main)
end

command.Run = function(main,user,users,stat)
	local list = {}
	for _,player in pairs(users) do
		if player:FindFirstChild('leaderstats')~=nil then
			if string.lower(stat)~='all' then
				if player.leaderstats:FindFirstChild(stat)~=nil then
					local leadstat = player.leaderstats:FindFirstChild(stat)
					
					if leadstat:IsA("IntValue") then
						leadstat.Value = 0
					elseif leadstat:IsA("NumberValue") then
						leadstat.Value = 0
					elseif leadstat:IsA("StringValue") then
						leadstat.Value = ""
					elseif leadstat:IsA("BoolValue") then
						leadstat.Value = false
					else
						return false, "The type of leaderstat is invalid."
					end
				else
					return false,"No leaderstat value matching name"
				end
			elseif string.lower(stat)=="all" then
				for _,Stat in pairs(player.leaderstats:GetChildren()) do
					if Stat:IsA("IntValue") then
						Stat.Value = 0
					elseif Stat:IsA("NumberValue") then
						Stat.Value = 0
					elseif Stat:IsA("StringValue") then
						Stat.Value = ""
					elseif Stat:IsA("BoolValue") then
						Stat.Value = false
					end
				end
			end
		end
		
		table.insert(list,player.Name)
	end
	
	return true,"Reset users " .. table.concat(list,", ") .. " stats " .. stat,
		list,user.Name .. " has reset your stats " .. stat
end

return command