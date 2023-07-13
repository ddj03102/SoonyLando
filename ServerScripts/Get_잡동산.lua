max_level = {{}, {}}
Server.RunLater(function() 
	for i=1, 60 do
		max_level[1][i] = (i==48 and 5) or 10 --스킬 만렙
		max_level[2][i] = 1 --스킬 소모포인트
	end
	max_level[2][warrior['1차'][1]] = 1 --재빠검
	max_level[2][warrior['1차'][2]] = 3 --강력몽둥
	max_level[2][warrior['1차'][3]] = 3 --블런트
	max_level[2][warrior['1차'][4]] = 8 --피검
	max_level[2][warrior['1차'][5]] = 4 --이격
	max_level[2][warrior['1차'][6]] = 4 --삼격
	max_level[2][warrior['1차'][7]] = 5 --후려패기
	max_level[2][warrior['1차'][8]] = 5 --암격
	max_level[2][warrior['1차'][9]] = 4 --암흑돌진
	max_level[2][warrior['1차'][10]] = 5 --강인한 육체

	max_level[2][wizard['1차'][1]] = 2 --사원소 마법
	max_level[2][wizard['1차'][2]] = 5 --포탈
	max_level[2][wizard['1차'][3]] = 4 --전격
	max_level[2][wizard['1차'][4]] = 4 --프로스트노바
	max_level[2][wizard['1차'][5]] = 5 --프로미넌스
	max_level[2][wizard['1차'][6]] = 5 --홀리 클로
	max_level[2][wizard['1차'][7]] = 4 --마법사의 지혜
	max_level[2][wizard['1차'][8]] = 10 --썬더스톰
	max_level[2][wizard['1차'][9]] = 10 --다크 네펜데스
end, 0.6)

Server.GetTopic("dice_sound").Add(function(txt)
	unit.PlaySE(txt, 1)
end)

Server.GetTopic("Language_Transformation").Add(function(txt, bool)
	if bool then
		if txt == 'Eng' then
			unit.SetVar(42, 1)	
		else
			unit.SetVar(42, 2)
		end
	else
		if txt == 'Eng' then
			unit.SetVar(24, 0)
		else
			unit.SetVar(24, 1)
		end
	end	
end)

function stat_Window()
	local Stat_Tick = {
	math.floor(unit.GetStat(101)), math.floor(unit.GetStat(102)), math.floor(unit.GetStat(103)), unit.GetStat(104),
	-- 근력                  인내력               지능              손재주
	unit.agi, unit.luk, unit.atk, unit.def, unit.maxHP, 
	unit.maxMP, unit.magicAtk, unit.magicDef,
	math.floor(100+unit.GetStat(104)*1.2+unit.level),
	math.floor(100+unit.agi*1.15),
	math.floor((1-400/(400+unit.luk))*100).."%",
	math.floor((1.1+unit.agi^0.75/10)*10).."%",
	unit.GetVar(21), unit.GetVar(24) }
	-- 남은포인트          언어선택
	--print(Utility.JSONSerialize(Stat_Tick))
	unit.FireEvent('stat_show', Utility.JSONSerialize(Stat_Tick))
end
Server.GetTopic('stat_Window').Add(function() stat_Window() end)


Server.GetTopic("dice_stat").Add(function(st1, st2, st3, st4, st5, st6)
	if unit.field.dataID ~= 1 and unit.CountItem(99) < 1 then
		unit.SendCenterLabel("스텟 초기화북이 없습니다.")
		return
	else
		unit.RemoveItem(99, 1, false)
	end
	
	local stat = {st1, st2, st3, st4, st5, st6}
	local sum = 0
	for i=1, 6 do
		sum = sum + stat[i]
	end
	
	if sum > 42 or sum < 37 then
		Server.SendSay("내 닉네임은 '<color=#00FF00>"..unit.player.name.."</color>'이다. 난 <color=#FA5858>주사위버그</color>를 사용했다. 감옥가서 평생 반성하며 살 것이다.")
		prison()
		return
	else
		for i=1, #stat do
			if stat[i] < 3 or stat[i] > 10 then
				Server.SendSay("내 닉네임은 '<color=#00FF00>"..unit.player.name.."</color>'이다. 난 <color=#FA5858>주사위버그</color>를 사용했다. 감옥가서 평생 반성하며 살 것이다.")
				prison()
				return
			end
		end
	end
	
	unit.SetVar(101, 0) --근력
	unit.SetVar(102, 0) --인내력
	unit.SetVar(103, 0) --지능
	unit.SetVar(104, 0) --손재주
	unit.SetVar(105, 0) --민첩
	unit.SetVar(106, 0) --행운
	
	unit.SetVar(101, unit.GetVar(101) + st1) --근력
	unit.SetVar(102, unit.GetVar(102) + st2) --인내력
	unit.SetVar(103, unit.GetVar(103) + st3) --지능
	unit.SetVar(104, unit.GetVar(104) + st4) --손재주
	unit.SetVar(105, unit.GetVar(105) + st5) --민첩
	unit.SetVar(106, unit.GetVar(106) + st6) --행운
	
	unit.SetVar(22, sum)
	unit.SetVar(21, Sarang2ran[unit.level])
	
	if unit.field.dataID == 1 then --하얀새의 섬에 위치할 경우 공용이벤트 실행
		unit.SetVar(20, 2) --스토리 진행변수
		unit.StartGlobalEvent(20)
		unit.SendCenterLabel("능력치가 결정되었습니다.")
	else
		unit.SendCenterLabel("스텟이 초기화되었습니다.")
	end
	
	
	unit.PlaySE("dice_decision.ogg",1)
	
	unit.RefreshStats()
	unit.SendUpdated()
end)

