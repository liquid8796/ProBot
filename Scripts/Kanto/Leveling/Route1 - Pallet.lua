
name = "Leveling: Route 1 - PalletTown"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Route 1 or PalletTown.]]

local team = require "teamlib"
local maxLv = 7

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
		if getMapName() == "Player Bedroom Pallet" then
			moveToCell(12,4)
		elseif getMapName() == "Player House Pallet" then
			moveToCell(4,10)
		elseif getMapName() == "Pallet Town" then
			moveToCell(13,0)
		elseif getMapName() == "Route 1" then
			--moveToRectangle(13, 48, 16, 49)
			moveToGrass()
		elseif getMapName() == "Prof. Antibans Classroom" then
			log("Quiz detected, talking to the prof.")
			pushDialogAnswer(1)
			talkToNpc("Prof. Antiban")
		end
	else
		if getMapName() == "Route 1" then
			moveToCell(15,50)
		elseif getMapName() == "Pallet Town" then
			moveToCell(6,12)
		elseif getMapName() == "Player House Pallet" then
			talkToNpcOnCell(7,6)
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