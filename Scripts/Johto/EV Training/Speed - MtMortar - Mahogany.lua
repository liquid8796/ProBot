-- Copyright © 2016 Silv3r <silv3r@proshine-bot.com>
-- This work is free. You can redistribute it and/or modify it under the
-- terms of the Do What The Fuck You Want To Public License, Version 2,
-- as published by Sam Hocevar. See the LICENSE file for more details.

name = "Speed EV: Mt. Mortar (near Mahogany)"
author = "Silv3r"
description = [[This script will train the first pokémon of your team.
It will only attack pokémon giving speed EV.
It will also try to capture shinies by throwing pokéballs.
Start anywhere between Mahogany Town and the Mt. Mortar.]]

function onPathAction()
	if isPokemonUsable(1) then
		if getMapName() == "Pokecenter Mahogany" then
			moveToMap("Mahogany Town")
		elseif getMapName() == "Mahogany Town" then
			moveToMap("Route 42")
		elseif getMapName() == "Route 42" then
			moveToMap("Mt. Mortar 1F")
		elseif getMapName() == "Mt. Mortar 1F" then
			moveNearExit("Route 42")
		end
	else
		if getMapName() == "Mt. Mortar 1F" then
			moveToMap("Route 42")
		elseif getMapName() == "Route 42" then
			moveToMap("Mahogany Town")
		elseif getMapName() == "Mahogany Town" then
			moveToMap("Pokecenter Mahogany")
		elseif getMapName() == "Pokecenter Mahogany" then
			usePokecenter()
		end
	end
end

function onBattleAction()
	if isWildBattle() and isOpponentShiny() then
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return
		end
	end
	if getActivePokemonNumber() == 1 and isOpponentEffortValue("Speed") then
		return attack() or run() or sendUsablePokemon() or sendAnyPokemon()
	else
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end
