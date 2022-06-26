
name = "Leveling: Route 6 (near Vermilion)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Vermilion City and Route 6.]]

local team = require "teamlib"
local maxLv = 100
local listVermilion_1 = "36-22,36-19,38-19,38-11,43-11,43-0"
local listVermilion_2 = "43-11,38-11,38-22,27-21"
local list_1_1 = "27-53,27-45,36-45,36-31,13-30,13-23,26-23,26-21,34-21,34-25,34-45,23-45,23-50,19-50,19-52,0-52"
local list_1_2 = "19-53,23-50,23-45,36-45,36-31,13-30,13-23,26-23,26-21,34-21,34-25,34-45,23-45,23-50,19-50,19-52,0-52"
local list_2 = "57-32,57-34,53-34,53-35,52-35,52-36,43-36,43-30,42-30,42-26,32-19,32-28,42-27,42-36,52-36,55-33,60-33"

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
		x = getPlayerX()
		y = getPlayerY()
		if getMapName() == "Pokecenter Vermilion" then
			moveToCell(9,22)
		elseif getMapName() == "Vermilion City" then
			moveToListCell(listVermilion_1)
		elseif getMapName() == "Route 6" then
			if x == 0 and y == 53 then
				moveToListCell(list_1_2)
			else
				moveToListCell(list_1_1)
			end
		elseif getMapName() == "Vermilion City Graveyard" then
			moveToListCell(list_2)	
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	else
		if getMapName() == "Vermilion City Graveyard" then
			moveToCell(60,33)		
		elseif getMapName() == "Route 6" then
			moveToCell(23,61)
		elseif getMapName() == "Vermilion City" then
			moveToListCell(listVermilion_2)
		elseif getMapName() == "Pokecenter Vermilion" then
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