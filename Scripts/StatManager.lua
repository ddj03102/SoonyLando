Client.GetTopic("stat_show").Add(function(Table)
	stat_Window(Table)
end)

function stat_Window(Table)
	local Q = Utility.JSONParse(Table)
	if Stat_Panel then
		for i=1, 17 do
			In_text[i].text = Q[i]
		end
	else
		local Blue_COLOR = Color(160, 220, 235, 255)
		local Light_Blue_COLOR = Color(160, 220, 235, 220)
		local Classic_COLOR = Color(104, 104, 104, 255)
		local cw = Client.width
		local ch = Client.height
		local Garo = 540
		local Sero = 300
		local Letter = {
		{'근력', '인내력', '지능', '손재주', '민첩', '운', '공격력', '방어력', '체력',
		'마나', '마공', '마방', '명중력', '회피력', '크리율', '크리딜', '남은포인트', '분배\n결정',
		'✪ 스 테 이 터 스'}, 
		{'STR', 'VIT', 'INT', 'DEX', 'AGI', 'LUK', 'ATK', 'DEF', 'HP',
		'MP', 'MAtk', 'MDef', 'HIT', 'Flee', 'Cri', 'CriDeal', 'Point', 'Decide',
		'✪ Status'}}
		
		Stat_Panel = ScrollPanel(Rect(cw/2-Garo/2, ch/2-Sero/2, Garo, Sero))
		Stat_Panel.content = Stat_Panel
		Stat_Panel.color = Color(38, 38, 38, 255)
		Stat_Panel.showOnTop = true
		
		local Stat_Panel2 = Panel(Rect(0, 0, Garo, 42))
		Stat_Panel2.color = Color(54, 54, 54, 255)
		Stat_Panel.AddChild(Stat_Panel2)
		
		local Stat_PanelText = Text(nil, Rect(16, 0, Garo, 42))
		Stat_PanelText.textSize = 26
		Stat_Panel2.AddChild(Stat_PanelText)
		if Q[18] == 0 then Stat_PanelText.text = Letter[1][19]
		else Stat_PanelText.text = Letter[2][19] end
		
		local CloseButton = Button("✖", Rect(Garo-42, 0, 42, 42))
		CloseButton.textSize = 26
		CloseButton.textAlign = 4
		CloseButton.color = Color(87, 87, 87, 255)
		Stat_Panel2.AddChild(CloseButton)
		CloseButton.onClick.Add(function()
			if Tip_Panel then
				Tip_Panel.Destroy()
				Tip_Panel = nil
			end
			Stat_Panel.DOScale(Point(0.01, 0.01), 0.2)
			Stat_Panel.DOMove(Point(TopMenu.mainPanel.x+TopMenu.mainPanel.width-86+20, TopMenu.mainPanel.y+20), 0.2)
			Client.RunLater(function()			
				Stat_Panel.Destroy()
				Stat_Panel = nil
			end, 0.2)
		end)
		
		local Stat_Text = {}
		for i=1, 17 do
			Stat_Text[i] = Text(nil, Rect(20, 70, 80, 40))
			if Q[18] == 0 then
				Stat_Text[i].text = Letter[1][i]
			else
				Stat_Text[i].text = Letter[2][i]
			end
			Stat_Text[i].textSize = 18
			Stat_Text[i].textAlign = 2
			Stat_Panel.AddChild(Stat_Text[i])
		end
		In_text = {} --23개
		local Panels = {}--17개
		local Buttons = {}--11개
		local Panel_Coordinate = {}
		local Button_Coordinate = {}
		local Stat_Coordinate = {
		{6, 48, 60, 30}, {6, 81, 60, 30}, {6, 114, 60, 30}, {6, 147, 60, 30},
		{6, 180, 60, 30}, {6, 213, 60, 30},
		{220, 48, 60, 30}, {368, 48, 60, 30}, {220, 81, 60, 30}, {368, 81, 60, 30},
		{220, 114, 60, 30}, {368, 114, 60, 30}, {220, 147, 60, 30}, {368, 147, 60, 30},
		{220, 180, 60, 30}, {368, 180, 60, 30}, {260, 213, 100, 30}
		}
		for i=1, #Stat_Coordinate do
			Stat_Text[i].x = Stat_Coordinate[i][1]
			Stat_Text[i].y = Stat_Coordinate[i][2]+2
			Stat_Text[i].width = Stat_Coordinate[i][3]
			Stat_Text[i].height = Stat_Coordinate[i][4]
			if i <= 6 then
				Panel_Coordinate[i] = Rect(Stat_Text[i].x+66, Stat_Text[i].y-3, 116, 28)
			elseif i == 17 then
				Panel_Coordinate[i] = Rect(Stat_Text[i].x+108, Stat_Text[i].y-3, 80, 28)
			else
				Panel_Coordinate[i] = Rect(Stat_Text[i].x+66, Stat_Text[i].y-3, 80, 28)
			end
			if i <= 6 then
				Button_Coordinate[i] = Rect(Panel_Coordinate[i].x+Panel_Coordinate[i].width+5, Panel_Coordinate[i].y, 28, 28)
			elseif i == 12 then
				Button_Coordinate[i] = Rect(Stat_Panel.width-84, Stat_Panel.height-84, 76, 76)
			else
				Button_Coordinate[i] = Rect(8+54*(i-7), Stat_Panel.height-54, 46, 46)
			end
		end

		for i=1, 17 do
			Panels[i] = Panel()
			Stat_Panel.AddChild(Panels[i])
			Panels[i].rect = Panel_Coordinate[i]
			Panels[i].color = Color(73, 73, 73, 255)
		end
		for i=1, 12 do
			Buttons[i] = Button('✚', Button_Coordinate[i])
			Buttons[i].color = Classic_COLOR
			Buttons[i].textSize = 18
			Buttons[i].textAlign = 4
			Stat_Panel.AddChild(Buttons[i])
			if i <= 6 then
				Buttons[i].onClick.Add(function() --[+누름]
					local hi = 1
					if Buttons[8].color.r == Light_Blue_COLOR.r then
						hi = 10
					elseif Buttons[9].color.r == Light_Blue_COLOR.r then
						hi = 100
					elseif Buttons[10].color.r == Light_Blue_COLOR.r then
						hi = 100000
					end
					if tonumber(In_text[17].text) > 0 then
						if In_text[i+17].text == nil or In_text[i+17].text == '' then
							In_text[i+17].text = '+0'
						end
						local TT_Danse = tonumber(string.sub(In_text[i+17].text, 2, #In_text[i+17].text))
						if tonumber(In_text[17].text) < hi then
							hi = tonumber(In_text[17].text)
						end
						In_text[i+17].text = '+'..TT_Danse+hi
						In_text[17].text = tonumber(In_text[17].text)-hi					
						if tonumber(In_text[17].text) <= 0 then
							for i=1, 6 do
								Buttons[i].color = Classic_COLOR
							end
							stat_icon.image = "Pictures/Stat.png"
						end
						Buttons[12].color = Light_Blue_COLOR
					end
				end)
			end
		end
		Buttons[7].text = 'TIP'
		Buttons[8].text = '+10'
		Buttons[9].text = '+100'
		Buttons[10].text = 'ALL'
		if Q[18] == 0 then 
			Buttons[11].text = 'Eng'
			Buttons[12].text = Letter[1][18]
			Buttons[12].textSize = 23
		else 
			Buttons[11].text = '한글'
			Buttons[12].text = Letter[2][18]
		end
		
		Buttons[7].onClick.Add(function() --TIP
			if Tip_Panel then 
				Tip_Panel.Destroy()
				Tip_Panel = nil
				return 
			end
			local _x = 180
			local _y = 350
			Tip_Panel = ScrollPanel(Rect(cw/2-_x/2, ch/2-_y/2, _x, _y))
			Tip_Panel.content = Tip_Panel
			Tip_Panel.color = Color(70, 70, 70, 200)
			Tip_Panel.showOnTop = true
			
			local Tip_Text = Text(nil, Rect(0, 0, Tip_Panel.width, Tip_Panel.height-30))
			Tip_Panel.AddChild(Tip_Text)
			Tip_Text.textSize = 16
			Tip_Text.textAlign = 6
			Tip_Text.text = 
[[<color=#F3F781>[근력]
공격력, 체력

[인내력]
체력, 방어력

[지능]
마공, 마방, 마나

[손재주]
명중력

[민첩]
회피력, 크리딜, 이속

[운]
크리율, 이속 소량</color>
			]]
			local Tip_close = Button('✖', Rect(Tip_Panel.width-30, 0, 30, 30))
			Tip_close.textSize = 18
			Tip_close.textAlign = 4
			Tip_close.color = Tip_Panel.color
			Tip_Panel.AddChild(Tip_close)
			
			Tip_close.onClick.Add(function()
				Tip_Panel.Destroy()
				Tip_Panel = nil 
			end)
		end)
		
		Buttons[8].onClick.Add(function() --+10
			if Buttons[8].color.r == Light_Blue_COLOR.r then
				Buttons[8].color = Classic_COLOR
			else
				Buttons[10].color = Classic_COLOR
				Buttons[9].color = Classic_COLOR
				Buttons[8].color = Light_Blue_COLOR			
			end
		end)
		
		Buttons[9].onClick.Add(function() --+100
			if Buttons[9].color.r == Light_Blue_COLOR.r then
				Buttons[9].color = Classic_COLOR
			else
				Buttons[10].color = Classic_COLOR
				Buttons[9].color = Light_Blue_COLOR
				Buttons[8].color = Classic_COLOR
			end
		end)
		
		Buttons[10].onClick.Add(function() --ALL
			if Buttons[10].color.r == Light_Blue_COLOR.r then
				Buttons[10].color = Classic_COLOR
			else
				Buttons[10].color = Light_Blue_COLOR
				Buttons[9].color = Classic_COLOR
				Buttons[8].color = Classic_COLOR			
			end
		end)
		
		Buttons[11].onClick.Add(function() --한글
			if Buttons[11].text == 'Eng' then
				for i=1, 17 do
					Stat_Text[i].text = Letter[2][i]
				end
				Stat_PanelText.text = Letter[2][19]
				Buttons[12].text = Letter[2][18]
				Buttons[11].text = '한글'
			else
				for i=1, 17 do
					Stat_Text[i].text = Letter[1][i]
				end
				Stat_PanelText.text = Letter[1][19]
				Buttons[12].text = Letter[1][18]
				Buttons[11].text = 'Eng'
			end
			Client.FireEvent("Language_Transformation", Buttons[11].text)
		end)
		
		Buttons[12].onClick.Add(function() --결정
			if Buttons[12].color.r == Light_Blue_COLOR.r then
				local D_Stat = {}
				Client.FireEvent("dice_sound", "dice_decision.ogg")
				if Buttons[11].text == 'Eng' then
					Client.FireEvent("SendCenterLabel", "능력치가 결정되었습니다.")
				else
					Client.FireEvent("SendCenterLabel", "Stat has been determined.")
				end
				Buttons[12].color = Classic_COLOR
				for i=1, 6 do
					if In_text[i+17].text ~= nil and In_text[i+17].text ~= '' then
						local TT_Danse = string.gsub(In_text[i+17].text, "+", '')
						TT_Danse = tonumber(TT_Danse)
						D_Stat[i] = TT_Danse
						In_text[i].text = tonumber(In_text[i].text) + TT_Danse
						In_text[i+17].text = nil
					else
						D_Stat[i] = 0
					end
				end
				stat_icon.image = "Pictures/Stat.png"
				Client.FireEvent("D_Stat", Utility.JSONSerialize(D_Stat))
			end
		end)
		
		for i=1, 23 do
			local j = i
			if i > 17 then j = i-17 end
			--print(Q[i])
			In_text[i] = Text(Q[i], Rect(5, 2, Panels[j].width, Panels[j].height))
			In_text[i].textSize = 18
			if i <= 17 then
				In_text[i].textAlign = 0
				Panels[j].AddChild(In_text[i])
			else
				In_text[i].textAlign = 2
				Panels[j].AddChild(In_text[i])
				In_text[i].x = 0
				In_text[i].width = In_text[i].width-5
				In_text[i].color = Blue_COLOR
				In_text[i].text = nil
			end
		end
		--[[
		In_text[1].text = '<color=#F5A9A9>'..In_text[1].text..'</color>'
		In_text[2].text = '<color=#F3F781>'..In_text[2].text..'</color>'
		In_text[3].text = '<color=#819FF7>'..In_text[3].text..'</color>'
		In_text[4].text = '<color=#F5A9A9>'..In_text[4].text..'</color>'
		In_text[5].text = '<color=#F5A9A9>'..In_text[5].text..'</color>'
		In_text[6].text = '<color=#F5A9A9>'..In_text[6].text..'</color>'
		]]
		if tonumber(In_text[17].text) > 0 then
			for i=1, 6 do
				Buttons[i].color = Light_Blue_COLOR
			end
		end	
		
		Client.GetTopic("stat_show2").Add(function(Table2)
			local W = Utility.JSONParse(Table2)
			for i=1, 17 do
				In_text[i].text = W[i]
			end
		end)
	end
end