Server.GetTopic("SendCenterLabel").Add(function(text)
	unit.SendCenterLabel(text)
end)

Server.GetTopic('D_Stat').Add(function(text)
	local Q = Utility.JSONParse(text)
	local sum = 0
	for i=1, #Q do
		sum = sum + Q[i]
	end
	
	if sum > unit.GetVar(21) then
		unit.SendCenterLabel('스텟을 다시 설정해주세요.')
		return
	end
	
	for i=1, #Q do
		unit.SetVar(100+i, unit.GetVar(100+i)+Q[i])
	end
	unit.SetVar(21, unit.GetVar(21)-sum)
	unit.RefreshStats()
	unit.SendUpdated()
	
	local Stat_Tick = {
	math.floor(unit.GetStat(101)), math.floor(unit.GetStat(102)), math.floor(unit.GetStat(103)), unit.GetStat(104),
	-- 근력                  인내력               지능              손재주
	unit.agi, unit.luk, unit.atk, unit.def, unit.maxHP, 
	unit.maxMP, unit.magicAtk, unit.magicDef,
	math.floor(100+unit.GetStat(104)*1.2+unit.level),
	math.floor(100+unit.agi*1.15),
	math.floor((1-400/(400+unit.luk))*100).."%",
	math.floor((1.1+unit.agi^0.75/10)*10).."%",
	unit.GetVar(21), unit.GetVar(24) }
	-- 남은포인트          언어선택
	unit.FireEvent('stat_show2', Utility.JSONSerialize(Stat_Tick))
end)

Server.GetTopic('Fireeeee').Add(function()
	Server.FireEvent('Server_Fire', unit.GetVar(25))
end)
Server.GetTopic("변수").Add(function(num, v)
	unit.SetVar(num, v)
end)

local spk_time = 0
local num = 11
Server.GetTopic("Loudspeaker").Add(function(text)
	if unit.CountItem(num) >= 1 then
		if spk_time+10.1 >= os.time() then
			local dumy = math.ceil(spk_time+10.1 - os.time())
			unit.SendCenterLabel(dumy..'초 후 사용이 가능합니다.')
		else
			local text2 = unit.player.name
			spk_time = os.time()
			unit.RemoveItem(num, 1, false)
			Server.FireEvent('Loudspeaker', text, text2)
		end
	else
		unit.SendCenterLabel('확성기가 부족합니다.')
	end
end)

warrior = {
['1차'] = {6, 7, 8, 9, 10, 11, 12, 13, 14, 15},
['2차'] = {}, 
['3차'] = {},
['4차'] = {}}
wizard = {
['1차'] = {46, 48, 53, 54, 55, 56, 57, 58, 60},
['2차'] = {}, 
['3차'] = {},
['4차'] = {}}
Server.RunLater(function() 
	Server.FireEvent('job_man', Utility.JSONSerialize(warrior), Utility.JSONSerialize(wizard))
end, 0.3)
function skill_Window()
	local sum = 0
	if unit.job == 1 then
		for i, v in pairs(warrior['1차']) do
			sum = sum + max_level[2][v]*(unit.GetSkillLevel(v) == -1 and 0 or unit.GetSkillLevel(v))
		end
	elseif unit.job == 2 then
		
	elseif unit.job == 3 then
		for i, v in pairs(wizard['1차']) do
			sum = sum + max_level[2][v]*(unit.GetSkillLevel(v) == -1 and 0 or unit.GetSkillLevel(v))
		end
	else
		
	end
	local num5 = unit.GetVar(43) - sum
	if unit.GetVar(42) == 0 then unit.SetVar(42, 1) end
	local Skill_Tick = {num5, unit.GetVar(42), unit.job }
	local Q = {}
	for i=1, 60 do
		table.insert(Q, unit.GetSkillLevel(i))
	end
	unit.FireEvent('skill_Window', Utility.JSONSerialize(Q), Utility.JSONSerialize(Skill_Tick))
