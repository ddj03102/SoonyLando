CustomChat = {}

CustomChat.ChatData = {}
CustomChat.ChatType = {
    "근처", "전체", "귓속말", "시스템", "클랜", "파티"
}
CustomChat.CurrenType = 1

function CustomChat.CreateChatPanel()
    ChatUI.visible = false

    local mainPanel = Image("Pictures/panel_beige.png") {
        rect = Rect(0, 50, 300, 150),
        opacity = 180,
        imageType = 1,
    }

    local horizontal = HorizontalPanel(Rect(0, 0, mainPanel.width, 20))
    horizontal.SetParent(mainPanel)

    local tab = {}
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
            CustomChat.CurrenType = i - 1
            CustomChat.RefreshCell(i - 1)
        end)

        local chatTypeText = Text() {
            rect = Rect(0, 0, tab[i].width, tab[i].height),
            text = CustomChat.ChatType[i],
            textSize = 10,
            textAlign = 4,
            font = Constants.FONTS.NotoSansKR
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

function CustomChat.AddChat(chat, isString)
    if isString then
        chat = Utility.JSONParse(chat)
    end
    if not CustomChat.ChatData[chat.type] then
        CustomChat.ChatData[chat.type] = {}
    end
    table.insert(CustomChat.ChatData[chat.type], { name = chat.name, text = chat.text })

    if chat.type == CustomChat.CurrenType then
        CustomChat.RefreshCell(chat.type)
    end
end

function CustomChat.RefreshCell(type)
    for i, v in pairs(CustomChat.tabs) do
        v.children[1].opacity = i == type+1 and 255 or 120
    end

    for i, v in pairs(CustomChat.chatTable.children) do
        v.Destroy()
        v = nil
    end
    if not CustomChat.ChatData[type] then return end
    for i = 1, #CustomChat.ChatData[type] do
        local chatData = CustomChat.ChatData[type][i]
        local chatCell = Text() {
            text = chatData.name == string.empty and chatData.text or chatData.name .. " : " .. chatData.text,
            rect = Rect(0, 0, CustomChat.chatTable.width, 15),
            anchor = 4,
            textSize = 10,
            lineSpacing = 0.8,
            font = Constants.FONTS.NotoSansKR
        }
        chatCell.shadow.visible = true
        chatCell.SetParent(CustomChat.chatTable)

        -- chatCell.scaleX, chatCell.scaleY = 0, 0
        -- chatCell.DOScale(Point(1, 1), 0.3)
    end
    CustomChat.chatTable.height = 15 * #CustomChat.ChatData[type]
    local gap = CustomChat.chatTable.height - CustomChat.chatScroll.height
    CustomChat.chatTable.y = gap > 0 and -gap or 0
end

Client.GetTopic("AddChat").Add(function (chat, isString)
    CustomChat.AddChat(chat, isString)
end)

Client.customData.chat = 0

function CustomChat.Initialize()
    CustomChat.CreateChatPanel()
    CustomChat.RefreshCell(CustomChat.CurrenType)
    CustomChat.AddChat({
        type = 1,
        name = string.empty,
        text = "<color=yellow>[#] 현재 버전: v"..Client.appVersion.."</color>",
    })
    CustomChat.AddChat({
        type = 1,
        name = string.empty,
        text = "<color=yellow>[#] 현재 ["..Client.platform.."] 환경에서 접속 중 입니다.</color>",
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
