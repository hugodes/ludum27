local state = {}

function state:init(  )
	victory = love.graphics.newImage("images/menu/victory.png")
	victory_sound = love.audio.newSource("sounds/sound_effects/Victory.wav", "static")
end

function state:mousereleased( x, y, button )
	elseif x>592 and x<592+189 and y>499 and y<499+61 then
		gstate.switch(next_level)
		level=level+1
	end
end

function state:keyreleased( key )
	if key == "return" then
		level=level+1
		gstate.switch(next_level)
	end
end