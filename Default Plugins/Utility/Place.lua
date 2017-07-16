local command = {}
command.PermissionLevel = 1
command.Shorthand = "plc"
command.Params = {"PlayerList","Number","Optional:Boolean"}
command.Usage = "place Player1,Player2,... PlaceId [Force=False]"
command.Description = [[Asks a user if they would like to teleport to a
given place. If "true" is passed as the final parameter,
they are teleported without being asked.]] 

command.Init = function(main)
end


local mps = game:GetService("MarketplaceService")
local tps = game:GetService("TeleportService")
command.Run = function(main,user,targets,placeId,force)
	local info = mps:GetProductInfo(placeId)
	local placeName = info.Name
	local creatorName = info.Creator.Name
	
	local list = {}
	if (force) then
		if (SyncAPI.GetPermissionLevel(user) < 3) then
			return false,"You aren't allowed to force people to teleport!"
		end
		
		for _,p in pairs(targets) do
			table.insert(list,p.Name)
			tps:Teleport(placeId,p)
		end
		return true,"Sent " .. table.concat(list,", ") .. " to " .. placeName .. " by " .. creatorName
	else
		for _,p in pairs(targets) do
			table.insert(list,p.Name)
			do
				local player = p
				spawn(function()
					local resp,ok = SyncAPI.DisplayQuestionMessage(
						player,
						"Go to " .. placeName .. "?",
						user.Name .. " wants you to go to " .. placeName .. " by " .. creatorName .. ". Do you want to go there?",
						"Check",
						{"Yes","No"}
					)
					if (ok) then
						if (resp == "Yes") then
							SyncAPI.DisplayNotification(user,player.Name .. " went to " .. placeName,"Check",10)
							tps:Teleport(placeId,player)
						else
							SyncAPI.DisplayNotification(user,player.Name .. " did not want to go to " .. placeName,"Cross",10)
						end
					else
						SyncAPI.DisplayNotification(user,player.Name .. " did not respond","Cross",10)
					end
				end)
			end
		end
		return true,"Asked " .. table.concat(list,", ") .. " to go to " .. placeName .. " by " .. creatorName
	end
end

return command