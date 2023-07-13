Client.RunLater(function()
	Client.FireEvent('Fireeeee')
	Client.FireEvent('gooooood')
end, 0.2)


Client.GetTopic('Server_Fire').Add(function(love)
	agree = love
end)