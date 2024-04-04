class_name SlidingEnemy
extends CharacterBody2D

var speed:float= 135
const GRAV = 50

func _physics_process(delta: float) -> void:
	
	velocity.y += GRAV
	
	velocity.x = -speed
	
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	pass # Replace with function body.
