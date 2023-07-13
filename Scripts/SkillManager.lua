Client.GetTopic("skill_Window").Add(function(Table, Table2)
	skill_Window(Table, Table2)
end)

local global_S_T = {
['재빠른 검기'] = 
[[쿨타임 : 2.2
<color=#A9E2F3>마나소모 : 1</color>
<color=#F5A9A9>물리 공격 계수 : 50%</color>
<color=#BDBDBD>레벨당 계수 : 5%</color>
<color=#F2F5A9>딜레이 : 0.25초</color>
<color=#A9F5F2>스킬포인트 : 1</color>

3가지 검기 중 하나를 사용한다.]],
--===========================================================================================================================================
['강력한 몽둥이'] = 
[[쿨타임 : 1.5
<color=#A9E2F3>마나소모 : 2</color>
<color=#F5A9A9>물리 공격 계수 : 200%</color>
<color=#BDBDBD>레벨당 계수 : 20%</color>
<color=#F2F5A9>딜레이 : 0.2초</color>
<color=#A9F5F2>선행스킬 : 재빠른검기 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 3</color>

강력한 몽둥이로 크게 휘두른다.]],
--===========================================================================================================================================
['파워 블런트'] = 
[[쿨타임 : 1.35
<color=#A9E2F3>마나소모 : 2</color>
<color=#F5A9A9>물리 공격 계수 : 180%</color>
<color=#BDBDBD>레벨당 계수 : 18%</color>
<color=#F2F5A9>딜레이 : 0.2초</color>
<color=#A9F5F2>선행스킬 : 재빠른검기 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 3</color>

뭉툭한 둔기로 크게 휘두른다.]],
--===========================================================================================================================================
['이격'] = 
[[쿨타임 : 2.5
<color=#A9E2F3>마나소모 : 3</color>
<color=#F5A9A9>물리 공격 계수 : 200%</color>
<color=#BDBDBD>레벨당 계수 : 20%</color>
<color=#F2F5A9>딜레이 : 0.2초</color>
<color=#A9F5F2>선행스킬 : 강력한 몽둥이 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 4</color>

설명]],
--===========================================================================================================================================
['삼격'] = 
[[쿨타임 : 2.8
<color=#A9E2F3>마나소모 : 3</color>
<color=#F5A9A9>물리 공격 계수 : 200%</color>
<color=#BDBDBD>레벨당 계수 : 20%</color>
<color=#F2F5A9>딜레이 : 0.2초</color>
<color=#A9F5F2>선행스킬 : 파워 블런트 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 4</color>

설명]],
--===========================================================================================================================================
['후려패기'] = 
[[쿨타임 : 4
<color=#A9E2F3>마나소모 : 6</color>
<color=#F5A9A9>물리 공격 계수 : 800%</color>
<color=#BDBDBD>레벨당 계수 : 80%</color>
<color=#F2F5A9>딜레이 : 0.3초</color>
<color=#A9F5F2>선행스킬 : 이격 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 5</color>

설명]],
--===========================================================================================================================================
['암격'] = 
[[쿨타임 : 4
<color=#A9E2F3>마나소모 : 6</color>
<color=#F5A9A9>물리 공격 계수 : 1200%</color>
<color=#BDBDBD>레벨당 계수 : 120%</color>
<color=#F2F5A9>딜레이 : 0.3초</color>
<color=#A9F5F2>선행스킬 : 삼격 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 5</color>

설명]],
--===========================================================================================================================================
['피의 검격'] = 
[[쿨타임 : 5.5
<color=#A9E2F3>마나소모 : 10</color>
<color=#F5A9A9>물리 공격 계수 : 260%</color>
<color=#BDBDBD>레벨당 계수 : 26%</color>
<color=#F2F5A9>딜레이 : 없음</color>
<color=#A9F5F2>선행스킬 : 후려패기 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 8</color>

설명]],
--===========================================================================================================================================
['암흑돌진'] = 
[[쿨타임 : 5
<color=#A9E2F3>마나소모 : 5</color>
<color=#F5A9A9>물리 공격 계수 : 900%</color>
<color=#BDBDBD>레벨당 계수 : 90%</color>
<color=#F2F5A9>딜레이 : 없음</color>
<color=#A9F5F2>선행스킬 : 암격 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 4</color>

설명]],
--===========================================================================================================================================
['강인한 육체[패시브]'] = 
[[<color=#F5A9A9>근력 : 1%</color>
<color=#F5A9A9>HP 자연회복 : 30</color>
<color=#BDBDBD>레벨당 계수 : 근력 0.5%</color>
<color=#BDBDBD>레벨당 계수 : HP 자연회복 30</color>
<color=#A9F5F2>스킬포인트 : 5</color>

전사의 기본소양이다.]],
--===========================================================================================================================================
['사원소 마법'] =
[[쿨타임 : 1.5
<color=#A9E2F3>마나소모 : 4</color>
<color=#F5A9A9>마법 공격 계수
얼음공 : 100% <color=#BDBDBD>레벨 당 : 10%</color>
불꼬리 : 150% <color=#BDBDBD>레벨 당 : 15%</color>
암흑구 : 200% <color=#BDBDBD>레벨 당 : 20%</color>
라이팅 : 250% <color=#BDBDBD>레벨 당 : 25%</color></color>
<color=#F2F5A9>딜레이 : 0.25초</color>
<color=#A9F5F2>스킬포인트 : 2</color>

설명]],
--===========================================================================================================================================
['포탈'] =
[[쿨타임 : 1
<color=#A9E2F3>마나소모 : 없음</color>
<color=#F2F5A9>딜레이 : 없음</color>
필요재화 : 2500 Gold
<color=#A9F5F2>스킬포인트 : 5</color>

레벨에 따라 저장할 수 있는 위치 개수가 달라진다. 본인 포함 최대 6명까지 이동이 가능한 포탈을 오픈한다. 위치를 저장하려면 '저장' 혹은 'save'라고 입력 시 위치가 저장된다.]],
--===========================================================================================================================================
['전격'] =
[[쿨타임 : 4
<color=#A9E2F3>마나소모 : 14 </color> <color=#BDBDBD>레벨 당 1추가 소모</color>
<color=#F5A9A9>마법 공격 계수 : 120%</color>
<color=#BDBDBD>레벨당 계수 : 12%</color>
<color=#F2F5A9><size='13'>딜레이 0.4초</size></color>
<color=#A9F5F2>선행스킬 : 사원소 마법 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 4</color>

설명]],
--===========================================================================================================================================
['프로스트 노바'] =
[[쿨타임 : 3.7
<color=#A9E2F3>마나소모 : 12 </color> <color=#BDBDBD>레벨 당 1추가 소모</color>
<color=#F5A9A9>마법 공격 계수 : 100%</color>
<color=#BDBDBD>레벨당 계수 : 10%</color>
<color=#F2F5A9><size='13'>딜레이 0.4초</size></color>
<color=#A9F5F2>선행스킬 : 사원소 마법 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 4</color>

설명]],
--===========================================================================================================================================
['프로미넌스'] =
[[쿨타임 : 11
<color=#A9E2F3>마나소모 : 38 </color> <color=#BDBDBD>레벨 당 2추가 소모</color>
<color=#F5A9A9>마법 공격 계수 : 150%</color>
<color=#BDBDBD>레벨당 계수 : 15%</color>
<color=#F2F5A9><size='13'>딜레이 없음</size></color>
<color=#A9F5F2>선행스킬 : 전격 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 5</color>

120px 반경의 몬스터를 1초의 틱마다 강력한 불에 태운다.]],
--===========================================================================================================================================
['홀리 클로'] =
[[쿨타임 : 11
<color=#A9E2F3>마나소모 : 38 </color> <color=#BDBDBD>레벨 당 2추가 소모</color>
<color=#F5A9A9>마법 공격 계수 : 70%</color>
<color=#BDBDBD>레벨당 계수 : 7%</color>
<color=#F2F5A9><size='13'>딜레이 없음</size></color>
<color=#A9F5F2>선행스킬 : 프로스트 노바 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 5</color>

170px 반경의 몬스터를 1초의 틱마다 성스러운 클로로 공격한다.]],
--===========================================================================================================================================
['썬더스톰'] =
[[쿨타임 : 6
<color=#A9E2F3>마나소모 : 95 </color> <color=#BDBDBD>레벨 당 4추가 소모</color>
<color=#F5A9A9>마법 공격 계수 : 500%</color>
<color=#BDBDBD>레벨당 계수 : 50%</color>
<color=#F2F5A9><size='13'>딜레이 0.7초</size></color>
<color=#A9F5F2>선행스킬 : 프로미넌스 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 10</color>

설명]],
--===========================================================================================================================================
['다크 네펜데스'] =
[[쿨타임 : 6
<color=#A9E2F3>마나소모 : 95 </color> <color=#BDBDBD>레벨 당 4추가 소모</color>
<color=#F5A9A9>마법 공격 계수 : 220%</color>
<color=#BDBDBD>레벨당 계수 : 22%</color>
<color=#F2F5A9><size='13'>딜레이 0.2초</size></color>
<color=#A9F5F2>선행스킬 : 홀리 클로 Lv.5</color>
<color=#A9F5F2>스킬포인트 : 10</color>

설명]],
--===========================================================================================================================================
['마법사의 지혜[패시브]'] = 
[[<color=#F5A9A9>지능 : 1%</color>
<color=#F5A9A9>MP 자연회복 : 20</color>
<color=#BDBDBD>레벨당 계수 : 지능 0.5%</color>
<color=#BDBDBD>레벨당 계수 : MP 자연회복 20</color>
<color=#A9F5F2>스킬포인트 : 4</color>

마법사의 기본 소양이다.]],
--===========================================================================================================================================
}
local max_level = {{}, {}, {{}, {}}}
for i=1, 60 do
	max_level[1][i] = (i==48 and 5) or 10 --스킬 만렙
	max_level[2][i] = 1 --스킬 소모포인트
	max_level[3][1][i] = 0 --선행 스킬
	max_level[3][2][i] = 0 --선행 스킬레벨
