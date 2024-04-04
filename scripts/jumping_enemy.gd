extends SlidingEnemy

func _physics_process(delta: float) -> void:
	
		
	velocity.y += GRAV/3
	
	velocity.x = -speed
	
	move_and_slide()
	
	get_node("Sprite2D").modulate = Color(0,0,1,1)
	if global_position.x <= 65 and global_position.x >= 60:
		jump()
		
func jump():
	velocity.y = -300
