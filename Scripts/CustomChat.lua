CustomChat = {}

CustomChat.ChatMessages = {}
CustomChat.ChatType = {
    {
        type = Constants.SAYTYPE.NEARBY,
        name = "근처",
        color = Color.white
    },
    {
        type = Constants.SAYTYPE.ALL,
        name = "전체",
        color = Color(160, 225, 255)
    },
    {
        type = Constants.SAYTYPE.WHISPER,
        name = "귓속말",
        color = Color.magenta
    },
    {
        type = Constants.SAYTYPE.WHISPER_TO,
        name = "시스템",
        color = Color(0, 255, 0)
    },
    {
        type = Constants.SAYTYPE.CLAN,
        name = "클랜",
        color = Color(121, 191, 0)
    },
    {
        type = Constants.SAYTYPE.PARTY,
        name = "파티",
        color = Color.cyan
    }
}
CustomChat.ChatCellHeight = 20
CustomChat.CurrentIndex = 2
CustomChat.IndexById = {}

for i, entry in ipairs(CustomChat.ChatType) do
    CustomChat.IndexById[entry.type] = i
end

function CustomChat.CreateChatPanel()
    ChatUI.visible = false

    local mainPanel = Image("Pictures/panel_beige.png") {
        rect = Rect(0, 50, 300, 150),
        opacity = 100,
        imageType = 1,
    }

    local horizontal = HorizontalPanel(Rect(0, 0, mainPanel.width, 20))
    horizontal.SetParent(mainPanel)

    local tab = {}
    local redDot = {}
    for i = 1, 6 do
        tab[i] = Button() {
            text = nil,
            rect = Rect(0, 0, mainPanel.width / 6, horizontal.height),
            opacity = 0,
            textAlign = 4,
            imageType = 1
        }
        tab[i].SetImage("Pictures/panel_deepPurple.png")
        tab[i].SetParent(horizontal)
        tab[i].onClick.Add(function()
            CustomChat.CurrentIndex = i
            CustomChat.RefreshCell(i)
        end)
        local redDot = Image("Pictures/A4.png"){
            rect = Rect(tab[i].width-20,-10,20,20),
        }
        redDot.SetParent(tab[i])

        local chatTypeText = Text() {
            rect = Rect(0, 0, tab[i].width, tab[i].height),
            text = CustomChat.ChatType[i].name,
            textSize = 11,
            textAlign = 4,
            -- font = Constants.FONTS.NotoSansKR
        }
        chatTypeText.shadow.visible = true
        chatTypeText.SetParent(tab[i])
    end

    local chatScroll = ScrollPanel() {
        rect = Rect(5, 25, mainPanel.width - 10, mainPanel.height - 30),
        horizontal = false,
    }
    chatScroll.SetParent(mainPanel)

    local vertical = VerticalPanel(Rect(0, 0, chatScroll.width, chatScroll.height))
    chatScroll.content = vertical

    CustomChat.mainPanel = mainPanel
    CustomChat.chatScroll = chatScroll
    CustomChat.chatTable = vertical
    CustomChat.tabs = tab
end

function CustomChat.ColorByType(index)
    return CustomChat.ChatType[index].color
end

function CustomChat.AddChat(chat, isString)
    if isString then
        chat = Utility.JSONParse(chat)
    end
    local index = CustomChat.IndexById[chat.type]
    if not CustomChat.ChatMessages[index] then
        CustomChat.ChatMessages[index] = {}
    end
    table.insert(CustomChat.ChatMessages[index], { name = chat.name, text = chat.text })

    if CustomChat.CurrentIndex == index then
        CustomChat.RefreshCell(index)
    end
end

function CustomChat.RefreshCell(index)
    for i, v in pairs(CustomChat.tabs) do
        v.children[1].opacity = i == index and 255 or 120
    end

    for i, v in pairs(CustomChat.chatTable.children) do
        v.Destroy()
        v = nil
    end
    if not CustomChat.ChatMessages[index] then return end
    for i = 1, #CustomChat.ChatMessages[index] do
        local chatData = CustomChat.ChatMessages[index][i]
        local chatCell = Text() {
            text = chatData.name == string.empty and chatData.text or chatData.name .. " : " .. chatData.text,
            rect = Rect(0, 0, CustomChat.chatTable.width, CustomChat.ChatCellHeight),
            anchor = 4,
            textSize = 12,
            lineSpacing = 0.8,
            font = Constants.FONTS.NotoSansKR,
            color = CustomChat.ColorByType(index)
        }
        chatCell.shadow.visible = true
        chatCell.SetParent(CustomChat.chatTable)

        -- chatCell.scaleX, chatCell.scaleY = 0, 0
        -- chatCell.DOScale(Point(1, 1), 0.3)
    end
    CustomChat.chatTable.height = CustomChat.ChatCellHeight * #CustomChat.ChatMessages[index]
    local gap = CustomChat.chatTable.height - CustomChat.chatScroll.height
    CustomChat.chatTable.y = gap > 0 and -gap or 0
end

Client.GetTopic("AddChat").Add(function(chat, isString)
    CustomChat.AddChat(chat, isString)
end)

Client.customData.chat = 0

function CustomChat.Initialize()
    CustomChat.CreateChatPanel()
    CustomChat.RefreshCell(CustomChat.CurrentIndex)
    CustomChat.AddChat({
        type = 1,
        name = string.empty,
        text = "<color=yellow>[#] 현재 버전: v" .. Client.appVersion .. "</color>",
    })
    CustomChat.AddChat({
        type = 1,
        name = string.empty,
        text = "<color=yellow>[#] 현재 [" .. Client.platform .. "] 환경에서 접속 중 입니다.</color>",
    })
end

CustomChat.Initialize()

-- function CustomChat.Print()
--     for i, chatDatas in pairs(CustomChat.ChatData) do
--         print("ChatType [" .. i .. "] ================")
--         for j, chatData in pairs(chatDatas) do
--             print(chatData.name .. " : " .. chatData.text)
--         end
--     end
-- end

function CustomChat.HandleRedDot()

end