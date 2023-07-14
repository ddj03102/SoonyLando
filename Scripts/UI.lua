local function showExpBar()
	if EXP_PANEL then
		return
	end

	EXP_PANEL = Panel(){
		rect = Rect(0, Client.height - 8, Client.width, 8),
		opacity = 0
	}

	BAR_EXP = Image("Pictures/BAR_EXP.png"){
		rect = Rect(0, 0, EXP_PANEL.width, EXP_PANEL.height)
	}
	EXP_PANEL.AddChild(BAR_EXP)
	
	EXP_TEXT = Text(){
		rect = Rect(0, -6, EXP_PANEL.width, EXP_PANEL.height * 2),
		text = "", textAlign = 4, textSize = 14,
		borderEnabled = true
	}
	EXP_PANEL.AddChild(EXP_TEXT)
end

local function refreshUI()
	local expTable = { Client.myPlayerUnit.exp, Client.myPlayerUnit.maxEXP }
	local decimalPoint = 2 --소수점 자리
	local progress = math.floor((expTable[1] / expTable[2] * 100) * 10 ^ decimalPoint) / 10 ^ decimalPoint .. "%"
	EXP_TEXT.text = progress
	BAR_EXP.DOScale(Point(expTable[1] / expTable[2], 1), 0.3)
end
Client.GetTopic('BAR_EXP').Add(function ()
	refreshUI()
end)

showExpBar()