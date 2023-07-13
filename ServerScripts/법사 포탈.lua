local not_map = {1, 86, 103} --위치를 저장할 수 없는 맵
function has_potal(unit)
	local me = unit.field.dataID
	if map_name[me] == nil then
		unit.SendCenterLabel("<size='17'><color=#F7BE81>에러코드 : 1040\n운영자에게 문의하세요.</color></size>")
		return
	end
	for i, v in pairs(not_map) do
		if v == me then
			unit.SendCenterLabel("<size='17'><color=#F7BE81>위치를 저장할 수 없는 맵입니다.</color></size>")
			return
		end
	end
	local num = 11
	local lv = 48
	if unit.GetStringVar(num) == nil or unit.GetStringVar(num) == '' then
		local Q = {0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1} 
		unit.SetStringVar(num, Utility.JSONSerialize(Q))
	end
	local W = Utility.JSONParse(unit.GetStringVar(num))
	local tx1 = 
[[<color=#81DAF5>포탈 위치 저장</color>
어떤 슬롯에 위치를 저장하시겠습니까?]]
	local tx2 = {}
	for i=1, unit.GetSkillLevel(lv) do
		if W[1+(i-1)*3] == 0 then
			table.insert(tx2, i..' : [빈 슬롯]')
		else
			table.insert(tx2, i..' : '..map_name[W[1+(i-1)*3]])
		end
	end
	
	table.insert(tx2, '취소')
	Desa_Script(tx1, Utility.JSONSerialize(tx2), "005", unit)
end

function potal(a, b)
	local num = 11
	local Q = Utility.JSONParse(a.GetStringVar(num))
	local W = a.GetVar(35)
	b.SpawnAtFieldID(Q[1+(W-1)*3], Q[1+(W-1)*3+1], Q[1+(W-1)*3+2])
end