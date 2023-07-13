--ScreenUI.expBarVisible  = false
function exp_bar()
	if EXP_PANEL then return end
	EXP_PANEL = Panel(Rect(0, Client.height-8, Client.width, 8))
	EXP_PANEL.SetOpacity(0)
	BAR_EXP = Image("Pictures/BAR_EXP.png", Rect(0, 0, EXP_PANEL.width, EXP_PANEL.height))
	EXP_TEXT = Text(nil, Rect(0, -6, EXP_PANEL.width, EXP_PANEL.height*2))
	EXP_TEXT.textSize = 14
	EXP_TEXT.textAlign = 4
	EXP_PANEL.AddChild(BAR_EXP)
	EXP_PANEL.AddChild(EXP_TEXT)
end

exp_bar()

function refreshUI()
	local Q = {Client.myPlayerUnit.exp, Client.myPlayerUnit.maxEXP}
	local R = 2--소수점 자리
	local W = math.floor((Q[1]/Q[2]*100)*10^R)/10^R
	local E = W..'%'
	EXP_TEXT.text = E
	BAR_EXP.DOScale(Point(Q[1]/Q[2], 1), 0.3)
end

Client.GetTopic('BAR_EXP').Add(refreshUI)