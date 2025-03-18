Config = {}

Config.VIPShopItems = {

    {label = "Schatzkiste", item = "schatzkiste", price = 2500, img = "schatzkiste.png"},  -- {label = "LABEL_IN_UI", item = "FROM_INVENTORY", price = HOW_MUCH_COINS, img = "ITEM.png"},
    {label = "Ammobox 9mm", item = "ammobox-9", price = 250, img = "ammobox-9.png"},
    {label = "Ammobox 5.56x45", item = "ammobox-rifle", price = 250, img = "ammobox-rifle.png"},
    {label = "Ammobox Schrot", item = "ammobox-shotgun", price = 300, img = "ammobox-shotgun.png"},
    {label = "VIP Schatzkiste", item = "schatzkistevip", price = 5000, img = "schatzkistevip.png"},
    {label = "Satanskreuz", item = "satanskreuz", price = 10000, img = "satanskreuz.png"},
    {label = "Airdrop Transmitter", item = "transmitter", price = 3000, img = "transmitter.png"},
    {label = "Kompakt Gewehr", item = "WEAPON_COMPACTRIFLE", price = 4000, img = "WEAPON_COMPACTRIFLE.png"},
    {label = "Doppellauf Flinte", item = "WEAPON_DBSHOTGUN", price = 4200, img = "WEAPON_DBSHOTGUN.png"},
    {label = "Schwere Schrotflinte", item = "WEAPON_HEAVYSHOTGUN", price = 3200, img = "WEAPON_HEAVYSHOTGUN.png"},
    {label = "Tec-9", item = "WEAPON_MACHINEPISTOL", price = 3000, img = "WEAPON_MACHINEPISTOL.png"},

--YOU CAN ADD MORE HERE OR CHANGE THE OTHER ONE  ONLY ITEMS WILL GO THE RESOURCE IS STILL IN DEVELOPMENT!!!

    --{label = "Schatzkiste", item = "schatzkiste", price = 2500, img = "schatzkiste.png"},
}

Config.GoldCoinSettings = {   -- every 60 min. all Players will recive 50 Gold Coins for Activity
    amount = 50,          -- How much coins you want to give to your Players for Activity  if u dont need this set it to 0
    intervalMinutes = 60  -- Intervall in Minutes to give Coins
}

Config.DefaultLanguage = "de" -- choose your Language here

Config.Translations = {
    ["de"] = {
        shop_title = 'COIN SHOP',
        purchase_success = 'Kauf erfolgreich!',
        not_enough_coins = 'Du hast nicht genug Gold Münzen!',
        gold_coins_received = 'Du hast für deine Aktivität Gold Münzen erhalten!',
    },
    ["en"] = {
        shop_title = 'COIN SHOP',
        purchase_success = 'Purchase successful!',
        not_enough_coins = 'You do not have enough Gold Coins!',
        gold_coins_received = 'You have received Gold Coins for your activity!',
    },
    -- you can add more locals here
}