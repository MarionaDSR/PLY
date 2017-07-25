W = display.contentWidth
H = display.contentHeight
X = display.contentWidth / 2
Y = display.contentHeight / 2

IMAGES_DIR = "images/"
IMAGE_EXT = ".png"

-- MENU

TITLE_X = X
TITLE_Y = 100
TITLE_SIZE = 80
TITLE_SHADOW = 4

PLAY_X = X
PLAY_Y = Y 
PLAY_W = 450
PLAY_H = 150
PLAY_RADIUS = 25

PLAY_TEXT_SIZE = 70

-- LEVEL 1
GOOD_PRE = "good_"
GOOD_NUM = 15
BAD_PRE = "bad_"
BAD_NUM = 3

GOAL_X = X
GOAL_Y = 150
GOAL_SCALE = 2

PLAY_LIMIT = 150 -- Número de partidas, a ajustar

GAME_AREA_MARGIN = 50
GAME_AREA_L = GAME_AREA_MARGIN
GAME_AREA_R = W - GAME_AREA_MARGIN
GAME_AREA_W = W --GAME_AREA_R - GAME_AREA_L

GAME_AREA_GRID = GAME_AREA_MARGIN * 2

GAME_ROWS = 5
GAME_COLS = 12

GAME_AREA_T = 250 + GAME_AREA_MARGIN
GAME_AREA_B = H - GAME_AREA_MARGIN
GAME_AREA_H = H -- GAME_AREA_B - GAME_AREA_T

GAME_SCALE = 1

GAME_DISAPPEAR_DELAY = 1500 -- 1.5 seg
MAX_TIME = 10000 -- 10 seg

SCORE_GOAL = 5
SCORE_GOOD = -1

SCORE_X = 150
SCORE_Y = 100
SCORE_FONT_SIZE = 60

BOOOM_FONT_SIZE = 250

-- COLORS
TITLE_COLOR = {1, 1, 1} -- TODO flat color
TITLE_SHADOW_COLOR = {0, 0, 0} -- TODO flat color
PLAY_COLOR = {0, 1, 0} -- TODO flat color
PLAY_TEXT_COLOR = {0, .5, 0} -- TODO flat color
SCORE_COLOR = {1, 0, 1} -- TODO flat color

-- FONTS
if system.getInfo( "platformName" ) == "Android" then
	MAIN_FONT = "Roboto-Light"
	BOLD_FONT = "Roboto"
else -- emulator
	MAIN_FONT = native.systemFont
	BOLD_FONT = native.systemFontBold
end