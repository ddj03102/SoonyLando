function onUnitDead(target, attacker)
	if target.type == 2 and attacker.type == 0 then
		local doubleEXP = target.monsterData.dropEXP
		if attacker.HasBuff(1) then
			attacker.AddEXP(doubleEXP)
		end
		if attacker.HasBuff(2) then
			attacker.AddEXP(doubleEXP*4)
		end
	end
end
Server.onUnitDead.Add(onUnitDead)