end
Client.RunLater(function() 
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
	
	for i=2, 9 do max_level[3][2][warrior['1차'][i]] = 5 end
	max_level[3][1][warrior['1차'][2]] = warrior['1차'][1]
	max_level[3][1][warrior['1차'][3]] = warrior['1차'][1]
	max_level[3][1][warrior['1차'][5]] = warrior['1차'][2]
	max_level[3][1][warrior['1차'][6]] = warrior['1차'][3]
	max_level[3][1][warrior['1차'][7]] = warrior['1차'][5]
	max_level[3][1][warrior['1차'][8]] = warrior['1차'][6]
	max_level[3][1][warrior['1차'][4]] = warrior['1차'][7]
	max_level[3][1][warrior['1차'][9]] = warrior['1차'][8]

	max_level[2][wizard['1차'][1]] = 2 --사원소 마법
	max_level[2][wizard['1차'][2]] = 5 --포탈
	max_level[2][wizard['1차'][3]] = 4 --전격
	max_level[2][wizard['1차'][4]] = 4 --프로스트노바
	max_level[2][wizard['1차'][5]] = 5 --프로미넌스
	max_level[2][wizard['1차'][6]] = 5 --홀리 클로
	max_level[2][wizard['1차'][7]] = 4 --마법사의 지혜
	max_level[2][wizard['1차'][8]] = 10 --썬더스톰
	max_level[2][wizard['1차'][9]] = 10 --다크 네펜데스
	
	for i=3, 6 do max_level[3][2][wizard['1차'][i]] = 5 end
	for i=8, 9 do max_level[3][2][wizard['1차'][i]] = 5 end
	max_level[3][1][wizard['1차'][3]] = wizard['1차'][1]
	max_level[3][1][wizard['1차'][4]] = wizard['1차'][1]
	max_level[3][1][wizard['1차'][5]] = wizard['1차'][3]
	max_level[3][1][wizard['1차'][6]] = wizard['1차'][4]
	max_level[3][1][wizard['1차'][8]] = wizard['1차'][5]
	max_level[3][1][wizard['1차'][9]] = wizard['1차'][6]
end, 0.6)

