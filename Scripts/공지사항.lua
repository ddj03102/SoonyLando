function Announcement()
	local Garo = 450
	local Sero = 330
	local cw = Client.width
	local ch = Client.height
	
	if Notice_Panel then return end
	
	Notice_Panel = Panel()
	Notice_Panel.rect = Rect(cw/2-Garo/2, ch/2-Sero/2, Garo, Sero)
	Notice_Panel.color = Color(64, 64, 64, 255)
	Notice_Panel.showOnTop = true
	
	local Notice_Panel_2 = Panel()
	Notice_Panel_2.rect = Rect(0, 0, Garo-24, Sero*3.3)
	Notice_Panel_2.color = Color(43, 43, 43, 255)
	--Notice_Panel.AddChild(Notice_Panel_2)
	
	local Close_Button = Button('✖', Rect(Garo+6, 0, 40, 40))
	--Close_Button.textAlign = 0
	Close_Button.textSize = 26
	Close_Button.color = Color(64, 64, 64, 255)
	Notice_Panel.AddChild(Close_Button)
	
	Close_Button.onClick.Add(function()
		if agree == 1 then
			Notice_Panel.DOScale(Point(0.01, 0.01), 0.2)
			Notice_Panel.DOMove(Point(TopMenu.mainPanel.x+TopMenu.mainPanel.width-43*4+20, TopMenu.mainPanel.y+20), 0.2)
			Client.RunLater(function()
				Notice_Panel.Destroy()
				Notice_Panel = nil
			end, 0.2)
		else
			Client.FireEvent("SendCenterLabel", 
			'<color=#FFFF00>스크롤을 아래로 내려서 동의해주세요.</color>')
		end
	end)
	
	local scroll_panel = ScrollPanel()
	scroll_panel.rect = Rect(12, 40, Garo-24, Sero-52)

	scroll_panel.AddChild(Notice_Panel_2)
	scroll_panel.content = Notice_Panel_2
	scroll_panel.horizontal = false
	scroll_panel.showVerticalScrollbar = false
	Notice_Panel.AddChild(scroll_panel)
	
	local Notice_Button = {}
	local Notice_Image = {}
	local Notice_Text = {}
	local In_text = {}
	local Last_Button = {}
	for i=1, 3 do
		Notice_Button[i] = Button(nil, Rect(Notice_Panel.width/3*(i-1), 0, Notice_Panel.width/3, 39))
		Notice_Image[i] = Image('Pictures/패널쓰2.png', Rect(0, 0, Notice_Button[i].width, Notice_Button[i].height))
		Notice_Image[i].SetOpacity(100)
		Notice_Button[i].color = Color(64, 64, 64, 255)
		Notice_Text[i] = Text(nil, Rect(0, 0, Notice_Button[i].width, Notice_Button[i].height))
		Notice_Text[i].textSize = 23
		Notice_Text[i].textAlign = 4
		
		Notice_Image[i].AddChild(Notice_Text[i])
		Notice_Button[i].AddChild(Notice_Image[i])
		Notice_Panel.AddChild(Notice_Button[i])
		
		Notice_Button[i].onClick.Add(function()
			Notice_Button[i].color = Color(160, 220, 235, 255)
			local bagic_color = Color(64, 64, 64, 255)
			if i==1 then
				Notice_Panel_2.height = Sero*3.3
				Notice_Button[i+1].color = bagic_color
				Notice_Button[i+2].color = bagic_color
				In_text[1].visible = true
				In_text[2].visible = false
				In_text[3].visible = false
				Last_Button[1].visible = true
				Last_Button[2].visible = true
			elseif i==2 then
				Notice_Panel_2.height = Sero-50
				Notice_Button[i-1].color = bagic_color
				Notice_Button[i+1].color = bagic_color
				In_text[1].visible = false
				In_text[2].visible = true
				In_text[3].visible = false
				Last_Button[1].visible = false
				Last_Button[2].visible = false
			else
				Notice_Panel_2.height = Sero-50
				Notice_Button[i-1].color = bagic_color
				Notice_Button[i-2].color = bagic_color
				In_text[1].visible = false
				In_text[2].visible = false
				In_text[3].visible = true
				Last_Button[1].visible = false
				Last_Button[2].visible = false
			end
		end)
	end
	Notice_Button[1].color = Color(160, 220, 235, 255)
	Notice_Text[1].text = '운영규칙'
	Notice_Text[2].text = '이벤트'
	Notice_Text[3].text = '공지사항'
	
	for i=1, 3 do
		In_text[i] = Text(nil, Rect(0, 0, Notice_Panel_2.width, Notice_Panel_2.height))
		In_text[i].textAlign = 0
		In_text[i].textSize = 15
		In_text[i].color = Color(244, 244, 244, 255)
		Notice_Panel_2.AddChild(In_text[i])
	end
	
	In_text[1].text = 
	[[
							<color=#FFFF00><size='26'>수니랜드 운영규칙</size></color>
			
	<size='15'>안녕하세요. 수니랜드 운영진입니다.

수니랜드는 다음과 같은 운영규칙을 기반으로 운영됩니다.
운영규칙을 잘 지켜주시기 바라며 공지합니다.</size>

<size='19'><color=#81F781>※ 채팅관련 분쟁</color></size>
게임 플레이 시 충동적인 언쟁에 의한 분쟁이 발생할 수 있습니다. 이를 감안하여 분쟁 발생 시
무조건적인 제재를 하지 않습니다.

단 악의적인 욕설, 모욕 및 성적발언, 인신공격 등 넷매너 비준수는 운영진의 제재가 있습니다.
해당부분의 제재단계는 다음과 같으며, 1단계 이후 동일문제에 대해서는 기간제한없이 가중처벌됩니다.

<color=#FAAC58>[제재단계 1]</color> 3일정지
<color=#FAAC58>[제재단계 2]</color> 30일정지
<color=#FAAC58>[제재단계 3]</color> 영구정지

<size='19'><color=#81F781>※ 비인가프로그램 및 매크로</color></size>
수니랜드에서 허용하지않는 모든 프로그램이 이에 해당합니다.

게임 플레이와 관련하여 비인가프로그램 및 매크로의 사용은 강력하게 제재합니다.
해당부분의 제재단계는 다음과 같으며, 1단계 이후 동일문제에 대해서는 기간제한없이 가중처벌됩니다.

<color=#FAAC58>[제재단계 1]</color> 해당문제 이용자제권고 및 3일정지
<color=#FAAC58>[제재단계 2]</color> 영구정지

<size='19'><color=#81F781>※ 기타사항</color></size>
1. 게임진행 방해, 성거래, 타게임 아이템과 맞교환 / 현거래유도 등 게임을 운영하는데 큰 피해를 주는 행위
2. 닉네임관련 사항입니다. 네코랜드 슈퍼캣님의 공지사항을 인용
      <color=#FAAC58>★ 닉네임에 욕설이 포함되었거나,</color>
      <color=#FAAC58>★ 보는 이로 하여금 불쾌감을 느끼게 하는 닉네임</color>
      <color=#FAAC58>★ 네코랜드GM 또는 관리자라는 혼란을 줄 수 있는 닉네임</color>
3. 수니랜드을 즐기시는 유저분들 악의적으로 괴롭히는 행위

해당부분의 제재단계는 다음과 같으며, 1단계 이후 동일문제에 대해서는 기간제한없이 가중처벌됩니다.

1번
<color=#FAAC58>[제재단계 1]</color> 영구정지

2, 3번
<color=#FAAC58>[제재단계 1]</color> 해당문제 권고 및 1일정지
<color=#FAAC58>[제재단계 2]</color> 영구정지

※ 차후 운영규칙은 수정되거나 추가될 수 있습니다.

※ 수니랜드 운영진은 어떠한 조건 감안하지 않고 유저분들을 공정하고 평등하게 판단하겠습니다.

※ 수니랜드를 즐겨주셔서 감사드리며, 언제나 행운이 있길 바랍니다. 수니랜드는 언제나 유저분들의 행복을 바랍니다.
	]]
	In_text[2].text = [[
	
	
	헤헤 뭐가 많이 없쥬?
	천천히 업데이트 할테니 재밌게 즐겨주세요.
	클로즈베타 기간을 길게잡고 완성도를 높힌다음
	오픈베타는 1~2일 정도로 짧게 치고 바로 정식오픈할거에요.
	
	어차피 날아갈 데이터 클베를 즐기시는데 의미 있으시라고,
	선착순 랭킹을 정해서 5등급 정도의 선물을 드리려합니다.
	큰건 아니니 무리하지 마시고, 클베의 목적은 버그를 찾고
	유저들의 다양한 의견을 받아서 재미와 완성도를 높히는거니까요!
	
	그럼 모두 고맙고 사랑해요. ♥]]
	In_text[3].text = [[
	
	룰루랄라]]
	In_text[2].visible = false
	In_text[3].visible = false
	
	Last_Button[1] = Button('동의한다.', Rect(20, Notice_Panel_2.height-60, 80, 40))
	Last_Button[2] = Button('동의못해', Rect(160, Notice_Panel_2.height-60, 80, 40))
	----------------------------------------------------------------------------------------
	----------------------------------------------------------------------------------------
	for i=1, 2 do
		Last_Button[i].color = Color(111, 111, 111, 255)
		Notice_Panel_2.AddChild(Last_Button[i])
		Last_Button[i].textAlign = 4
		Last_Button[i].textSize = 18
	end
	
	Last_Button[1].onClick.Add(function()
		Notice_Panel.Destroy()
		Notice_Panel = nil
		local ran = math.random(1, 11)
		local txt = '당신이 최고야'
		if ran == 1 then txt = '고마워요.'
		elseif ran == 2 then txt = '행복하게 만들어줄게요.'
		elseif ran == 3 then txt = '나도 동의한다.'
		elseif ran == 4 then txt = '항상 감사해요.'
		elseif ran == 5 then txt = '즐겨주셔서 고마워요.'
		elseif ran == 6 then txt = '건강하세요.'
		elseif ran == 7 then txt = '행복하세요.'
		elseif ran == 8 then txt = '하하하하하하' Client.FireEvent("dice_sound", "으하하하하(저).ogg")
		elseif ran == 9 then txt = '힘내세요!'
		elseif ran == 10 then txt = '긍정에너지를 드릴게요!'
		end
		txt = "<color=#BFFF00><size='25'>"..txt.."</size></color>"
		Client.FireEvent("SendCenterLabel", txt)
		Client.FireEvent("변수", 25, 1)
	end)
	
	Last_Button[2].onClick.Add(function()
		local ran = math.random(1, 11)
		local txt = '제발 동의해줘'
		if ran == 1 then txt = '동의해주면 안잡아먹지'
		elseif ran == 2 then txt = '동의보감'
		elseif ran == 3 then txt = '동의하면 잘해줄게요.'
		elseif ran == 4 then txt = '장난치는거죠?'
		elseif ran == 5 then txt = '동의하면 당신의 외모가 +3 상승합니다.'
		elseif ran == 6 then txt = '동의 못하면 100원을 잃어버릴 겁니다.'
		elseif ran == 7 then txt = '저희 엄마도 동의하길 바랄 거에요.'
		elseif ran == 8 then txt = 'ㅋㅋㅋㅋ' Client.FireEvent("dice_sound", "ㅋㅋㅋㅋㅎ.ogg")
		elseif ran == 9 then txt = '당신은 할 수 있어요!'
		elseif ran == 10 then txt = '동의를 해주세요.'
		end
		txt = "<size='25'>"..txt.."</size>"
		Client.FireEvent("SendCenterLabel", txt)
	end)
end