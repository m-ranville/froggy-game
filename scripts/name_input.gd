extends LineEdit

func _on_text_changed(new_text: String) -> void:
	var allowed_characters = "[A-Z]"
	var old_caret_position = self.caret_column
	var regex = RegEx.new()
	var upper = new_text.to_upper()
	var word = ""
	
	regex.compile(allowed_characters)
	
	for valid_character in regex.search_all(upper):
		word += valid_character.get_string()
	self.set_text(word) 
	caret_column = old_caret_position
