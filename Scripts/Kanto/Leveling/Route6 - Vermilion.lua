
name = "Leveling: Route 6 (near Vermilion)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Vermilion City and Route 6.]]

local team = require "teamlib"
local maxLv = 50
local list_1 = "27-53,37-45,36-31,13-30,13-23,26-23,26-21,34-21,34-25"
local list_2 = "36-31,25-31,25-30,14-32,14-23,16-22,21-22,26-22,36-23,38-40,36-40"

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
			moveToCell(43,0)
		elseif getMapName() == "Route 6" then
			--moveToGrass()
			moveToListCell(list_1,list_2)
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	else
		if getMapName() == "Route 6" then
			moveToCell(23,61)
		elseif getMapName() == "Vermilion City" then
			moveToCell(27,21)
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