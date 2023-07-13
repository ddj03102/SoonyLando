--[[

--]]
Client.GetTopic("selling_start").Add(function(Q, W, E, R, T, Eq)
	local dataID = Utility.JSONParse(Q)
	local ID = Utility.JSONParse(W)
	local count = Utility.JSONParse(E)
	local level = Utility.JSONParse(R)
	local IsEquippedItem = Utility.JSONParse(Eq)
	
	sooni_mon(dataID, ID, count, level, T, IsEquippedItem)
end)

function sooni_mon(Q, W, E, R, T, Eq)
	if Full_panel ~= nil then return end
	local T = Utility.JSONParse(T)
	RGB = 111
	classic_RGB = 150
	COLOR = Color(RGB, RGB, RGB, 255)
	blue_COLOR = Color(160, 220, 235, 255)
	classic_COLOR = Color(classic_RGB, classic_RGB, classic_RGB, 255)
	local Garo = 420
	local Sero = 350
	Full_panel = ScrollPanel()
	Full_panel.content = Full_panel
	Full_panel.rect = Rect(Client.width/2-Garo/2, Client.height/2-Sero/2, Garo, Sero)
	Full_panel.color = Color(87, 87, 87, 255)
	
	local Close_button = Button("", Rect(Full_panel.width-36, 0, 36, 36))
	Close_button.color = Color(87, 87, 87, 255)
	Close_button.onClick.Add(function()
		Full_panel.DOScale(Point(0.01, 0.01), 0.2)
		Full_panel.DOMove(Point(TopMenu.mainPanel.x+TopMenu.mainPanel.width-43*3+20, TopMenu.mainPanel.y+20), 0.2)
		Client.RunLater(function()
			Full_panel.Destroy()
			Full_panel = nil
		end, 0.2)
		if UI_Panel ~= nil then
			UI_Panel.Destroy()
			UI_Panel = nil
		end
	end)
	local Close_text = Text("✖", Rect(0, 0, 40, 40))
	Close_text.textAlign = 4
	Close_text.textSize = 23
	local Full_panel_text = Text(" ✪ 편리한 가방", Rect(0, -7, 250, 50))
	Full_panel_text.textSize = 22
	
	local menu_button = {}
	local menu_text = {}
	for i=1, 6 do
		menu_button[i] = Button("", Rect((57.5)*(i-1)+5, 37, 52.5, 40))
		Full_panel.AddChild(menu_button[i])
		menu_button[i].color = classic_COLOR
		menu_text[i] = Text("", Rect(0, 0, menu_button[i].width, menu_button[i].height))
		menu_text[i].textAlign = 4
		menu_text[i].textSize = 16
		menu_button[i].AddChild(menu_text[i])
	end
	menu_button[1].color = blue_COLOR
	menu_text[1].text = 'ALL'
	menu_text[2].text = '무기'
	menu_text[3].text = '방어구'
	menu_text[4].text = '장신구'
	menu_text[5].text = '재료'
	menu_text[6].text = '소모품'
	--이 부분은 추후에 이미지로 변경
	Tip_button = Button("", Rect((57.5)*6+5, 37, 52.5, 40))
	Full_panel.AddChild(Tip_button)
	Tip_button.color = classic_COLOR
	Tip_text = Text("TIP", Rect(0, 0, menu_button[1].width, menu_button[1].height))
	Tip_text.textAlign = 4
	Tip_text.textSize = 16
	Tip_button.AddChild(Tip_text)
	Tip_button.onClick.Add(function()
		print("===================================")
		print("<color=#FFFF00>수량이 부족하여 편리한 가방에 있는 아이템이 사라져도 실제 인벤에 영향이 있지는 않음.</color>")
		print("===================================")
	end)
	
	local Assi_panel = Panel()
	Assi_panel.rect = Rect(0, 0, Garo-30, Sero-110)
	Assi_panel.color = Color(63, 63, 63, 255)
	
	local key_button = {}
	local key_text = {}
	for i=1, 6 do
		key_button[i] = Button("", Rect(69*(i-1)+5, Sero-45, 64, 40))
		Full_panel.AddChild(key_button[i])
		key_button[i].color = classic_COLOR
		key_text[i] = Text("", Rect(0, 0, key_button[i].width, key_button[i].height))
		key_text[i].textAlign = 4
		key_text[i].textSize = 16
		key_button[i].AddChild(key_text[i])
	end
	key_text[1].text = '초기화'
	key_text[2].text = 'DOWN'
	key_text[3].text = '1'
	key_text[4].text = 'UP'
	key_text[5].text = '판매'
	key_text[6].text = '분해'
	key_button[3].color = blue_COLOR
	
	local scroll_panel = ScrollPanel()
	scroll_panel.rect = Rect(5, 81, Garo-10, Sero-130)
	scroll_panel.color = classic_COLOR

	scroll_panel.AddChild(Assi_panel)
	scroll_panel.content = Assi_panel
	scroll_panel.horizontal = false
	scroll_panel.showVerticalScrollbar = true
	
	local Item_button = {}
	local streng_text = {}
	local count_text = {}
	local Item_image = {}
	local ItemEq_text = {}
	local gkan, skan = 0, 0
	for i, p in pairs(Q) do
		gkan = gkan + 1
		if i % 7 == 1 then
			skan = skan +1
			gkan = 1
			if skan >= 4 then
				Assi_panel.height = Assi_panel.height + 55
			end
		end
		Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
		Item_button[i].color = COLOR
		Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
		Item_image[i].SetImageID(Client.GetItem(p).imageID)
		if R[i] ~= 0 then
			streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
			streng_text[i].textSize = 11
			Item_image[i].AddChild(streng_text[i])
		end
		if Eq[i] then
			ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
			ItemEq_text[i].textAlign = 2
			ItemEq_text[i].textSize = 12
			Item_image[i].AddChild(ItemEq_text[i])
			Item_button[i].color = Color(255, 167, 167, 255)
		end
		count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
		count_text[i].textAlign = 2
		count_text[i].textSize = 11
		Item_button[i].AddChild(Item_image[i])
		Assi_panel.AddChild(Item_button[i])
		Item_image[i].AddChild(count_text[i])
	end
	
	menu_button[1].onClick.Add(function()--ALL
		if menu_button[1].color.r == classic_RGB then
			Assi_panel.height = Sero-110
			for i=1, 6 do
				menu_button[i].color = classic_COLOR
			end
			menu_button[1].color = blue_COLOR
			
			for i, p in pairs(Q) do
				local B = Item_button[i]
				if B ~= nil then
					B.Destroy()
					B = nil
				end
			end
			Item_button = {}
			streng_text = {}
			count_text = {}
			Item_image = {}
			ItemEq_text = {}
			gkan, skan = 0, 0
			local IJ = 0
			for i, p in pairs(Q) do
				if E[i] ~= 0 then
					IJ = IJ + 1
					gkan = gkan + 1
					if IJ % 7 == 1 then
						skan = skan +1
						gkan = 1
						if skan >= 4 then
							Assi_panel.height = Assi_panel.height + 55
						end
					end
					Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
					Item_button[i].color = COLOR
					Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
					Item_image[i].SetImageID(Client.GetItem(p).imageID)
					if R[i] ~= 0 then
						streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
						streng_text[i].textSize = 11
						Item_image[i].AddChild(streng_text[i])
					end
					if Eq[i] then
						ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
						ItemEq_text[i].textAlign = 2
						ItemEq_text[i].textSize = 12
						Item_image[i].AddChild(ItemEq_text[i])
						Item_button[i].color = Color(255, 167, 167, 255)
					end
					count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
					count_text[i].textAlign = 2
					count_text[i].textSize = 11
					Item_button[i].AddChild(Item_image[i])
					Assi_panel.AddChild(Item_button[i])
					Item_image[i].AddChild(count_text[i])
				end
			end
			UI_Button(Q, W, R, T, Item_button, Item_image)
		end
	end)
	
	menu_button[2].onClick.Add(function()--무기
		if menu_button[2].color.r == classic_RGB then
			Assi_panel.height = Sero-110
			for i=1, 6 do
				menu_button[i].color = classic_COLOR
			end
			menu_button[2].color = blue_COLOR
			for i, p in pairs(Q) do
				local B = Item_button[i]
				if B ~= nil then
					B.Destroy()
					B = nil
				end
			end
			Item_button = {}
			streng_text = {}
			count_text = {}
			Item_image = {}
			ItemEq_text = {}
			gkan, skan = 0, 0
			local IJ = 0
			for i, p in pairs(Q) do
				if Client.GetItem(p).type == 2 then
					if E[i] ~= 0 then
						IJ = IJ + 1
						gkan = gkan + 1
						if IJ % 7 == 1 then
							skan = skan +1
							gkan = 1
							if skan >= 4 then
								Assi_panel.height = Assi_panel.height + 55
							end
						end
						Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
						Item_button[i].color = COLOR
						Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
						Item_image[i].SetImageID(Client.GetItem(p).imageID)
						if R[i] ~= 0 then
							streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
							streng_text[i].textSize = 11
							Item_image[i].AddChild(streng_text[i])
						end
						if Eq[i] then
							ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
							ItemEq_text[i].textAlign = 2
							ItemEq_text[i].textSize = 12
							Item_image[i].AddChild(ItemEq_text[i])
							Item_button[i].color = Color(255, 167, 167, 255)
						end
						count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
						count_text[i].textAlign = 2
						count_text[i].textSize = 11
						Item_button[i].AddChild(Item_image[i])
						Assi_panel.AddChild(Item_button[i])
						Item_image[i].AddChild(count_text[i])
					end
				end
			end
			UI_Button(Q, W, R, T, Item_button, Item_image)
		end
	end)
	
	menu_button[3].onClick.Add(function()--방어구
		if menu_button[3].color.r == classic_RGB then
			Assi_panel.height = Sero-110
			for i=1, 6 do
				menu_button[i].color = classic_COLOR
			end
			menu_button[3].color = blue_COLOR
			for i, p in pairs(Q) do
				local B = Item_button[i]
				if B ~= nil then
					B.Destroy()
					B = nil
				end
			end
			Item_button = {}
			streng_text = {}
			count_text = {}
			Item_image = {}
			ItemEq_text = {}
			gkan, skan = 0, 0
			local IJ = 0
			for i, p in pairs(Q) do
				local Item = Client.GetItem(p).type
				if Item == 0 or Item == 1 or Item == 3 or Item == 4 then
					if E[i] ~= 0 then
						IJ = IJ + 1
						gkan = gkan + 1
						if IJ % 7 == 1 then
							skan = skan +1
							gkan = 1
							if skan >= 4 then
								Assi_panel.height = Assi_panel.height + 55
							end
						end
						Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
						Item_button[i].color = COLOR
						Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
						Item_image[i].SetImageID(Client.GetItem(p).imageID)
						if R[i] ~= 0 then
							streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
							streng_text[i].textSize = 11
							Item_image[i].AddChild(streng_text[i])
						end
						if Eq[i] then
							ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
							ItemEq_text[i].textAlign = 2
							ItemEq_text[i].textSize = 12
							Item_image[i].AddChild(ItemEq_text[i])
							Item_button[i].color = Color(255, 167, 167, 255)
						end
						count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
						count_text[i].textAlign = 2
						count_text[i].textSize = 11
						Item_button[i].AddChild(Item_image[i])
						Assi_panel.AddChild(Item_button[i])
						Item_image[i].AddChild(count_text[i])
					end
				end
			end
			UI_Button(Q, W, R, T, Item_button, Item_image)
		end
	end)
	
	menu_button[4].onClick.Add(function()--장신구
		if menu_button[4].color.r == classic_RGB then
			Assi_panel.height = Sero-110
			for i=1, 6 do
				menu_button[i].color = classic_COLOR
			end
			menu_button[4].color = blue_COLOR
			for i, p in pairs(Q) do
				local B = Item_button[i]
				if B ~= nil then
					B.Destroy()
					B = nil
				end
			end
			Item_button = {}
			streng_text = {}
			count_text = {}
			Item_image = {}
			ItemEq_text = {}
			gkan, skan = 0, 0
			local IJ = 0
			for i, p in pairs(Q) do
				local Item = Client.GetItem(p).type
				if Item == 5 or Item == 6 or Item == 7 then
					if E[i] ~= 0 then
						IJ = IJ + 1
						gkan = gkan + 1
						if IJ % 7 == 1 then
							skan = skan +1
							gkan = 1
							if skan >= 4 then
								Assi_panel.height = Assi_panel.height + 55
							end
						end
						Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
						Item_button[i].color = COLOR
						Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
						Item_image[i].SetImageID(Client.GetItem(p).imageID)
						if R[i] ~= 0 then
							streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
							streng_text[i].textSize = 11
							Item_image[i].AddChild(streng_text[i])
						end
						if Eq[i] then
							ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
							ItemEq_text[i].textAlign = 2
							ItemEq_text[i].textSize = 12
							Item_image[i].AddChild(ItemEq_text[i])
							Item_button[i].color = Color(255, 167, 167, 255)
						end
						count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
						count_text[i].textAlign = 2
						count_text[i].textSize = 11
						Item_button[i].AddChild(Item_image[i])
						Assi_panel.AddChild(Item_button[i])
						Item_image[i].AddChild(count_text[i])
					end
				end
			end
			UI_Button(Q, W, R, T, Item_button, Item_image)
		end
	end)
	
	menu_button[5].onClick.Add(function()--재료
		if menu_button[5].color.r == classic_RGB then
			Assi_panel.height = Sero-110
			for i=1, 6 do
				menu_button[i].color = classic_COLOR
			end
			menu_button[5].color = blue_COLOR
			for i, p in pairs(Q) do
				local B = Item_button[i]
				if B ~= nil then
					B.Destroy()
					B = nil
				end
			end
			Item_button = {}
			streng_text = {}
			count_text = {}
			Item_image = {}
			ItemEq_text = {}
			gkan, skan = 0, 0
			local IJ = 0
			for i, p in pairs(Q) do
				local Item = Client.GetItem(p).type
				if Item == 9 then
					if E[i] ~= 0 then
						IJ = IJ + 1
						gkan = gkan + 1
						if IJ % 7 == 1 then
							skan = skan +1
							gkan = 1
							if skan >= 4 then
								Assi_panel.height = Assi_panel.height + 55
							end
						end
						Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
						Item_button[i].color = COLOR
						Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
						Item_image[i].SetImageID(Client.GetItem(p).imageID)
						if R[i] ~= 0 then
							streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
							streng_text[i].textSize = 11
							Item_image[i].AddChild(streng_text[i])
						end
						if Eq[i] then
							ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
							ItemEq_text[i].textAlign = 2
							ItemEq_text[i].textSize = 12
							Item_image[i].AddChild(ItemEq_text[i])
							Item_button[i].color = Color(255, 167, 167, 255)
						end
						count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
						count_text[i].textAlign = 2
						count_text[i].textSize = 11
						Item_button[i].AddChild(Item_image[i])
						Assi_panel.AddChild(Item_button[i])
						Item_image[i].AddChild(count_text[i])
					end
				end
			end
			UI_Button(Q, W, R, T, Item_button, Item_image)
		end
	end)
	
	menu_button[6].onClick.Add(function()--소모품
		if menu_button[6].color.r == classic_RGB then
			Assi_panel.height = Sero-110
			for i=1, 6 do
				menu_button[i].color = classic_COLOR
			end
			menu_button[6].color = blue_COLOR
			for i, p in pairs(Q) do
				local B = Item_button[i]
				if B ~= nil then
					B.Destroy()
					B = nil
				end
			end
			Item_button = {}
			streng_text = {}
			count_text = {}
			Item_image = {}
			ItemEq_text = {}
			gkan, skan = 0, 0
			local IJ = 0
			for i, p in pairs(Q) do
				local Item = Client.GetItem(p).type
				if Item == 8 or Item == 10 then
					if E[i] ~= 0 then
						IJ = IJ + 1
						gkan = gkan + 1
						if IJ % 7 == 1 then
							skan = skan +1
							gkan = 1
							if skan >= 4 then
								Assi_panel.height = Assi_panel.height + 55
							end
						end
						Item_button[i] = Button("", Rect(5+55*(gkan-1), 5+55*(skan-1), 50, 50))
						Item_button[i].color = COLOR
						Item_image[i] = Image("", Rect(0, 0, Item_button[i].width, Item_button[i].height))
						Item_image[i].SetImageID(Client.GetItem(p).imageID)
						if R[i] ~= 0 then
							streng_text[i] = Text("<color=#00FF00>+"..R[i].."</color>", Rect(0, 0, 50, 15))
							streng_text[i].textSize = 11
							Item_image[i].AddChild(streng_text[i])
						end
						if Eq[i] then
							ItemEq_text[i] = Text("<color=#00FF00>E</color>", Rect(0, 0, 50, 15))
							ItemEq_text[i].textAlign = 2
							ItemEq_text[i].textSize = 12
							Item_image[i].AddChild(ItemEq_text[i])
							Item_button[i].color = Color(255, 167, 167, 255)
						end
						count_text[i] = Text(E[i], Rect(0, 37, 50, 15))
						count_text[i].textAlign = 2
						count_text[i].textSize = 11
						Item_button[i].AddChild(Item_image[i])
						Assi_panel.AddChild(Item_button[i])
						Item_image[i].AddChild(count_text[i])
					end
				end
			end
			UI_Button(Q, W, R, T, Item_button, Item_image)
		end
	end)
	
	key_button[1].onClick.Add(function()--초기화
		for i, p in pairs(Q) do
			if Item_button[i] ~= nil then
				Item_button[i].color = COLOR
				Item_image[i].SetOpacity(255)
				if Eq[i] then
					Item_image[i].AddChild(ItemEq_text[i])
					Item_button[i].color = Color(255, 167, 167, 255)
				end
			end
		end
		key_text[3].text = 1
	end)
	
	key_button[2].onClick.Add(function()--다운
		if tonumber(key_text[3].text) <= 1 then
		else
			key_text[3].text = tonumber(key_text[3].text) - 1
		end
	end)
	
	key_button[3].onClick.Add(function()--1
		local key_value = key_text[3].text
		
		if key_text[3].text == 'ALL' then
			key_text[3].text = 1
		elseif tonumber(key_value) < 10 then
			key_text[3].text = 10
		elseif tonumber(key_value) < 100 then
			key_text[3].text = 100
		elseif tonumber(key_value) < 1000 then
			key_text[3].text = 1000
		elseif tonumber(key_value) >= 1000 then
			key_text[3].text = 'ALL'
		end
	end)
	
	key_button[4].onClick.Add(function()--업
		key_text[3].text = tonumber(key_text[3].text) + 1
	end)
	
	key_button[5].onClick.Add(function()--판매
		Client.ShowYesNoAlert("선택한 아이템을 판매하시곘습니까?", function(a)
			if a == 1 then
				local real_item = {}
				local save_count = {}
				for i, p in pairs(Q) do
					if Item_button[i] ~= nil and Item_button[i].color.r == blue_COLOR.r and Client.GetItem(p).canSell then
						table.insert(real_item, W[i])
						table.insert(save_count, E[i])
						if key_text[3].text ~= 'ALL' then
							if tonumber(count_text[i].text) <= tonumber(key_text[3].text) then
								Item_button[i].Destroy()
								Item_button[i] = nil
								E[i] = 0
							else
								count_text[i].text = tonumber(count_text[i].text)-tonumber(key_text[3].text)
								E[i] = tonumber(count_text[i].text)
							end
						else
							Item_button[i].Destroy()
							Item_button[i] = nil
							E[i] = 0
						end
					end
					if Item_button[i] ~= nil then
						if Eq[i] then
							Item_button[i].color = Color(255, 167, 167, 255)
						else
							Item_button[i].color = COLOR
							Item_image[i].SetOpacity(255)
						end
					end
					if UI_Panel ~= nil then
						UI_Panel.Destroy()
						UI_Panel = nil
					end
				end
				if real_item[1] ~= nil then
					if key_text[3].text == 'ALL' then
						Client.FireEvent("selling_end", Utility.JSONSerialize(real_item), tonumber(key_text[3].text), Utility.JSONSerialize(save_count))
					else
						Client.FireEvent("selling_end", Utility.JSONSerialize(real_item), tonumber(key_text[3].text))
					end
				else
					print("<color=#F78181>판매불가 아이템 포함</color>")
				end
				key_text[3].text = 1
			else
				
			end
		end)
	end)
	
	key_button[6].onClick.Add(function()--분해
		Client.FireEvent("SendCenterLabel", "미구현 기능입니다.")
		--[[
		Client.ShowYesNoAlert("선택한 아이템을 분해하시곘습니까?", function(a)
			if a == 1 then
				local real_item = {}
				local save_count = {}
				for i, p in pairs(Q) do
					if Item_button[i] ~= nil and Item_button[i].color.r == blue_COLOR.r then
						table.insert(real_item, W[i])
						table.insert(save_count, E[i])
						if key_text[3].text ~= 'ALL' then
							if tonumber(count_text[i].text) <= tonumber(key_text[3].text) then
								Item_button[i].Destroy()
								Item_button[i] = nil
								E[i] = 0
							else
								count_text[i].text = tonumber(count_text[i].text)-tonumber(key_text[3].text)
								E[i] = tonumber(count_text[i].text)
							end
						else
							Item_button[i].Destroy()
							Item_button[i] = nil
							E[i] = 0
						end
					end
					if Item_button[i] ~= nil then
						if Eq[i] then
							Item_button[i].color = Color(255, 167, 167, 255)
						else
							Item_button[i].color = COLOR
							Item_image[i].SetOpacity(255)
						end
					end
					if UI_Panel ~= nil then
						UI_Panel.Destroy()
						UI_Panel = nil
					end
				end
				if real_item[1] ~= nil then
					if key_text[3].text == 'ALL' then
						Client.FireEvent("selling_Decomposition", Utility.JSONSerialize(real_item), tonumber(key_text[3].text), Utility.JSONSerialize(save_count))
					else
						Client.FireEvent("selling_Decomposition", Utility.JSONSerialize(real_item), tonumber(key_text[3].text))
					end
				else
					
				end
				key_text[3].text = 1
			end
		end)
		]]
	end)
	
	UI_Button(Q, W, R, T, Item_button, Item_image)
	
	Full_panel.AddChild(scroll_panel)
	Full_panel.AddChild(Full_panel_text)
	Close_button.AddChild(Close_text)
	Full_panel.AddChild(Close_button)
	Full_panel.showOnTop = true
