
--      @Description: Synchronized Admin Commands
--      @Author: VolcanoINC, DataSynchronized

local command = {}
command.PermissionLevel = 1
command.Shorthand = nil
command.Params = {"PlayerList","StringList","..."}
command.Usage = "ask player1,player2,player3,... opt1,opt2,opt3,... Message"
command.Description = [[Ask a player a question.]] 

command.Init = function(main)
	
end

command.Run = function(main,user,players,optionsRaw,...)
	local title = user.Name .. " asks..."
	local msg = game:GetService("Chat"):FilterStringForBroadcast(table.concat({...}," "),user)
	
	local responses = {}
	local done = false
	
	local options = {}
	for _,o in pairs(optionsRaw) do
		local str = game:GetService("Chat"):FilterStringForBroadcast(o,user)
		table.insert(options,str)
	end
	
	for _,player in pairs(players) do
		do
			local pl = player
			spawn(function()
				local resp,ok = SyncAPI.DisplayQuestionMessage(pl,title,msg,"Check",options)
				if (done) then return end
				if (ok) then
					SyncAPI.DisplayNotification(user,pl.Name .. " responded with " .. resp,"Check",30)
					table.insert(responses,resp)
				else
					SyncAPI.DisplayNotification(user,pl.Name .. " failed to respond","Cross",30)
					table.insert(responses,"No response")
				end
			end)
		end
	end
	
	spawn(function()
		--Wait 120 seconds (2 minutes) and continuously check if all users replied
		for t = 120,0,-1 do
			wait(1)
			if (#responses == #players) then
				break --All users responded, no reason to wait around
			end
		end
		
		--Make it ignore anyone elses' input
		done = true
		
		--Fill the rest in with "did not respond"
		for a = #responses,#players-1 do
			table.insert(responses,"No response")
		end
		
		--Prepare tables for final results display
		local finalResults = {}
		for _,r in pairs(options) do finalResults[r] = 0 end
		for _,r in pairs(responses) do 
			if (finalResults[r] == nil) then finalResults[r] = 0 end
			finalResults[r] = finalResults[r] + 1 
		end
		
		--Calculate percentages and output to user
		for r,c in pairs(finalResults) do
			local percent = math.floor(c*1000/#responses)/10 --Round to 0.1%
			SyncAPI.DisplayNotification(user,r .. ": " .. percent .. "%","Check",120)
		end
	end)
	return true,"Successfully dispatched your question"
end

return command