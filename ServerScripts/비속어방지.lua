-- --[[ GetVar(27)욕설횟수 GetVar(28)감옥횟수
-- 근처0 전체1 귓2 @없음3 클랜4 파티6
-- ]]
-- Server.sayCallback = function(player, text, sayType)
-- 	local sayUnit = player.unit

-- 	if text == '저장' or text == 'save' then
-- 		if sayUnit.HasSkill(48) then
-- 			has_potal(sayUnit)
-- 		else
-- 			sayUnit.SendCenterLabel("<size='17'><color=#F7BE81>포탈 스킬을 지니고 있지 않습니다.</color></size>")
-- 		end
-- 		return false
-- 	end

-- 	if text == '횰님을 사랑합니다!!' and sayUnit.field.dataID == 53 then
-- 		sayUnit.SendCenterLabel("저도 사랑합니다.")
-- 		sayUnit.SpawnAtFieldID(53, 30 * 32 + 16, -14 * 32 - 16)
-- 		return true
-- 	end

-- 	if sayUnit.player.name == "수니몬" then
-- 		return true
-- 	end
-- 	if sayUnit.player.name == "횰" or sayUnit.player.name == "마샬" then
-- 		if string.sub(text, 1, 2) == "/노" then
-- 			Server.SendSay("<color=#00FFFF>[관리자] " .. string.sub(text, 4, string.len(text)) .. "</color>")
-- 			return false
-- 		end
-- 		return true
-- 	end
-- 	if sayUnit.field.name == "감옥" then -- 맵이름이 감옥일경우 채팅차단
-- 		if sayType ~= 0 then
-- 			return false
-- 		else
-- 			return true
-- 		end
-- 	else -- 그외의경우 정상적으로 채팅함
-- 		local badWordCheck = false
-- 		local badWords = { 
-- 			"애미", "년아", "시발", "씨발", "걔섀", "개쉑", "걔쉑", "씨/발", "씨ㅡ발",
-- 			"시/발", "씨ㅡ발", "애/미", "애ㅡ미", "애,미", "느금마", "ㅆㅂ년", "앰뒤",
-- 			"창녀", "창년", "새끼야", "빨통" 
-- 		}
-- 		local allChatCoolTime = 2
-- 		if sayType == 1 and (os.time() - sayUnit.GetVar(33) <= allChatCoolTime) then
-- 			sayUnit.SendCenterLabel("<size='17'><color=#F7BE81>전체 채팅은 2초 마다 한번씩 가능합니다.</color></size>")
-- 			return false
-- 		elseif sayType == 0 or sayType == 1 or sayType == 2 then
-- 			for i = 1, #badWords do
-- 				if string.find(text, badWords[i]) then
-- 					badWordCheck = true
-- 					print(badWords[i])
-- 				end
-- 			end
-- 			if badWordCheck then
-- 				sayUnit.SetVar(27, sayUnit.GetVar(27) + 1)
-- 				sayUnit.SendSay("<color=#FF0000>비속어 " .. sayUnit.GetVar(27) .. "회 감지</color>")
-- 				sayUnit.SendCenterLabel("<color=#FF0000>공연성 및 특정성을 포함한 욕은 고소당할 수 있음을 알려드립니다.</color>")
-- 				if sayUnit.GetVar(27) % 5 == 0 then
-- 					sayUnit.SetVar(28, sayUnit.GetVar(28) + 1)
-- 					--u.SpawnAtFieldID(40, 368, -320)
-- 				end
-- 				return false
-- 			end
-- 		end
-- 		sayUnit.SetVar(33, os.time())
-- 		return true
-- 	end
-- end
