RegisterServerEvent("addMoneyToInventory")
AddEventHandler("addMoneyToInventory", function(amount)
    local src = source
    local player = ESX.GetPlayerFromId(src)
    local item = {"black_money"}
    exports.ox_inventory:AddItem(source, item[math.random(#item)],amount)
end)
