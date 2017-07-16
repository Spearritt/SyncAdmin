
--      @Description: Synchronized Admin Commands
--      @Author: VolcanoINC, DataSynchronized

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"unfreeze"} 
command.Params = {"Optional:PlayerList"}
command.Usage = "thaw Player"
command.Description = [[Thaw a selected player.]] 

--// Now to the actual command
command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user == nil) then error("No user found") end
	if (users == nil or #users == 0) then users = {user} end
	
	local list = {}
	for _,player in pairs(users) do
		table.insert(list,player.Name)
		local char = player.Character
        if char ~= nil then
			function thaw (x)
			    for _,i in pairs (x:children()) do
			        thaw (i)
			        if i:IsA("BasePart") then
			            i.Anchored = false
						char.Humanoid.WalkSpeed = "16"
			        end
				end
			end
			
			thaw (char)
        end
	end
	return true,"Thawed players: " .. table.concat(list,", "),list,user.Name .. " has thawed you."
end

return command
