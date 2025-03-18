ESX = exports["es_extended"]:getSharedObject()

local isUsingTablet = false -- Variable, um den Status der Tablet-Nutzung zu verfolgen

RegisterNetEvent('vipshop:useTablet')
AddEventHandler('vipshop:useTablet', function()
    local playerPed = PlayerPedId()

    -- Animation abspielen
    isUsingTablet = true -- Status setzen
    RequestAnimDict("cellphone@") -- Animations-Dictionary anfordern

    while not HasAnimDictLoaded("cellphone@") do
        Citizen.Wait(0) -- Warten, bis das Dictionary geladen ist
    end

    -- Starte die Animation in einer Schleife
    TaskPlayAnim(playerPed, "cellphone@", "cellphone_text_in", 8.0, -8.0, -1, 50, 0, false, false, false)

    -- UI öffnen
    TriggerEvent('vipshop:requestItems')

    -- Warten, bis die UI geschlossen wird
    while isUsingTablet do
        Citizen.Wait(0) -- Halte die Schleife aktiv
    end

    -- Stoppe die Animation, wenn die UI geschlossen wird
    ClearPedTasks(playerPed)
end)

RegisterNUICallback('closeShop', function(data, cb)
    SetNuiFocus(false, false)
    isUsingTablet = false -- Status zurücksetzen, UI wurde geschlossen
    SendNUIMessage({
        action = "closeShop"
    })
    cb('ok')
end)




RegisterNetEvent('vipshop:openUI', function(items)
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openShop",
        items = items
    })
end)


RegisterNUICallback('closeShop', function(data, cb)
    SetNuiFocus(false, false)
    cb('ok')
end)

RegisterNUICallback('buyItem', function(data, cb)
    ESX.TriggerServerCallback('vipshop:purchase', function(success)
        if success then

        else

        end
    end, data.item, data.price)
end)

AddEventHandler('onClientResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetNuiFocus(false, false)
        SendNUIMessage({
            action = "closeShop"
        })
    end
end)

RegisterCommand('openvipshop', function()
    TriggerServerEvent('vipshop:requestItems')
end)

RegisterCommand('closevipshop', function()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeShop"
    })
end)

RegisterNUICallback('closeShop', function(data, cb)
    SendNUIMessage({
        action = "closeShop"
    })
    cb('ok')
end)



-------- TARGETING DEAKTIVIERN


local inVehicle = false
local nearGate = false

-- Funktion zum Finden des nächsten Tors
local function FindNearestGate()
    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local objects = GetGamePool('CObject')
    
    for _, object in ipairs(objects) do
        local model = GetEntityModel(object)
        local modelName = GetEntityArchetypeName(object)
        if modelName == "model_biggate_wood" or modelName == "model_biggateway_wood" then
            local objectCoords = GetEntityCoords(object)
            local distance = #(playerCoords - objectCoords)
            if distance <= 15.0 then
                return true
            end
        end
    end
    
    return false
end

-- Hauptthread zur Überprüfung des Fahrzeugstatus und Targeting
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(500)  -- Überprüfe alle 500ms
        local playerPed = PlayerPedId()
        
        -- Überprüfen, ob der Spieler in einem Fahrzeug sitzt
        if IsPedInAnyVehicle(playerPed, false) then
            if not inVehicle then
                inVehicle = true
            end
            
            -- Überprüfen, ob sich der Spieler in der Nähe eines Tors befindet
            nearGate = FindNearestGate()
            
            -- Targeting nur aktivieren, wenn in der Nähe eines Tors
            if nearGate then
                exports['ox_target']:disableTargeting(false)  -- Aktiviert ox_target
            else
                exports['ox_target']:disableTargeting(true)   -- Deaktiviert ox_target
            end
        else
            if inVehicle then
                inVehicle = false
                exports['ox_target']:disableTargeting(false)  -- Aktiviert ox_target beim Verlassen des Fahrzeugs
            end
        end
    end
end)