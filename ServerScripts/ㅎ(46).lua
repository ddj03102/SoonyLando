-- 몬스터 선제공격 AI스크립트
function FirstAttack(enemy, ai, event, data)
    if event == AI_UPDATE then 
        if enemy.field.playerCount <= 0 then
            ai.SetTargetUnit(nil)

        elseif (ai.GetTargetUnit()==nil)
               or (enemy.field.GetUnit(ai.GetTargetUnitID())==nil)
               or (math.abs(enemy.x-enemy.field.GetUnit(ai.GetTargetUnitID()).x) >= 1500) 
               or (math.abs(enemy.y-enemy.field.GetUnit(ai.GetTargetUnitID()).y) >= 1500) then

            ai.SetNearTarget(0, 350)

            if ai.GetTargetUnit() ~= nil then 
                ai.SetFollowTarget(true)
            end
        end
		
		if ai.GetTargetUnit() ~= nil then
			if rand(1, 5) == 1 then
				ai.UseSkill(105)
			end
		end
		
        if ai.GetTargetUnit() == nil then
			ai.SetFollowTarget(false)
            ai.SetTargetUnit(nil)
            return
        end
    end

    if event == AI_ATTACKED then 
        if ai.GetAttackedUnit() == nil then
            return
        else
            if ai.GetTargetUnit() ~= ai.GetAttackedUnit() then 
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
            end
        end
    end
end
Server.SetMonsterAI(46, FirstAttack)