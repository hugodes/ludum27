function love.load()
	screen_w = 800
	screen_h = 600

	player = love.graphics.newImage("images/characters/Pj_Blop.png")
	player_x = 5*80
	player_y = 4*80
	player_speed = 450
	player_size=0.125
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
		new_pos_x = player_x + (player_speed * dt)
		if new_pos_x > 800 then
			player_x=799
		else
			player_x=new_pos_x
		end
	end

	if love.keyboard.isDown("left") then
		new_pos_x = player_x -(player_speed*dt)
		if new_pos_x < 1 then
			player_x=1
		else
			player_x=new_pos_x
		end
	end

	if love.keyboard.isDown("up") then
		new_pos_y = player_y -(player_speed *dt)
		if new_pos_y<1 then
			player_y=1
		else
			player_y=new_pos_y
		end
	end

	if love.keyboard.isDown("down") then
		new_pos_y = player_y +(player_speed*dt)
		if new_pos_y >600 then
			player_y=599
		else
			player_y=new_pos_y
		end
	end
	
	player_grid_x = math.floor(player_x / 80)
	player_grid_y = math.floor(player_y /80)

	if pnj_pos[player_grid_x][player_grid_y] == 1 then
		pnj_pos[player_grid_x][player_grid_y]=0
		player_size = player_size + player_size*0.2
	end
	if pnj_pos[player_grid_x][player_grid_y] == 2 then
		pnj_pos[player_grid_x][player_grid_y]=0
		player_size = player_size - player_size*0.2
	end
		
	
end

function love.draw()
	love.graphics.print(timer, 0, 0)
	love.graphics.draw(player, player_x, player_y, 0, player_size, player_size, 130, 130)
	for i=0,9 do
		for j=0,6 do
			--print(pnj_pos[i][j])
			if pnj[pnj_pos[i][j]] and (i~=5 and j~=4) then
				love.graphics.draw(pnj[pnj_pos[i][j]], i*80, j*80)
			end
		end
	end
end
