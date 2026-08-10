extends Control 

@onready var next_level_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/NextLevelButton

var scene : PackedScene

func _ready() -> void:
	next_level_button.visible = true
	
	if LevelManager.is_on_last_level():
		next_level_button.visible = false

func _on_next_level_button_pressed() -> void:
	LevelManager.swap_scene_to_next_level()

func _on_retry_button_pressed() -> void:
	LevelManager.swap_scene_to_current_level()
