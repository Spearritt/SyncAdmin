--      @Description: Synchronized Admin Commands // Custom Command Plugins
--      @Author: VolcanoINC, DataSynchronized

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"resutil","res","fixmap"} -- Rather than typing out the full command name, this can be a quick alternative
command.Params = {"Optional:String","Optional:String"}
command.Usage = "restore Save/Restore SaveName"
command.Description = [[Restores the workspace to the best of its ability.]] 

local saves = {}

command.Init = function(main)
	command.Run(main,nil,"save","Default")
end

local lt = 0
function throttle(x)
	if lt < tick()-x then
		wait()
		lt = tick()
	end
end

command.Run = function(main,user,option,name)
	if (name == nil) then name = "Default" end
	if (option and option:lower() == "save" and name) then
		local cache = {}
		local clonedFrom = {}

		local instances = workspace:children()
		for _,i in pairs(instances) do
			if (not i:IsA("Terrain") and not i:IsA("Camera")) then
				local c = i:clone()
				if (c) then
					table.insert(cache,c)
					clonedFrom[c] = i
				end
			end
		end
		
		local function rec(x)
			if (clonedFrom[x] == main) then
				x:Destroy()
				return
			end
		end
		
		for _,i in pairs(cache) do
			rec(i)
		end
		
		local save = {
			Cache = cache;
		}
		saves[name] = save
		return true,"Saved under the name " .. name
	elseif (option == nil or (option and option:lower() == "restore")) then
		local save = saves[name]
		if (save == nil) then return false,"No save found by the name " .. name end
		
		for _,i in pairs(workspace:children()) do
			if (not i:IsA("Terrain") and not i:IsA("Camera")) then
				i:Destroy()
				throttle(0.1)
			else
				i:ClearAllChildren()
			end
		end
		
		local scDisabled = {}
		local ptAnchored = {}
		local function rec(x)
			if (x:IsA("Script") or x:IsA("LocalScript")) then
				scDisabled[x] = x.Disabled
				x.Disabled = true
			end
			if (x:IsA("BasePart")) then
				ptAnchored[x] = x.Anchored
				x.Anchored = true
			end
			for _,i in pairs(x:children()) do
				rec(i)
			end
		end
		
		for _,i in pairs(save.Cache) do
			local c = i:clone()
			if (c) then
				rec(c)
				c.Parent = workspace
				throttle(0.1)
			end
		end
		
		for pt,anchored in pairs(ptAnchored) do
			pt.Anchored = anchored
			pt:MakeJoints()
		end
		
		for sc,disabled in pairs(scDisabled) do
			sc.Disabled = disabled
		end
		
		for _,player in pairs(game:GetService("Players"):GetPlayers()) do
			player:LoadCharacter()
		end
		return true,"Restored from save " .. name
	end
	return false,option .. " is not a valid option"
end

return command
