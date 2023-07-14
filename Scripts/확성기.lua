---@diagnostic disable: param-type-mismatch, lowercase-global
function ShowLoudspeakerPanel()
	Client.ShowBag(false)

	local panelWidth = 185
	local panelHeight = 80

	if loudspeakerPanel then
		loudspeakerPanel.rect = Rect(558, 68, panelWidth, panelHeight)
		return
	end

	loudspeakerPanel = Panel(Rect(558, 68, panelWidth, panelHeight))
	loudspeakerPanel.color = Color(100, 100, 100, 0)
	loudspeakerPanel.showOnTop = true

	local panelBackground = Image("Pictures/panel_beige.png") {
		rect = Rect(0, 0, loudspeakerPanel.width, loudspeakerPanel.height),
		imageType = 1
	}
	loudspeakerPanel.AddChild(panelBackground)

	local inputField = InputField(Rect(10, 10, panelWidth - 20, 30))
	inputField.placeholder = '확성 내용을 입력하세요.'
	inputField.textSize = 14
	inputField.textAlign = 3
	loudspeakerPanel.AddChild(inputField)

	local sendButton = Button('보내기', Rect(5, 50, 55, 40))
	sendButton.SetImage("Pictures/panel_brown.png")
	sendButton.color = Color.green
	loudspeakerPanel.AddChild(sendButton)

	local deleteButton = Button('삭제', Rect(65, 50, 55, 40))
	deleteButton.SetImage("Pictures/panel_brown.png")
	deleteButton.color = Color.black
	loudspeakerPanel.AddChild(deleteButton)

	local cancelButton = Button('취소', Rect(125, 50, 55, 40))
	cancelButton.SetImage("Pictures/panel_brown.png")
	cancelButton.color = Color.red
	loudspeakerPanel.AddChild(cancelButton)

	sendButton.onClick.Add(function()
		if inputField.text == string.empty then
			return
		end
		Client.FireEvent('Loudspeaker', inputField.text)
	end)

	deleteButton.onClick.Add(function()
		inputField.text = ''
	end)

	cancelButton.onClick.Add(function()
		loudspeakerPanel.Destroy()
		loudspeakerPanel = nil
	end)

	Draggable.AddItem(loudspeakerPanel)
end

function ShowLoudspeakerMessage(message, owner)
	if loudspeakerMessagePanel then
		return
	end

	local panelWidth = 400
	loudspeakerMessagePanel = Panel() {
		rect = Rect(0, 35 + 45, panelWidth, 90),
		pivot = Point(0.5, 0.5), anchor = 1,
		-- content = loudspeakerMessagePanel,
		color = Color(0, 0, 0, 0),
		showOnTop = true,
		scaleX = 0, scaleY = 0
	}

	local speakerImage = Image('Pictures/확성기.png',
		Rect(0, 0, loudspeakerMessagePanel.width, loudspeakerMessagePanel.height))
	loudspeakerMessagePanel.AddChild(speakerImage)

	local speakerOwnerText = Text() {
		text = '[' .. owner .. ']',
		rect = Rect(70, 0, loudspeakerMessagePanel.width - 140, 30),
		textSize = 14,
		textAlign = 4
	}
	speakerOwnerText.shadow.visible = true
	loudspeakerMessagePanel.AddChild(speakerOwnerText)

	local speakerMessageText = Text() {
		text = message,
		rect = Rect(70, 22, loudspeakerMessagePanel.width - 140, loudspeakerMessagePanel.height - 22),
		textSize = 17,
		textAlign = 4
	}
	speakerMessageText.shadow.visible = true
	loudspeakerMessagePanel.AddChild(speakerMessageText)


	Client.RunLater(function()
		loudspeakerMessagePanel.Destroy()
		loudspeakerMessagePanel = nil
	end, 9.9)

	speakerMessageText.DOColor(Color.yellow, 0.1).SetLoops(90,1)

	loudspeakerMessagePanel.SetOrderIndex(1)
	loudspeakerMessagePanel.DOScale(Point(1, 1), 0.5).SetEase(30).OnComplete(function ()
		loudspeakerMessagePanel.DOScale(Point(1.05,1.05),0.5).SetLoops(16,1).OnComplete(function ()
			loudspeakerMessagePanel.DOScale(Point(0, 0), 0.4)
		end)
	end)
end
Client.GetTopic("Loudspeaker").Add(ShowLoudspeakerMessage)