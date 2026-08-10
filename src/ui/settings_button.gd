extends Button
@onready var settings_menu = $"../../../../Settings"

func _on_mouse_entered() -> void:
	# Play sound
	pass

func _on_pressed() -> void:
	# Play sound
	#AudioManager.select_sfx.play()
	if !settings_menu.visible:
		settings_menu.visible = true
	else:
		settings_menu.visible = false
