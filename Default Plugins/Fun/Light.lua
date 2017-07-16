--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to create a light source for the selected player using the provided RGB value.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
--]]

local command = {}
command.PermissionLevel = 2
command.Shorthand = nil
command.Params = {"PlayerList","String"}
command.Usage = "light Player1,Player2,Player3,... R,G,B/off"
command.Description = [[Creates a light around the player]] 

function strSplit(inputstr,sep)
	local t,i = {},1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

command.Init = function(main)
end

command.Run = function(main,user,users,color)
	if (user == nil) then error("No user found") end
	if (users == nil) then error("Users is required") end
	if (color == nil) then error("Color is required") end
	
	
	if (color == "off") then
		local list = {}
		for _,player in pairs(users) do
			if (player.Character and player.Character:findFirstChild("HumanoidRootPart") and player.Character.HumanoidRootPart:findFirstChild("PointLight")) then
				player.Character.HumanoidRootPart.PointLight:Destroy()
			end
			table.insert(list,player.Name)
		end
		return true,"Removed lights from: " .. table.concat(list,", ")
	else
		local color = strSplit(color,",")
		local r,g,b = tonumber(color[1]),tonumber(color[2]),tonumber(color[3])
		if (r == nil or g == nil or b == nil) then error("Invalid color value") end
		local color = Color3.new(r/255,g/255,b/255)
		local list = {}
		for _,player in pairs(users) do
			table.insert(list,player.Name)
			if (player.Character and player.Character:findFirstChild("HumanoidRootPart")) then
				if (player.Character.HumanoidRootPart:findFirstChild("PointLight")) then
					player.Character.HumanoidRootPart.PointLight.Brightness = 2
					player.Character.HumanoidRootPart.PointLight.Color = color
				else
					Instance.new("PointLight",player.Character.HumanoidRootPart).Color = color
				end
			end
		end
		return true,"Given light to players: " .. table.concat(list,", "),list,user.Name .. " has given you a light."
	end
end

return command
