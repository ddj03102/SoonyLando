---@diagnostic disable: param-type-mismatch, redundant-parameter, lowercase-global
Dice = {}
Dice.isOpen = false
Dice.realStat = { 3, 3, 3, 3, 3, 3 }
Dice.realSum = 0

function dice()
	Dice.Open()
end

function Dice.Open()
	Dice.isOpen = true

	local W = Client.width
	local H = Client.height

	local mainWidth = 550
	local mainHeight = 330

	PanelDice = Image("Pictures/panel_beigeLight.png"){
		rect = Rect(W / 2 - mainWidth / 2, H / 2 - mainHeight / 2, mainWidth, mainHeight),
		imageType = 1
	}

	dice_play = Panel()
	dice_play.rect = Rect(30, 20, 225, 225)
	dice_play.color = Color(63, 63, 63, 0)

	dice_textbox = Button("", Rect(50, 265, 185, 45))
	dice_textbox.color = Color(63, 63, 63, 255)

	dice_text = CustomText("주사위 굴리기", Rect(0, 0, 185, 45))
	dice_text.textAlign = 4
	dice_text.textSize = 21
	dice_textbox.AddChild(dice_text)

	dice_img = Image("Pictures/start_dice.png", Rect(30, 30, 180, 180))

	dice_textbox.onClick.Add(function()
		Dice.Rolling()
	end)

	dice_Decision = Button("", Rect(310, 265, 185, 45))
	dice_Decision.color = Color(63, 63, 63, 255)

	dice_text2 = CustomText("능력치 결정하기", Rect(0, 0, 185, 45))
	dice_text2.textAlign = 4
	dice_text2.textSize = 21
	dice_Decision.AddChild(dice_text2)

	dice_Decision.onClick.Add(function()
		Dice.Close()
	end)

	Dice.Initialize()
end

function Dice.Close()
	if Dice.realSum <= 42 and Dice.realSum >= 37 then
		Client.ShowYesNoAlert("능력치를 결정하시겠습니까?", function(a)
			if a == 1 then
				PanelDice.DOScale(Point(0, 0), 0.2)
				Client.RunLater(function()
					PanelDice.Destroy()
				end, 0.2)
				Dice.isOpen = false
				Client.FireEvent("dice_stat", Dice.realStat[1], Dice.realStat[2], Dice.realStat[3], Dice.realStat[4],
					Dice.realStat[5],
					Dice.realStat[6])
			end
		end)
	else
		Client.ShowCenterLabel("주사위를 굴리세요.")
	end
end

