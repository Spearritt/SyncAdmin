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
command.Shorthand = {"dburn"}
command.Params = {"String", "String", "Optional:Number", "Optional:Number"}
command.Usage = "dfire <R,G,B / BrickColor> <R,G,B / BrickColor> [size] [opacity]"
command.Description = "[Donator]: Sets you on fire. [Help]: R,G,B = Red, Green, Blue values with a range of 0-255 (e.g :dfire 255,0,0 That'd be red!). BrickColor = e.g Bright-blue (Example: :dfire Bright-blue)"
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

command.Run = function(main, user, color1, color2, size, heat)
	if (user == nil) then error("No user found") end
	if (color1 == nil) then error("Color1 is required") end
	if (color2 == nil) then error("Color2 is required") end
	if (size == nil) then size =  5 end
	if (size > 10) then error("Size must be less than or equal to 10!") end
	if (heat == nil) then heat = 9 end
	if (heat > 15) then error("Heat must be less than or equal to 15!") end
		
	if color1:match(",") and color2:match(",") then
		local color = strSplit(color1,",")
		local r,g,b = tonumber(color[1]),tonumber(color[2]),tonumber(color[3])
		if (r == nil or g == nil or b == nil) then error("Invalid color value") end
		local color1 = Color3.fromRGB(r, g, b)
		
		local color = strSplit(color2,",")
		local r,g,b = tonumber(color[1]),tonumber(color[2]),tonumber(color[3])
		if (r == nil or g == nil or b == nil) then error("Invalid color value") end
		local color2 = Color3.fromRGB(r, g, b)
		
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
			if (user.Character.HumanoidRootPart:findFirstChild("Fire")) then
				user.Character.HumanoidRootPart.Fire.Color = color1
				user.Character.HumanoidRootPart.Fire.SecondaryColor = color2
				user.Character.HumanoidRootPart.Fire.Size = size
				user.Character.HumanoidRootPart.Fire.Heat = heat
			else
				local fire = Instance.new("Fire", user.Character.HumanoidRootPart)
				fire.Color = color1
				fire.SecondaryColor = color2
				fire.Size = size
				fire.Heat = heat
			end
		end
	else
		local colorExtract1 = string.gsub(color1, "-", " ")
		if (colorExtract1 == nil) then error("Invalid brickcolor value") end
		local color1 = BrickColor.new(colorExtract1).Color
		
		local colorExtract2 = string.gsub(color2, "-", " ")
		if (colorExtract2 == nil) then error("Invalid brickcolor value") end
		local color2 = BrickColor.new(colorExtract2).Color
		
		--error(tostring(colorExtract1) .. " " .. tostring(colorExtract2) .. " | " .. tostring(color1) .. " " .. tostring(color2))
		
		if (user.Character and user.Character:findFirstChild("HumanoidRootPart")) then
			if (user.Character.HumanoidRootPart:findFirstChild("Fire")) then
				user.Character.HumanoidRootPart.Fire.Color = color1
				user.Character.HumanoidRootPart.Fire.SecondaryColor = color2
				user.Character.HumanoidRootPart.Fire.Size = size
				user.Character.HumanoidRootPart.Fire.Heat = heat
			else
				local fire = Instance.new("Fire", user.Character.HumanoidRootPart)
				fire.Color = color1
				fire.SecondaryColor = color2
				fire.Size = size
				fire.Heat = heat
			end
		end
	end
	return true,"Given fire to player."
end

return command
