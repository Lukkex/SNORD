extends Node2D

@onready var snordmusicloop = $SnordMusicLoop
@onready var snord1 = $SnordSound1

func stop_all_sounds() -> void:
	for sound in get_children():
		sound.stop()
