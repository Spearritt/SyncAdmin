
--      @Description: This plugin is used to get a list of all the tools found in the specified search area(s)
--      @Author: Dark_Messiah

local command = {}
command.PermissionLevel = 1
command.Shorthand = {"tls","tools"}
command.Params = {}
command.Usage = "ToolList"
command.Description = [[Display a list of tools found inside ServerStorage, ReplicatedStorage, and Lighting]] 

command.Init = function(main)
end

command.Run = function(main,user)
	if (user == nil) then error("No user found") end
	local SearchThese = {game:GetService("ServerStorage"),game:GetService("ReplicatedStorage"),game:GetService("Lighting")} -- Add/Remove Objects to search for tools.
	
	if #SearchThese==0 then return false,"Did not specify search area(s)" end -- Without a search area it should fail.
	
	local EntireMessage = ""
	
	for i,Search in pairs(SearchThese) do
		if Search == nil then 
			SyncAPI.DisplayNotification(user,"One of the Specified Search Areas is non-existant [ToolList Plugin in SyncAdmin]","Cross",30) -- The "[ToolList Plugin in SyncAdmin]" isn't needed, but I think it helps people know what is wrong and where the problem is.
		end
		
		local NumberOfTools = 0
		local SearchMessage = ""
		
		SearchMessage = EntireMessage=="" and Search.Name.." Tools\n" or "\n"..Search.Name.." Tools\n"		
		
		for num,tool in pairs(Search:GetChildren()) do
			if (tool:IsA("Tool") or tool:IsA("HopperBin")) then
				NumberOfTools = NumberOfTools+1
				SearchMessage = SearchMessage .. tostring(NumberOfTools) .. ": "..tool.Name .."\n"
			end
		end
		
		if NumberOfTools>0 then
			EntireMessage = EntireMessage .. SearchMessage
		end
	end
	
	SyncAPI.DisplayScrollMessage(user,"TOOL LIST",EntireMessage)
end

return command