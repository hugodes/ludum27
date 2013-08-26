useful = {}
function useful.col_circle_rectangle(x1, y1, r, x2, y2, w, h)
	circle_distance_x = math.abs(x1-x2-w/2)
	circle_distance_y = math.abs(y1-y2-h/2)
	
	if circle_distance_x > w/2+ r then
		return false
	end
	if circle_distance_y > h/2 + r then
		return false
	end
	
	if circle_distance_x<=w/2 then
		return true
	end
	if circle_distance_y<=h/2 then
		return true
	end

	corner_distance_sq = math.pow(circle_distance_x-w/2, 2)+
				math.pow(circle_distance_y-h/2, 2)
	return corner_distance_sq<=math.pow(r,2)
end

function useful.col_circle_circle(x1,y1,r1,x2,y2,r2)
	if math.pow(x1-x2,2)+math.pow(y1-y2,2)>math.pow(r1+r2,2) then
		return false
	else
		return true
	end
end

function useful.level_random(level)
	number=math.random(100)
	if number > 0 and number < 17 then
		return 1
	elseif number < (level-1)*4+21 then
		return 3
	elseif number < (level-1)*4*2+21 then
		return 2
	else
		return 0
	end
end
