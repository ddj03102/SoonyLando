function Hi_sun(num)
	local sum = 0
	for i=1, num do
		local lv = i
		local W = 0
		if lv > 90 then
			W = math.floor((lv-90)/10)*10
			lv = lv - W
		end

		local Q = math.ceil(lv/10)
		if lv % 10 == 0 then
			Q = Q * 4
		end
		
		sum = sum + Q
	end
	return sum
end