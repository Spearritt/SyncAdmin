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
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"String", "Optional:Number"}
command.Usage = "dlight <R,G,B / BrickColor / off> [range]"
command.Description = "[Donator]: Creates a light around the player. [Help]: R,G,B = Red, Green, Blue values with a range of 0-255 (e.g :dlight 255,0,0 That'd be red!). BrickColor = e.g Bright-blue (Example: :dlight Bright-blue)"
command.AllowDonators = true

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

command.Run = function(main, user, color, range)
	if (user == nil) then error("No user found") end
	if (color == nil) then error("Color is required") end
	if (range == nil) then range = 8 end
	if (range > 16) then error("Range must be 16 or less!") end
	
	if (color == "off") then
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart") and user.Character.HumanoidRootPart:findFirstChild("PointLight")) then
			user.Character.HumanoidRootPart.PointLight:Destroy()
		end
		return true,"Removed lights."
	else
		if color:match(",") then
			local color = strSplit(color,",")
			local r,g,b = tonumber(color[1]),tonumber(color[2]),tonumber(color[3])
			if (r == nil or g == nil or b == nil) then error("Invalid color value") end
			local color = Color3.fromRGB(r, g, b)
			if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
				if (user.Character.HumanoidRootPart:findFirstChild("PointLight")) then
					user.Character.HumanoidRootPart.PointLight.Brightness = 1.25
					user.Character.HumanoidRootPart.PointLight.Color = color
					user.Character.HumanoidRootPart.PointLight.Range = range
				else
					local light = Instance.new("PointLight",user.Character.HumanoidRootPart)
					light.Color = color
					light.Range = range
				end
			end
		else
			local color = string.gsub(color, "-", " ")
			if (color == nil) then error("Invalid brickcolor value") end
			local color = BrickColor.new(color).Color
			if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
				if (user.Character.HumanoidRootPart:findFirstChild("PointLight")) then
					user.Character.HumanoidRootPart.PointLight.Brightness = 1.25
					user.Character.HumanoidRootPart.PointLight.Color = color
					user.Character.HumanoidRootPart.PointLight.Range = range
				else
					local light = Instance.new("PointLight",user.Character.HumanoidRootPart)
					light.Color = color
					light.Range = range
				end
			end
		end
		return true,"Given light to player."
	end
end

return command
