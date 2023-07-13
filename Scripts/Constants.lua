---@diagnostic disable: redundant-parameter
local Constants = {}

string.empty = ""

Constants.IMAGES = {
}

function SetVar(num, variable)
    Client.FireEvent("변수", num, variable)
end

function CustomText(text, rect)
    return Text() {
        text = text or "",
        rect = rect or Rect(0,0,0,0),
        font = Font("NotoSansCJKkr-Medium")
    }
end