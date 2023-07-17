---@diagnostic disable: param-type-mismatch, redundant-parameter
local sayType = {
    NEARBY = 0,
    ALL = 1,
    WHISPER = 2,
    WHISPER_TO = 3,
    CLAN = 5,
    PARTY = 6,
}

local sayFunc = {
    [sayType.NEARBY] = function(sayUnit, text, sayType, id)
        for i = 1, #sayUnit.field.playerUnits do
            local fieldUnit = sayUnit.field.playerUnits[i]
            fieldUnit.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }),
                true)
        end
    end,
    [sayType.ALL] = function(sayUnit, text, sayType, id)
        Server.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
    end,
    [sayType.WHISPER] = function(sayUnit, text, sayType, id)
        local targetUnit = GetUnitByID(id)
        targetUnit.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
        sayUnit.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
    end,
    [sayType.WHISPER_TO] = function(sayUnit, text, sayType, id)
        local targetUnit = GetUnitByID(id)
        targetUnit.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
        sayUnit.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
    end,
    [sayType.CLAN] = function(sayUnit, text, sayType, id)
        for i=1, #sayUnit.player.clan.memberIDs do
            local memberID = sayUnit.player.clan.memberIDs[i]
            GetUnitByID(memberID).FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
        end
    end,
    [sayType.PARTY] = function(sayUnit, text, sayType, id)
        for i=1, #sayUnit.party.players do
            local partyUnit = sayUnit.party.players[i].unit
            partyUnit.FireEvent("AddChat", Utility.JSONSerialize({ name = sayUnit.name, text = text, type = sayType }), true)
        end
        print(123)
    end
}

Server.sayCallback = function(player, text, sayType, targetID)
    local sayUnit = player.unit
    local sayText = text

    sayFunc[sayType](sayUnit, sayText, sayType, targetID)

    return true
end

function GetUnitByID(id)
    for i = 1, #Server.players do
        local findUnit = Server.players[i]
        return id == findUnit.id and findUnit.unit or nil
    end
end
