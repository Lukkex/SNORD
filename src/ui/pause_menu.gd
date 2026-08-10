extends Control

@onready var quiz_manager : Control = $"../../QuizManager"

@onready var player : CharacterBody3D

func _ready() -> void:
	visible = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		pausemenu()

func _on_resume_pressed():
	if visible:
		visible = false

func pausemenu():
	if visible:
		visible = false
	else:
		visible = true

func _on_restart_pressed() -> void:
	AudioManager.stop_all_sounds()
	get_tree().reload_current_scene()
