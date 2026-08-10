extends Node2D

@export_file_path() var character_sound_directory : String

@onready var snordmusicloop = $SnordMusicLoop
@onready var snord1 = $SnordSound1

# var audio_stream_player : AudioStreamPlayer

func _ready() -> void:
	SignalBus.character_selected.connect(set_character_sound)
	SignalBus.game_started.connect(set_character_sound)

func stop_all_sounds() -> void:
	for sound in get_children():
		sound.stop()

func set_character_sound() -> void:
	print(Global.character.audio_file)
	snord1.stream = load(Global.character.audio_file)

func play_character_move_sound() -> void:
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.stream = snord1.stream
	audio_stream_player.play()
