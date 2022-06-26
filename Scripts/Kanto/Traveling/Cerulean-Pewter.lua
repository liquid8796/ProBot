
name = "Leveling: Route 4 (near Cerulean)"
author = "Liquid"
description = [[This script will travel between 2 cities: Cerulean and Pewter.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Cerulean or Pewter.]]

flag = 0
pass1 = 0

mode_catch = 0
mode_fight = 0
notfound = 0

setOptionName(1, "Cerulean-Pewter")
setOptionName(2, "Pewter-Cerulean")

function onStart()
	if getOption(1) then
		flag = 1
	elseif getOption(2) then
		flag = 3
	end
	
end
function onPathAction()

	if flag == 1 then
		if getMapName() == "Cerulean City" then
			moveToCell(0,21)
		elseif getMapName() == "Route 4" then
			moveToCell(12,14)
		elseif getMapName() == "Mt. Moon Exit" then
			moveToCell(4,5)
		elseif getMapName() == "Mt. Moon B1F" and pass1 == 0 then
			moveToCell(32,21)
		elseif getMapName() == "Mt. Moon B2F" then
			pass1 = 1
			moveToCell(38,40)
		elseif getMapName() == "Mt. Moon B1F" and pass1 == 1 then
			moveToCell(75,15)
		elseif getMapName() == "Mt. Moon 1F" then
			moveToCell(38,63)
		elseif getMapName() == "Route 3" then
			moveToCell(22,18)
		elseif getMapName() == "Pewter City" then
			flag = 2
			moveToCell(29,33)
		end
	elseif flag == 2 then
		fatal("You are now in Pewter city!")
	elseif  flag == 3 then
		if getMapName() == "Pewter City" then
			moveToRectangle(65, 32, 65, 33)
		elseif getMapName() == "Route 3" then
			moveToCell(84,16)
		elseif getMapName() == "Mt. Moon 1F" then
			moveToCell(21,20)
		elseif getMapName() == "Mt. Moon B1F" and pass1 == 0 then
			moveToCell(56,34)
		elseif getMapName() == "Mt. Moon B2F" then
			pass1 = 1
			moveToCell(17,27)
		elseif getMapName() == "Mt. Moon B1F" and pass1 == 1 then
			moveToCell(41,20)
		elseif getMapName() == "Mt. Moon Exit" then
			moveToCell(14,7)
		elseif getMapName() == "Route 4" then
			moveToCell(96,20)
		elseif getMapName() == "Cerulean City" then
			flag = 4
			moveToCell(27,19)
		end
	elseif flag == 4 then
		fatal("You are now in Cerulean city!")
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
