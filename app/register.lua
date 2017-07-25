-----------------------------------------------------------------------------------------
--
-- menu.lua
--
-----------------------------------------------------------------------------------------

local composer = require( "composer" )
local scene = composer.newScene()

--------------------------------------------

local function buttonListener()
	printDebug(PLAY_TEXT)
	-- go to level1.lua scene
	composer.gotoScene( "menu", "fade", 500 )
	
	return true	-- indicates successful touch
end

function scene:create( event )
	local sceneGroup = self.view

	-- Called when the scene's view does not exist.
	-- 
	-- INSERT code here to initialize the scene
	-- e.g. add display objects to 'sceneGroup', add touch listeners, etc.
	
	-- create/position logo/title image on upper-half of the screen
	local titleShadow = display.newText(sceneGroup, END_TITLE, TITLE_X + TITLE_SHADOW, TITLE_Y + TITLE_SHADOW, BOLD_FONT, TITLE_SIZE)
	titleShadow:setFillColor(getColor(TITLE_SHADOW_COLOR))
	local title = display.newText(sceneGroup, END_TITLE, TITLE_X, TITLE_Y, BOLD_FONT, TITLE_SIZE)
	title:setFillColor(getColor(TITLE_COLOR))

	-- create a button (which will loads level1.lua on release)
	local buttonRect = display.newRoundedRect(sceneGroup, PLAY_X, PLAY_Y, PLAY_W, PLAY_H, PLAY_RADIUS)
	buttonRect:setFillColor(getColor(PLAY_COLOR))
	buttonRect:addEventListener("touch", buttonListener)

	local buttonText = display.newText(sceneGroup, PLAY_AGAIN, PLAY_X, PLAY_Y, BOLD_FONT, PLAY_TEXT_SIZE)
	buttonText:setFillColor(getColor(PLAY_TEXT_COLOR))

	local footerText = display.newText(sceneGroup, END_FOOTER, X, H *0.95, FONT, PLAY_TEXT_SIZE/2)
	footerText:setFillColor(getColor(PLAY_TEXT_COLOR))
end

function scene:show( event )
	local sceneGroup = self.view
	local phase = event.phase
	
	if phase == "will" then
		-- Called when the scene is still off screen and is about to move on screen
	elseif phase == "did" then
		-- Called when the scene is now on screen
		-- 
		-- INSERT code here to make the scene come alive
		-- e.g. start timers, begin animation, play audio, etc.
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
	elseif phase == "did" then
		-- Called when the scene is now off screen
	end	
end

function scene:destroy( event )
	local sceneGroup = self.view
	
	-- Called prior to the removal of scene's "view" (sceneGroup)
	-- 
	-- INSERT code here to cleanup the scene
	-- e.g. remove display objects, remove touch listeners, save state, etc.

end

---------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )

-----------------------------------------------------------------------------------------

return scene