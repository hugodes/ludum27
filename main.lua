require("useful")

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
	timer_offset=0
	
	--loading our pnj images
	pnj = {}
	pnj[0]=nil -- pas de pnj
	pnj[1]=love.graphics.newImage("images/pnj/Good_Blop.png")
	pnj[2]=love.graphics.newImage("images/pnj/Bad_Blop.png")
	pnj[3]=love.graphics.newImage("images/pnj/Time_Blop.png")
	--pnj positions and hit boxes
	pnj_pos = {}
	for i=0, 9 do
		pnj_pos[i]={}
		for j=0, 7 do
			pnj_pos[i][j]={}
			random_number=math.random(4)-1
			if random_number>0 then
				pnj_pos[i][j]["type"]=random_number
				if random_number == 1 then
					pnj_pos[i][j]["pos_x"]=80*i
					pnj_pos[i][j]["pos_y"]=80*j+22
					pnj_pos[i][j]["width"]=80
					pnj_pos[i][j]["height"]=35
				elseif random_number == 2 then
					pnj_pos[i][j]["pos_x"]=80*i+50
					pnj_pos[i][j]["pos_y"]=80*j+40
					pnj_pos[i][j]["radius"]=20
				elseif random_number == 3 then
					pnj_pos[i][j]["pos_x"]=80*i+40
					pnj_pos[i][j]["pos_y"]=80*j+40
					pnj_pos[i][j]["radius"]=20
				end
			end
		end
	end
	--position de départ du joueur
	pnj_pos[5][4]["type"]=0
end

function love.update(dt)
	ntime = love.timer.getTime()
	timer = 10-(ntime-stime)+timer_offset
	

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
	player_hb={}
	player_hb["pos_x"]=player_x
	player_hb["pos_y"]=player_y
	player_hb["radius"]=130*player_size
	
	for i=0,9 do
		for j=0,6 do
			if pnj_pos[i][j]["type"]==1 then
				if useful.col_circle_rectangle(player_hb["pos_x"],
				player_hb["pos_y"],
				player_hb["radius"],
				pnj_pos[i][j]["pos_x"],
				pnj_pos[i][j]["pos_y"],
				pnj_pos[i][j]["width"],
				pnj_pos[i][j]["height"]) then
					pnj_pos[i][j]["type"]=0
					player_size = player_size + player_size*0.2
				end
			elseif pnj_pos[i][j]["type"]==2 then
				if useful.col_circle_circle(player_hb["pos_x"],
				player_hb["pos_y"],
				player_hb["radius"],
				pnj_pos[i][j]["pos_x"],
				pnj_pos[i][j]["pos_y"],
				pnj_pos[i][j]["radius"]) then
					pnj_pos[i][j]["type"]=0
					player_size = player_size -player_size*0.2
				end
			elseif pnj_pos[i][j]["type"]==3 then
				if useful.col_circle_circle(player_hb["pos_x"],
				player_hb["pos_y"],
				player_hb["radius"],
				pnj_pos[i][j]["pos_x"],
				pnj_pos[i][j]["pos_y"],
				pnj_pos[i][j]["radius"]) then
					pnj_pos[i][j]["type"]=0
					timer_offset=timer_offset+0.5
				end
			end
		end
	end
end

function love.draw()
	love.graphics.print(timer, 0, 0)
	love.graphics.draw(player, player_x, player_y, 0, player_size, player_size, 130, 130)
	for i=0,9 do
		for j=0,6 do
			--print(pnj_pos[i][j])
			if pnj[pnj_pos[i][j]["type"]] then
				love.graphics.draw(pnj[pnj_pos[i][j]["type"]], i*80, j*80)
				if pnj_pos[i][j]["type"] == 1 then
					love.graphics.rectangle("line",
					pnj_pos[i][j]["pos_x"],
					pnj_pos[i][j]["pos_y"],
					pnj_pos[i][j]["width"],
					pnj_pos[i][j]["height"])
				else
					love.graphics.circle("line",pnj_pos[i][j]["pos_x"],
					pnj_pos[i][j]["pos_y"],
					pnj_pos[i][j]["radius"])
				end
				love.graphics.circle("line",player_hb["pos_x"],
				player_hb["pos_y"],
				player_hb["radius"])
			end
		end
	end
end
