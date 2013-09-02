local state = {}

function state:init(  )
	victory = love.graphics.newImage("images/menu/victory.png")
	victory_sound = love.audio.newSource("sounds/sound_effects/Victory.wav", "static")
end