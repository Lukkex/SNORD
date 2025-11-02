extends VBoxContainer

@onready var textbutton = $TextureButton
@onready var player_skin = textbutton.texture.path

func _on_texture_button_pressed() -> void:
	AudioManager.snord1.play()


func _on_texture_button_mouse_entered() -> void:
	AudioManager.snord1.play()
