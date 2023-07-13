---@diagnostic disable: missing-parameter, undefined-field, param-type-mismatch
-- 마나가 없을경우 스킬이 사용되지 않습니다.
-------------------------------------------------
Auto = {}
-------------------------------------------------
-- 설정하기
-------------------------------------------------

--활용할 퀵슬롯 개수 (4또는 8 권장)
Auto.quickSlot = 4

---------------------------------------------
-- 아래는 건들지 마세요
---------------------------------------------
Auto.cnt = 0
Auto.rndStopCount = 5 --쌓이는 데이터를 5초마다 초기화하겠다.
Auto.style = 0        -- 0: 취소 / 1: 추적 / 2: 제자리

function Auto:Tick(t)
    if not self.object.mode then
        return
    end

    local me = Client.myPlayerUnit

    if not me then
        return
    end

    self.cnt = self.cnt + t
    if self.cnt > self.rndStopCount then
        me.StopMove()
        self.target = nil
        self.cnt = 0
    end

    local target = self.target

    --valid란 오브젝트 유효여부 target과 target.valid 이 어떤 차이점인지는 모르겠음.
    if target and target.valid and not target.dead then
        local dist = (me.x - target.x) * (me.x - target.x) + (me.y - target.y) * (me.y - target.y)
        if dist < 50 * 50 then
            me.StopMove()
        else
            if self.style == 2 then
                me.StopMove()
            else
                me.MoveToPosition(target.x, target.y)
            end
        end

        for i, quickSlot in pairs(Client.myPlayerUnit.quickSlots) do
            if i > self.quickSlot then
                break
            end
            local skillData = Client.GetSkill(quickSlot.skillDataID)
            if skillData ~= nil then
                if me.mp >= skillData.consumeMP then
                    me.UseSkill(quickSlot.skillDataID, target and Point(target.x - me.x, target.y - me.y) or nil)
                end
            end
        end
    else
        self.target = Client.field.FindNearUnit(me.x, me.y, 2000, 2, me)
    end
end

function Auto:Show()
    local cw = Client.width
    local ch = Client.height

    if self.object then
        return
    end

    self.object = {}

    local o = self.object

    o.body = Button("", Rect(cw - 265, ch - 190, 64, 58))
    o.body.SetOpacity(0)

    o.buttonImage = {}
    for i = 1, 2 do --이미지를 선언해주는 부분 --클라 실행시 최초1번 발동
        o.buttonImage[i] = Image("Pictures/auto" .. i .. ".png", Rect(0, 0, 64, 58))
        local ob = o.buttonImage[i]
        ob.visible = i == 1 and true or false
        ob.SetOpacity(150)  --이미지의 투명도
        o.body.AddChild(ob) --1번과 2번을 둘다 자식으로 넣는데, 최초에는 1번만 표시를 해주겠다.
    end
    o.mode = false
    o.body.onClick.Add(function()
        if self.style == 0 then
            self.style = self.style + 1
        elseif self.style == 1 then
            self.style = self.style + 1
            Client.ShowCenterLabel(
            "<color=#A4A4A4>[자동사냥]</color> <color=#00FFFF>[제자리]</color> <color=#A4A4A4>[종료]</color>")
            Client.FireEvent("변수", 26, 2)
            return
        elseif self.style == 2 then
            self.style = 0
        end
        o.buttonImage[1].visible = not o.buttonImage[1].visible
        o.buttonImage[2].visible = not o.buttonImage[2].visible
        o.mode = not o.mode
        Client.myPlayerUnit.StopMove()
        if o.mode then
            Client.ShowCenterLabel(
            "<color=#00FFFF>[자동사냥]</color> <color=#A4A4A4>[제자리]</color> <color=#A4A4A4>[종료]</color>")
            SetVar(26, 1)
        else
            Client.ShowCenterLabel(
            "<color=#A4A4A4>[자동사냥]</color> <color=#A4A4A4>[제자리]</color> <color=#00FFFF>[종료]</color>")
            SetVar(26, 0)
        end
    end)

    Client.onTick.Add(function(t) Auto:Tick(t) end)
end

Client.RunLater(function()
    Auto:Show()
end, 0.5)