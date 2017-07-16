
--      @Description: This plugin uses String Manipulation to give users tools with the provided name.
--      @Author: Dark_Messiah

local command = {}
command.PermissionLevel = 1 
command.Shorthand = {"gt","givet"}
command.Params = {"PlayerList","..."}
command.Usage = "givetool Player Tool Name"
command.Description = [[Gives tool(s) from ServerStorage, ReplicatedStorage, and Lighting to Player(s)]]

command.Init = function(main)
end

command.Run = function(main,user,users,...)
	if (user == nil) then error("No user found") end
	local message = table.concat({...}," ")
	local Tools = {}
	local ToolNames = {}
	local SearchThese = {game:GetService("ServerStorage"),game:GetService("ReplicatedStorage"),game:GetService("Lighting")} -- Add/Remove to change where it searches for tools.  
	
	for _,Search in pairs(SearchThese) do
		for _,Tl in pairs(Search:GetChildren()) do
			if (Tl:IsA("Tool") or Tl:IsA("HopperBin")) then
				if (string.sub(string.lower(Tl.Name),1,string.len(message)) == string.lower(message)) or string.lower(message)=="all" then
					table.insert(Tools,Tl)
					table.insert(ToolNames,Tl.Name)
				end
			end
		end
	end
	
	
	if #Tools == 0 then 
		return false,"Selected tool was not found"
	end
	
	local list = {}
	
	for _,player in pairs(users) do
		for _,Tool in pairs(Tools) do
			Tool:Clone().Parent = player.Backpack
		end
		
		table.insert(list,player.Name)
	end
	return true,"Gave users: " .. table.concat(list,", ") .. " these tool(s): "..table.concat(ToolNames,", ")
end

return command