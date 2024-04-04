extends RigidBody2D

class_name FloatingEnemy

@onready var timer: Timer = $Timer

var speed :float= 140
var float_dir : bool
var behavior :int
var count:= 0
var start_pos :Vector2

func _physics_process(delta: float) -> void:
	
	position.x -= speed*delta
	
	if float_dir:
		position.y += 10*delta
	else:
		position.y -= 10*delta


func _on_timer_timeout() -> void:
	float_dir = !float_dir
	pass # Replace with function body.


func _on_area_2d_body_entered(body: Node2D) -> void:
	body.queue_free()
	pass # Replace with function body.
