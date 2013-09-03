local state = {}

function state:init(  )
	level=1
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

function state:mousereleased( x, y, button )
	if x>335 and x<335+130 and y>4 and y<4+42 then
		gstate.switch(menu)
end