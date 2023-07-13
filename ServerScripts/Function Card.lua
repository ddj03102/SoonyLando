Server.onUseItem.Add(function(unit, item)
	--Utility.JSONSerialize(Q)
	if item.dataID >= 201 and item.dataID <= 300 then
		local Q = Utility.JSONParse(Server.GetItem(item.dataID).actionName)
		unit.SetVar(32, item.dataID)
		unit.StartGlobalEvent(Q[2]+8)
	end
end)

function Monster_Card(Tem, unit)
	local Q = Utility.JSONParse(Server.GetItem(unit.GetVar(32)).actionName)
	unit.RemoveItem(unit.GetVar(32), 1, false)
	if Q[1] == 8 then
		Utility.AddItemOption(Tem, 3, (rand(0, 8+1) == 8 and rand(101, 104+1)) or rand(0, 8), rand(Q[3], Q[4]+1))
	else
		Utility.AddItemOption(Tem, 3, Q[1], rand(Q[3], Q[4]+1))
	end
	unit.SendCenterLabel("카드를 장착하였습니다.")
	unit.PlaySE("인챈트"..rand(1, 3)..".ogg", 1)
	unit.player.SendItemUpdated(Tem)
	unit.RefreshStats()
end