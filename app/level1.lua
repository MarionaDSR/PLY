-----------------------------------------------------------------------------------------
--
-- level1.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

LEVEL_DIR = IMAGES_DIR..GAME_TYPE.."/"

--------------------------------------------
local function occupeCell(cell)
	cells[cell[1]][cell[2]] = true
	printDebug("TAKING UP "..cell[1].."-"..cell[2])
end

local function freeCell(cell)
	cells[cell[1]][cell[2]] = false
	printDebug("RELEASING "..cell[1].."-"..cell[2])
end

local function getGameCell()
	local x = math.random(GAME_COLS)
	local y = math.random(GAME_ROWS)
	printDebug("CELL "..x.."-"..y)
	while cells[x][y] do
		printDebug("TAKED UP")
		x = math.random(GAME_COLS)
		y = math.random(GAME_ROWS)
		printDebug("*CELL "..x.."-"..y)
	end
	local res = {x, y}
	return res
end

local function showScore()
	if scoreText then
		scoreText:removeSelf( )
	end
	scoreText = display.newText(sceneGroup, score, SCORE_X, SCORE_Y, BOLD_FONT, SCORE_FONT_SIZE)
	scoreText:setTextColor(getColor(SCORE_COLOR))
end

local function removeGame(num)
	if games[num] then
		freeCell(games[num].cell)
		games[num]:removeSelf()
		games[num] = nil
	end
end

local function endGame(score)
	composer.gotoScene("register", "fade", 500)
end

local function endGameListener(event)
	endGame(event.source.params.score)
end

local function gameListener(event)
	local target = event.target
	removeGame(target.num)
	if target.isGoal then
		score = score + SCORE_GOAL
	elseif target.gameType == GOOD_PRE then
		score = score + SCORE_GOOD
	else
		booom = display.newText(sceneGroup, BOOOM, X, Y, BOLD_FONT, BOOOM_FONT_SIZE)
		stop = true
		local endTimer = timer.performWithDelay(GAME_DISAPPEAR_DELAY, endGameListener)
		endTimer.params = {score = score}
	end
	showScore()
	printDebug("SCORE = "..score)
	return true
end

local function disapearListener(event)
	local num = event.source.params.game
	removeGame(num)
end

local function initCells()
	local cells = {}
	for i=1, GAME_COLS do
		cells[i] = {}
		for j = 1, GAME_ROWS do
			cells[i][j] = false
		end
	end
	return cells
end

local function addGameListener(event)
	if not stop then
		local num = event.source.params.num
		local randomNum = math.random(GOOD_NUM + BAD_NUM)
		printDebug("randomNum = "..randomNum)
		local gameType, gameNumber, isGoal
		if randomNum <= BAD_NUM then
			gameType = BAD_PRE
			gameNumber = randomNum
			isGoal = false
		else
			gameType = GOOD_PRE
			gameNumber = randomNum - BAD_NUM
			isGoal = (gameNumber == goalNumber)
		end

		local cell = getGameCell()
		local gameX = getGrided(GAME_AREA_L, cell[1])
		local gameY = getGrided(GAME_AREA_T, cell[2])
		occupeCell(cell)
		printDebug("game = "..gameType..gameNumber.." on "..gameX..","..gameY)

		local gameImage = display.newImage(sceneGroup, LEVEL_DIR..gameType..gameNumber..IMAGE_EXT, gameX, gameY)
		gameImage:scale(GAME_SCALE, GAME_SCALE)
		gameImage.isGoal = isGoal
		gameImage.gameType = gameType
		gameImage.cell = cell
		gameImage:addEventListener("tap", gameListener)
		games[num] = gameImage

		local tm = timer.performWithDelay(GAME_DISAPPEAR_DELAY, disapearListener)
		tm.params = {game = num}
	end
end

function scene:create( event )

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.

end

function scene:show( event )
	sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		stop = false
		playCounter = 1
		score = 0
		games = {}
		cells = initCells()
		showScore()
	elseif phase == "did" then
		goalNumber = math.random(GOOD_NUM)
		printDebug("goalNumber = "..goalNumber)
		goalImage = display.newImage(sceneGroup, LEVEL_DIR..GOOD_PRE..goalNumber..IMAGE_EXT, GOAL_X, GOAL_Y)
		goalImage:scale(GOAL_SCALE, GOAL_SCALE)

		local endTimer = timer.performWithDelay(MAX_TIME, endGameListener)
		endTimer.params = {score = score}

		repeat
			local randomDelay = math.random(MAX_TIME - GAME_DISAPPEAR_DELAY)
			local tm = timer.performWithDelay(randomDelay, addGameListener)
			tm.params = {num = playCounter}
			playCounter = playCounter + 1
		until playCounter > PLAY_LIMIT
	end
end

function scene:hide( event )
	local sceneGroup = self.view
	
	local phase = event.phase
	
	if event.phase == "will" then
		-- Called when the scene is on screen and is about to move off screen
		--
		-- INSERT code here to pause the scene
		-- e.g. stop timers, stop animation, unload sounds, etc.)
		--physics.stop()
	elseif phase == "did" then
		-- Called when the scene is now off screen
		if goalImage then
			goalImage:removeSelf()
		end
		if booom then
			booom:removeSelf( )
		end
		cells = nil
	end	
	
end

function scene:destroy( event )

	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.
	local sceneGroup = self.view
	
	--package.loaded[physics] = nil
	--physics = nil
end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene