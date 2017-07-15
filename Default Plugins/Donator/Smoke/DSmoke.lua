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
command.Shorthand = nil
command.Params = {"String", "Optional:Number", "Optional:Number"}
command.Usage = "dsmoke <R,G,B / BrickColor> [size] [opacity]"
command.Description = "[Donator]: Gives you smoke. [Help]: R,G,B = Red, Green, Blue values with a range of 0-255 (e.g :dsmoke 255,0,0 That'd be red!). BrickColor = e.g Bright-blue (Example: :dsmoke Bright-blue)"
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

command.Run = function(main, user, color, size, opacity)
	if (user == nil) then error("No user found") end
	if (color == nil) then error("Color is required") end
	if (size == nil) then size =  1 end
	if (size > 2) then error("Size must be less than or equal to 2!") end
	if (opacity == nil) then opacity = 0.3 end
	
	if color:match(",") then
		local color = strSplit(color,",")
		local r,g,b = tonumber(color[1]),tonumber(color[2]),tonumber(color[3])
		if (r == nil or g == nil or b == nil) then error("Invalid color value") end
		local color = Color3.fromRGB(r, g, b)
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
			if (user.Character.HumanoidRootPart:findFirstChild("Smoke")) then
				user.Character.HumanoidRootPart.Smoke.Color = color
				user.Character.HumanoidRootPart.Smoke.Size = size
				user.Character.HumanoidRootPart.Smoke.Opacity = opacity
			else
				local smoke = Instance.new("Smoke", user.Character.HumanoidRootPart)
				smoke.Color = color
				smoke.Size = size
				smoke.Opacity = opacity
			end
		end
	else
		local color = string.gsub(color, "-", " ")
		if (color == nil) then error("Invalid brickcolor value") end
		local color = BrickColor.new(color).Color
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
			if (user.Character.HumanoidRootPart:findFirstChild("Smoke")) then
				user.Character.HumanoidRootPart.Smoke.Color = color
				user.Character.HumanoidRootPart.Smoke.Size = size
				user.Character.HumanoidRootPart.Smoke.Opacity = opacity
			else
				local smoke = Instance.new("Smoke", user.Character.HumanoidRootPart)
				smoke.Color = color
				smoke.Size = size
				smoke.Opacity = opacity
			end
		end
	end
	return true,"Given smoke to player."
end

return command
