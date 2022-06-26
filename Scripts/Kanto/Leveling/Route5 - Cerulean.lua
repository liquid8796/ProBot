
name = "Leveling: Route 5 (near Cerulean)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Cerulean City and Route 5.]]

local team = require "teamlib"
local maxLv = 50
local list_route_5 = ""

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
	if getUsablePokemonCount() > 1 
		and (getPokemonLevel(team.getLowestIndexOfUsablePokemon()) < maxLv
		or team.isSearching())
	then
		if getMapName() == "Pokecenter Vermilion" then
			moveToCell(9,22)
		elseif getMapName() == "Cerulean City" then
			moveToCell(17,50)
		elseif getMapName() == "Route 5" then
			moveToGrass()
		elseif getMapName() == "Prof. Antibans Classroom" then
			log("Quiz detected, talking to the prof.")
			pushDialogAnswer(1)
			talkToNpc("Prof. Antiban")
		end
	else
		if getMapName() == "Route 5" then
			moveToCell(28,0)
		elseif getMapName() == "Cerulean City" then
			moveToCell(26,30)
		elseif getMapName() == "Pokecenter Vermilion" then
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
