require("useful")

function love.load()
	
	gamestate="menu"
	level=1
	current_frame=1
	frame_time=0.1
	time_since=0
	
	font = love.graphics.newFont(30)
	update_true = false
	
	--load the menu
	menu = love.graphics.newImage("images/menu/menu.png")
	controls = love.graphics.newImage("images/menu/controls.png")
	death = love.graphics.newImage("images/menu/Death.png")
	victory = love.graphics.newImage("images/menu/victory.png")

	--load the background
	background = love.graphics.newImage("images/backgrounds/Fond1.png")
	foreground = love.graphics.newImage("images/backgrounds/Fond2.png")
	player = love.graphics.newImage("images/characters/Blop_walk.png")
	player_quad = {}
	for i = 1 , 8 do
		player_quad[i]=love.graphics.newQuad((i-1)*260,0,260,260,2080,260)
	end
	player_x = 5*80
	player_y = 4*80
	player_speed = 450
	player_size_ini = 0.125
	player_size=player_size_ini
	player_growth=0.02
	player_size_max=player_size_ini+6*player_growth
	player_size_min=player_size_ini-6*player_growth
	
	player_hb={}
	pnj_pos = {}
	for i=0, 9 do
		pnj_pos[i]={}
		for j=0, 7 do
			pnj_pos[i][j]={}
		end
	end

	--loading our pnj images
	pnj = {}
	pnj[0]=nil -- pas de pnj
	pnj[1]=love.graphics.newImage("images/pnj/Good_Blop_walk.png")
	pnj[2]=love.graphics.newImage("images/pnj/Bad_Blop_walk.png")
	pnj[3]=love.graphics.newImage("images/pnj/Time_Blop_Walk.png")
	pnj[4]=love.graphics.newImage("images/pnj/Good_Blop_Death.png")
	pnj[5]=love.graphics.newImage("images/pnj/Bad_Blop_Death.png")
	pnj[6]=love.graphics.newImage("images/pnj/Time_Blop_Death.png")
	pnj_quad={}
	for i=1, 8 do
		pnj_quad[i]=love.graphics.newQuad((i-1)*80,0,80,80,80*8,80)
	end

	timer=0
	timer_offset=0
	stime=0
end

function love.mousereleased(x, y, button)
	if gamestate=="menu" and x>302 and x<302+205 then
		if y>278 and y<278+70 then
			level=1
			gamestate="next_level"
		elseif y>369 and y<369+70 then
			gamestate="controls"
		elseif y>463 and y<463+70 then
			love.event.quit()
		end
	elseif (gamestate=="controls" or gamestate=="death")and x>43 and x<43+189 and y>38 and y<38+61 then
		gamestate="menu"
	elseif gamestate=="game" and x>335 and x<335+130 and y>4 and y<4+42 then
		gamestate="menu"
	elseif gamestate=="victory" and x>592 and x<592+189 and y>499 and y<499+61 then
		gamestate="next_level"
		level=level+1
	end
end

function love.keyreleased(key)
	if key=="escape" then
		if gamestate  == "menu" then
			love.event.quit()
		else
			gamestate="menu"
		end
	end
	if key=="return" then
		if gamestate=="menu" then
			level=1
			gamestate="next_level"
		elseif gamestate=="victory" then
			gamestate="next_level"
			level=level+1
		elseif gamestate=="death" then
			gamestate="menu"
		end
	end
end

