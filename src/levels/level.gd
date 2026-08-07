extends Node2D

@onready var music = $SnordMusicLoop

const WIN_SCREEN = preload("res://src/ui/win_screen.tscn")

func _ready() -> void:
	if music:
		music.play()
	SignalBus.player_died.connect(_restart)
	SignalBus.player_win.connect(_win)

func _physics_process(delta: float) -> void:
	if !music.playing:
		music.play()

func _restart():
	await get_tree().create_timer(1).timeout
	get_tree().reload_current_scene()

func _win():
	get_tree().change_scene_to_packed(WIN_SCREEN)
