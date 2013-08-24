function love.load()
	player = love.graphics.newImage("images/characters/Pj_Blop.png")
	x = 50
	y = 50
	speed = 300
	stime = love.timer.getTime()
	timer=0
end

function love.update(dt)
	ntime = love.timer.getTime()
	timer = 10-(ntime-stime)
	

	if love.keyboard.isDown("right") then
	x = x + (speed * dt)
	end

	if love.keyboard.isDown("left") then
	x = x -(speed*dt)
	end

	if love.keyboard.isDown("up") then
	y = y -(speed *dt)
	end

	if love.keyboard.isDown("down") then
	y = y +(speed*dt)
	end
end

function love.draw()
	love.graphics.print(timer, 0, 0)
	love.graphics.draw(player, x, y, 0, 0.25, 0.25, 130, 130)
end
