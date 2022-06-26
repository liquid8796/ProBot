
name = "Leveling: Route 10 (near RockTunnel)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Route 10 and RockTunnel.]]

local team = require "teamlib"
local maxLv = 100
local list1 = "<:44->:8?&&,>:34-<:17?&&"
local list2 = ">:35-<:17?&&,<:38->:10?&&,>:5-<:11?||"
local list3 = ">:6->:6?&&,<:28-<:16?&&"
local list4 = ">:7->:12?&&,<:27-<:27?&&"
local list5 = ">:5-<:32?&&,<:23->:21?&&"

local half = 0
function onStart()	
	return team.onStart(maxLv)
end

function onPathAction()
	while not isTeamSortedByLevelAscending() and getOption(4) do
		return sortTeamByLevelAscending()
	end
	if team.isTrainingOver(maxLv) and not team.isSearching() then
		return logout("Complete training! Stop the bot.")
	end
	if team.useLeftovers() then
		return
    end
	if getUsablePokemonCount() > 1 
		and (getPokemonLevel(team.getLowestIndexOfUsablePokemon()) < maxLv
		or team.isSearching())
	then	
		if getMapName() == "Pokecenter Route 10" then		
			moveToCell(9,22)
		elseif getMapName() == "Route 10" and not isInArea(">:1->:43?&&") then
			half = 0
			return moveToListCell("18-10,14-10,14-11,20-10,11-5")
		elseif getMapName() == "Route 10" and isInArea(">:1->:43?&&") then
			half = 1							
			return moveToCell(5,44)
		end
		if half == 0 then			
			if getMapName() == "Rock Tunnel 1" and isInArea(list1) then
				moveToCell(35,16)
			elseif getMapName() == "Rock Tunnel 2" and isInArea(list2) then
				moveToCell(7,5)
			elseif getMapName() == "Rock Tunnel 1" and isInArea(list3) then
				moveToCell(8,15)
			elseif getMapName() == "Rock Tunnel 2" and isInArea(list4) then
				moveToCell(8,26)
			elseif getMapName() == "Rock Tunnel 1" and isInArea(list5) then
				return moveToListCell("19-27,20-22,7-22,7-24,20-22,21-32")
			elseif getMapName() == "Prof. Antibans Classroom" then
				return team.antibanclassroom()
			end
		end
		if half == 1 then
			if getMapName() == "Rock Tunnel 1" and isInArea(list5) then
				moveToCell(7,30)
			elseif getMapName() == "Rock Tunnel 2" and isInArea(list4) then
				moveToCell(10,13)
			elseif getMapName() == "Rock Tunnel 1" and isInArea(list3) then
				moveToCell(7,7)
			elseif getMapName() == "Rock Tunnel 2" and isInArea(list2) then
				moveToCell(36,16)
			elseif getMapName() == "Rock Tunnel 1" and isInArea(list1) then
				moveToCell(43,11)							
			elseif getMapName() == "Prof. Antibans Classroom" then
				return team.antibanclassroom()
			end
		end
	else
		if getMapName() == "Rock Tunnel 1" and isInArea(list5) then
			moveToCell(7,30)
		elseif getMapName() == "Rock Tunnel 2" and isInArea(list4) then
			moveToCell(10,13)
		elseif getMapName() == "Rock Tunnel 1" and isInArea(list3) then
			moveToCell(7,7)
		elseif getMapName() == "Rock Tunnel 2" and isInArea(list2) then
			moveToCell(36,16)	
		elseif getMapName() == "Rock Tunnel 1" and isInArea(list1) then
			moveToCell(43,11)
		elseif getMapName() == "Route 10" then
			moveToCell(18,4)
		elseif getMapName() == "Pokecenter Route 10" then
			usePokecenter()
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	end
end

function onBattleAction()
	return team.onBattleFighting()
end

function onStop()
	return team.onStop()
end

function onBattleMessage(message)
	return team.onBattleMessage(message)
end

function onDialogMessage(message)
	return team.onAntibanDialogMessage(message)
end

function onSystemMessage(message)
	return team.onSystemMessage(message)
end