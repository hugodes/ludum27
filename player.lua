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
end

function player.reset(  )
	player.x = 5*80
	player.y = 4*80
	player.size=player_size_ini
end

function player.update( dt )
	player.hb = {}
end