end
Server.GetTopic('skill_Window').Add(function() skill_Window() end)

Server.GetTopic('skill_Decide').Add(function(a)
	local Q = Utility.JSONParse(a)
	local E = {}
	if unit.job == 1 then
		for i, v in pairs(warrior['1차']) do
			if unit.GetSkillLevel(v) == -1 then
				table.insert(E, tonumber(Q[i]))
			elseif Q[i] == 'max' then
				table.insert(E, 0)
			else
				table.insert(E, tonumber(Q[i]) - unit.GetSkillLevel(v))
			end
		end
		local sum = 0
		for i, v in pairs(E) do
			sum = sum + v*max_level[2][warrior['1차'][i]]
		end
		--==================================
		for i, v in pairs(E) do
			if v ~= 0 then
				if unit.HasSkill(warrior['1차'][i]) then
					unit.SetSkillLevel(warrior['1차'][i], unit.GetSkillLevel(warrior['1차'][i]) + v)
					unit.SendCenterLabel((Server.GetSkill(warrior['1차'][i]).name)..'Lv.'..(unit.GetSkillLevel(warrior['1차'][i]))..' 스킬을 배웠습니다!')
				else
					unit.AddSkill(warrior['1차'][i], v, true)
				end
			end
		end
		unit.PlaySE("잡소리/스킬배움.ogg", 1)
		--===================================
	elseif unit.job == 2 then
	elseif unit.job == 3 then
		for i, v in pairs(wizard['1차']) do
			if unit.GetSkillLevel(v) == -1 then
				table.insert(E, tonumber(Q[i]))
			elseif Q[i] == 'max' then
				table.insert(E, 0)
			else
				table.insert(E, tonumber(Q[i]) - unit.GetSkillLevel(v))
			end
		end
		local sum = 0
		for i, v in pairs(E) do
			sum = sum + v*max_level[2][wizard['1차'][i]]
		end
		--==================================
		for i, v in pairs(E) do
			if v ~= 0 then
				if unit.HasSkill(wizard['1차'][i]) then
					unit.SetSkillLevel(wizard['1차'][i], unit.GetSkillLevel(wizard['1차'][i]) + v)
					unit.SendCenterLabel((Server.GetSkill(wizard['1차'][i]).name)..'Lv.'..(unit.GetSkillLevel(wizard['1차'][i]))..' 스킬을 배웠습니다!')
				else
					unit.AddSkill(wizard['1차'][i], v, true)
				end
			end
		end
		unit.PlaySE("잡소리/스킬배움.ogg", 1)
	else
		
	end
end)



Server.GetTopic('gooooood').Add(function()
	Server.RunLater(function()
		Server.FireEvent('job_man', Utility.JSONSerialize(warrior), Utility.JSONSerialize(wizard))
	end, 0.3)
end)

--===============================================================================================================

g_but, g_menu, g_Delicate, g_count = {}, {}, {}, {}
Server.GetTopic('Love').Add(function(A, B, C, D)
	g_but, g_menu, g_Delicate, g_count = Utility.JSONParse(A), Utility.JSONParse(B), Utility.JSONParse(C), Utility.JSONParse(D)
end)

Server.GetTopic('Love2').Add(function(Q, W)
	local E, R = {}, {}
	if g_Delicate[tostring(g_menu[g_but[Q]][W])] == nil then return end
	for i, v in pairs(g_Delicate[tostring(g_menu[g_but[Q]][W])]) do
		table.insert(E, unit.CountItem(v))
		table.insert(R, v)
	end
	unit.FireEvent('Love3', Utility.JSONSerialize(E), Utility.JSONSerialize(R), tostring(g_menu[g_but[Q]][W]))
end)

Server.GetTopic('Love4').Add(function(Q)
	for i, v in pairs(g_count[Q]) do
		if unit.CountItem(g_Delicate[Q][i]) < v then
			unit.SendCenterLabel('재료가 부족합니다.')
			return
		end
	end
	
	for i, v in pairs(g_count[Q]) do
		unit.RemoveItem(g_Delicate[Q][i], v, false)
	end
	unit.AddItem(tonumber(Q), 1, false)
	unit.SendCenterLabel(Server.GetItem(tonumber(Q)).name..' 제작에 성공하였습니다!')
	unit.FireEvent('Twinkle', tonumber(Q), 3, 6)
end)











































