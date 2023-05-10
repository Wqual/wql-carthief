local blipPosition = vector3(-390.2397, 6059.2056, 31.5000)

Citizen.CreateThread(function()
    local blip = AddBlipForCoord(blipPosition.x, blipPosition.y, blipPosition.z)
        
    while true do
        Citizen.Wait(0)
        
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)
        
        if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, blipPosition.x, blipPosition.y, blipPosition.z) < 5.0 then
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                DeleteEntity(vehicle)
                TriggerServerEvent("addMoneyToInventory", math.random(14000, 23000))
            end
        end
    end
end)