ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)


PlayerData = {}

function checkPlayerJob(job)

	-- this removes normal players access to the radio frequency
	exports["rp-radio"]:RemovePlayerAccessToFrequency(1)
	exports["rp-radio"]:RemovePlayerAccessToFrequency(2)


	-- this gives the access for player with certain jobs to access it
	if job.name == "police" or job.name == "offpolice" then
		exports["rp-radio"]:GivePlayerAccessToFrequency(1)
		if job.grade >= 3 then -- you can modify this so if the grade is 3 or above you can access even more frequencies
		exports["rp-radio"]:GivePlayerAccessToFrequency(2) 
    	end
	end

	-- you can add more by just simply copying the same code and changing the function parameter from 1 to other

	--[[ EXAMPLE


		
	if job.name == "nil" or job.name == "nil" then 
			exports["rp-radio"]:GivePlayerAccessToFrequency(nil)
			if job.grade >= nil then -- you can modify this so if the grade is 3 or above you can access even more frequencies
			exports["rp-radio"]:GivePlayerAccessToFrequency(nil) 
			end
	end
		]]
end

-- When the player joins the server he gets the access
RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
   PlayerData = xPlayer
  checkPlayerJob(PlayerData.job)
end)
-- When the player gets the job he gets the access
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	PlayerData.job = job
	PlayerJob = job
	checkPlayerJob(PlayerData.job)
end)

