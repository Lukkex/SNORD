extends Button

@export var set_text : String = "button"
@export_file("*.tscn") var scene : String

func _ready() -> void:
	if set_text != "button": text = set_text

func _on_pressed() -> void:
	AudioManager.stop_all_sounds()
	AudioManager.play_character_move_sound()
	get_tree().paused = false
	if scene: get_tree().change_scene_to_file(scene)
