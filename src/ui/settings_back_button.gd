extends Button
@onready var settings_menu = $"../../.."

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _on_mouse_entered() -> void:
	# Play Sound
	pass

func _on_pressed() -> void:
	# Play Sound
	#AudioManager.select_back_sfx.play()
	if !settings_menu.visible:
		settings_menu.visible = true
	else:
		settings_menu.visible = false