function Dice.Rolling()
	Client.FireEvent("dice_sound", "dice_play.ogg")

	local stat = { 3, 3, 3, 3, 3, 3 }
	local bonus = math.random(37 - 18, 42 - 18)
	local tmp = {}
	local sum = 0

	for i = 1, bonus, 1 do
		local r = math.random(1, #stat)
		stat[r] = stat[r] + 1
		if stat[r] >= 10 then
			table.insert(tmp, 10)
			table.remove(stat, r)
		end
	end

	for i = #stat, 1, -1 do
		table.insert(tmp, stat[i])
		table.remove(stat, i)
	end

	for i = 1, 6, 1 do
		local r = math.random(1, #tmp)
		stat[i] = tmp[r]
		table.remove(tmp, r)
	end

	for i = 1, 6 do
		sum = sum + stat[i]
		Dice.realStat[i] = stat[i]
	end
	Dice.realSum = sum

	dice_img.DOJump(Point(30, 30), 40, 1, 0.25, true).OnStart(function()
		dice_img.position = Point(30, 30)
	end)
	local newCoroutine = coroutine.create(function()
		for i = 1, 5 do
			dice_img.image = "Pictures/m" .. i .. ".png"
			WaitForSeconds(0.05)
		end

		if sum == 37 then
			dice_img.image = "Pictures/start_dice.png"
		elseif sum == 38 then
			dice_img.image = "Pictures/2.png"
		elseif sum == 39 then
			dice_img.image = "Pictures/3.png"
		elseif sum == 40 then
			dice_img.image = "Pictures/4.png"
		elseif sum == 41 then
			dice_img.image = "Pictures/5.png"
		elseif sum == 42 then
			dice_img.image = "Pictures/6.png"
		end

		if stat[1] == 10 and stat[2] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 투사 직업을 추천합니다. </color>"
		elseif stat[1] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 전사 직업을 추천합니다. </color>"
		elseif stat[2] == 10 and stat[3] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 성기사 직업을 추천합니다. </color>"
		elseif stat[2] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 성기사, 사제 직업을 추천합니다. </color>"
		elseif stat[3] == 10 and stat[2] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 사제 직업을 추천합니다. </color>"
		elseif stat[3] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 마법사계열, 성기사 직업을 추천합니다. </color>"
		elseif stat[4] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 궁수계열 직업을 추천합니다. </color>"
		elseif stat[5] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 민첩은 후반에 중요한 스텟입니다. </color>"
		elseif stat[6] == 10 then
			SText08.text = "<color=#D8D8D8>✪ 행운은 보조적인 스텟입니다. </color>"
		else
			SText08.text = "<color=#D8D8D8>✪ 능력치는 정해진게 없습니다. 특별한 캐릭터를 만들어 보세요.</color>"
		end

		SText01.text = stat[1]
		SText02.text = stat[2]
		SText03.text = stat[3]
		SText04.text = stat[4]
		SText05.text = stat[5]
		SText06.text = stat[6]
		SText07.text = math.floor(Dice.realSum)

		-- SText02.DOScale(Point(1,1),0.5).OnStart(function ()
		-- 	SText02.scaleX, SText02.scaleY = 1.2,1.2
		-- end)
		-- SText03.DOScale(Point(1,1),0.5).OnStart(function ()
		-- 	SText03.scaleX, SText03.scaleY = 1.2,1.2
		-- end)
		-- SText04.DOScale(Point(1,1),0.5).OnStart(function ()
		-- 	SText04.scaleX, SText04.scaleY = 1.2,1.2
		-- end)
		-- SText05.DOScale(Point(1,1),0.5).OnStart(function ()
		-- 	SText05.scaleX, SText05.scaleY = 1.2,1.2
		-- end)
		-- SText06.DOScale(Point(1,1),0.5).OnStart(function ()
		-- 	SText06.scaleX, SText06.scaleY = 1.2,1.2
		-- end)
		-- SText07.DOScale(Point(1,1),0.5).OnStart(function ()
		-- 	SText07.scaleX, SText07.scaleY = 1.2,1.2
		-- end)

		coroutine.yield()
	end)
	coroutine.resume(newCoroutine)
end

function Dice.Initialize()
	local calculatedWidth = PanelDice.width / 2 + 55
	DT01 = Panel()
	DT02 = Panel()
	DT03 = Panel()
	DT04 = Panel()
	DT05 = Panel()
	DT06 = Panel()
	DT07 = Panel()

	DT01.rect = Rect(calculatedWidth, 40, 60, 30)
	DT02.rect = Rect(calculatedWidth + 135, 40, 60, 30)
	DT03.rect = Rect(calculatedWidth, 80, 60, 30)
	DT04.rect = Rect(calculatedWidth + 135, 80, 60, 30)
	DT05.rect = Rect(calculatedWidth, 120, 60, 30)
	DT06.rect = Rect(calculatedWidth + 135, 120, 60, 30)
	DT07.rect = Rect(calculatedWidth + 135 / 2, 160, 60, 30)

	DT01.color = Color(63, 63, 63, 255)
	DT02.color = Color(63, 63, 63, 255)
	DT03.color = Color(63, 63, 63, 255)
	DT04.color = Color(63, 63, 63, 255)
	DT05.color = Color(63, 63, 63, 255)
	DT06.color = Color(63, 63, 63, 255)
	DT07.color = Color(63, 63, 63, 255)

	statText1 = CustomText("근력:", Rect(DT01.x - 45, DT01.y, 40, 30))
	statText2 = CustomText("인내력:", Rect(DT02.x - 60, DT02.y, 60, 30))
	statText3 = CustomText("지능:", Rect(DT03.x - 45, DT03.y, 40, 30))
	statText4 = CustomText("손재주:", Rect(DT04.x - 60, DT04.y, 60, 30))
	statText5 = CustomText("민첩:", Rect(DT05.x - 45, DT05.y, 40, 30))
	statText6 = CustomText("행운:", Rect(DT06.x - 45, DT06.y, 40, 30))
	statText7 = CustomText("능력치합:", Rect(DT07.x - 80, DT07.y, 80, 30))

	statText1.textSize = 17
	statText2.textSize = 17
	statText3.textSize = 17
	statText4.textSize = 17
	statText5.textSize = 17
	statText6.textSize = 17
	statText7.textSize = 17

	SText01 = CustomText("0", Rect(5, 0, 60, 30))
	SText02 = CustomText("0", Rect(5, 0, 60, 30))
	SText03 = CustomText("0", Rect(5, 0, 60, 30))
	SText04 = CustomText("0", Rect(5, 0, 60, 30))
	SText05 = CustomText("0", Rect(5, 0, 60, 30))
	SText06 = CustomText("0", Rect(5, 0, 60, 30))
	SText07 = CustomText("0", Rect(5, 0, 60, 30))

	SText08 = CustomText("", Rect(statText5.x, statText5.y + 75, 240, 60))
	SText08.textAlign = 4

	SText01.textSize = 17
	SText02.textSize = 17
	SText03.textSize = 17
	SText04.textSize = 17
	SText05.textSize = 17
	SText06.textSize = 17
	SText07.textSize = 17
	SText08.textSize = 17
	--================================================================================
	DT01.AddChild(SText01)
	DT02.AddChild(SText02)
	DT03.AddChild(SText03)
	DT04.AddChild(SText04)
	DT05.AddChild(SText05)
	DT06.AddChild(SText06)
	DT07.AddChild(SText07)
	PanelDice.AddChild(statText1)
	PanelDice.AddChild(statText2)
	PanelDice.AddChild(statText3)
	PanelDice.AddChild(statText4)
	PanelDice.AddChild(statText5)
	PanelDice.AddChild(statText6)
	PanelDice.AddChild(statText7)
	PanelDice.AddChild(SText08)
	PanelDice.AddChild(DT01)
	PanelDice.AddChild(DT02)
	PanelDice.AddChild(DT03)
	PanelDice.AddChild(DT04)
	PanelDice.AddChild(DT05)
	PanelDice.AddChild(DT06)
	PanelDice.AddChild(DT07)
	dice_play.AddChild(dice_img)
	PanelDice.AddChild(dice_play)
	PanelDice.AddChild(dice_Decision)
	PanelDice.AddChild(dice_textbox)
	PanelDice.showOnTop = true
end
