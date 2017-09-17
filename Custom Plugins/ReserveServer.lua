--stillunt1tled
local command = {};
command.PermissionLevel = 3;
command.Shorthand = {"ps","privateserver"};
command.Params = {"Optional:PlayerList"};
command.Usage = "reservedgame Player1,Player2,Player3,...";
command.Description = [[Creates a reserved server and teleports the specified players there.]];

command.Init = function(main)
end

command.Run = function(main,user,users)
	if (user==nil) then return false,"No user found." end	
	if (users == nil or #users == 0) then
		users = {user};
	end
	SyncAPI.DisplayNotification(user,"Reserving server...","Info",5);
	local ts = game:GetService("TeleportService");
	local s = ts:ReserveServer(game.PlaceId);
	ts:TeleportToPrivateServer(game.PlaceId,s,users,nil,{["syncadmin-reservedserver"]=true,["serverid"]=s});
	return true,"Server reserverd, teleporting.."
end

return command;
