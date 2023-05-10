local checkauto = false

RegisterNetEvent("checkauto", function() 
    if not checkauto then
        checkauto = true
        TriggerClientEvent("checkauto", source)
        local minuti = 60 * 1000
        Wait (20 * minuti)
        checkauto = false
    else
        TriggerClientEvent("aziz_notifica:manda", source, "Devi aspettare un po'...")
    end 
end)

