ESX = exports["es_extended"]:getSharedObject()

local function translate(key, lang)
    lang = lang or Config.DefaultLanguage
    return Config.Translations[lang][key] or Config.Translations[Config.DefaultLanguage][key]
end


RegisterNetEvent('vipshop:requestItems', function()
    local source = source
    TriggerClientEvent('vipshop:openUI', source, Config.VIPShopItems)
end)

ESX.RegisterServerCallback('vipshop:purchase', function(source, cb, item, price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local coins = xPlayer.getInventoryItem('gold_muenze').count

    if coins >= price then
        xPlayer.removeInventoryItem('gold_muenze', price)
        xPlayer.addInventoryItem(item, 1)

        TriggerClientEvent('dilza-notify:Alert', source, translate("shop_title"), translate("purchase_success"), 5000, 'success')
        cb(true)
    else
        TriggerClientEvent('dilza-notify:Alert', source, translate("shop_title"), translate("not_enough_coins"), 5000, 'error')
        cb(false)
    end
end)

local function giveGoldCoinsToAllPlayers()
    for _, playerId in ipairs(GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(playerId)
        if xPlayer then
            xPlayer.addInventoryItem('gold_muenze', Config.GoldCoinSettings.amount)
            TriggerClientEvent('dilza-notify:Alert', playerId, 'Info', translate("gold_coins_received"), 5000, 'info')
        end
    end
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.GoldCoinSettings.intervalMinutes * 60 * 1000)
        giveGoldCoinsToAllPlayers()
    end
end)

ESX.RegisterUsableItem('tablet', function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerClientEvent('vipshop:useTablet', source)
    TriggerClientEvent('vipshop:openUI', source, Config.VIPShopItems)
end)



