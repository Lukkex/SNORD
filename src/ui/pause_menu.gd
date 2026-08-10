extends Control

@onready var quiz_manager : Control = $"../../QuizManager"

@onready var player : CharacterBody3D

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		pausemenu()

func _on_resume_pressed():
	if visible:
		visible = false
		get_tree().paused = false

func pausemenu():
	if visible:
		visible = false
		get_tree().paused = false
	else:
		visible = true
		get_tree().paused = true

func _on_restart_pressed() -> void:
	AudioManager.stop_all_sounds()
	get_tree().reload_current_scene()
