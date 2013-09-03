state = {}

function controls:init()
	controls_bg = love.graphics.newImage("images/menu/controls.png")
end

function state:mousereleased(x, y, button)
	if x>43 and x<43+189 and y>38 and y<38+61 then
		gstate.switch(next_level)
	end
end

function state:draw( dt )
	love.graphics.draw(controls_bg)
end