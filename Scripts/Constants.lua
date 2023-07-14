---@diagnostic disable: redundant-parameter
Constants = {}

string.empty = ""

Constants.IMAGES = {
}

Constants.FONTS = {
    NotoSansKR = "NotoSansCJKkr-Medium",
    NanumGothic = "NanumGothic",
    NanumMyeongjo = "NanumMyeongjo",
}

function SetVar(num, variable)
    Client.FireEvent("변수", num, variable)
end

function CustomText(text, rect)
    return Text() {
        text = text or "",
        rect = rect or Rect(0,0,0,0),
        font = Font(Constants.FONTS.NotoSansKR)
    }
end

-- local function test()
--     local path = "/"              -- 읽을 파일이 있는 경로
--     print(coroutine)

--     local file = io.open("게임에 사용할 대사.txt", "r") -- 경로와 파일명을 조합하여 파일 열기
--     if file then
--         local content = file:read("*a")          -- 파일 내용 전체 읽기
--         file:close()                             -- 파일 닫기

--         -- 파일 내용 처리
--         print(content)
--     else
--         print("파일을 열 수 없습니다.")
--     end
-- end
-- test()