function skp(Q, p_m_but, lv, real_text, j, RRT)
	local num = RRT[j]
	local name = Client.GetSkill(num).name
	local W = (Q[num] == -1 and 0 or Q[num])
	if skp_b then 
		skp_t.text = "<color=#FFFF00><size='16'>Lv."..lv[j].text.." "..name.."</size></color>\n"..global_S_T[name] 
		for i=1, 2 do
			p_m_but[i] = Button((i==1 and '✚') or '▬', Rect(skp_b.width - 30, (i==1 and 5) or 35, 25, 25))
			p_m_but[i].color = Color(150, 150, 150, 255)
			skp_b.AddChild(p_m_but[i])
		end
		if lv[j].text == 'max' then return end
		p_m_but[1].onClick.Add(function()
			if tonumber(lv[j].text) >= max_level[1][num] then
				Client.FireEvent("SendCenterLabel", "이미 최대레벨입니다.")
			else
				if tonumber(real_text.text) >= max_level[2][num] then
					local dumy = {}
					for k, p in pairs(RRT) do
						if max_level[3][1][num] == p then
							table.insert(dumy, k)
						end
					end
					for k, p in pairs(dumy) do
						if lv[p].text == 'max' or tonumber(lv[p].text) >= max_level[3][2][num] then
							
						else
							Client.FireEvent("SendCenterLabel", "선행스킬이 부족합니다.")
							return
						end
					end
					lv[j].text = tonumber(lv[j].text) + 1
					real_text.text = tonumber(real_text.text) - max_level[2][num]
					skp_t.text = "<color=#FFFF00><size='16'>Lv."..lv[j].text.." "..name.."</size></color>\n"..global_S_T[name] 
				else
					Client.FireEvent("SendCenterLabel", "스킬포인트가 부족합니다.")
				end
			end
		end)
		p_m_but[2].onClick.Add(function()
			if tonumber(lv[j].text) > W then
				local dumy = {}
				for k, p in pairs(max_level[3][1]) do
					if num == p then
						table.insert(dumy, k)
					end
				end
				local dumy2 = {}
				for k, p in pairs(dumy) do
					for i, v in pairs(RRT) do
						if p == v then
							table.insert(dumy2, i)
						end
					end
				end
				for i, v in pairs(dumy2) do
					if tonumber(lv[v].text) >= 1 and tonumber(lv[j].text) <= 5 then
						return
					end
				end
				lv[j].text = tonumber(lv[j].text) - 1
				skp_t.text = "<color=#FFFF00><size='16'>Lv."..lv[j].text.." "..name.."</size></color>\n"..global_S_T[name] 
				real_text.text = tonumber(real_text.text) + max_level[2][num]
			end
		end)
		return 
	end
	skp_b = Button('', Rect(Skill_Panel.x+Skill_Panel.width+20, Skill_Panel.y-15, 240, 400))
	skp_b.color = Color(0, 0, 0, 0)
	skp_b.showOnTop = true
	skp_b.onClick.Add(function()
		--[[
		skp_b.Destroy()
		skp_b = nil
		]]
	end)
	local skp_p = Panel(Rect(0, 0, skp_b.width, skp_b.height))
	skp_p.color = Color(38, 38, 38, 220)
	skp_b.AddChild(skp_p)
	
	skp_t = Text('', Rect(5, 5, skp_b.width-10, skp_b.height))
	skp_t.text = "<color=#FFFF00><size='16'>Lv."..lv[j].text.." "..name.."</size></color>\n"..global_S_T[name] 
	for i=1, 2 do
		p_m_but[i] = Button((i==1 and '✚') or '▬', Rect(skp_b.width - 30, (i==1 and 5) or 35, 25, 25))
		p_m_but[i].color = Color(150, 150, 150, 255)
		skp_b.AddChild(p_m_but[i])
	end
	skp_t.textAlign = 0
	skp_b.AddChild(skp_t)
	p_m_but[1].OrderToLast()
	p_m_but[2].OrderToLast()
	if lv[j].text == 'max' then return end
	p_m_but[1].onClick.Add(function()
		if tonumber(lv[j].text) >= max_level[1][num] then
			Client.FireEvent("SendCenterLabel", "이미 최대레벨입니다.")
		else
			if tonumber(real_text.text) >= max_level[2][num] then
				local dumy = {}
				for k, p in pairs(RRT) do
					if max_level[3][1][num] == p then
						table.insert(dumy, k)
					end
				end
				for k, p in pairs(dumy) do
					if lv[p].text == 'max' or tonumber(lv[p].text) >= max_level[3][2][num] then
						
					else
						Client.FireEvent("SendCenterLabel", "선행스킬이 부족합니다.")
						return
					end
				end
				lv[j].text = tonumber(lv[j].text) + 1
				real_text.text = tonumber(real_text.text) - max_level[2][num]
				skp_t.text = "<color=#FFFF00><size='16'>Lv."..lv[j].text.." "..name.."</size></color>\n"..global_S_T[name] 
			else
				Client.FireEvent("SendCenterLabel", "스킬포인트가 부족합니다.")
			end
		end
	end)
	p_m_but[2].onClick.Add(function()
		if tonumber(lv[j].text) > W then
			local dumy = {}
			for k, p in pairs(max_level[3][1]) do
				if num == p then
					table.insert(dumy, k)
				end
			end
			local dumy2 = {}
			for k, p in pairs(dumy) do
				for i, v in pairs(RRT) do
					if p == v then
						table.insert(dumy2, i)
					end
				end
			end
			for i, v in pairs(dumy2) do
				if tonumber(lv[v].text) >= 1 and tonumber(lv[j].text) <= 5 then
					return
				end
			end
			lv[j].text = tonumber(lv[j].text) - 1
			skp_t.text = "<color=#FFFF00><size='16'>Lv."..lv[j].text.." "..name.."</size></color>\n"..global_S_T[name] 
			real_text.text = tonumber(real_text.text) + max_level[2][num]
		end
	end)
