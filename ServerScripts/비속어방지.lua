--[[ GetVar(27)욕설횟수 GetVar(28)감옥횟수
근처0 전체1 귓2 @없음3 클랜4 파티6
]]
Server.sayCallback = function(player, text, sayType)
	local u = player.unit
	
	if text == '저장' or text == 'save' then
		if u.HasSkill(48) then
			has_potal(u)
		else
			u.SendCenterLabel("<size='17'><color=#F7BE81>포탈 스킬을 지니고 있지 않습니다.</color></size>")
		end
		return false
	end
	
	if text == '횰님을 사랑합니다!!' and u.field.dataID == 53 then
		u.SendCenterLabel("저도 사랑합니다.")
		u.SpawnAtFieldID(53, 30*32+16, -14*32-16)
		return true
	end
	
	if u.player.name == "수니몬" then
		return true
	end
	if u.player.name == "횰" or u.player.name == "마샬" then
		if string.sub(text, 1, 2) == "/노" then
			Server.SendSay("<color=#00FFFF>[관리자] "..string.sub(text, 4, string.len(text)).."</color>")
			return false
		end
		return true
	end
	if u.field.name == "감옥" then -- 맵이름이 감옥일경우 채팅차단
		if sayType ~= 0 then return false
		else return true end
	else -- 그외의경우 정상적으로 채팅함
		local P = false
		local B = {"애미", "년아", "시발", "씨발", "걔섀", "개쉑", "걔쉑", "씨/발", "씨ㅡ발",
					"시/발", "씨ㅡ발", "애/미", "애ㅡ미", "애,미", "느금마", "ㅆㅂ년", "앰뒤", 
					"창녀", "창년", "새끼야", "빨통"}
		if sayType == 1 and (u.GetVar(33)+6 >= os.time()) then
			u.SendCenterLabel("<size='17'><color=#F7BE81>전체 채팅은 6초의 쿨타임이 있습니다.</color></size>")
			return false
		elseif sayType == 0 or sayType == 1 or sayType == 2 then
			for i=1, #B do
				if string.find(text, B[i]) then P = true print(B[i]) end
			end
			if P then
				u.SetVar(27, u.GetVar(27)+1)
				u.SendSay("<color=#FF0000>비속어 ".. u.GetVar(27).."회 감지</color>")
				u.SendCenterLabel("<color=#FF0000>공연성 및 특정성을 포함한 욕은 고소당할 수 있음을 알려드립니다.</color>")
				if u.GetVar(27) % 5 == 0 then
					u.SetVar(28, u.GetVar(28)+1)
					--u.SpawnAtFieldID(40, 368, -320)
				end
				return false
			end
		end
		u.SetVar(33, os.time())
		return true
	end
end
