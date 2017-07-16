local command = {}
command.PermissionLevel = 0
command.Shorthand = "tpa"
command.Params = {"SafePlayer"}
command.Usage = "teleportask Player"
command.Description = [[Allows you to request to teleport to another user.
They can then choose to either allow or deny your
teleport.]] 

command.Init = function(main)
	
end

local users = {}
local timeDelay = 300 --Users cannot send another request to that person 5 minutes after the last deny

command.Run = function(main,user,target)
	if (users[user] ~= nil and users[user][target] ~= nil) then
		local timeRemaining = users[user][target] - tick()
		if (timeRemaining > 0) then
			return false,"You cannot send " .. target.Name 
				.. " a request for another " .. math.floor(timeRemaining/60) 
				.. " minutes and " .. math.floor(timeRemaining % 60) 
				.. " seconds"
		end
	end
	
	spawn(function()
		local options = {
			{ Text = "Accept"; Color = Color3.new(0,1,0); },
			{ Text = "Deny"; Color = Color3.new(1,0,0); },
			{ Text = "Ignore"; Color = Color3.new(1,1,0); }
		}
		local resp,ok = SyncAPI.DisplayQuestionMessage(target,"Teleport Request",user.Name .. " wants to teleport to you!","Exclamation",options)
		if (ok) then
			if (resp == "Accept") then
				if (user.Character and user.Character:findFirstChild("HumanoidRootPart")
						and target.Character and target.Character:findFirstChild("HumanoidRootPart")
						and user.Character:FindFirstChild("Humanoid") and not user.Character.Humanoid.Sit) then
					SyncAPI.DisplayNotification(user,target.Name .. " accepted your teleport request","Check",10)
					SyncAPI.DisplayNotification(target,"Accepted " .. user.Name .. "'s teleport request","Check",10)
					user.Character.HumanoidRootPart.Velocity = Vector3.new()
					user.Character.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame * CFrame.new(Vector3.new(math.random()-0.5,0,math.random()-0.5)*10)
				else
					SyncAPI.DisplayNotification(target,"Could not teleport " .. user.Name .. " to you; one of you is missing a HumanoidRootPart or currently sitting","Cross",10)
					SyncAPI.DisplayNotification(user,"Could not teleport to " .. target.Name .. "; one of you is missing a HumanoidRootPart or currently sitting","Cross",10) -- Patched your stupid teleporting boats ayyyyy
				end
			elseif (resp == "Deny") then
				SyncAPI.DisplayNotification(user,target.Name .. " denied your teleport request; you can not send them another request for 5 minutes","Cross",10)
				SyncAPI.DisplayNotification(target,"Denied " .. user.Name .. "'s teleport request","Check",10)
				if (users[user] == nil) then users[user] = {} end
				users[user][target] = tick() + timeDelay
			end
		end
	end)
	
	return true,"Requested to teleport to " .. target.Name
end

return command