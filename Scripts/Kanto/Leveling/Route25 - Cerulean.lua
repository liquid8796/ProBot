
name = "Leveling: Route 25 (near Cerulean)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Route 25 or Cerulean city.]]

local team = require "teamlib"
local maxLv = 50

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
		if getMapName() == "Pokecenter Cerulean" then
			moveToCell(9,22)
		elseif getMapName() == "Cerulean City" then
			moveToCell(39,0)
		elseif getMapName() == "Route 24" then
			moveToCell(14,0)
		elseif getMapName() == "Route 25" then
			moveToGrass()
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	else
		if getMapName() == "Route 25" then
			moveToCell(15,30)
		elseif getMapName() == "Route 24" then
			moveToCell(14,31)
		elseif getMapName() == "Cerulean City" then
			moveToCell(26,30)
		elseif getMapName() == "Pokecenter Cerulean" then
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