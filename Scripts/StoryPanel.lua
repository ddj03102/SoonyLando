Client.GetTopic("story_panel").Add(function(num)
	if num == 2 then
		local W = Client.width
		local H = Client.height

		if story_panel then return end
		story_panel = Panel()
		story_panel.rect = Rect(W - 320, H - 200, 115, 50)
		story_panel.color = Color(0, 0, 0, 40)

		story_text = Text("마을은 위쪽에 있어요.", Rect(5, 0, 115, 50))
		story_text.textSize = 15

		story_panel.AddChild(story_text)

		Client.RunLater(function()
			story_panel.Destroy()
		end, 8)
	end
end)