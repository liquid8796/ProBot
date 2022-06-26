
name = "Leveling: Graveyard (near Vermilion)"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Vermilion City and Vermilion City Graveyard.]]

local team = require "teamlib"
local maxLv = 42
local list = 
{
[42]=15,
[37]=12,
}
function onStart()
	return team.onStart(maxLv)
end

function onPathAction()
	relog(5, "test relog")
	if getUsablePokemonCount() > 1 
		and (getPokemonLevel(team.getLowestIndexOfUsablePokemon()) < maxLv
		or team.isSearching())
	then
		if getMapName() == "Pokecenter Vermilion" then
			moveToCell(9,22)
		elseif getMapName() == "Vermilion City" then
			local x = getPlayerX()
			local y = getPlayerY()
			if x<=27 and y>=21 then
				moveToCell(36,21)
			elseif x>27 and x<=36 and y>=21 then
				moveToCell(36,19)
			elseif x>27 and x<=36 and y>=19 and y<21 then
				moveToCell(38,19)
			elseif x>36 and x<=38 and y>=19 and y<21 then
				moveToCell(38,11)
			elseif x>36 and x<=38 and y>=11 and y<19 then
				moveToCell(43,11)
			elseif x>38 and x<=43 and y>=11 and y<19 then
				moveToCell(43,0)
			end
		elseif getMapName() == "Route 6" then
			moveToCell(0,52)
		elseif getMapName() == "Vermilion City Graveyard" then
			moveToListCell(list)
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	else
		if getMapName() == "Vermilion City Graveyard" then
			moveToCell(60,33)
		elseif getMapName() == "Route 6" then
			moveToCell(23,61)
		elseif getMapName() == "Vermilion City" then
			local x = getPlayerX()
			local y = getPlayerY()
			if x>=43 and y<=1 then
				moveToCell(43,11)
			elseif x>=43 and y>1 and y<=11 then
				moveToCell(38,11)
			elseif x>=38 and x<43 and y>1 and y<=11 then
				moveToCell(38,22)
			elseif x<=38 and y>11 and y<=22 then
				moveToCell(27,21)
			end
		elseif getMapName() == "Pokecenter Vermilion" then
			usePokecenter()
		elseif getMapName() == "Prof. Antibans Classroom" then
			return team.antibanclassroom()
		end
	end
end

function onBattleAction()
	return run()
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