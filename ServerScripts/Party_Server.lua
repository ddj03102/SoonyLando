function GetPartyTable()
    local partyTable = {}
    for i=1, #Server.players do
        local party = Server.players[i].unit.party
        if party then
            partyTable[i] = party
        end
    end
    unit.FireEvent("GetParty", Utility.JSONSerialize(partyTable))
end