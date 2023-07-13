Server.damageCallback = function(a, b, damage, sk, critical, visible)
	if sk == 47 then--포탈
		if b.GetVar(26) == 0 then
			potal(a, b)
		else
			b.SendCenterLabel("<size='17'><color=#F7BE81>자동사냥중에는 포탈이 타지지 않습니다.</color></size>")
		end
		return 0, false, false
	end
	
	SV = {['reDmg'] = 0, ['Hit'] = 100+a.GetStat(104)*1.2+a.level, 
	['Flee'] = 100+b.GetStat(4)*1.15}
	
	--sk의 값이 상태번호로도 뜸.(주의)
	if b.type == 2 then
		local atk_type = Server.GetSkill(sk).type
		if atk_type == 0 then
			if rand(1, SV.Flee) > SV.Hit then
				b.ShowAnimation(198)
				return 0, false, false
			end
			
			if rand(1, 1000) <= (1-400/(400+a.luk))*1000 then --물리 크리
				SV.reDmg = damage * (1.1+a.agi^0.75/100) - b.def
				return SV.reDmg, true
			end
		elseif atk_type == 1 then
			SV.reDmg = damage - b.magicDef
			return SV.reDmg
		end
	elseif b.type == 0 then
		local MP = a.maxMP*10
		if rand(1, SV.Flee) > SV.Hit+MP then
			b.ShowAnimation(197)
			return 0, false, false
		end
		
		local atk_type = 0
		if sk ~= -1 then
			atk_type = Server.GetSkill(sk).type
		end
		
		if atk_type == 0 then
			SV.reDmg = damage - b.def
			if SV.reDmg <= 1 then
				SV.reDmg = 1
			end
			return SV.reDmg
		elseif atk_type == 1 then
			SV.reDmg = damage - b.magicDef
			return SV.reDmg
		end
	end
	
	--이도 저도 아닌 경우
	SV.reDmg = damage - b.def
	if SV.reDmg <= 1 then
		SV.reDmg = 1
	end
    return SV.reDmg
end