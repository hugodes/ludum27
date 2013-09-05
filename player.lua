player = {}

function player.init(  )
	player = love.graphics.newImage("images/characters/Blop_walk.png")

	player.quad = {}
	for i = 1 , 8 do
		player_quad[i]=love.graphics.newQuad((i-1)*260,0,260,260,2080,260)
	end
	player.speed = 450
	player.size_ini = 0.125
	player.growth=0.02
	player.size_max=player_size_ini+6*player_growth
	player.size_min=player_size_ini-6*player_growth
	player.hb = {}
end

function player.reset(  )
	player.x = 5*80
	player.y = 4*80
	player.size=player_size_ini
end

function player.update( dt )
end

function player.moveRight( dt )
	new_pos_x = player.x + (player.speed * dt)
	if new_pos_x > 800 then
		player.x=799
	else
		player.x=new_pos_x
	end
end

function player.moveLeft( dt )
	new_pos_x = player.x -(player.speed*dt)
	if new_pos_x < 1 then
		player.x=1
	else
		player.x=new_pos_x
	end	
end

function player.moveDown( dt )
	new_pos_y = player.y -(player.speed *dt)
	if new_pos_y<1 then
		player.y=1
	else
		player.y=new_pos_y
	end
end

function player.moveUp( dt )
	new_pos_y = player.y +(player.speed*dt)
	if new_pos_y >600 then
		player.y=599
	else
		player.y=new_pos_y
	end
end

function player.updateHB(  )
	player.hb["pos_x"]=player.x
	player.hb["pos_y"]=player.y
	player.hb["radius"]=130*player.size
end