function love.update(dt)

	if gamestate=="next_level" then
		--initialisations
		timer=0
		timer_offset=0
		stime = love.timer.getTime()

		player_x = 5*80
		player_y = 4*80
		player_size=player_size_ini
		player_growth=0.02

		--pnj positions and hit boxes
		for i=0, 9 do
			for j=0, 7 do
				pnj_pos[i][j].type = 0
			end
		end
		for i=0, 9 do
			for j=0, 7 do
				random_number=math.random(4)-1
				if random_number>0 then
					pnj_pos[i][j]["type"]=random_number
					pnj_pos[i][j].current_frame=math.random(8)
					if random_number == 1 then
						pnj_pos[i][j]["pos_x"]=80*i
						pnj_pos[i][j]["pos_y"]=80*j+22+40
						pnj_pos[i][j]["width"]=80
						pnj_pos[i][j]["height"]=35
					elseif random_number == 2 then
						pnj_pos[i][j]["pos_x"]=80*i+50
						pnj_pos[i][j]["pos_y"]=80*j+40+40
						pnj_pos[i][j]["radius"]=20
					elseif random_number == 3 then
						pnj_pos[i][j]["pos_x"]=80*i+40
						pnj_pos[i][j]["pos_y"]=80*j+40+40
						pnj_pos[i][j]["radius"]=20
					end
				end
			end
		end
		--position de départ du joueur
		pnj_pos[5][4]["type"]=0

	elseif gamestate=="game" then
		time_since=time_since+dt
		if time_since > frame_time then
			update_true = true
			time_since = time_since -frame_time
			if current_frame >= 8 then
				current_frame=1
			else
				current_frame = current_frame +1
			end
		else
			update_true=false
		end

		if update_true then
			for i=0,9 do
				for j=0,6 do
					if pnj_pos[i][j]["type"]>3 and pnj_pos[i][j].type<7 then
						if pnj_pos[i][j].current_frame <= 7 then
							pnj_pos[i][j].current_frame= pnj_pos[i][j].current_frame +1
						else pnj_pos[i][j].type=0
						end
					elseif pnj_pos[i][j].type>0 and pnj_pos[i][j].type<4 then
						if pnj_pos[i][j].current_frame <= 7 then
							pnj_pos[i][j].current_frame= pnj_pos[i][j].current_frame +1
						else
							pnj_pos[i][j].current_frame = 1
						end
					end
				end
			end
		end
		
		ntime = love.timer.getTime()
		timer = 10-(ntime-stime)+timer_offset
		if timer > 10 then
			timer =10
		end
		if timer <= 0 then
			gamestate="death"
		end
		

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
						pnj_pos[i][j]["type"]=4
						pnj_pos[i][j].current_frame=1
						new_player_size = player_size + player_growth
						if new_player_size>=player_size_max-player_growth then
							gamestate="victory"
						else
							player_size=new_player_size
						end
					end
				elseif pnj_pos[i][j]["type"]==2 then
					if useful.col_circle_circle(player_hb["pos_x"],
					player_hb["pos_y"],
					player_hb["radius"],
					pnj_pos[i][j]["pos_x"],
					pnj_pos[i][j]["pos_y"],
					pnj_pos[i][j]["radius"]) then
						pnj_pos[i][j]["type"]=5
						pnj_pos[i][j].current_frame=1
						new_player_size = player_size - player_growth
						if new_player_size > player_size_min then
							player_size=new_player_size
						elseif new_player_size <= player_size_min then
							gamestate="death"
						end
					end
				elseif pnj_pos[i][j]["type"]==3 then
					if useful.col_circle_circle(player_hb["pos_x"],
					player_hb["pos_y"],
					player_hb["radius"],
					pnj_pos[i][j]["pos_x"],
					pnj_pos[i][j]["pos_y"],
					pnj_pos[i][j]["radius"]) then
						pnj_pos[i][j]["type"]=6
						pnj_pos[i][j].current_frame=1
						timer_offset=timer_offset+0.5
					end
				end
			end
		end
	end
end

function love.draw()
	if gamestate=="menu" then
		love.graphics.draw(menu)
	elseif gamestate=="victory" then
		love.graphics.draw(victory)
	elseif	gamestate=="death" then
		love.graphics.draw(death)
		love.graphics.setFont(font)
		love.graphics.print(level,423,320)
	elseif gamestate=="controls" then
		love.graphics.draw(controls)
	elseif gamestate=="game" then
		love.graphics.draw(background)
		love.graphics.print(timer, 0, 0)
		love.graphics.drawq(player, player_quad[current_frame], player_x, player_y, 0, player_size, player_size, 130, 130)
		for i=0,9 do
			for j=0,6 do
				--print(pnj_pos[i][j])
				if pnj[pnj_pos[i][j]["type"]] then
					love.graphics.drawq(pnj[pnj_pos[i][j]["type"]], pnj_quad[pnj_pos[i][j].current_frame], i*80, j*80+40)
					if pnj_pos[i][j]["type"] == 1 then
						--love.graphics.rectangle("line",
						--pnj_pos[i][j]["pos_x"],
						--pnj_pos[i][j]["pos_y"],
						--pnj_pos[i][j]["width"],
						--pnj_pos[i][j]["height"])
					else
						--love.graphics.circle("line",pnj_pos[i][j]["pos_x"],
						--pnj_pos[i][j]["pos_y"],
						--pnj_pos[i][j]["radius"])
					end
					--love.graphics.circle("line",player_hb["pos_x"],
					--player_hb["pos_y"],
					--player_hb["radius"])
				end
			end
		end
		love.graphics.draw(foreground)
		--drawing of bars
		time_bar_width = 160/10*timer
		love.graphics.setColor(182,168,97)
		love.graphics.rectangle("fill",121,18,time_bar_width,24)
		love.graphics.setColor(127,180,101)
		player_size_bar_width = 160/(player_size_max-player_size_min)*(player_size-player_size_min)
		love.graphics.rectangle("fill",544,18,player_size_bar_width,24)
		love.graphics.setColor(255, 255, 255)
	elseif gamestate=="next_level" then
		gamestate="game"
	end
end
