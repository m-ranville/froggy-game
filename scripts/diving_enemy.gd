extends FloatingEnemy

func _physics_process(delta: float) -> void:
	
	position.x -= speed*delta
	
	if float_dir:
		position.y += 10*delta
	else:
		position.y -= 10*delta
		
	get_node("Pupil256").modulate = Color(0,0,1,1)
	if global_position.x < 115:
		if position.y < 185:
			position.y += (speed/1.2)*delta
