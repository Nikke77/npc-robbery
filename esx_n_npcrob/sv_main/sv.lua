
local items = {
    {
       itemName = 'ammo-9',
       itemRandomAmount = {1, 3}
    },
    {
       itemName = 'ammo-45',
       itemRandomAmount = {1, 2}
    },
    {
        itemName = 'hotdog',
        itemRandomAmount = {1, 6}
    },
    {
        itemName = 'bread',
        itemRandomAmount = {1, 8} 
    },
    {
        itemName = 'water',
        itemRandomAmount = {1, 4}
    },
}

RegisterNetEvent('n-npcRob:server:robNpc', function(entityId)
    local source = source
    print(tostring(entityIdz))
    local stash = {
        id = tostring(entityId),
        label = 'pockets',
        slots = 5,
        weight = 100000,
    }
    
    local item = items[math.random(1, #items)].itemName
    local minAmount = items[math.random(1, #items)].itemRandomAmount[1]
    local maxAmount = items[math.random(1, #items)].itemRandomAmount[2]
    local amount = math.random(minAmount, maxAmount)
    exports.ox_inventory:RegisterStash(stash.id, stash.label, stash.slots, stash.weight)
    exports.ox_inventory:AddItem(stash.id, item, amount)

    local stashID = stash.id
    TriggerClientEvent('n-npcRob:client:openStash', source, stashID)
end)

RegisterNetEvent('n-npcRob:server:policeAlert', function (pos)
	TriggerClientEvent('n-npcRob:client:policeAlert', -1, pos)
end)
