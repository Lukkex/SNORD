extends Control 

@onready var next_level_button: Button = $MarginContainer/HBoxContainer/VBoxContainer/NextLevelButton
@onready var time_label: Label = $MarginContainer/HBoxContainer/VBoxContainer/TimeLabel

var scene : PackedScene

func _ready() -> void:
	next_level_button.visible = true
	time_label.text = "Level #" + str(LevelManager.current_level) + ": " + LevelManager.get_current_level_time()
	
	if LevelManager.is_on_last_level():
		next_level_button.visible = false

func _on_next_level_button_pressed() -> void:
	LevelManager.swap_scene_to_next_level()

func _on_retry_button_pressed() -> void:
	LevelManager.swap_scene_to_current_level()
