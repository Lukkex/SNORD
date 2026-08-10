extends Control

@onready var volume_slider = $MarginContainer/VBoxContainer/Volume

func _on_volume_value_changed(value: float) -> void:
	if value <= volume_slider.min_value:
		value = -999
	AudioServer.set_bus_volume_db(0, value)

func _on_mute_enabler_item_selected(index: int) -> void:
	match index:
		0:
			AudioServer.set_bus_mute(0, true)
		1:
			AudioServer.set_bus_mute(0, false)

func _on_resolutions_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_size(Vector2i(1920, 1080))
		1:
			DisplayServer.window_set_size(Vector2i(1600, 900))
		2:
			DisplayServer.window_set_size(Vector2i(1280, 720))


func _on_fullscreen_enabler_item_selected(index: int) -> void:
	match index:
		0:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_EXCLUSIVE_FULLSCREEN)
		1:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
		2:
			DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	pass # Replace with function body.


func _on_timer_enabler_item_selected(index: int) -> void:
	match index:
		0:
			Global.timer_enabled = true
		1:
			Global.timer_enabled = false
