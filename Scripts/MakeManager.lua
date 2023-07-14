--[[
	제작 : 사랑요
	마음대로 사용하시고 마음껏 수정하세요.
]]

local DA_SOM = {}
local CATEGORIES = { '무기', '방어구', '악세사리', '소모품', '재료' }
local CHOICE_MENU = {
	[CATEGORIES[1]] = { 95, 124, 90 },
	[CATEGORIES[2]] = { 91, 92 },
	[CATEGORIES[3]] = { 93, 150 },
	[CATEGORIES[4]] = {},
	[CATEGORIES[5]] = { 103, 104, 105, 106, 107, 108, 109, 110, 111 }
}
local DELICATE = {
	['95'] = { 94, 96, 8, 112, 113, 117, 119 },
	['124'] = { 94, 96, 8, 112, 113, 117, 119 },
	['90'] = { 84, 87, 88, 96, 47, 36, 37 },
	['91'] = { 86, 12, 96, 17, 52, 53 },
	['92'] = { 86, 85, 9, 96, 61, 63 },
	['93'] = { 89, 96, 70, 74, 24, 45 },
	['150'] = { 90, 91, 92, 93 },
	['103'] = { 100 },
	['104'] = { 101 },
	['105'] = { 102 },
	['106'] = { 103 },
	['107'] = { 104 },
	['108'] = { 105 },
	['109'] = { 106 },
	['110'] = { 107 },
	['111'] = { 108 },
}
local DELICATECOUNT = {
	['95'] = { 1, 3, 10, 50, 350, 10, 1 },
	['124'] = { 1, 3, 10, 350, 50, 10, 1 },
	['90'] = { 240, 200, 160, 1, 1, 1, 1 },
	['91'] = { 150, 400, 1, 15, 1, 1 },
	['92'] = { 150, 200, 120, 1, 1, 1 },
	['93'] = { 200, 1, 1, 1, 1, 1 },
	['150'] = { 1, 1, 1, 1 },
	['103'] = { 10 },
	['104'] = { 10 },
	['105'] = { 10 },
	['106'] = { 10 },
	['107'] = { 10 },
	['108'] = { 10 },
	['109'] = { 25 },
	['110'] = { 25 },
	['111'] = { 25 },
}

--Delicate 와 Delicate_count 의 짝이 꼭 맞아야함.
--아래부터는 수정할 필요가 없습니다.
Client.RunLater(function()
	Client.FireEvent('Love', Utility.JSONSerialize(CATEGORIES), Utility.JSONSerialize(CHOICE_MENU),
		Utility.JSONSerialize(DELICATE), Utility.JSONSerialize(DELICATECOUNT))
end, 0.5)

Client.RunLater(function()
	Client.FireEvent('DASOM3')
end, 0.3)

Client.GetTopic("DASOM2").Add(function(Table)
	DA_SOM = Utility.JSONParse(Table)
end)

