extends Button

func _on_pressed() -> void:
	AudioManager.play_character_move_sound()
	get_tree().quit(0)
