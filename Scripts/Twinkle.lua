function Twinkle(id, num, num2)
	local cw = Client.width
	local ch = Client.height
	local Garo = 300
	local Sero = 200
	local th = 32
	local ran_width = math.random(cw/2-Garo/2-th, cw/2+Garo/2-th)
	local ran_height = math.random(ch/2-Sero/2-th, ch/2+Sero/2-th)
	
	local Tem = Image("", Rect(cw/2-th, ch/2-th, 64, 64))
	Tem.SetImageID(Client.GetItem(id).imageID)
	Tem.showOnTop = true
	
	Client.RunLater(function()
		Tem.DOScale(Point(0.5, 0.5), 0.7)
		Tem.DOMove(Point(TopMenu.mainPanel.x+43*3, TopMenu.mainPanel.y), 0.7)
		Client.RunLater(function()
			Tem.Destroy()
			Tem = nil
		end, 0.7)
	end, 2)
	Client.FireEvent("dice_sound", "득.ogg")
	local Q = 2 / num2
	for i=1, num2 do	
		Client.RunLater(function()
			Lighting(Garo, Sero, num)
		end, (i-1)*Q)
	end
end

function Lighting(Garo, Sero, num)
	local cw = Client.width
	local ch = Client.height
	
	for i=1, num do
		local ran_width = math.random(cw/2-Garo/2, cw/2+Garo/2)
		local ran_height = math.random(ch/2-Sero/2, ch/2+Sero/2)
		local Twinkle_image = Image("Pictures/A1.png", Rect(ran_width, ran_height, 64, 64))
		Twinkle_image.showOnTop = true
		Twinkle_image.SetOpacity(185)
		Client.RunLater(function()
			Twinkle_image.image = 'Pictures/A2.png'
			Client.RunLater(function()
				Twinkle_image.image = 'Pictures/A3.png'
				Client.RunLater(function()
					Twinkle_image.image = 'Pictures/A2.png'
					Client.RunLater(function()
						Twinkle_image.image = 'Pictures/A1.png'
						Client.RunLater(function()
							Twinkle_image.Destroy()
							Twinkle_image = nil
						end, 0.1)
					end, 0.1)
				end, 0.1)
			end, 0.1)
		end, 0.1)
	end
end

Client.GetTopic("Twinkle").Add(function(id, num, num2)
	Twinkle(id, num, num2)
end)