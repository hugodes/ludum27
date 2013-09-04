local state = {}

function state:init(  )
	victory_bg = love.graphics.newImage("images/menu/victory.png")
	victory_sound = love.audio.newSource("sounds/sound_effects/Victory.wav", "static")
end

function state:enter( current, l)
	love.audio.stop()
	love.audio.play(victory_sound)
	local level = l
end

function state:mousereleased( x, y, button )
	if x>592 and x<592+189 and y>499 and y<499+61 then
		gstate.switch(game, level+1)
	end
end

function state:keyreleased( key )
	if key == "return" then
		gstate.switch(game, level+1)
	end
end

function state:draw(  )
	love.graphics.draw(victory_bg)
end

return state