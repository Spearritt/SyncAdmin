--[[
	  ____                      _       _           _       
	 / ___| _   _ _ __   ___   / \   __| |_ __ ___ (_)_ __  
	 \___ \| | | | '_ \ / __| / _ \ / _` | '_ ` _ \| | '_ \ 
	  ___) | |_| | | | | (__ / ___ \ (_| | | | | | | | | | |
	 |____/ \__, |_| |_|\___/_/   \_\__,_|_| |_| |_|_|_| |_|
	        |___/                                                                                         
	               
	@Description: SyncAdmin plugin command to create a light source for the selected player using the provided RGB value.
	@Author: Dominik [VolcanoINC], Hannah Jane [DataSynchronized]
	@Editor: SolidBlocks
--]]

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"dspark"}
command.Params = {"String"}
command.Usage = "dsparkle <R,G,B / BrickColor>"
command.Description = "[Donator]: Gives you sparkles. [Help]: R,G,B = Red, Green, Blue values with a range of 0-255 (e.g :dsparkle 255,0,0 That'd be red!). BrickColor = e.g Bright-blue (Example: :dsparkle Bright-blue)"
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

command.Run = function(main, user, color)
	if (user == nil) then error("No user found") end
	if (color == nil) then error("Color is required") end
	
	if color:match(",") then
		local color = strSplit(color, ",")
		local r,g,b = tonumber(color[1]),tonumber(color[2]),tonumber(color[3])
		if (r == nil or g == nil or b == nil) then error("Invalid color value") end
		local color = Color3.fromRGB(r, g, b)
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
			if (user.Character.HumanoidRootPart:findFirstChild("Sparkles")) then
				user.Character.HumanoidRootPart.Sparkles.SparkleColor = color
			else
				Instance.new("Sparkles",user.Character.HumanoidRootPart).SparkleColor = color
			end
		end
	else
		local color = string.gsub(color, "-", " ")
		if (color == nil) then error("Invalid brickcolor value") end
		local color = BrickColor.new(color).Color
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
			if (user.Character.HumanoidRootPart:findFirstChild("Sparkles")) then
				user.Character.HumanoidRootPart.Sparkles.SparkleColor = color
			else
				Instance.new("Sparkles",user.Character.HumanoidRootPart).SparkleColor = color
			end
		end
	end
	return true,"Given sparkles to player."
end

return command
