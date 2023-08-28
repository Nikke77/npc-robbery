ESX = exports["es_extended"]:getSharedObject()

ped = {}

local function policeAlert()
    local alertLuck = math.random(1,100)
    if alertLuck <= 100 then 
        TriggerServerEvent('n-npcRob:server:policeAlert', GetEntityCoords(PlayerPedId()))
        FreezeEntityPosition(PlayerPedId(), false)
    end    
 end

exports.ox_target:addGlobalPed({
    {
        name = 'npc-rob',
        label = 'Rob this person',
        icon = 'fa-solid fa-male',
        canSelect = function(entity)
            return GetPedType(entity) == 28
        end, 
        onSelect = function(data)
            if ped[data.entity] then
                lib.notify({
                    title = "Can't rob",
                    description = "You can't rob same person",
                    type = 'error'
                })
                return false end
            if IsPedArmed(PlayerPedId(), 2 | 4) then
            SetBlockingOfNonTemporaryEvents(data.entity, true)
            TaskHandsUp(data.entity, 15000, PlayerPedId(), 0, 0)
            local entityId = NetworkGetNetworkIdFromEntity(data.entity)
            TriggerServerEvent('n-npcRob:server:robNpc', entityId)
            Wait(15000)
            ClearPedTasks(data.entity)
            SetBlockingOfNonTemporaryEvents(data.entity, false)
            TaskSmartFleePed(data.entity, PlayerPedId(), 50.0, 100000, 0, 0)
            policeAlert()

            ped[data.entity] = true
            
        end
    end
    }
})


RegisterNetEvent('n-npcRob:client:openStash', function(stashID)
    exports.ox_inventory:openInventory('stash', {id=stashID})
end)

RegisterNetEvent('n-npcRob:client:policeAlert', function (pos)
	if ESX.PlayerData.job.name ~= nil then
		if ESX.PlayerData.job.name == "police" then
			ESX.ShowAdvancedNotification('911','Alert from pedestrian', 'Citizen robbery on going!', 'CHAR_CHAT_CALL', 2, false, false, 27)
			local alert = AddBlipForCoord(pos)
			SetBlipSprite(alert , 161)
			SetBlipScale(alert , 1.0)
			SetBlipColour(alert, 29)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString('Pedestrian alert')
			EndTextCommandSetBlipName(alert)
			PulseBlip(alert)
			Wait(10*1000)
			RemoveBlip(alert)
		end
	end
end)
