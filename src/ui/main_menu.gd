extends Control

@onready var music = $SnordMusicLoop
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var video_stream_player: VideoStreamPlayer = $MarginContainer2/VBoxContainer/VideoStreamPlayer

func _ready() -> void:
	#music.play()
	animation_player.play("fade_in")
