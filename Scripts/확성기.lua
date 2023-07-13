function Loudspeaker()
	local cw = Client.width
	local ch = Client.height
	local Garo = 185
	local Sero = 80
	if Input_Panel then 
		Input_Panel.rect = Rect(558, 68, Garo, Sero)
		return 
	end
	
	Input_Panel = ScrollPanel(Rect(558, 68, Garo, Sero))
	Input_Panel.content = Input_Panel
	Input_Panel.color = Color(100, 100, 100, 100)
	Input_Panel.showOnTop = true
	
	local Input_speaker = InputField(Rect(0, 50, Garo, Sero-50))
	Input_speaker.placeholder = '확성 내용을 입력하세요.'
	Input_speaker.textSize = 14
	Input_speaker.textAlign = 3
	Input_Panel.AddChild(Input_speaker)
	
	local Input_but = {}
	for i=1, 3 do
		Input_but[i] = Button('', Rect(5+60*(i-1), 5, 55, 40))
		Input_but[i].color = Color(0, 0, 0, 60)
		Input_but[i].text = (i==1 and '보내기') or (i==2 and '삭제') or (i==3 and '취소')
		Input_Panel.AddChild(Input_but[i])
	end
	
	Input_but[1].onClick.Add(function()
		Client.FireEvent('Loudspeaker', Input_speaker.text)
	end)
	
	Input_but[2].onClick.Add(function()
		Input_speaker.text = ''
	end)
	
	Input_but[3].onClick.Add(function()
		Input_Panel.Destroy()
		Input_Panel = nil
	end)
end

Client.GetTopic("Loudspeaker").Add(function(text, text2)
	if speaker_Panel then return end
	local Garo = 400
	speaker_Panel = ScrollPanel(Rect(Client.width/2-Garo/2, 35, Garo, 90))
	speaker_Panel.content = speaker_Panel
	speaker_Panel.color = Color(0, 0, 0, 0)
	speaker_Panel.showOnTop = true
	
	speaker_image = Image('Pictures/확성기.png', Rect(0, 0, speaker_Panel.width, speaker_Panel.height))
	speaker_Panel.AddChild(speaker_image)
	
	speaker_text2 = Text('['..text2..']', Rect(70, 0, speaker_Panel.width-140, 30))
	speaker_text2.textSize = 14
	speaker_text2.textAlign = 4
	speaker_Panel.AddChild(speaker_text2)
	
	speaker_text = Text(text, Rect(70, 22, speaker_Panel.width-140, speaker_Panel.height-22))
	speaker_text.textSize = 17
	speaker_text.textAlign = 4
	speaker_Panel.AddChild(speaker_text)
	
	Client.RunLater(function()
		speaker_Panel.Destroy()
		speaker_Panel = nil
	end, 9.9)
	
	speaker_Panel.SetOrderIndex(1)
end)