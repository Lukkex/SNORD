extends Node2D

func _ready() -> void:
	if AudioManager.snordmusicloop:
		AudioManager.snordmusicloop.play()
