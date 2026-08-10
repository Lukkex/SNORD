extends Node2D

@export_file_path() var character_sound_directory : String

@onready var snordmusicloop = $SnordMusicLoop
@onready var snord1 = $SnordSound1

func _ready() -> void:
	load_character_sounds(character_sound_directory)

func stop_all_sounds() -> void:
	for sound in get_children():
		sound.stop()

func load_character_sounds(path):
	var dir = DirAccess.open(path)
	if dir:
		dir.list_dir_begin()
		var file_name = dir.get_next()
		while file_name != "":
			# do something with the file
			print(file_name)
			file_name = dir.get_next()
