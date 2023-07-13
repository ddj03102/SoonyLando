---@diagnostic disable: param-type-mismatch
state_windows = true
function STATE_Windows()
	local W = Client.width
	local H = Client.height

	if windows then return end
	windows = Button("", Rect(W - 25, 50, 25, 60))
	windows.color = Color(63, 63, 63, 255)
	local windows_text = Text(){
		text = "▶",
		rect = Rect(0, 0, 25, 60),
		textAlign = 4,
		textSize = 18,
		borderEnabled = true,
		borderColor = Color.white
	}

	windows.onClick.Add(function()
		if state_windows then
			windows_text.text = "◀"
			state_windows = false
			TopMenu.mainPanel.Destroy()
			TopMenu.mainPanel = nil
		else
			windows_text.text = "▶"
			state_windows = true
			TopMenu.Initialize()
		end
	end)
	windows.AddChild(windows_text)
	windows.showOnTop = true
end

Client.RunLater(function()
	STATE_Windows()
end, 0.5)

TopMenu = {}
TopMenu.list = {}

TopMenu.list[1] = {
	icon = "Pictures/Skill.png",
	name = "스킬",
	runLater = 1,
	closure = function()
		if Skill_Panel then
			Skill_Panel.DOScale(Point(0.01, 0.01), 0.2)
			Skill_Panel.DOMove(Point(TopMenu.mainPanel.x + TopMenu.mainPanel.width - 43 + 20, TopMenu.mainPanel.y + 20),
				0.2)
			if skp_b then
				skp_b.Destroy()
				skp_b = nil
			end
			Client.RunLater(function()
				Skill_Panel.Destroy()
				Skill_Panel = nil
			end, 0.2)
		else
			Client.FireEvent('skill_Window')
		end
	end
}

TopMenu.list[2] = {
	icon = "Icons/accessory/Item_0017.png",
	name = "스텟",
	runLater = 0,
	closure = function()
		if Stat_Panel then
			Stat_Panel.DOScale(Point(0.01, 0.01), 0.2)
			Stat_Panel.DOMove(Point(TopMenu.mainPanel.x + TopMenu.mainPanel.width - 86 + 20, TopMenu.mainPanel.y + 20),
				0.2)
			Client.RunLater(function()
				Stat_Panel.Destroy()
				Stat_Panel = nil
			end, 0.2)
		else
			Client.FireEvent('stat_Window')
		end
	end
}

TopMenu.list[3] = {
	icon = "Icons/accessory/Item_0002.png",
	name = "가방",
	runLater = 0,
	closure = function()
		if Full_panel then
			Full_panel.DOScale(Point(0.01, 0.01), 0.2)
			Full_panel.DOMove(
				Point(TopMenu.mainPanel.x + TopMenu.mainPanel.width - 43 * 3 + 20, TopMenu.mainPanel.y + 20),
				0.2)
			Client.RunLater(function()
				Full_panel.Destroy()
				Full_panel = nil
			end, 0.2)
		else
			Client.FireEvent("selling")
		end
	end
}

TopMenu.list[4] = {
	icon = "Icons/시나브로 불개미.png",
	name = "공지",
	runLater = 0,
	closure = function()
		Announcement()
	end
}

TopMenu.list[5] = {
	icon = "Pictures/절전.png",
	name = "절전",
	runLater = 0,
	closure = function()
		local Dark_Panel = Panel()
		Dark_Panel.color = Color(0, 0, 0, 255)
		Dark_Panel.showOnTop = true
		local Dark_Button = Button('', Rect(0, 0, Client.width, Client.height))
		Dark_Button.color = Color(0, 0, 0, 255)
		local Dark_Text = CustomText('Touch', Rect(0, 0, 200, 200))
		Dark_Text.color = Color(255, 255, 255, 80)
		Dark_Text.textAlign = 4
		Dark_Text.textSize = 30
		Dark_Panel.AddChild(Dark_Button)
		Dark_Button.AddChild(Dark_Text)
		Dark_Button.onClick.Add(function()
			Dark_Panel.Destroy()
			Dark_Panel = nil
		end)
		Dark_Panel.SetOrderIndex(2)
	end
}

