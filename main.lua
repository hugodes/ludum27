function love.load()
	gstate = require("gamestate")
	menu = require("menu")
	victory = require("victory")
	death = require("death")
	controls = require("controls")
	next_level = require("next_level")

	require("useful")	
	
	gstate.registerEvents()
	gstate.switch(menu)
end

function love.mousereleased(x, y, button)
	gstate.mousereleased(x, y, button)
end

function love.keyreleased(key)
	gstate.keyreleased(key)
	if key =="escape" and gstate.current ~= menu then
		love.event.quit()
	end
end

function love.update(dt)
	gstate.update(dt)
end

function love.draw()
	if gamestate=="next_level" then
		gamestate="game"
	end
end
