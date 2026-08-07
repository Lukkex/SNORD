extends VBoxContainer

@onready var snord = $SnordSound1
@onready var textbutton = $TextureButton
@export_file("*.tscn") var scene : String

func _on_texture_button_pressed() -> void:
	snord.play()
	if scene:
		get_tree().change_scene_to_file(scene)
	pass


func _on_texture_button_mouse_entered() -> void:
	snord.play()
	pass
