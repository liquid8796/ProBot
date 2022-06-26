
name = "Leveling: Route 4 (near Cerulean)"
author = "Liquid"
description = [[This script will travel between 2 cities: Vermilion and Cerulean.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Vermilion or Cerulean.]]

flag = 0
pass1 = 0

mode_catch = 0
mode_fight = 0
notfound = 0

setOptionName(1, "Vermilion-Cerulean")
setOptionName(2, "Cerulean-Vermilion")

function onStart()
	if getOption(1) then
		flag = 1
	elseif getOption(2) then
		flag = 3
	end
	useItem("Blue Bicycle")
end
function onPathAction()
	
	if flag == 1 then
		if getMapName() == "Vermilion City" then
			moveToCell(42,0)
		elseif getMapName() == "Route 6" then
			moveToCell(36,18)
		elseif getMapName() == "Underground House 2" then
			moveToCell(9,3)
		elseif getMapName() == "Underground2" then
			moveToCell(3,3)
		elseif getMapName() == "Underground House 1" then
			moveToCell(5,10)
		elseif getMapName() == "Route 5" then
			moveToCell(28,0)
		elseif getMapName() == "Cerulean City" then
			flag = 2
			moveToCell(31,20)
		end
	elseif flag == 2 then
		fatal("You are now in Cerulean city!")
	elseif  flag == 3 then
		if getMapName() == "Cerulean City" then
			moveToCell(24,50)	
		elseif getMapName() == "Route 5" then
			moveToCell(27,29)
		elseif getMapName() == "Underground House 1" then
			moveToCell(9,3)		
		elseif getMapName() == "Underground2" then
			moveToCell(3,43)
		elseif getMapName() == "Underground House 2" then
			moveToCell(5,10)	
		elseif getMapName() == "Route 6" then
			moveToCell(23,61)
		elseif getMapName() == "Vermilion City" then
			flag = 4
			moveToCell(36,23)
		end
	elseif flag == 4 then
		fatal("You are now in Vermilion city!")
	end
	
end

function onBattleAction()
	if mode_catch == 1 then
		if isWildBattle() and (isOpponentShiny() or getOpponentName() == "Pineco") then
			fatal("Your desire pokemon has been found!")
		else
			if getActivePokemonNumber() == 1 then
				return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
			else
				return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
			end
		end

	else
		if mode_fight == 0 then
			return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
		else
			if isWildBattle() and isOpponentShiny() then
				if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
					return
				end
			end
			if getActivePokemonNumber() == 1 then
				return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
			else
				return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
			end
		end
	end
end
