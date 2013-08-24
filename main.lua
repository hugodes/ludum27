function love.load()
	screen_w = 800
	screen_h = 600

	player = love.graphics.newImage("images/characters/Pj_Blop.png")
	x = 50
	y = 50
	speed = 300
	stime = love.timer.getTime()
	timer=0
	
	--loading our pnj images
	pnj = {}
	pnj[0]=nil -- pas de pnj
	pnj[1]=love.graphics.newImage("images/pnj/Good_Blop.png")
	pnj[2]=love.graphics.newImage("images/pnj/Bad_Blop.png")
	--pnj positions
	pnj_pos = {}
	for i=0, 9 do
		pnj_pos[i]={}
		for j=0, 7 do
			pnj_pos[i][j]=math.random(3)-1
		end
	end
			
	
	
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
	for i=0,9 do
		for j=0,6 do
			--print(pnj_pos[i][j])
			if pnj[pnj_pos[i][j]] then
				love.graphics.draw(pnj[pnj_pos[i][j]], i*80, j*80)
			end
		end
	end
end
