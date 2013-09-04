local state = {}

function state:init(  )
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

function state:draw(  )
	gstate.switch(game)
end

return state