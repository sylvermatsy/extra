ESX = nil
CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(1000)
    end
end)

open = false
local mainMenu = RageUI.CreateMenu("Extras", "Interaction")
mainMenu.Closed = function() 
    open = false 
end

local function openextramenu()
    if open then 
        open = false 
        RageUI.Visible(mainMenu, false)
        return 
    else
        open = true 
        RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do 

                RageUI.IsVisible(mainMenu, function()

                    local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))

                    local liveryCount = GetVehicleLiveryCount(vehicle)
    
    
    
                    RageUI.Separator("~r~Livery(s)")
    
                        for i = 1, liveryCount do
    
                            local state = GetVehicleLivery(vehicle) 
    
    
                            if state == i then
    
                                -- RageUI.ButtonWithStyle("Livery: "..i, nil, {RightLabel = "~g~ON"}, true, function(Hovered, Active, Selected)
    
                                --     if (Selected) then   
    
                                --         SetVehicleLivery(vehicle, i, not state)
    
                                --     end      
    
                                -- end)

                                RageUI.Button("~g~[ON]~s~ | Livery: "..i, nil, {}, true, {
                                    onSelected = function()
                                        SetVehicleLivery(vehicle, i, not state)
                                    end
                                })
    
                            else
    
                                -- RageUI.ButtonWithStyle("Livery: "..i, nil, {RightLabel = "~r~OFF"}, true, function(Hovered, Active, Selected)
    
                                --     if (Selected) then
    
                                --         SetVehicleLivery(vehicle, i, state)
    
                                --     end      
    
                                -- end)

                                RageUI.Button("~r~[OFF]~s~ | Livery: "..i, nil, {}, true, {
                                    onSelected = function()
                                        SetVehicleLivery(vehicle, i, state)
                                    end
                                })
    
                            end
    
                        end
    
    
    
                    RageUI.Separator("~b~Extra(s)")
    
    
    
                    for id=0, 12 do
    
                            if DoesExtraExist(vehicle, id) then
    
                                local state2 = IsVehicleExtraTurnedOn(vehicle, id)
    
                            if state2 then
    
                                -- RageUI.ButtonWithStyle("Extra: "..id, nil, {RightLabel = "~g~ON"}, true, function(Hovered, Active, Selected)
    
                                --     if (Selected) then   
    
                                --         SetVehicleExtra(vehicle, id, state2)
    
                                --     end      
    
                                -- end)

                                RageUI.Button("~g~[ON]~s~ | Extra: "..id, nil, {}, true, {
                                    onSelected = function()
                                        SetVehicleExtra(vehicle, id, state2)
                                    end
                                })
    
                            else

                                RageUI.Button("~r~[OFF]~s~ | Extra: "..id, nil, {}, true, {
                                    onSelected = function()
                                        SetVehicleExtra(vehicle, id, state2)
                                    end
                                })
    
                                -- RageUI.ButtonWithStyle("Extra: "..id, nil, {RightLabel = "~r~OFF"}, true, function(Hovered, Active, Selected)
    
                                --     if (Selected) then
    
                                --         SetVehicleExtra(vehicle, id, state2)
    
                                --     end
    
                                -- end)
    
                            end
    
                        end
    
                    end
                end)
                Wait(0)
            end
        end)
    end
end

RegisterCommand("extramenu", function() openextramenu() end)
RegisterKeyMapping('extramenu', 'Menu Extra', 'keyboard', 'EQUALS')