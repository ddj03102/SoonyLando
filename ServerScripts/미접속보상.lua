function onJoinPlayer(scriptRoomPlayer)
	local Unit = scriptRoomPlayer.unit
	local ts = os.time() + 32400
	local Count = ts - Unit.GetVar(10)
	local supertime = 259200 --72시간
	
	scriptRoomPlayer.unit.SetVar(26, 0)
	scriptRoomPlayer.unit.SetVar(31, 0)
	if Unit.GetVar(10) ~= 0 and Count >= 60 then
		if Count >= supertime then Count = supertime end
		--보상
	end
	Unit.AddHP(Unit.maxHP)
	Unit.AddMP(Unit.maxMP)
end



function onLeavePlayer(scriptRoomPlayer)
	scriptRoomPlayer.unit.SetVar(10, os.time() + 32400)
end
Server.RunLater(function() 
	Server.onJoinPlayer.Add(onJoinPlayer)
	Server.onLeavePlayer.Add(onLeavePlayer)
end, 0.3)