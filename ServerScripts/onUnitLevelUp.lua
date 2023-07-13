function onUnitLevelUp(unit, level)
	local lv = level
	local W = 0
	if lv > 90 then
		W = math.floor((lv-90)/10)*10
		lv = lv - W
	end

	local Q = math.ceil(lv/10)
	if lv % 10 == 0 then
		Q = Q * 4
	end

	unit.SetVar(21, unit.GetVar(21)+Q)

	local E = 0
	for i=101, 106 do
		E = E + unit.GetVar(i)
	end
	
	if E + unit.GetVar(21) ~= Sarang2ran[level] then
		unit.SetVar(21, Sarang2ran[level]-E+unit.GetVar(22))
	end
	unit.PlaySE("레벨업 소리.ogg", 1.1)
	unit.SetVar(43, level-1)
end

Server.onUnitLevelUp.Add(onUnitLevelUp)