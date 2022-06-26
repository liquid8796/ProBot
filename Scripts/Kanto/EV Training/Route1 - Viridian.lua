
name = "Leveling: Route 10 (near the Pokecenter)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Route 1 or Viridian city.]]

local team = require "teamlib"
local maxLv = 25

function onStart()
	return team.onStart(maxLv)
end

function onPathAction()
	while not isTeamSortedByLevelAscending() do
		return sortTeamByLevelAscending()
	end
	if team.isTrainingOver(maxLv) then
		return fatal("Complete training! Stop the bot.")
	end
	if getUsablePokemonCount() > 1 and getPokemonLevel(team.getLowestIndexOfUsablePokemon()) < maxLv then
		if getMapName() == "Pokecenter Viridian" then
			moveToCell(9,22)
		elseif getMapName() == "Viridian City" then
			moveToCell(48,61)
		elseif getMapName() == "Route 1 Stop House" then
			moveToCell(3,12)	
		elseif getMapName() == "Route 1" then
			moveToRectangle(18, 12, 25,13)
		elseif getMapName() == "Prof. Antibans Classroom" then
			log("Quiz detected, talking to the prof.")
			pushDialogAnswer(1)
			talkToNpc("Prof. Antiban")
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
			log("Quiz detected, talking to the prof.")
			pushDialogAnswer(1)
			talkToNpc("Prof. Antiban")
		end
	end
end

function onBattleAction()
	return team.onBattleFighting()
end

function onStop()
	if getOption(1) then
		return relog(2,"Restart bot after 2s")
	else
		return
	end
end

function onBattleMessage(message)
	return team.onBattleMessage(message)
end

function onDialogMessage(message)
	return team.onAntibanDialogMessage(message)
end