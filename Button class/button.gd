extends Button

@export var set_text : String = "button"
@export var scene : PackedScene


func _ready() -> void:
	text = set_text

func _on_pressed() -> void:
	if scene: get_tree().change_scene_to_packed(scene)
