
name = "Leveling: Route 1 (near Viridian city)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Route 1 or Viridian city.]]

local team = require "teamlib"
local maxLv = 10

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
		if getMapName() == "Pokecenter Viridian" then
			moveToCell(9,22)
		elseif getMapName() == "Viridian City" then
			moveToCell(48,61)
		elseif getMapName() == "Route 1 Stop House" then
			moveToCell(3,12)	
		elseif getMapName() == "Route 1" then
			moveToGrass()
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	else
		if getMapName() == "Route 1" then
			moveToCell(14,4)
		elseif getMapName() == "Route 1 Stop House" then
			moveToCell(4,2)
		elseif getMapName() == "Viridian City" then
			moveToCell(44,43)
		elseif getMapName() == "Pokecenter Viridian" then
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