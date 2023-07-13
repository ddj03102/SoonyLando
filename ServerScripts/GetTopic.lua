--[[
주의할 점
데이터베이스 스텟에 <color=#FFFFFF>공격력</color>
이런식으로 스텟이름에 컬러가 들어가 있으면 작동이 안됨
--]]
Server.GetTopic("selling_end").Add(function(ID, su, Count)
	local id = Utility.JSONParse(ID)
	if Count ~= nil then
		count_num = Utility.JSONParse(Count)
	end
	local sum = 0
	local save_su = 0
	
	if Count ~= nil then
		for i, p in pairs(id) do
			local Tem = unit.player.GetItem(p)
			if Tem == nil then 
				unit.SendCenterLabel("비정상적 판매시도")
				return
			end
			local Sem = Server.GetItem(Tem.dataID).sellerPrice * Tem.count
			save_su = Tem.count
			sum = sum + Sem
			
			unit.RemoveItemByID(p, save_su, false, true, true)
		end
		unit.AddGameMoney(sum)
		unit.SendCenterLabel("<color=#81DAF5>아이템을 판매하여 "..sum.."골드를 획득하셨습니다.</color>")
	else
		for i, p in pairs(id) do
			local Tem = unit.player.GetItem(p)
			if Tem == nil then 
				unit.SendCenterLabel("비정상적 판매시도")
				return
			end
			local Sem = Server.GetItem(Tem.dataID).sellerPrice
			if Tem.count < su then
				unit.SendCenterLabel("수량이 부족합니다.")
				return
			else
				sum = sum + Sem*su
			end
			
			unit.RemoveItemByID(p, su, false, true, true)
		end
		unit.AddGameMoney(sum)
		unit.SendCenterLabel("<color=#81DAF5>아이템을 판매하여 "..sum.."골드를 획득하셨습니다.</color>")
	end
end)
--클라에서 버튼을 클릭할 때 호출되므로 필요함. 지우면 안대 수나
Server.GetTopic("selling").Add(function()
	selling_start()
end)


function selling_start()
	local Q, W, E, R, T = {}, {}, {}, {}, {}
	local Tstr, Eq = {}, {}
	for i, p in pairs(unit.player.GetItems()) do
		table.insert(Q, p.dataID)
		table.insert(W, p.id)
		table.insert(E, p.count)
		table.insert(R, p.level)
		table.insert(T, Utility.GetItemOptions(p))
		table.insert(Tstr, '')
		table.insert(Eq, unit.IsEquippedItem(p.id))
	end
	for i, p in pairs(T) do
		for j, o in pairs(p) do
			Tstr[i] = Tstr[i]..filter(o.type, o.statID, o.value)
		end	
	end
	
	local q, w, e, r, t = Utility.JSONSerialize(Q), Utility.JSONSerialize(W), Utility.JSONSerialize(E), Utility.JSONSerialize(R), Utility.JSONSerialize(Tstr)
	local eq = Utility.JSONSerialize(Eq)
	unit.FireEvent("selling_start", q, w, e, r, t, eq)
end

function filter(Q, W, E)
	local txt = {}
	local text1, text2, text3 = "", "", ""
	
	if W == 0 then
		local atk = Server.GetStrings().attack
		text2 = (atk == "" and "공격력") or atk
	elseif W == 1 then
		local def = Server.GetStrings().defense
		text2 = (def == "" and "방어력") or def
	elseif W == 2 then
		local Matk = Server.GetStrings().magic_attack
		text2 = (Matk == "" and "마법 공격력") or Matk
	elseif W == 3 then
		local Mdef = Server.GetStrings().magic_defense
		text2 = (Mdef == "" and "마법 방어력") or Mdef
	elseif W == 4 then
		local agi = Server.GetStrings().agility
		text2 = (agi == "" and "민첩") or agi
	elseif W == 5 then
		local luk = Server.GetStrings().lucky
		text2 = (luk == "" and "민첩") or luk
	elseif W == 6 then
		local hp = Server.GetStrings().hp
		text2 = (hp == "" and "체력") or hp
	elseif W == 7 then
		local mp = Server.GetStrings().mp
		text2 = (mp == "" and "마나") or mp
	elseif W == 101 then
		text2 = Server.GetStrings().custom1
	elseif W == 102 then
		text2 = Server.GetStrings().custom2
	elseif W == 103 then
		text2 = Server.GetStrings().custom3
	elseif W == 104 then
		text2 = Server.GetStrings().custom4
	end
	
	if Q == 1 then
		text1 = '직업 '..text2..' +'..E
	elseif Q == 2 then
		text1 = '직업 '..text2..' +'..E..'%'
	elseif Q == 3 then
		text1 = '아이템 '..text2..' +'..E
	elseif Q == 4 then
		text1 = '아이템 '..text2..' +'..E..'%'
	end
	
	text1 = text1.."\n"
	return text1
end