end

function UI_Button(Q, W, R, T, Item_button, Item_image)
	for i, p in pairs(Q) do
		if Item_button[i] ~= nil then
			Item_button[i].onClick.Add(function()
				if Item_button[i].color.r == RGB then
					Item_button[i].color = blue_COLOR
					Item_image[i].SetOpacity(100)
				elseif Item_button[i].color.r == 255 then --장착중인 아이템
					
				else
					Item_button[i].color = COLOR
					Item_image[i].SetOpacity(255)
				end
				if UI_Panel ~= nil then
					UI_Panel.Destroy()
					UI_Panel = nil
				end
				--local mouse = Input.mousePosition
				--UI_Panel = Button("", Rect(mouse.x, mouse.y, 200, 90))
				UI_Panel = Button("", Rect(Full_panel.x+Full_panel.width+10, 110, 200, 90))
				UI_Panel.color = Color(0, 0, 0, 210)
				UI_Panel.showOnTop = true
				UI_Panel.onClick.Add(function() UI_Panel.Destroy() UI_Panel = nil end)
				UI_Text = Text("", Rect(5, 5, UI_Panel.width-5, UI_Panel.height-5))
				UI_Panel.AddChild(UI_Text)
				local Text01 = " +"..R[i]
				if R[i] == 0 then Text01 = "" end
				UI_Text.text = Client.GetItem(p).name..Text01
				UI_Text.textAlign = 0
				UI_Text.textSize = 17
				
				UI_Text02 = Text("", Rect(5, 27, UI_Panel.width-5, UI_Panel.height-5))
				UI_Panel.AddChild(UI_Text02)
				UI_Text02.text = (Client.GetItem(p).canSell and "<color=#A9D0F5>판매가능" or 
					Client.GetItem(p).canSell or "<color=#F5A9A9>판매불가").."</color>\n판매가격 : "..Client.GetItem(p).sellerPrice.."\n"
				UI_Text02.textAlign = 0
				UI_Text02.textSize = 14
				
				UI_Text03 = Text(T[i], Rect(5, 65, UI_Panel.width-5, UI_Panel.height-5))
				UI_Panel.AddChild(UI_Text03)
				UI_Text03.textAlign = 0
				if UI_Text03.text == '' then
					UI_Text03.text = '<color=#BDBDBD>특별옵션 없음</color>'
					UI_Text03.textSize = 12
				else
					
					UI_Text03.text = 
						'<color=#FF00FF><size=15>옵션</size>\n</color><color=#00FFFF>'..
						T[i]..'</color>'
					UI_Text03.textSize = 13
					local line_break = 1
					local i_su = 0
					local str = T[i]
					
					for j=1, #T[i] do
						local check = string.find(T[i], '\n', line_break)
						if check then
							i_su = i_su + 1
							line_break = check + 1
						else
							break
						end
					end
					UI_Panel.height = UI_Panel.height + i_su*15
					UI_Text03.height = UI_Text03.height + i_su*15
				end
			end)
		end
	end
end

--[[
function UI_Appear(ad)
	ad.Destroy()
end
]]