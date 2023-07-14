function Desa_Script(tx1, tx2, tx3, u)
	if u == nil then
		unit.FireEvent("Send_Desa", tx1, tx2, tx3)
	else
		u.FireEvent("Send_Desa", tx1, tx2, tx3)
	end
	--u.moveSpeed = 0
	--u.SendUpdated()
end

Server.GetTopic("Desa_End").Add(function(num, tx3)
	if tx3 == "001" then
		if num == 1 then
			if unit.gameMoney >= 4000 then
				unit.SendCenterLabel("하늘길 짜잔")
				unit.UseGameMoney(4000)
				unit.SpawnAtFieldID(46, 14*32+16, -24*32-16)
			else
				unit.SendCenterLabel("입장료가 부족합니다.")
			end
		end
	elseif tx3 == "002" then
		if num == 1 then
			if unit.CountItem(9) >= 1 then
				unit.RemoveItem(9, 1, false)
				unit.SendCenterLabel("바다로 나가자!")
				unit.SpawnAtFieldID(23, 19*32+16, -10*32-16)
			else
				unit.SendCenterLabel("삽을 소지하고 있지 않습니다.")
			end
		elseif num == 2 then
			if unit.CountItem(10) >= 3 then
				unit.RemoveItem(10, 3, false)
				unit.SendCenterLabel("바다로 나가자!")
				unit.SpawnAtFieldID(23, 19*32+16, -10*32-16)
			else
				unit.SendCenterLabel("나뭇가지는 3개가 필요합니다.")
			end
		end
	elseif tx3 == "003" then
		if num == 1 then
			if unit.CountItem(9) >= 1 then
				unit.RemoveItem(9, 1, false)
				unit.SendCenterLabel("육지로 가자!")
				unit.SpawnAtFieldID(22, 14*32+16, -11*32-16)
			else
				unit.SendCenterLabel("삽을 소지하고 있지 않습니다.")
			end
		elseif num == 2 then
			if unit.CountItem(10) >= 3 then
				unit.RemoveItem(10, 3, false)
				unit.SendCenterLabel("육지로 가자!")
				unit.SpawnAtFieldID(22, 14*32+16, -11*32-16)
			else
				unit.SendCenterLabel("나뭇가지는 3개가 필요합니다.")
			end
		end
	elseif tx3 == "004" then
		if num == 1 then
			unit.SpawnAtFieldID(14, 26*32+16, -5*32-16)
		end
	elseif tx3 == "005" then
		local num2 = 11
		local lv = 48
		for i=1, 5 do
			if unit.GetSkillLevel(lv) == i and num == i+1 then
				unit.RefreshStats()
				unit.SendUpdated()
				return
			end
		end
		
		local Q = Utility.JSONParse(unit.GetStringVar(num2))
		for i=1, 5 do
			if num == i then
				Q[1+(i-1)*3] = unit.field.dataID
				Q[1+(i-1)*3+1] = unit.x
				Q[1+(i-1)*3+2] = unit.y
				print(Q[i], Q[i+1], Q[i+2])
				unit.SendCenterLabel('위치 저장 완료')
			end
		end
		unit.SetStringVar(num2, Utility.JSONSerialize(Q))
	elseif tx3 == "006" then
		local num2 = 11
		local lv = 48
		for i=1, 5 do
			if unit.GetSkillLevel(lv) == i and num == i+1 then
				unit.RefreshStats()
				unit.SendUpdated()
				return
			end
		end
		
		local W = Utility.JSONParse(unit.GetStringVar(num2))
		if W[1+(num-1)*3] == 0 then
			unit.RefreshStats()
			unit.SendUpdated()
			return
		end
		
		if unit.GetVar(37)+7.5 >= os.time() then
			unit.SendCenterLabel("<size='17'><color=#F7BE81>포탈오픈은 7초의 쿨타임이 있습니다.</color></size>")
			unit.RefreshStats()
			unit.SendUpdated()
			return
		end
		
		if unit.gameMoney >= 2500 then
			unit.UseGameMoney(2500)
		else
			unit.SendCenterLabel("골드가 부족합니다.")
			unit.RefreshStats()
			unit.SendUpdated()
			return
		end 
		
		unit.SetVar(35, num)
		unit.SetVar(37, os.time())
		unit.StartGlobalEvent(34)
	elseif tx3 == "007" then
		if num == 1 then
			unit.SendCenterLabel("한글자도 틀리지 않아야한다.")
		end
	elseif tx3 == "008" then
		if num == 1 then
			if unit.gameMoney >= 6000 then
				unit.UseGameMoney(6000)
				unit.SpawnAtFieldID(86, 16*32+16, -9*32-16)
			else
				unit.SendCenterLabel("골드가 부족합니다.")
				unit.RefreshStats()
				unit.SendUpdated()
				return
			end 
		end
	elseif tx3 == "009" then
		if num == 1 then --보마
			unit.SpawnAtFieldID(97, 16*32+16, -9*32-16)
		elseif num == 2 then --사제
			unit.SpawnAtFieldID(98, 16*32+16, -9*32-16)
		elseif num == 3 then --학살자
			unit.SpawnAtFieldID(99, 16*32+16, -9*32-16)
		elseif num == 4 then --스펠헌터
			unit.SpawnAtFieldID(100, 16*32+16, -9*32-16)
		elseif num == 5 then --마도
			unit.SpawnAtFieldID(101, 16*32+16, -9*32-16)
		elseif num == 6 then --사신
			unit.SpawnAtFieldID(102, 16*32+16, -9*32-16)
		end
	end
	
	unit.RefreshStats()
	unit.SendUpdated()
end)