---@diagnostic disable: param-type-mismatch, missing-parameter
TopMenu = {}
TopMenu.list = {}
TopMenu.isWindowOpened = true
TopMenu.RedDots = {}
TopMenu.MenuType = {
	SKILL = 1,
	STAT = 2,
	BAG = 3,
	NOTICE = 4,
	SAVE = 5,
	MAKE = 6
}

function TopMenu.OpenWindow()
	local W = Client.width
	local H = Client.height

	if TopMenu.window then
		return
	end
	TopMenu.window = Button("", Rect(W - 25, 50, 25, 60))
	TopMenu.window.color = Color(63, 63, 63, 200)
	TopMenu.window.SetImage("Pictures/bar_vertical_A.png")
	local windows_text = Text() {
		text = "▶",
		rect = Rect(0, 0, 25, 60),
		textAlign = 4,
		textSize = 18,
	}

	TopMenu.window.onClick.Add(function()
		if TopMenu.isWindowOpened then
			windows_text.text = "◀"
			TopMenu.isWindowOpened = false
			TopMenu.mainPanel.Destroy()
			TopMenu.mainPanel = nil
		else
			windows_text.text = "▶"
			TopMenu.isWindowOpened = true
			TopMenu.OpenMenu()
		end
	end)
	TopMenu.window.AddChild(windows_text)
	TopMenu.window.showOnTop = true
end

Client.RunLater(function()
	TopMenu.OpenWindow()
end, 0.5)

TopMenu.list[1] = {
	icon = "Pictures/book_brown.png",
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
	icon = "Pictures/heart.png",
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
		Notice.Show()
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

TopMenu.list[7] = {
	icon = "Pictures/Buff_30002.png",
	name = "파티",
	runLater = 0.5,
	closure = function()
		Client.ShowParty(true)
	end
}


function TopMenu.OpenMenu()
	local cw = Client.width
	local ch = Client.height

	if TopMenu.mainPanel then return end
	TopMenu.mainPanel = Image("Pictures/bar_vertical_A.png") {
		sliceBorder = RectOff(150, 200, 200, 150),
		imageType = 1,
		pivot = Point(1, 0),
		scaleX = 0,
		anchor = 2,
		rect = Rect(-25, 50, #TopMenu.list * 43, 60),
		opacity = 100,
	}

	local cachedButtons = {}

	for i = 1, #TopMenu.list do
		local menuButtonInfo = TopMenu.list[i]
		local menuButton = Button("", Rect(TopMenu.mainPanel.width - 43 * (i), 0, 43, 43))
		menuButton.opacity = 200
		menuButton.SetImage(menuButtonInfo.icon)
		menuButton.onClick.Add(function()
			if not menuButton.enabled then
				return
			end
			menuButtonInfo.closure()
		end)
		menuButton.SetParent(TopMenu.mainPanel)

		local menuText = Text() {
			text = menuButtonInfo.name,
			rect = Rect(0, 43, 43, 17),
			textSize = 10,
			textAlign = 4,
			borderEnabled = true,
		}
		menuText.SetParent(menuButton)

		TopMenu.RedDots[i] = Image("Pictures/A3.png") {
			rect = Rect(0, 0, 20, 20),
			anchor = 2, pivot = Point(1, 0)
		}
		TopMenu.RedDots[i].SetParent(menuButton)
		TopMenu.RedDots[i].visible                       = false

		-- if menuButtonInfo.runLater > 0 then
		-- 	menuButton.enabled = false
		-- 	menuText.opacity = 100
		-- 	Client.RunLater(function()
		-- 		menuButton.enabled = true
		-- 		menuText.opacity = 255
		-- 	end, menuButtonInfo.runLater)
		-- end

		cachedButtons[i]                                 = menuButton
		cachedButtons[i].scaleX, cachedButtons[i].scaleY = 0, 0
	end
	TopMenu.tweenCoroutine = coroutine.create(function()
		TopMenu.mainPanel.DOScale(Point(1, 1), 0.3)
		WaitForSeconds(0.3)
		for i = 1, #cachedButtons do
			cachedButtons[i].DOScale(Point(1, 1), 0.3)
			WaitForSeconds(0.1)
		end
		coroutine.yield()
	end)
	coroutine.resume(TopMenu.tweenCoroutine)
end

Client.RunLater(function()
	TopMenu.OpenMenu()
end, 0.5)

function TopMenu.HandleRedDot(type)
	TopMenu.RedDots[type].visible = true
end

ScreenUI.bagButtonVisible = false
ScreenUI.menuButtonVisible = false
