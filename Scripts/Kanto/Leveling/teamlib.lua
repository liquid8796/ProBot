local listPokemon = require "listPokemon"
local ev = require "listEVs"
local mountList = require "mountList"
local timeLeft = 0

team = {}
local ran = 1
local isMount = true
local isMoveBlocked = false
local isCanSwitch = True

function team.onStart(maxLv)
	setOptionName(1, "Auto restart")
	setOptionName(2, "EVs training")
	setOption(2, true)
	setOptionName(3, "Only search")
	setOptionName(4, "Sorting mode")
	setOption(4, true)
	setOptionName(5, "Team combat")
	setOption(5, true)
	setLoadingMapTimeout(1200)
	closeAllChannel()
	if isMount then
		for key, mount in ipairs(mountList) do
			if hasItem(mount) then
				setMount(mount)
				break
			end
		end
	end
	log("Training pokemon until reach level "..maxLv)
	--for longer botting runs
	return disablePrivateMessage()
end

function team.onBattleFighting()
	local isTeamUsable = getTeamSize() == 1 --if it's our starter, it has to atk
		or getUsablePokemonCount() > 1		--otherwise we atk, as long as we have 2 usable pkm	
	if isTeamUsable then
		local huntCondition = isWildBattle() and (isOpponentShiny() or team.isInListPokemon(listPokemon, getOpponentName()))
		local opponentLevel = getOpponentLevel()
		local myPokemonLvl  = getPokemonLevel(getActivePokemonNumber())
		if isMoveBlocked then
			return team.antiMoveBlocked()
		end
		if not isCanSwitch then
			if sendUsablePokemon() or sendAnyPokemon() or useAnyMove() or run() then
				isCanSwitch = true
				return
			end
		end
		if getOption(3) and huntCondition then
			if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
				return log("Try to catch "..getOpponentName())
			end
		elseif getOption(3) and not huntCondition then
			return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
		end
		if opponentLevel >= myPokemonLvl and getOption(5) and not huntCondition then
			local requestedId, requestedLevel = team.getMaxLevelUsablePokemon()
			if requestedLevel > myPokemonLvl and requestedId ~= nil	then 
				return sendPokemon(requestedId) 
			end
		end	
		if getOption(2) then
			local listEVs = ev.getListEVs("Atk")
			if team.isInList(listEVs, getOpponentName()) or huntCondition then
				return team.doHunting(huntCondition)
			else
				return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
			end
		end
		team.doHunting(huntCondition)
	else
		--relog(1,"Restart for healing!")
		return run() or attack() or sendUsablePokemon() or sendAnyPokemon()
	end
end

function team.doHunting(hunt_condition)
	if hunt_condition then		
		if useItem("Ultra Ball") or useItem("Great Ball") or useItem("Pokeball") then
			return
		else
			return attack() or sendUsablePokemon() or sendAnyPokemon() or run() 
		end
	else
		return attack() or useAnyMove() or sendUsablePokemon() or sendAnyPokemon() or run()
	end	
end

function team.isSearching()
	return getOption(3)
end

function team.antiMoveBlocked()
	if isWildBattle() then
		if run() or sendAnyPokemon() or useAnyMove() then
			isMoveBlocked = false
			return log("Unstuck from battle")
		else
			log("Stuck in battle")
		end
	else
		if sendUsablePokemon() or sendAnyPokemon() or useAnyMove() then
			isMoveBlocked = false
			return log("Unstuck from battle")
		else
			log("Stuck in battle")
		end
	end	
end

function team.getLowestIndexOfUsablePokemon()
	local size = getTeamSize()
	for i=1,size do
		if isPokemonUsable(i) then
			return i
		end
	end
	return size
end
function team.isTrainingOver(maxLv)
	local count = 0
	local size = getTeamSize()
	for i=1,size do
		if getPokemonLevel(i) >= maxLv then
			count = count + 1
		end
	end
	if count < size and not getOption(3) then return false end
	return true
end
function team.getMaxLevelUsablePokemon()
	local currentId
	local currentLevel
	for pokemonId=1, getTeamSize(), 1 do
		local pokemonLevel = getPokemonLevel(pokemonId)
		if  (currentLevel == nil or pokemonLevel > currentLevel)
			and isPokemonUsable(pokemonId) then
			currentLevel = pokemonLevel
			currentId    = pokemonId
		end
	end
	return currentId, currentLevel
