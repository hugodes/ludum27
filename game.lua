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
end
