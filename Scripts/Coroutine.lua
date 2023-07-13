---@diagnostic disable: param-type-mismatch
function WaitForSeconds(time)
    local runningCoroutine = coroutine.running()
    Client.RunLater(function()
        coroutine.resume(runningCoroutine)
    end, time)
    coroutine.yield()
end

-- Example
-- local newCoroutine = coroutine.create(function()
--     print('\n--코루틴 딜레이 적용')
--     WaitForSeconds(1)
--     print('1초경과')
--     WaitForSeconds(1)
--     print('2초경과')
--     WaitForSeconds(1)
--     print('3초경과')
--     WaitForSeconds(1)
--     print('4초경과')
--     WaitForSeconds(1)
--     print('5초경과')
--     WaitForSeconds(3)
--     print('\n--코루틴 딜레이 미적용')
--     WaitForSeconds(1)
--     print('1초경과')
--     print('2초경과')
--     print('3초경과')
--     print('4초경과')
--     print('5초경과')

--     coroutine.yield()
-- end)

-- coroutine.resume(newCoroutine)