end
function team.addListToFile(list, path)
	local line = "local listPokemon = \n{"
	for key, value in pairs(list) do		
        line = line .. "\n['"..key.."']="..value..","
    end
	line = line .. "\n}\nreturn listPokemon"
	writeToFile(path, line, true)
end
function team.isInListPokemon(list, val)
    for key, value in pairs(list) do		
        if key == val and value < 2 then
            return true
        end
    end
    return false
end
function team.isInList(list, val)
	for key, value in ipairs(list) do		
        if value == val then
            return true
        end
    end
	return false
end
function split(str, sep)
   local result = {}
   local regex = ("([^%s]+)"):format(sep)
   for each in str:gmatch(regex) do
      table.insert(result, each)
   end
   return result
end
function team.getFirstUsablePokemon()
	for i=1, getTeamSize(), 1 do
		if isPokemonUsable(i) then
			return i
		end
	end
	return 0
end
function team.getPokemonIdWithItem(ItemName)	
	for i=1, getTeamSize(), 1 do
		if getPokemonHeldItem(i) == ItemName then
			return i
		end
	end
	return 0
end
function team.useLeftovers()
	ItemName = "Leftovers"
	local PokemonNeedLeftovers = team.getFirstUsablePokemon()
	local PokemonWithLeftovers = team.getPokemonIdWithItem(ItemName)
	
	if getTeamSize() > 0 then
		if PokemonWithLeftovers > 0 then
			if PokemonNeedLeftovers == PokemonWithLeftovers  then
				return false -- now leftovers is on rightpokemon
			else
				takeItemFromPokemon(PokemonWithLeftovers)
				return true
			end
		else

			if hasItem(ItemName) and PokemonNeedLeftovers ~= 0 then
				giveItemToPokemon(ItemName,PokemonNeedLeftovers)
				return true
			else
				return false
			end
		end
	else
		return false
	end
end
function team.delay(waitTime)
    timer = os.time()
	log((waitTime-os.time()-timer).."s remaining...")
    repeat until os.time() > timer + waitTime
end

function team.onBattleMessage(message)
	if stringContains(message, "This move is disabled") then
		isMoveBlocked = true
	end
	if stringContains(message, "You can not switch this Pokemon") then
		isCanSwitch = false
	end
	if stringContains(message, "caught") and not isOpponentShiny() then
		listPokemon[getOpponentName()] = listPokemon[getOpponentName()] + 1
		log(getItemQuantity("Pokeball").." pokeballs left")
		team.addListToFile(listPokemon, "D:\\ProScript\\Scripts\\Kanto\\Leveling\\listPokemon.lua")
		--team.addListToFile(listPokemon, "C:\\ProScript\\Scripts\\Kanto\\Leveling\\listPokemon.lua")
	end
end
function team.onStop()
	if getOption(1) then
		return restart(5,"Restart bot after 5s")
	else
		return
	end
end
function team.antibanclassroom()
	if useItem("Escape Rope") then
		return
	end
	log("Quiz detected, talking to the prof.")
	pushDialogAnswer(1)
	talkToNpc("Prof. Antiban")
end
antibanQuestions = {

["What type is Flygon?"] = "Dragon/Ground",
["How many Pokemon can Eevee currently evolve into?"] = "8",
["Which of these are effective against Dragon?"] = "Dragon",
["What level does Litleo evolve into Pyroar?"] = "35",
["Articuno is one of the legendary birds of Kanto."] = "True",

}

function team.onAntibanDialogMessage(message)
	if getMapName() == "Prof. Antibans Classroom" then
		if stringContains(message, "incorrect") then
			log("Could not answer correctly, try another answer.")
			if ran < 3 then
				pushDialogAnswer(ran+1)
			else
				ran = 1
				pushDialogAnswer(ran)
			end
		else
			pushDialogAnswer(ran)
		end
	end
end

function team.onSystemMessage(message)
	if stringContains(message, "Bot still stuck") then
		return relog(5,"Relog in 5s.")
	end
end

function closeAllChannel()
	closeChannel("All")
	closeChannel("Trade")
	closeChannel("Battle")
	closeChannel("Other")
	closeChannel("Help")
end

return team