function make_Window()
	if Make_Panel then return end
	local cw = Client.width
	local ch = Client.height
	local windowWidth = 650
	local windowHeight = 380
	local blueColor = Color(160, 220, 235, 255)
	local lightBlueColor = Color(160, 220, 235, 140)

	Make_Panel = ScrollPanel(Rect(cw / 2 - windowWidth / 2, ch / 2 - windowHeight / 2, windowWidth, windowHeight))
	Make_Panel.content = Make_Panel
	Make_Panel.color = Color(0, 0, 0, 255)
	Make_Panel.showOnTop = true

	local Make_Panel2 = Panel(Rect(1, 1, Make_Panel.width - 2, Make_Panel.height - 2))
	Make_Panel2.color = Color(66, 66, 66, 255)
	Make_Panel.AddChild(Make_Panel2)

	local CloseButton = Button('✖', Rect(windowWidth - 42, 0, 42, 42))
	CloseButton.textSize = 26
	CloseButton.textAlign = 4
	CloseButton.color = Color(87, 87, 87, 255)
	Make_Panel2.AddChild(CloseButton)
	CloseButton.onClick.Add(function()
		Make_Panel.Destroy()
		Make_Panel = nil
		if op then
			for i, v in pairs(op[1]) do
				v.Destroy()
				v = nil
			end
		end
	end)

	local Make_but = {}
	for i = 1, 1 do
		Make_but[i] = Button((i == 1 and '제작') or (i == 2 and '분해'), Rect(5 + 85 * (i - 1), 5, 80, 42))
		Make_but[i].color = Color(89, 89, 89, 255)
		Make_but[i].textSize = 22
		Make_but[i].textAlign = 4
		Make_Panel2.AddChild(Make_but[i])
	end
	Make_but[1].color = blueColor
	local main_panel = Panel(Rect(90, 65, 553, 268))
	main_panel.color = Color(77, 77, 77, 255)
	Make_Panel2.AddChild(main_panel)
	local inP = Panel(Rect(main_panel.width - 258, 5, 253, 258))
	inP.color = Color(44, 44, 44, 255)
	main_panel.AddChild(inP)
	local inL = Panel(Rect(0, 0, 285, inP.height))
	inL.color = Color(44, 44, 44, 255)
	local scroll_panel = ScrollPanel()
	scroll_panel.rect = Rect(5, 5, 285, 258)
	scroll_panel.horizontal = false
	scroll_panel.showVerticalScrollbar = false
	scroll_panel.content = inL
	main_panel.AddChild(scroll_panel)

	local Choice_Panel = Panel(Rect(5, 65, 80, 308))
	Choice_Panel.color = Color(77, 77, 77, 255)
	Make_Panel2.AddChild(Choice_Panel)

	local hi_size = 50
	local hp = Panel(Rect(inP.width / 2 - hi_size / 2, inP.height - hi_size / 1.2, hi_size, hi_size / 1.5))
	hp.color = Color(0, 0, 0, 255)
	local hi = Button('제 작', Rect(1, 1, hp.width - 2, hp.height - 2))
	hp.AddChild(hi)
	hi.textSize = 16
	hi.color = Color(153, 153, 103, 255)
	inP.AddChild(hp)
	hp.visible = false

	local Choice_but = {}
	local happy_but = {}
	local happy_panel = {}
	local icon_panel = {}
	local happy_image = {}
	local happy_text = {}
	local oyo = {}
	local D_pal = {}
	local D_icon = {}
	local D_count = {}
	local dumy = {}
	local dumy2 = {}
	local dumy3 = {}
	local bagic = Color(77, 77, 77, 255)
	local bagic2 = Color(111, 111, 111, 255)
	for i = 1, #CATEGORIES do
		Choice_but[i] = Button(CATEGORIES[i], Rect(5, 5 + 37 * (i - 1), 70, 32))
		Choice_but[i].color = bagic2
		Choice_but[i].textSize = 16
		Choice_but[i].textAlign = 4
		Choice_Panel.AddChild(Choice_but[i])
		Choice_but[i].onClick.Add(function()
			for j, q in pairs(D_pal) do
				q.Destroy()
			end
			hp.visible = false
			inL.height = 5 + #CHOICE_MENU[CATEGORIES[i]] * 45
			if Choice_but[i].color.r == blueColor.r then
				return --같은 버튼을 눌렀을 때 쓸데없는 부하 방지
			end
			for j, q in pairs(Choice_but) do
				Choice_but[j].color = bagic2
			end
			for k, n in pairs(happy_but) do
				n.Destroy()
			end
			Choice_but[i].color = blueColor
			for j, b in pairs(CHOICE_MENU[CATEGORIES[i]]) do
				local B = tostring(b)
				happy_but[j] = Button('', Rect(5, 5 + 45 * (j - 1), inL.width - 10, 40))
				happy_but[j].color = Color(0, 0, 0, 0)
				happy_panel[j] = Panel(Rect(0, 0, happy_but[j].width, happy_but[j].height))
				happy_panel[j].color = bagic
				happy_but[j].AddChild(happy_panel[j])
				inL.AddChild(happy_but[j])
				icon_panel[j] = Panel(Rect(1, 1, happy_panel[j].height - 2, happy_panel[j].height - 2))
				icon_panel[j].color = Color(55, 55, 55, 255)
				happy_panel[j].AddChild(icon_panel[j])
				happy_image[j] = Image('', Rect(0, 0, icon_panel[j].width, icon_panel[j].height))
				happy_image[j].SetImageID(Client.GetItem(b).imageID)
				icon_panel[j].AddChild(happy_image[j])
				happy_text[j] = Text(Client.GetItem(b).name,
					Rect(icon_panel[j].width + 7, 0, happy_panel[j].width - icon_panel[j].width - 10,
						happy_panel[j].height))
				happy_text[j].textSize = 16
				happy_text[j].textAlign = 3
				happy_panel[j].AddChild(happy_text[j])
				oyo[j] = Button('✎',
					Rect(happy_panel[j].width - happy_panel[j].height, 0, happy_panel[j].height, happy_panel[j].height))
				oyo[j].color = icon_panel[j].color
				oyo[j].textSize = 22
				happy_panel[j].AddChild(oyo[j])
				happy_but[j].onClick.Add(function()
					if happy_panel[j].color.r == lightBlueColor.r then
						return --같은 버튼을 눌렀을 때 쓸데없는 부하 방지
					end
					hp.visible = true
					for c, m in pairs(happy_panel) do
						m.color = bagic
					end
					happy_panel[j].color = lightBlueColor
					for z, x in pairs(D_pal) do
						x.Destroy()
					end
					if DELICATE[B] == nil then return end

					for l, n in pairs(DELICATE[B]) do
						D_pal[l] = Button('', Rect(5 + 41 * (((l % 6 == 0 and 6) or l % 6) - 1), 5 + 41 *
						math.ceil(l / 6 - 1), 37, 37))
						D_pal[l].color = Color(22, 22, 22, 255)
						inP.AddChild(D_pal[l])
						D_icon[l] = Image('', Rect(0, 0, D_pal[l].width, D_pal[l].height))
						D_icon[l].SetImageID(Client.GetItem(n).imageID)
						D_pal[l].AddChild(D_icon[l])
						D_count[l] = Text('', Rect(0, 0, D_icon[l].width, D_icon[l].height))
						D_count[l].text = (DELICATECOUNT[B][l] ~= nil and DELICATECOUNT[B][l]) or
						'<color=#FE2E2E>잘못됨</color>'
						D_count[l].textSize = 11
						D_count[l].textAlign = 8
						D_icon[l].AddChild(D_count[l])
						D_pal[l].onClick.Add(function()
							if dumy[l] then return end
							local mouse = Input.mousePositionToScreen
							local dumy4 = {}
							for K, V in pairs(DA_SOM) do
								for KK, VV in pairs(V['dataID']) do
									if VV == n then
										table.insert(dumy4, K)
									end
								end
							end
							dumy[l] = Panel(Rect(mouse.x, mouse.y, 120, 45 + #dumy4 * 16))
							dumy[l].color = Color(22, 22, 22, 180)
							dumy[l].showOnTop = true
							dumy2[l] = Text(Client.GetItem(n).name, Rect(5, 5, dumy[l].width - 5, dumy[l].height / 2))
							dumy3[l] = Text('', Rect(5, 5, dumy[l].width - 5, dumy[l].height))
							dumy3[l].text = (#dumy4 == 0 and '\n<color=#FA5858>[드랍 불가]</color>') or
							'\n<color=#F7D358>[▼드랍 몬스터]</color>\n'
							dumy2[l].textAlign = 0
							dumy3[l].textAlign = 0
							for K, V in pairs(dumy4) do
								dumy3[l].text = dumy3[l].text .. Client.GetMonster(V).name .. '\n'
							end
							dumy[l].AddChild(dumy2[l])
							dumy[l].AddChild(dumy3[l])
							Client.RunLater(function()
								dumy[l].Destroy()
								dumy[l] = nil
							end, 1.5)
						end)
					end
				end)
				op = { {}, {}, {} }
				oyo[j].onClick.Add(function()
					op[1][j] = Button('', Rect(300, 50, 235, 400))
					op[1][j].color = Color(0, 0, 0, 0)
					op[1][j].SetOrderIndex(happy_panel[j].GetOrderIndex() + 1)
					op[1][j].showOnTop = true
					op[2][j] = Panel(Rect(0, 0, op[1][j].width, op[1][j].height))
					op[2][j].color = Color(0, 0, 0, 200)
					op[3][j] = Text('', Rect(10, 20, op[1][j].width - 10, op[1][j].height - 20))
					op[3][j].textAlign = 0
					op[3][j].text =
						"<size='18'>" .. Client.GetItem(b).name .. "</size>\n\n" .. Client.GetItem(b).desc
					op[2][j].AddChild(op[3][j])
					op[1][j].AddChild(op[2][j])
					op[1][j].onClick.Add(function()
						op[1][j].Destroy()
						op[1][j] = nil
					end)
				end)
			end
		end)
	end
	hi.onClick.Add(function()
		if oq then --쓸데없는 부하 방지
			return
		end
		local ABC = { 0, 0 }
		for j, b in pairs(Choice_but) do
			if b.color.r == blueColor.r then
				ABC[1] = j
				break
			end
		end
		for i, v in pairs(happy_panel) do
			if v.color.r == lightBlueColor.r then
				ABC[2] = i
				break
			end
		end
		Client.FireEvent('Love2', ABC[1], ABC[2])
	end)

	Client.GetTopic('Love3').Add(function(Table, Table2, txt)
		if oq then
			--oq[1].x = 280
			--oq[1].y = 80
			return
		end
		local T = Utility.JSONParse(Table)
		local T2 = Utility.JSONParse(Table2)
		oq = { [5] = {}, [6] = {}, [7] = {}, [8] = {}, [11] = {} }
		oq[1] = Panel(Rect(280, 80, 250, 350))
		--oq[1].content = oq[1]
		oq[1].color = Color(0, 0, 0, 255)
		oq[1].showOnTop = true
		oq[2] = ScrollPanel(Rect(1, 1, oq[1].width - 2, oq[1].height - 2))
		oq[2].color = Color(54, 54, 54, 255)
		oq[1].AddChild(oq[2])
		oq[4] = Panel(Rect(1, 1, oq[1].width - 2, oq[1].height - 2))
		oq[4].color = Color(78, 78, 78, 255)
		oq[2].AddChild(oq[4])
		oq[2].horizontal = false
		oq[2].showVerticalScrollbar = false
		oq[2].content = oq[4]
		oq[3] = Button('✖', Rect(oq[2].width - 24, 0, 24, 24))
		oq[3].textSize = 17
		oq[3].textAlign = 4
		oq[3].color = Color(43, 43, 43, 255)
		oq[2].AddChild(oq[3])
		oq[3].onClick.Add(function()
			oq[1].Destroy()
			oq = nil
		end)
		if #T > 14 then
			oq[4].height = oq[4].height + (#T - 14) * 20 + 5
		end
		for i, v in pairs(T) do
			oq[5][i] = Panel(Rect(5 + 120 * (((i % 2 == 0 and 2) or i % 2) - 1), 25 + 40 * math.ceil(i / 2 - 1), 32, 32))
			oq[5][i].color = Color(55, 55, 55, 255)
			oq[4].AddChild(oq[5][i])
			oq[6][i] = Image('', Rect(0, 0, oq[5][i].width, oq[5][i].height))
			oq[6][i].SetImageID(Client.GetItem(T2[i]).imageID)
			oq[5][i].AddChild(oq[6][i])
			oq[7][i] = Panel(Rect(oq[5][i].x + oq[5][i].width + 2, oq[5][i].y, 83, 32))
			oq[7][i].color = Color(55, 55, 55, 255)
			oq[4].AddChild(oq[7][i])
			oq[8][i] = Text('', Rect(3, 1, oq[7][i].width - 6, oq[7][i].height / 2))
			oq[11][i] = Text('', Rect(3, oq[7][i].height / 2, oq[7][i].width - 6, oq[7][i].height / 2))
			oq[8][i].textSize = 10
			oq[7][i].AddChild(oq[8][i])
			oq[11][i].textSize = 12
			oq[7][i].AddChild(oq[11][i])
			if v >= DELICATECOUNT[txt][i] then
				v = '<color=#58FAF4>' .. v .. '</color>'
			else
				v = '<color=#F78181>' .. v .. '</color>'
			end
			oq[8][i].text = Client.GetItem(T2[i]).name
			oq[11][i].text = v .. ' / ' .. DELICATECOUNT[txt][i]
		end
		oq[10] = Panel(Rect(oq[4].width / 2 - 24, oq[4].height - 30, 38, 27))
		oq[10].color = Color(0, 0, 0, 255)
		oq[9] = Button('제 작', Rect(1, 1, 36, 25))
		oq[10].AddChild(oq[9])
		oq[4].AddChild(oq[10])
		oq[9].textSize = 14
		oq[9].color = Color(153, 153, 103, 255)

		oq[9].onClick.Add(function()
			Client.FireEvent('Love4', txt)
			oq[1].Destroy()
			oq = nil
		end)
	end)
end