TopMenu.list[6] = {
	icon = "Pictures/제작.png",
	name = "제작",
	runLater = 0.5,
	closure = function()
		make_Window()
	end
}


function TopMenu.Initialize()
	local cw = Client.width
	local ch = Client.height

	if TopMenu.mainPanel then return end
	TopMenu.mainPanel = Image("Pictures/패널쓰.png")
	TopMenu.mainPanel.sliceBorder = RectOff(150,200,200,150)
	TopMenu.mainPanel.imageType = 1
	TopMenu.mainPanel.rect = Rect(cw - 288, 50, #TopMenu.list * 43, 60)
	TopMenu.mainPanel.opacity = 100
	--====================================================================
	--skillbutton
	for i = 1, #TopMenu.list do
		local menuButtonInfo = TopMenu.list[i]
		local menuButton = Button("", Rect(TopMenu.mainPanel.width - 43 * (i), 0, 43, 43))
		menuButton.opacity = 200
		menuButton.SetSpriteByPath(menuButtonInfo.icon)
		menuButton.onClick.Add(function()
			if not menuButton.enabled then
				return
			end
			menuButtonInfo.closure()
		end)
		menuButton.SetParent(TopMenu.mainPanel)

		local menuText = Text(){
			text = menuButtonInfo.name,
			rect = Rect(0,43,43,17),
			textSize = 10,
			textAlign = 4,
			borderEnabled = true,
		}
		menuText.SetParent(menuButton)

		if menuButtonInfo.runLater > 0 then
			menuButton.enabled = false
			menuText.opacity = 100
			Client.RunLater(function()
				menuButton.enabled = true
				menuText.opacity = 255
			end, menuButtonInfo.runLater)
		end
	end
	-- --====================================================================
	-- --statbutton
	-- stat_button = Button("", Rect(whole_panel.width-86, 0, 43, 43))
	-- stat_button.color = Color(0, 0, 0, 0)
	-- stat_icon = Image("Pictures/Stat.png", Rect(0, 0, 43, 43))
	-- stat_icon.SetOpacity(200)

	-- stat_button.onClick.Add(function()

	-- end)
	-- --====================================================================
	-- --bagbutton
	-- sell_button = Button("", Rect(whole_panel.width-129, 0, 43, 43))
	-- sell_button.color = Color(0, 0, 0, 0)
	-- local sell_icon = Image("Pictures/bag.png", Rect(0, 0, 43, 43))

	-- sell_button.onClick.Add(function()

	-- end)
	-- --====================================================================
	-- --noticebutton
	-- Notice_button = Button("", Rect(whole_panel.width-43*4, 0, 43, 43))
	-- Notice_button.color = Color(0, 0, 0, 0)
	-- local Notice_icon = Image("Icons/시나브로 불개미.png", Rect(0, 0, 43, 43))
	-- Notice_icon.SetOpacity(200)

	-- Notice_button.onClick.Add(function()

	-- end)
	-- --====================================================================
	-- --powersavingbutton
	-- PowerSaving_button = Button("", Rect(whole_panel.width-43*5, 0, 43, 43))
	-- PowerSaving_button.color = Color(0, 0, 0, 0)
	-- local PowerSaving_icon = Image("Pictures/절전.png", Rect(0, 0, 43, 43))
	-- PowerSaving_icon.SetOpacity(150)

	-- PowerSaving_button.onClick.Add(function()

	-- end)
	-- --====================================================================
	-- --productionbutton
	-- Production_button = Button("", Rect(whole_panel.width-43*6, 0, 43, 43))
	-- Production_button.color = Color(0, 0, 0, 0)
	-- local Production_icon = Image("Pictures/제작.png", Rect(0, 0, 43, 43))
	-- Production_icon.SetOpacity(200)

	-- Production_button.onClick.Add(function()
	-- end)
	-- Production_button.visible = false
	-- Client.RunLater(function()
	-- 	Production_button.visible = true
	-- end, 0.5)
	-- --====================================================================
	-- --layout
end

Client.RunLater(function()
	TopMenu.Initialize()
end, 0.5)