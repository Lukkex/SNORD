extends Node2D
class_name SpikeLevel

@export var level_speed_multiplier : float = 1.0
@export_range(1, 3) var level_num : int = 0

const WIN_SCREEN = preload("uid://bwi1x7xvk1aue")

func _ready() -> void:
	LevelManager.current_level = level_num - 1
	SignalBus.player_died.connect(_restart)
	SignalBus.player_win.connect(_win)
	AudioManager.snordmusicloop.play()
	Global.speed_multiplier = level_speed_multiplier * Global.character.speed_multiplier

func _restart():
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

func _win():
	get_tree().change_scene_to_packed(WIN_SCREEN)
