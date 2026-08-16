extends Node2D

@export_file_path() var character_sound_directory : String

@onready var snordmusicloop = $SnordMusicLoop
@onready var snord1 = $SnordSound1
@onready var antagonist_sound: AudioStreamPlayer = $AntagonistSound

@onready var death_screams = [$death_scream1, $death_scream2]
@onready var death_sounds = [$death_sound1, $death_sound2, $death_sound3, $death_sound4, $death_sound5, $death_sound6, $death_sound7, $death_sound8]

# var audio_stream_player : AudioStreamPlayer

func _ready() -> void:
	SignalBus.character_selected.connect(set_character_sound)
	SignalBus.game_started.connect(set_antagonist_sound)
	SignalBus.game_started.connect(set_character_sound)
	

func stop_all_sounds() -> void:
	for sound in get_children():
		sound.stop()

func set_character_sound(_arg1 = null) -> void:
	print(Global.character.audio_file)
	snord1.stream = load(Global.character.audio_file)

## TODO Set antag sound depending on chosen character (basically make it kyle if player didnt chose kyle but something else if they did
func set_antagonist_sound(_arg1 = null) -> void:
	pass

func play_antagonist_sound() -> void:
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.stream = antagonist_sound.stream
	audio_stream_player.play()

func play_character_move_sound() -> void:
	var audio_stream_player = AudioStreamPlayer.new()
	add_child(audio_stream_player)
	audio_stream_player.stream = snord1.stream
	audio_stream_player.play()

func play_death_sound(position) -> void:
	var audio_stream_player1 = AudioStreamPlayer2D.new()
	add_child(audio_stream_player1)
	audio_stream_player1.position = position
	audio_stream_player1.stream = death_screams.pick_random().stream
	
	var audio_stream_player2 = AudioStreamPlayer2D.new()
	add_child(audio_stream_player2)
	audio_stream_player2.position = position
	audio_stream_player2.stream = death_sounds.pick_random().stream
	audio_stream_player2.volume_db = 8
	
	audio_stream_player1.play()
	await get_tree().create_timer(0.2).timeout
	audio_stream_player2.play()
