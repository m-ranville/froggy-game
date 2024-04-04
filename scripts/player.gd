extends CharacterBody2D

@export var jump_str : int
@export var gravity_str: int
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var timer: Timer = $Timer
var jumps_available: int
var max_jumps:= 1

func _ready() -> void:
	
	pass

func _physics_process(delta: float) -> void:
	
	if is_on_floor() and jumps_available<max_jumps:
		jumps_available = max_jumps
	
	if jumps_available and Input.is_action_just_pressed("action_button"):
		jumps_available -= 1
		velocity.y = -jump_str
		timer.start()
	
	if Input.is_action_pressed("action_button") and not is_on_floor():
		if timer.time_left>0:
			velocity.y -= jump_str*0.05
	
	if not is_on_floor() and velocity.y < 0:
		sprite_2d.play("jump")
	elif not is_on_floor() and velocity.y >0:
		sprite_2d.play("fall")
	else:
		sprite_2d.play("run")
	
	velocity.y += gravity_str*delta

	
	move_and_slide()
