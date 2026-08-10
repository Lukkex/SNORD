extends Node2D

@export_file_path() var character_sound_directory : String

@onready var snordmusicloop = $SnordMusicLoop
@onready var snord1 = $SnordSound1

func _ready() -> void:
	SignalBus.game_started.connect(set_character_sound)

func stop_all_sounds() -> void:
	for sound in get_children():
		sound.stop()

func set_character_sound() -> void:
	print(Global.character.audio_file)
	snord1.stream = load(Global.character.audio_file)
