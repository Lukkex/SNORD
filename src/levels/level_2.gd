extends Node2D

const WIN_SCREEN = preload("uid://bwi1x7xvk1aue")

func _ready() -> void:
	SignalBus.player_died.connect(_restart)
	SignalBus.player_win.connect(_win)

func _restart():
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

func _win():
	get_tree().change_scene_to_packed(WIN_SCREEN)
