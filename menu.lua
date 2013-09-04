local state = {}

function state:init(  )
	menu_bg = love.graphics.newImage("images/menu/menu.png")
end

function state:mousereleased( x, y, button )
	if x>302 and x<302+205 then
		if y>278 and y<278+70 then
			gstate.switch(game, 1)
		elseif y>369 and y<369+70 then
			gstate.switch(controls	)
		elseif y>463 and y<463+70 then
			love.event.quit()
		end
	end
	
end

function state:keyreleased( key )
	if key=="return" then
		gstate.switch(game, 1)
	end
	if key=="escape" then
		print("I can't surely be here !")
		love.event.quit()
	end
end

function state:draw( dt )
	love.graphics.draw(menu_bg)
end

return state