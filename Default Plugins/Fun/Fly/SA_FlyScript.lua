-- THIS IS A LOCALSCRIPT

if not script:WaitForChild('UnFly', 1) then
	Instance.new("RemoteFunction", script).Name = "UnFly";
end

local char = script.Parent
local plr = game:GetService("Players").LocalPlayer
local rstep = game:GetService("RunService").RenderStepped
local flyEnabled = true
local disabled = false;
local camera = workspace.CurrentCamera
local mouse = plr:GetMouse()

local key_w,key_a,key_s,key_d,key_e,key_q,key_space = 0,0,0,0,0,0,0

local humanoid
for _,i in pairs(char:children()) do
	if (i:IsA("Humanoid")) then
		humanoid = i
		break
	end
end

local checked = {}
local function getRecursiveMass(part)
	local total = 0
	for _,p in pairs(part:GetConnectedParts()) do
		if (not checked[p]) then
			checked[p] = true
			total = total + p:GetMass()
			total = total + getRecursiveMass(p)
		end
	end
	return total
end

local bforce,bgyro,mass = nil,nil,0
local part = char.HumanoidRootPart

bforce = Instance.new("BodyForce")
bforce.Force = Vector3.new()
bforce.Parent = part

bgyro = Instance.new("BodyGyro")
bgyro.CFrame = CFrame.new()
bgyro.MaxTorque = Vector3.new(1,1,1) * 40e6
bgyro.Parent = part

mass = getRecursiveMass(part)

local ev_kD = mouse.KeyDown:connect(function(key)
	key = key:upper()
	
	if (key == "W") then key_w = 1 end
	if (key == "A") then key_a = 1 end
	if (key == "S") then key_s = 1 end
	if (key == "D") then key_d = 1 end
	if (key == "E") then key_e = 1 end
	if (key == "Q") then key_q = 1 end
	if (key == "X") then
		flyEnabled = not flyEnabled
		if (flyEnabled) then
			bforce.Parent = part
			bgyro.Parent = part
			
			checked = {}
			mass = getRecursiveMass(part)
		else
			humanoid.PlatformStand = false
			bforce.Parent = nil
			bgyro.Parent = nil
		end
	end
end)

local ev_kU = mouse.KeyUp:connect(function(key)
	key = key:upper()
	
	if (key == "W") then key_w = 0 end
	if (key == "A") then key_a = 0 end
	if (key == "S") then key_s = 0 end
	if (key == "D") then key_d = 0 end
	if (key == "E") then key_e = 0 end
	if (key == "Q") then key_q = 0 end
end)

script:WaitForChild('UnFly').OnClientInvoke = function()
	disabled = true;
	rstep:wait();
	humanoid.PlatformStand = false;
	bforce.Parent = nil;
	bgyro.Parent = nil;
	return true;
end

while not disabled do
	rstep:wait()
	if (flyEnabled) then
		humanoid.PlatformStand = true
		local cf = camera.CoordinateFrame
		
		local _,_,_,
			a,b,c,
			d,e,f,
			g,h,i = cf:components()
		
		local right = Vector3.new(a,d,g)
		local up = Vector3.new(b,e,h)
		local fwd = -Vector3.new(c,f,i)
		
		local tvel = 50 * (right*(key_d - key_a) + up*(key_e - key_q) + fwd*(key_w - key_s))
		
		local force = (tvel - part.Velocity) * mass * 2
		
		bgyro.CFrame = cf
		bforce.Force = Vector3.new(0,workspace.Gravity * mass,0) + force
	end
end

