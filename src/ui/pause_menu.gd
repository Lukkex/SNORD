extends Control

@onready var settings_menu: Control = $Settings
@onready var character_name: Label = $MarginContainer/HBoxContainer/CharacterName

@onready var player : CharacterBody3D

func _ready() -> void:
	visible = false
	get_tree().paused = false

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("escape"):
		character_name.text = Global.character.character_name
		settings_menu.visible = false
		pausemenu()

func pausemenu():
	if visible:
		var tween = create_tween()
		tween.tween_property( Global.player_camera, "zoom", Vector2(10, 10), 0.1 )
		tween.parallel().tween_property( Global.player_camera, "offset", Vector2(0, 0), 0.15 )
		visible = false
		
		await tween.finished
		get_tree().paused = false
	else:
		var tween2 = create_tween()
		tween2.tween_property( Global.player_camera, "zoom", Vector2(100, 160), 0.1 )
		tween2.parallel().tween_property( Global.player_camera, "offset", Vector2(6, 0), 0.15 )
		get_tree().paused = true
		
		await tween2.finished
		visible = true
		AudioManager.play_character_move_sound()

func _on_resume_pressed():
	pausemenu()

func _on_restart_pressed() -> void:
	AudioManager.stop_all_sounds()
	get_tree().reload_current_scene()
