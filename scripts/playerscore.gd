extends VBoxContainer

@onready var player_name: Label = $Panel/MarginContainer/HBoxContainer/player_name
@onready var player_score: Label = $Panel/MarginContainer/HBoxContainer/player_score
@onready var placement: Label = $Panel/MarginContainer/HBoxContainer/placement


func set_new_placement(new_name:String, new_score:int):
	player_name.text = new_name
	player_score.text = str(new_score)
	
