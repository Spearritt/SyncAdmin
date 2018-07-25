
--[[
									Verified SyncAdmin Command
	======================================================================================
	Authors 				Hannah Jane [DataSynchronized], Dominik [VolcanoINC]
	Description				Run in-game scripts. 
	--------------------------------------------------------------------------------------
--]]

local command = {}
command.PermissionLevel = 3
command.Shorthand = {"qs","script"}
command.Params = {"..."}
command.Usage = "quickscript Source"
command.Description = [[Runs Source on the server.]] 

command.Init = function(main)
end

command.Run = function(main,user,...)
	local luavm = require(script:WaitForChild("LuaVM"))
	local source = table.concat({...}," ")
	local env = {
		--Instances
		workspace = workspace;
		game = game;
		
		--Classes
		Instance = Instance;
		Vector2 = Vector2;
		Vector3 = Vector3;
		Vector2int16 = Vector2int16;
		Vector3int16 = Vector3int16;
		BrickColor = BrickColor;
		UDim = UDim;
		UDim2 = UDim2;
		math = math;
		Enum = Enum;
		string = string;
		tostring = tostring;
		tonumber = tonumber;
		table = table;
		Region3 = Region3;
		Region3int16 = Region3int16;
		Ray = Ray;
		
		--Functions
		pcall = pcall;
		spawn = spawn;
		xpcall = xpcall;
		ypcall = ypcall;
		getmetatable = getmetatable;
		setmetatable = setmetatable;
		type = type;
		tick = tick;
		time = time;
		print = print;
		warn = warn;
		error = error;
		pairs = pairs;
		wait = wait;
		spawn = spawn;
		PhysicalProperties = PhysicalProperties;
		CFrame = CFrame;
		_G = _G;
		collectgarbage = collectgarbage;
		assert = assert;
		delay = delay;
		elapsedTime = elapsedTime;
		
		--Special-Case functions
		setfenv = function(func,...)
			local ftype = type(func)
			if (ftype ~= "function") then 
				return { error = "[SyncAdmin] Cannot use setfenv(number)"; } 
			end
			return setfenv(func,...)
		end;
		getfenv = function(func,...)
			local ftype = type(func)
			if (ftype ~= "function") then 
				return { error = "[SyncAdmin] Cannot use getfenv(number)"; } 
			end
			return getfenv(func,...)
		end;
		
		--SyncAPI
		SyncAPI = SyncAPI;
	}
	local func,err = luavm(source,env,true)
	if (func) then
		local fenv = getfenv(func)
		fenv.script = nil
		setfenv(func,fenv)
		spawn(func)

		return true,"Executed your script"
	else
		return false,"The script encountered an error: " .. tostring(err)
	end
end

return command
