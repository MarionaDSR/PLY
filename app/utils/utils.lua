function getColor(color)
	return color[1], color[2], color[3]
end

function printDebug(text)
	if isDebug then
		print(text)
	end
end

function getGrided(init, pos)
	return init + (pos - .5) * GAME_AREA_GRID
end