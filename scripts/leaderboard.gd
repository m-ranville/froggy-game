extends Control

@onready var leaderboard: Panel = $leaderboard
@onready var submit_score: Panel = $submit_score
@onready var name_input: LineEdit = $submit_score/MarginContainer/VBoxContainer/name_input
@onready var new_score: Label = $submit_score/MarginContainer/VBoxContainer/new_score
@onready var scores_container: VBoxContainer = $leaderboard/MarginContainer/VBoxContainer/Panel/VBoxContainer/ScrollContainer/scores_container

var score_number:= 0
var placements := [
	"1st",
	"2nd",
	"3rd",
]

const PLAYERSCORE = preload("res://scenes/playerscore.tscn")

func _ready() -> void:
	draw_scores()
		

func _process(delta: float) -> void:
	pass

func _on_submitnewscore_button_pressed() -> void:
	submit_score.show()
	name_input.grab_focus()

func _on_backtomenu_button_pressed() -> void:
	self.queue_free()

func _on_back_button_pressed() -> void:
	submit_score.hide()

func _on_upload_button_pressed() -> void:
	print(name_input.text)
	var player_name:String = name_input.text
	SilentWolf.Scores.save_score(player_name, Global.high_score)
	await SilentWolf.Scores.sw_save_score_complete
	draw_scores()
	submit_score.hide()
	
func draw_scores():
	for children in scores_container.get_children():
		children.queue_free()
		
	var sw_result: Dictionary = await SilentWolf.Scores.get_scores(20).sw_get_scores_complete
	var counter:= 0
	submit_score.hide()
	new_score.text = str(Global.high_score)
	for score in sw_result.scores:
		var new_score = PLAYERSCORE.instantiate()
		scores_container.add_child(new_score)
		new_score.set_new_placement(score.player_name, score.score)
		if counter <3:
			new_score.placement.text = placements[counter]
		else:
			new_score.placement.text = str(counter+1) +"th"
		counter += 1
#func _on_name_input_text_changed(new_text: String) -> void:
#		var caret_pos = name_input.caret_column
#		name_input.text = new_text.to_upper() 
#		name_input.caret_column = caret_pos


