function love.load()
	gstate = require("gamestate")
	menu = require("menu")
	victory = require("victory")
	death = require("death")
	controls = require("controls")
	game = require("game")

	require("useful")	
	
	gstate.switch(menu)
end

function love.mousereleased(x, y, button)
	gstate.mousereleased(x, y, button)
end

function love.keyreleased(key)
	if key =="escape" and gstate.current() ~= menu then
		gstate.switch(menu)
	else
		gstate.keyreleased(key)
	end
end

function love.update(dt)
	gstate.update(dt)
end

function love.draw()
	gstate.draw()
end
