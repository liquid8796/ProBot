
name = "Leveling: Route 9 (near Route 10)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Route 10 and RockTunnel.]]

local team = require "teamlib"
local maxLv = 100

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
		elseif getMapName() == "Route 10" then
			moveToCell(22,0)
		elseif getMapName() == "Route 9" then
			moveToGrass()
		end
	else
		if getMapName() == "Route 9" then
			moveToCell(86,33)
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