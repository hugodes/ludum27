local state = {}

function state:init(  )
	menu_bg = love.graphics.newImage("images/menu/menu.png")

end

function state:mousreleased( x, y, button )
	if x>302 and x<302+205 then
		if y>278 and y<278+70 then
			level=1
			gstate.switch(next_level)
		elseif y>369 and y<369+70 then
			gstate.switch(controls
		elseif y>463 and y<463+70 then
			love.event.quit()
		end
	end
	
end

function state:keyreleased( key )
	if key=="escape" then
		love.event.quit()
	end
	if key=="return" then
		level=1
		gstate.switch(game)
	end
	
end