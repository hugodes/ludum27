local state = {}

function state:init(  )
	death = love.graphics.newImage("images/menu/Death.png")
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
