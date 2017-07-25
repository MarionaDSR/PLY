-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
require("utils.constants")
require("utils.texts")
require("utils.utils")
database = require("utils.database")

isDebug = true

database.testDB()

-- hide the status bar
display.setStatusBar( display.HiddenStatusBar )

math.randomseed(os.time())

-- display a background image
bgGroup = display.newGroup()
local bg = display.newImage(bgGroup, IMAGES_DIR..GAME_TYPE.."_background"..IMAGE_EXT, X, Y)
bg:scale(W / bg.width, H / bg.height)

-- include the Corona "composer" module
local composer = require "composer"

-- load menu screen
composer.gotoScene("menu")
--composer.gotoScene("level1")