extends ParallaxBackground

@onready var parallax_layer: ParallaxLayer = $ParallaxLayer


func _physics_process(delta: float) -> void:
	parallax_layer.motion_mirroring = Vector2(162,0)
	
	scroll_offset += Vector2(-100, 0)*delta
	
