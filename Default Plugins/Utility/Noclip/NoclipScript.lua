-- THIS IS A LOCALSCRIPT INSIDE THE PLUGIN MODULE ITSELF

local char = script.Parent;
local hrp = char:WaitForChild'HumanoidRootPart';
local plr = game:service'Players'.LocalPlayer;
local rs = game:service'RunService';
local noclipEnabled = true;
local mouse = plr:GetMouse();
local touchingparts = {};

local cached_Parts; 
--//somewhat more efficient but to consider it may fail when a new part is added?
--//todo: perhaps remove old parts from cache which are Destroy()'d?

local function recursive(object) --//returns a table of parts inside the object
	local parts = {};
	local function inside_func_recursive(obj) --//probably not the best naming
		for _,part in next, obj:children() do
			if part:IsA'BasePart' then
				table.insert(parts, {part, part.CanCollide}); --include original state
			end
			inside_func_recursive(part);
		end
	end
	inside_func_recursive(object)
	if object:IsA'BasePart' then --//don't forget the main object itself ;)
		table.insert(parts, {object, object.CanCollide});
	end
	return parts;
end

local function mergeTables(table1, table2)
	--//i was wondering whether to use table1, but then i thought that like in C languages,
	--//tables are probably ported as they are to the script, not cloned
	--//so i just make a new table, probably a bit inefficient but ensures safety
	local table3 = {};
	for _,object in next, table1 do
		table.insert(table3, object);
	end
	for _,object in next, table2 do
		table.insert(table3, object);
	end
	return table3;
end



mouse.KeyDown:connect(function(key)
	if (key:lower() == "c") then
		noclipEnabled = not noclipEnabled;
	end
end)

rs.Stepped:connect(function() --//stepped runs before physics, thanks roblox C:
	if not cached_Parts then
		cached_Parts = recursive(char); --//make sure we have a cache to read
	end
	if (noclipEnabled) then
		for _,array in next, cached_Parts do
			array[1].CanCollide = false;
		end
	else
		for _,array in next, cached_Parts do
			array[1].CanCollide = array[2]; --//return parts to their former glorious cancollide state
		end
		for part,_ in next, touchingparts do
			part.LocalTransparencyModifier = 0;
		end
	end
end)

char.DescendantAdded:connect(function(instance) --//so we can update the cache with new parts
	if not cached_Parts then --//again, we need to confirm cache even exists or not before we overwrite it
		cached_Parts = recursive(char);
	else --//in most cases it should already exist, physics runs faster than descendant, but that still depends'
		cached_Parts = mergeTables(cached_Parts, recursive(instance));
	end
end)

hrp.Touched:connect(function(part)
	if noclipEnabled then
		touchingparts[part] = part.Transparency;
		part.LocalTransparencyModifier = .5;
	end
end)

hrp.TouchEnded:connect(function(part)
	if touchingparts[part] then
		touchingparts[part] = nil;
		part.LocalTransparencyModifier = 0;
	end
end)
