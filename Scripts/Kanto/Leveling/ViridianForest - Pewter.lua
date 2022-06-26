
name = "Leveling: Viridian Forest"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Viridian Forest or Pewter city.]]

local team = require "teamlib"
local maxLv = 18

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
		if getMapName() == "Pokecenter Pewter" then
			moveToCell(9,22)
		elseif getMapName() == "Pewter City" then
			moveToCell(16,55)
		elseif getMapName() == "Route 2" then
			moveToCell(10,42)	
		elseif getMapName() == "Route 2 Stop2" then
			moveToCell(4,12)
		elseif getMapName() == "Viridian Forest" then
			moveToGrass()
			--moveToRectangle(20, 17, 21, 23) --Coordinator for pikachu
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	else
		if getMapName() == "Viridian Forest" then
			moveToCell(12,15)
		elseif getMapName() == "Route 2 Stop2" then
			moveToCell(4,2)
		elseif getMapName() == "Route 2" then
			moveToCell(25,0)
		elseif getMapName() == "Pewter City" then
			moveToCell(24,35)
		elseif getMapName() == "Pokecenter Pewter" then
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
