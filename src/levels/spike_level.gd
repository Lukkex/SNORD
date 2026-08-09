extends Node2D

class_name SpikeLevel

@export var speed_multiplier : float = 1.0

const WIN_SCREEN = preload("res://src/ui/win_screen.tscn")

func _ready() -> void:
	SignalBus.player_died.connect(_restart)
	SignalBus.player_win.connect(_win)
	AudioManager.snordmusicloop.play()
	Global.player.speed_multipler = self.speed_multiplier

func _restart():
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

func _win():
	get_tree().change_scene_to_packed(WIN_SCREEN)
