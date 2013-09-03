state = {}

function controls:init()
	controls = love.graphics.newImage("images/menu/controls.png")
end

function state:mousereleased(x, y, button)
	if x>43 and x<43+189 and y>38 and y<38+61 then
		gstate.switch(next_level)
	end
end