
name = "Leveling: Graveyard (near Vermilion)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Vermilion City and Vermilion City Graveyard.]]

local team = require "teamlib"
local maxLv = 45
local listVermilion_1 = "36-22,36-19,38-19,38-11,43-11,43-0"
local listVermilion_2 = "43-11,38-11,38-22,27-21"

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
		if getMapName() == "Pokecenter Vermilion" then
			moveToCell(9,22)
		elseif getMapName() == "Vermilion City" then
			moveToListCell(listVermilion_1)
		elseif getMapName() == "Route 6" then
			moveToCell(0,52)
		elseif getMapName() == "Vermilion City Graveyard" then
			moveToGrass()
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