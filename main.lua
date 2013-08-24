function love.load()
	player = love.graphics.newImage("images/characters/Pj_Blop.png")
end

function love.draw()
	love.graphics.draw(player, 0, 0)
end
