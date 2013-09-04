local state = {}

function state:init(  )
	death_bg = love.graphics.newImage("images/menu/Death.png")
	death_sound = love.audio.newSource("sounds/sound_effects/Death.wav", "static")
end

function state:mousreleased( x, y, button )
	if x>43 and x<43+189 and y>38 and y<38+61 then
		gstate.switch(menu)
	end
end

function state:keyreleased( key )
	if key == "return" then
		gstate.switch(menu)
	end
end

function state:draw( dt )
	love.graphics.draw(death_bg)
	love.graphics.setFont(font)
	love.graphics.print(level,423,320)
end

return state