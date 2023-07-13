--[[

<< 유저 소환,출두 스크립트 >>

 0. 기존에 onSay콜백을 사용하고 있다면?
  onSay부분만 빼고 복붙하세요.
  크게 뭐 건드리는거 없습니다.
  onSay사용하지 않으시면 그냥 본문 내용 전부 복붙하셔도 됩니다.

 1. 운영자라고 적힌 부분을 본인의 네코랜드 닉네임으로 변경해야 합니다.

  unit.name == '운영자' or
  unit.name == '부운영자1' or
  unit.name == '부운영자2' or
  unit.name == '부운영자3' then
  과 같은 형식으로 여러명의 소환,출두 가능 user를 만들 수 있습니다.

 2. x와 y자리에 들어가는 변수를 지정해야 합니다.

  예를 들어
    x = 128 : 소환용 변수
    y = 129 : 출두용 변수
  이렇게 설정하셨다면
  모든 x의 자리에 128 , 모든 y의 자리에 129를 설정하셔야 합니다.
  unit.GetVar(x) - > unit.GetVar(128)의 형식입니다.


 3. 사용법

 소환 및 출두 -- 해당 유저에게 동의없이 소환 , 출두합니다.
  a. 채팅창에 /소환 or /출두 입력
  b. 유저 닉네임 입력
  c. 종료

 전체소환 -- 유저 전체를 동의없이 소환합니다.
  a. 채팅창에 /전체소환 입력
  b. 종료

 4. 문제가 있다면 연락 주세요. fatal_sr@naver.com 혹은 HiSGram, 미스레시아를 찾아주시면 됩니다.

Made By HiSGram
--]]
--[[
function onSay(unit, text)
 if unit.name == 'TEST_1' then -- 이 '운영자'를 본인의 네코랜드 닉네임으로 변경 해 주세요.

     if unit.GetVar(2) == 1 then -- 이 'x'을 본인의 네코랜드 변수 중 하나로 변경 해 주세요.
       for i, rp in ipairs(Server.players) do
        if rp.name == text then
          unit.field.JoinUnit(rp.unit)
          rp.unit.SpawnAtFieldID(unit.field.dataID,unit.x,unit.y)
          unit.SendSay('소환 완료.' , 0xFFFF00)
        end
       end
       unit.SetVar(2,0) -- 이 'x'을 본인의 네코랜드 변수 중 하나로 변경 해 주세요.
     end

     if unit.GetVar(3) == 1 then -- 이 'y'을 본인의 네코랜드 변수 중 하나로 변경 해 주세요.
       for i, rp in ipairs(Server.players) do
        if rp.name == text then
          rp.unit.field.JoinUnit(unit)
          unit.SpawnAt(rp.unit.x,rp.unit.y)
          unit.SendSay('출두 완료.' , 0xFFFF00)

        end
       end
       unit.SerVar(3,0) -- 이 'y'을 본인의 네코랜드 변수 중 하나로 변경 해 주세요.
     end

     if text == "/소환" then
       unit.SetVar(2,1) -- 이 'x'을 본인의 네코랜드 변수 중 하나로 변경 해 주세요.
       unit.SendSay('소환 준비 , 소환할 Player의 닉네임은?' , 0xFFFF)
     end

     if text == "/출두" then
       unit.SetVar(3,1) -- 이 'y'을 본인의 네코랜드 변수 중 하나로 변경 해 주세요.
       unit.SendSay('출두 준비 , 출두할 Player의 닉네임은?' , 0xFFFF)
     end

     if text == "/전체소환" then
       for i, rp in ipairs(Server.players) do
        rp.unit.SpawnAtFieldID(unit.field.dataID,unit.x,unit.y)
       end
     end

  end

end
Server.onSay.Add(onSay)
]]
