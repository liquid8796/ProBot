
name = "Leveling: Fuchsia - Route 18"
author = "Liquid"
description = [[This script will train the first pokémon of your team.
It will also try to capture shinies by throwing pokéballs.
Start anywhere on Fuchsia city or Route 18.]]

mode_catch = 0
mode_carry = 0
notfound = 0

setOptionName(1, "Auto relog")

function onPathAction()
	if isPokemonUsable(1) then
		if getMapName() == "Pokecenter Fuchsia" then
			moveToCell(9,22)
		elseif getMapName() == "Fuchsia City" then
			moveToCell(0,28)
		elseif getMapName() == "Route 18" then
			moveToRectangle(31,19,34,21)
		end
	else
		if getMapName() == "Route 18" then
			moveToCell(50,17)
		elseif getMapName() == "Fuchsia City" then
			moveToCell(30,39)
		elseif getMapName() == "Pokecenter Fuchsia" then
			usePokecenter()
		end
	end
end

function onBattleAction()
	if mode_catch == 1 then
		if isWildBattle() and (isOpponentShiny() or getOpponentName() == "Murkrow") then
			fatal("Your desire pokemon has been found!")
		else
			if getActivePokemonNumber() == 1 then
				return attack() or sendUsablePokemon() or run() or sendAnyPokemon()
			else
				return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
			end
		end

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

function onStop()

	if getOption(1) then
		return relog(5,"Restart bot after 5s")
	else
		return
	end
end