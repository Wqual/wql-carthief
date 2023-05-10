ESX = exports["es_extended"]:getSharedObject()

Citizen.CreateThread(function()
    if not HasModelLoaded('s_m_y_dealer_01') then
       RequestModel('s_m_y_dealer_01')
       while not HasModelLoaded('s_m_y_dealer_01') do
          Citizen.Wait(5)
       end
    end

npc = CreatePed(4, 's_m_y_dealer_01', 1275.4928, -1710.6118, 53.7714, 111.0233, false, true)
FreezeEntityPosition(npc, true)
SetEntityInvincible(npc, true)
SetBlockingOfNonTemporaryEvents(npc, true)


CreateThread(function()
   while true do
       Sleep = 1000
           local ped = PlayerPedId()
           local plyCords = GetEntityCoords(ped)
           local coords = vector3(1275.4928, -1710.6118, 53.7714 + 2)
           local dist = #( plyCords - coords)
           if dist < 5 then
               Sleep = 0
               SetFloatingHelpTextWorldPosition(1, coords)
               SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
               BeginTextCommandDisplayHelp("Indicazione1")
               EndTextCommandDisplayHelp(2, false, false, -1)
           end
       Wait(Sleep)
   end
end)

local options = {
   {
       name = 'ox:option1',
       icon = 'fa-solid fa-road',
       label = '🔐 Ruba un veicolo',
       onSelect = function() 
        TriggerServerEvent("checkauto")
       end,
   }
}

exports.ox_target:addLocalEntity(npc,options)

end)

RegisterNetEvent("checkauto", function() 
    Wqual()
end)

local random = {
    vector3 (-373.2228, 2956.7563, 25.0152),
    vector3 (1097.9977, -2402.0002, 30.6892),
    vector3 (-585.3372, -1781.8192, 22.6961),
    vector3 (-2985.3604, 336.0064, 14.7268),
    vector3 (-390.2397, 6059.2056, 31.5000)
}


Wqual = function()
    lavoro = true
    ESX.Game.SpawnVehicle('cheetah', vector3(1282.5558, -1732.1664, 52.7154), 85.29, function(v)
        SetPedIntoVehicle(PlayerPedId(), v, -1)
    end)
    ESX.ShowNotification('Raggiungi il punto di consegna!')
    
    local posizione = random[math.random(1, #random)]

    waypoint5 = SetNewWaypoint(posizione)
    Wql = AddBlipForCoord(posizione)
    SetBlipSprite (Wql, 353)
    SetBlipDisplay(Wql, 6)
    SetBlipScale  (Wql, 0.9)
    SetBlipColour (Wql, 1)
    SetBlipAsShortRange(Wql, true)

    BeginTextCommandSetBlipName('STRING')
    AddTextComponentString("Punto di consegna")
    EndTextCommandSetBlipName(Wql)

    while true do
        Citizen.Wait(0)
        
        local playerPed = GetPlayerPed(-1)
        local playerCoords = GetEntityCoords(playerPed)
        
        if Vdist(playerCoords.x, playerCoords.y, playerCoords.z, posizione.x, posizione.y, posizione.z) < 5.0 then
            if IsPedInAnyVehicle(playerPed, false) then
                local vehicle = GetVehiclePedIsIn(playerPed, false)
                DeleteEntity(vehicle)
                TriggerServerEvent("addMoneyToInventory", math.random(14000, 23000))
                RemoveBlip(Wql)
                print("ciao")
            end
        end
    end
end
