extends Control

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var video_stream_player: VideoStreamPlayer = $MarginContainer2/VBoxContainer/VideoStreamPlayer
@onready var color_rect: ColorRect = $ColorRect

func _ready() -> void:
	AudioManager.stop_all_sounds()
	AudioManager.main_menu.play()
	if animation_player != null: 
		animation_player.play("fade_in")
		await animation_player.animation_finished
	remove_child(color_rect)
