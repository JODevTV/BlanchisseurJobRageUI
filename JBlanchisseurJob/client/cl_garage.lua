local CurrentActionData         = {}
RMenu.Add('blanchisseur', 'main', RageUI.CreateMenu("Garage", "Pour sortir un vehicule."))
RMenu.Add('blanchisseur', 'voiture', RageUI.CreateMenu("Garage", "Sélectionne un Vehicule"))

Citizen.CreateThread(function()
    while true do
        RageUI.IsVisible(RMenu:Get('blanchisseur', 'main'), true, true, true, function() 
            RageUI.Button("Sultan", nil, {},true, function(Hovered, Active, Selected)
                if (Selected) then
                spawnuniCar("sultan")
                RageUI.CloseAll()
                end
            end)

			RageUI.Button("Kuruma", nil, {},true, function(Hovered, Active, Selected)
                if (Selected) then
                spawnuniCar("kuruma")
                RageUI.CloseAll()
                end
            end)
            

            
        end, function()
        end)
    Citizen.Wait(0)
        end
    end)

Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    

    
                local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
                local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.garage.position.x, Config.pos.garage.position.y, Config.pos.garage.position.z)
                DrawMarker(20, 1130.32, -1304.86, 34.74, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
            if dist3 <= 3.0 then
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'blanchisseur' then    
                    ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] pour accéder au garage")
                    if IsControlJustPressed(1,51) then           
                        RageUI.Visible(RMenu:Get('blanchisseur', 'main'), not RageUI.Visible(RMenu:Get('blanchisseur', 'main')))
                    end   
                end
               end
        end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)



            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Config.pos.Return.position.x, Config.pos.Return.position.y, Config.pos.Return.position.z)
            DrawMarker(20, 1136.43, -1273.97 ,33.57+1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 0, 255, 255, 0, 1, 2, 0, nil, nil, 0)
        if dist3 <= 3.0 then
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'blanchisseur' then    
                ESX.ShowHelpNotification("Appuyez sur [~b~E~w~] rentrer votre vehicule")
                if IsControlJustPressed(1,51) then           
                    local veh,dist4 = ESX.Game.GetClosestVehicle(playerCoords)
                    if dist4 < 4 then
                        DeleteEntity(veh)
                    end 
                end   
            end
           end 
    end
end)

function spawnuniCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Config.pos.spawnvoiture.position.x, Config.pos.spawnvoiture.position.y, Config.pos.spawnvoiture.position.z, Config.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "QUARTIER"..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1) 
end


