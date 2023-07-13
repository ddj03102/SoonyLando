local sin_list = {}

sin_list[60] = 5 --나막신
sin_list[61] = 5 --화이트 슈즈
sin_list[62] = 30 --샤페이
sin_list[63] = 5 --유치원 장화
sin_list[64] = 5 --털장화
sin_list[65] = 5 --낮은 구두
sin_list[66] = 10 --가벼운 장화
sin_list[67] = 5 --낡은 장화
sin_list[68] = 5 --슈즈
sin_list[69] = 5 --슈즈
sin_list[92] = 25 --아이언 슈즈

local Eq = {{}, {}, {}, {}, {}} --0~9, 장비번호, 어떤스텟, value, 제한레벨
table.insert(Eq[1], 1)
table.insert(Eq[2], 91)
table.insert(Eq[3], {1})
table.insert(Eq[4], {65})
table.insert(Eq[5], 400)

table.insert(Eq[1], 2)
table.insert(Eq[2], 90)
table.insert(Eq[3], {101})
table.insert(Eq[4], {200})
table.insert(Eq[5], 400)

table.insert(Eq[1], 4)
table.insert(Eq[2], 92)
table.insert(Eq[3], {1})
table.insert(Eq[4], {44})
table.insert(Eq[5], 400)

for PTSQ=7, 8 do
	table.insert(Eq[1], PTSQ)
	table.insert(Eq[2], 93)
	table.insert(Eq[3], {3})
	table.insert(Eq[4], {135})
	table.insert(Eq[5], 400)
end

table.insert(Eq[1], 2)
table.insert(Eq[2], 95)
table.insert(Eq[3], {101})
table.insert(Eq[4], {570})
table.insert(Eq[5], 650)

table.insert(Eq[1], 2)
table.insert(Eq[2], 124)
table.insert(Eq[3], {103})
table.insert(Eq[4], {430})
table.insert(Eq[5], 650)
--=====================================================================
local skl = {{}, {}, {}} --0~9, 장비번호, 스킬
table.insert(skl[1], 2)
table.insert(skl[2], 124)
table.insert(skl[3], {109})

Server.onRefreshStats.Add(function(unit)
	for i=0, 9 do
		if unit.GetEquipItem(i) ~= nil then
			if unit.GetEquipItem(i).dataID ~= unit.GetVar(i) then
				unit.SendCenterLabel(Server.GetItem((unit.GetEquipItem(i).dataID)).name.."를(을) 착용하였습니다.")
				unit.SetVar(i, unit.GetEquipItem(i).dataID)
				if i == 2 then
					unit.PlaySE("무기변경 효과음.ogg", 0.9)
					break
				else
					unit.PlaySE("장비변경 효과음.ogg", 1)
					break
				end
			end
		else
			unit.SetVar(i, 0)
		end
	end
	--=====================================================================
	unit.SetStat(101, unit.GetStat(101) + unit.GetVar(101)) --근력
	unit.SetStat(102, unit.GetStat(102) + unit.GetVar(102)) --인내력
	unit.SetStat(103, unit.GetStat(103) + unit.GetVar(103)) --지능
	unit.SetStat(104, unit.GetStat(104) + unit.GetVar(104)) --손재주
	unit.SetStat(4,   unit.GetStat(4) + unit.GetVar(105)) --민첩
	unit.SetStat(5,   unit.GetStat(5) + unit.GetVar(106)) --운
	--=====================================================================
	if unit.HasSkill(15) then
		unit.SetStat(101, unit.GetStat(101)*(1.05+unit.GetSkillLevel(15)*0.05) ) --근력
		unit.SetVar(40, unit.GetSkillLevel(15))
	elseif unit.HasSkill(57) then
		unit.SetStat(103, unit.GetStat(103)*(1.05+unit.GetSkillLevel(57)*0.05) )
		unit.SetVar(41, unit.GetSkillLevel(57))
	end
	--=====================================================================
	local AGI = unit.agi/30 --3000 찍었을 때 이동속도 100 증가
	local LUK = unit.luk/20 --1000 찍었을 때 이동속도 50 증가
	if AGI >= 100 then AGI = 100 end
	if LUK >= 50 then LUK = 50 end
	unit.moveSpeed = Server.GetCharacter(unit.characterID).moveSpeed + AGI + LUK
	
	for i=1, #Eq[1] do --레벨제한, 스텟상승 로직
		if unit.GetEquipItem(Eq[1][i]) ~= nil then
			if unit.GetEquipItem(Eq[1][i]).dataID == Eq[2][i] and unit.level >= Eq[5][i] then
				for j, v in pairs(Eq[3][i]) do
					unit.SetStat(Eq[3][i][j], unit.GetStat(Eq[3][i][j]) + Eq[4][i][j] )
				end
			end
		end
	end
	
	for i=1, #skl[1] do --스킬 배움, 삭제 로직
		if unit.GetEquipItem(skl[1][i]) ~= nil then
			if unit.GetEquipItem(skl[1][i]).dataID == skl[2][i] then
				for j, v in pairs(skl[3][i]) do
					unit.AddSkill(v, 1, false)
					--print(v, '익힘')
				end
			else
				for j, v in pairs(skl[3][i]) do
					unit.RemoveSkill(v)
					--print(v, '삭제')
				end
			end
		end
	end
	--=====================================================================
	unit.SetStat(0, unit.GetStat(0) + (1+unit.GetStat(101)/4)*1.4) --공격력
	unit.SetStat(1, unit.GetStat(1) + unit.GetStat(102)/4.5) --방어력
	unit.SetStat(2, unit.GetStat(2) + unit.GetStat(103)*1.2) --마법공격력
	unit.SetStat(3, unit.GetStat(3) + unit.GetStat(103)/3^1.05) --마법방어력
	unit.SetStat(6, unit.GetStat(6) + unit.GetStat(101)/2 + unit.GetStat(102)^1.05 ) --체력
	unit.SetStat(7, unit.GetStat(7) + unit.GetStat(103)*1.2) --마나
	--unit.SetStat(110, unit.GetStat(110)) --지 속성
	--unit.SetStat(111, unit.GetStat(111)) --화 속성
	--unit.SetStat(112, unit.GetStat(112)) --수 속성
	--unit.SetStat(113, unit.GetStat(113)) --풍 속성
	--unit.SetStat(114, unit.GetStat(114)) --암 속성
	--unit.SetStat(115, unit.GetStat(115)) --성 속성
	--unit.SetStat(116, unit.GetStat(116)) --무 속성
	--unit.SetStat(117, unit.GetStat(117)) --마 속성
	--=====================================================================
	local Sin = 0 --이동속도를 조절해줄 변수
	if unit.GetEquipItem(4) ~= nil then --신발
		local Qs = unit.GetEquipItem(4).dataID
		Sin = sin_list[Qs]
	end
	--=====================================================================
	if Sin ~= 0 and Sin ~= nil then
		unit.moveSpeed = unit.moveSpeed + Sin
	end
	--=====================================================================
	unit.StartGlobalEvent(18)
end)