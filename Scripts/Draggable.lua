Draggable = {}
Draggable.movingItem = nil

--- draggable UIs

ScreenUI.bagButtonVisible = false

local function SetMaxPosition(curPosX, curPosY)
    local x = curPosX >= Client.width and Client.width or curPosX <= 0 and 0 or curPosX
    local y = curPosY >= Client.height and Client.height or curPosY <= 50 and 50 or curPosY

    return Point(x,y)
end

---버튼의 좌표값을 마우스 좌표값으로 설정합니다.
function MoveAnchor()
    -- 좌표 변경 형식
    Draggable.movingItem.position = SetMaxPosition(Input.mousePositionToScreen.x, Input.mousePositionToScreen.y)

    -- 부드러운 이동 형식
    -- local X = Input.mousePositionToScreen.x
    -- local Y = Input.mousePositionToScreen.y
    -- movingObject.DOMove(SetMaxPosition(X, Y),0.3)
end

function Draggable.AddItem(movingObject)
    local buttonObject = Button(){
        text = string.empty,
        opacity = 0,
        rect = Rect(0,0,movingObject.width,20),
    }
    buttonObject.SetParent(movingObject)

    ---버튼에 마우스를 누를 시에 온틱에 좌표 설정 함수를 추가합니다.
    buttonObject.onMouseDown.Add(function()
        if Input.GetMouseButtonDown(0) then
            Draggable.movingItem = movingObject
            Client.onTick.Add(MoveAnchor)
        end
    end)

    ---버튼에 마우스를 뗄 시에 온틱에 좌표 설정 함수를 삭제합니다.
    buttonObject.onMouseUp.Add(function()
        if Input.GetMouseButtonUp(0) then
            Draggable.movingItem = nil
            Client.onTick.Remove(MoveAnchor)
        end
    end)
end
