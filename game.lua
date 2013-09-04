local state = {}

function state:init(  )
	current_frame=1
	frame_time=0.1
	time_since=0
	
	font = love.graphics.newFont(30)
	update_true = false
	
	good_sound = love.audio.newSource("sounds/sound_effects/Good.wav", "static")
	bad_sound = love.audio.newSource("sounds/sound_effects/Bad.wav", "static")
	time_sound = love.audio.newSource("sounds/sound_effects/Time.wav", "static")

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

function state:enter( current, l)
	local level = l
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
			random_number=useful.level_random(level)
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
end

function state:mousereleased( x, y, button )
	if x>335 and x<335+130 and y>4 and y<4+42 then
		gstate.switch(menu)
	end
end

function state:update( dt )	
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
		gstate.switch(death, level)
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
					love.audio.stop()
					love.audio.play(good_sound)
					pnj_pos[i][j]["type"]=4
					pnj_pos[i][j].current_frame=1
					new_player_size = player_size + player_growth
					if new_player_size>=player_size_max-player_growth then
						gstate.switch(victory, level)
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
					love.audio.stop()
					love.audio.play(bad_sound)
					pnj_pos[i][j]["type"]=5
					pnj_pos[i][j].current_frame=1
					new_player_size = player_size - player_growth
					if new_player_size > player_size_min then
						player_size=new_player_size
					elseif new_player_size <= player_size_min then
						gstate.switch(death, level)
					end
				end
			elseif pnj_pos[i][j]["type"]==3 then
				if useful.col_circle_circle(player_hb["pos_x"],
				player_hb["pos_y"],
				player_hb["radius"],
				pnj_pos[i][j]["pos_x"],
				pnj_pos[i][j]["pos_y"],
				pnj_pos[i][j]["radius"]) then
					love.audio.stop()
					love.audio.play(time_sound)
					pnj_pos[i][j]["type"]=6
					pnj_pos[i][j].current_frame=1
					timer_offset=timer_offset+0.5
				end
			end
		end
	end
end

function state:draw(  )
	love.graphics.draw(background)
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
end

return state