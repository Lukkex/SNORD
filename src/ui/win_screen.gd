extends Control 

var scene : PackedScene

func _on_next_level_button_pressed() -> void:
	LevelManager.swap_scene_to_next_level()

func _on_retry_button_pressed() -> void:
	LevelManager.swap_scene_to_current_level()
