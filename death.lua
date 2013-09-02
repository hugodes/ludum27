local state = {}

function state:init(  )
	death = love.graphics.newImage("images/menu/Death.png")
	death_sound = love.audio.newSource("sounds/sound_effects/Death.wav", "static")
end
