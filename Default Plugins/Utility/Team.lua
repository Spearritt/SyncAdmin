
--      @Description: This plugin uses String Manipulation to Team Users to the Provided Team Name if such team exists.
--      @Author: Dark_Messiah

local command = {}
command.PermissionLevel = 1 
command.Shorthand = nil
command.Params = {"PlayerList","..."}
command.Usage = "team bobdylan,nobleprize,winner.... Red Team"
command.Description = [[Allows you to change the TeamColor of the Player(s) provided to the Team Name provided.]]

command.Init = function(main)
end

command.Run = function(main,user,users,...)
	if (user == nil) then error("No user found") end
	local message = table.concat({...}," ")
	local Team = nil
	
	for _,Tm in pairs(game:GetService("Teams"):GetChildren()) do
		if string.sub(string.lower(Tm.Name),1,string.len(message)) == string.lower(message) then
			Team = Tm
			break
		end
	end
	
	if Team == nil then 
		return false,"Selected team was not found"
	end
	
	local list = {}
	for _,player in pairs(users) do
		local p = player
		p.TeamColor = Team.TeamColor

		table.insert(list,player.Name)
	end
	return true,"Changed users: " .. table.concat(list,", ") .. " Team to "..Team.Name
end

return command