end

local RRT = {}
function has_pay(T, Q, icon_n_but, skill_level, Skill_Image, Skill_Panel_2, p_m_but, real_text)	
	for i, v in pairs(T) do
		RRT[i] = v
		icon_n_but[i] = Button('', Rect(0, 0, 40, 40))
		icon_n_but[i].color = Color(76, 76, 76, 255)
		skill_level[i] = Text((Q[v] == -1 and 0 or Q[v] == 10 and 'max' or Q[v]), Rect(1, 0, icon_n_but[i].width-1, icon_n_but[i].height))
		skill_level[i].textSize = 12
		skill_level[i].textAlign = 0
		skill_level[i].color = Color(0, 255, 0, 255)
		Skill_Image[i] = Image('', Rect(0, 0, icon_n_but[i].width, icon_n_but[i].height))
		Skill_Image[i].SetImageID(Client.GetSkill(v).iconID)
		icon_n_but[i].AddChild(Skill_Image[i])
		Skill_Image[i].AddChild(skill_level[i])
		Skill_Panel_2.AddChild(icon_n_but[i])
		icon_n_but[i].onClick.Add(function() 
			skp(Q, p_m_but, skill_level, real_text, i, RRT)
		end)
	end
end

function skill_Window(Table, Table2)
	if Skill_Panel then return end
	local Q = Utility.JSONParse(Table)
	local W = Utility.JSONParse(Table2)
	
	local cw = Client.width
	local ch = Client.height
	local Garo = 225
	local Sero = 360
	local blue_color = Color(160, 220, 235, 255)
	local Letter = {
	{'✪ 스킬트리', '포인트', 'Eng', '결 정', '초기화'}, 
	{'✪ Skill Streat', 'Point', '한글', 'Decide', 'Dft'}
	}
	Skill_Panel = ScrollPanel(Rect(cw/2-Garo/2, ch/2-Sero/2, Garo, Sero))
	Skill_Panel.content = Skill_Panel
	Skill_Panel.color = Color(38, 38, 38, 255)
	Skill_Panel.showOnTop = true
	
	local Top_Panel = Panel(Rect(0, 0, Skill_Panel.width, 34))
	Top_Panel.color = Color(56, 56, 56, 255)
	Skill_Panel.AddChild(Top_Panel)
	
	local Top_Text = Text(Letter[W[2]][1], Rect(5, 0, Skill_Panel.width, 34))
	Top_Text.textSize = 20
	Top_Text.textAlign = 3
	Top_Panel.AddChild(Top_Text)
	
	local Close_button = Button("✖", Rect(Skill_Panel.width-34, 0, 34, 34))
	Close_button.textSize = 24
	Close_button.textAlign = 4
	Close_button.color = Color(74, 74, 74, 255)
	Top_Panel.AddChild(Close_button)
	Close_button.onClick.Add(function()
		Skill_Panel.DOScale(Point(0.01, 0.01), 0.2)
		Skill_Panel.DOMove(Point(TopMenu.mainPanel.x+TopMenu.mainPanel.width-43+20, TopMenu.mainPanel.y+20), 0.2)
		if skp_b then skp_b.Destroy() skp_b=nil end
		Client.RunLater(function()
			Skill_Panel.Destroy()
			Skill_Panel = nil
		end, 0.2)
	end)
	local point_txt = Text(Letter[W[2]][2], Rect(4, Skill_Panel.height-36, 44, 32))
	point_txt.textSize = 15
	point_txt.textAlign = 4
	Top_Panel.AddChild(point_txt)
	
	local Point_Panel = Panel(Rect(52, Skill_Panel.height-36, 36, 32))
	Point_Panel.color = Color(64, 64, 64, 255)
	Top_Panel.AddChild(Point_Panel)
	
	local but = {}
	for i=1, 3 do
		but[i] = Button(nil, Rect(128+36*(i-1), Skill_Panel.height-36, ((i==1 or i==3) and 32) or 57, 32))
		but[i].color = Color(87, 87, 87, 255)
		but[i].text = Letter[W[2]][i+2]
		Top_Panel.AddChild(but[i])
	end
	but[3].x = Point_Panel.x+Point_Panel.width+4
	but[3].textSize = 11
	
	but[1].onClick.Add(function() --Eng, 한글
		if but[1].text == 'Eng' then
			Top_Text.text = Letter[2][1]
			point_txt.text = Letter[2][2]
			for i=1, 3 do
				but[i].text = Letter[2][i+2]
			end
		else
			Top_Text.text = Letter[1][1]
			point_txt.text = Letter[1][2]
			for i=1, 3 do
				but[i].text = Letter[1][i+2]
			end
		end
		Client.FireEvent("Language_Transformation", but[1].text, true)
	end)
	
	but[2].onClick.Add(function() --Decide, 결정
		local QQ = {}
		for i, v in pairs(skill_level) do
			table.insert(QQ, v.text)
		end
		Client.FireEvent("skill_Decide", Utility.JSONSerialize(QQ))
	end)
	but[3].onClick.Add(function() --Dft, 초기화
		if W[3] == 1 then
			for i, v in pairs(warrior['1차']) do
				if skp_b then
					skp_b.Destroy()
					skp_b = nil
				end
				skill_level[i].text = (Q[v] == -1 and 0 or Q[v] == 10 and 'max' or Q[v])
			end
		elseif W[3] == 2 then
		elseif W[3] == 3 then
		else
		end
		real_text.text = W[1]
	end)
	
	real_text = Text(W[1], Rect(4, 0, Point_Panel.width, Point_Panel.height))
	real_text.textSize = 15
	real_text.textAlign = 3
	real_text.color = Color(160, 220, 235, 255)
	Point_Panel.AddChild(real_text)
	
	local menu_but = {}
	for i=1, 4 do
		menu_but[i] = Button((i==1) and 'Ⅰ' or (i==2) and 'Ⅱ' or (i==3) and 'Ⅲ' or (i==4) and 'Ⅳ', 
			Rect((i-1)*55+4, 38, 51, 32))
		menu_but[i].color = Color(87, 87, 87, 255)
		menu_but[i].textSize = 18
		menu_but[i].textAlign = 4
		Top_Panel.AddChild(menu_but[i])
		menu_but[i].onClick.Add(function()
		menu_but[i].color = blue_color
			for j=1, 4 do
				if i ~= j then
					menu_but[j].color = Color(87, 87, 87, 255)
				end
			end			
		end)
	end
	menu_but[1].color = blue_color
	local scroll_panel = ScrollPanel()
	scroll_panel.rect = Rect(4, menu_but[1].y+menu_but[1].height+4, Garo-8, Sero-114)	
	scroll_panel.horizontal = false
	scroll_panel.showVerticalScrollbar = true
	Skill_Panel.AddChild(scroll_panel)
	local Skill_Panel_2 = Panel(Rect(0, 0, Garo-8, Sero-100))
	Skill_Panel_2.color = Color(22, 22, 22, 255)
	scroll_panel.AddChild(Skill_Panel_2)
	scroll_panel.content = Skill_Panel_2
	local icon_n_but = {}
	local Skill_Image = {}
	skill_level = {}
	local p_m_but = {}
	local skill_bg = Image('', Rect(0, 0, Skill_Panel_2.width, Skill_Panel_2.height))
	if W[3] == 1 then
		has_pay(warrior['1차'], Q, icon_n_but, skill_level, Skill_Image, 
		Skill_Panel_2, p_m_but, real_text)
		skill_bg.image = 'Pictures/warrior.png'
		Skill_Panel_2.AddChild(skill_bg)
		skill_bg.OrderToFirst()
		icon_n_but[1].x = 75 --재빠른 검기
		icon_n_but[1].y = 10
		icon_n_but[2].x = 30 --강력한 몽둥이
		icon_n_but[2].y = 60
		icon_n_but[3].x = 120 --파워 블런트
		icon_n_but[3].y = 60
		icon_n_but[4].x = 30 --피의 검격
		icon_n_but[4].y = 210
		icon_n_but[5].x = 30 --이격
		icon_n_but[5].y = 110
		icon_n_but[6].x = 120 --삼격
		icon_n_but[6].y = 110
		icon_n_but[7].x = 30 --후려패기
		icon_n_but[7].y = 160
		icon_n_but[8].x = 120 --암격
		icon_n_but[8].y = 160
		icon_n_but[9].x = 120 --암흑돌진
		icon_n_but[9].y = 210
		icon_n_but[10].x = 10 --강인한 육체[패시브]
		icon_n_but[10].y = 10
	elseif W[3] == 2 then
	elseif W[3] == 3 then
		has_pay(wizard['1차'], Q, icon_n_but, skill_level, Skill_Image, 
		Skill_Panel_2, p_m_but, real_text)
		skill_bg.image = 'Pictures/wizard.png'
		Skill_Panel_2.AddChild(skill_bg)
		skill_bg.OrderToFirst()
		icon_n_but[1].x = 75 --사원소 마법
		icon_n_but[1].y = 10
		icon_n_but[2].x = 147 --포탈
		icon_n_but[2].y = 10
		icon_n_but[3].x = 30 --전격
		icon_n_but[3].y = 70
		icon_n_but[4].x = 120 --프로스트 노바
		icon_n_but[4].y = 70
		icon_n_but[5].x = 30 --프로미넌스
		icon_n_but[5].y = 130
		icon_n_but[6].x = 120 --홀리 클로
		icon_n_but[6].y = 130
		icon_n_but[7].x = 10 --마법사의 지혜[패시브]
		icon_n_but[7].y = 10
		icon_n_but[8].x = 30 --썬더스톰
		icon_n_but[8].y = 190
		icon_n_but[9].x = 120 --다크 네펜데스
		icon_n_but[9].y = 190
	else
		skill_bg.Destroy()
		skill_bg = nil
	end
end











warrior = {}
wizard = {}
Client.GetTopic("job_man").Add(function(a, b)
	warrior = Utility.JSONParse(a)
	wizard = Utility.JSONParse(b)
end)
