## TODO: 
## - make resources for all the characters
## - make flame sprite use texture of character selected lmao

## NOTE: sprite2d works for the resource input, just need to change the sprite (more later potentially)

extends Control

@export var character_name : String
@export var bg_color : Color = Color.from_hsv(0.0, 0.0, 1.0, 1.0)
@export var character_sprite : AtlasTexture

@onready var texture_rect: TextureRect = $CharacterCutoff/TextureRect
@onready var char_name: Label = $Name
@onready var portrait_background: ColorRect = $PortraitFrame/MarginContainer/PortraitBackground
@onready var flames_effect: GPUParticles2D = $FlamesEffect

@onready var button: Button = $PortraitFrame/MarginContainer/Button

func _ready() -> void:
	if character_sprite != null: texture_rect.texture = character_sprite
	if character_name != null: char_name.text = character_name
	if bg_color != null: portrait_background.color = bg_color
	flames_effect.emitting = false

func _on_button_pressed() -> void:
	pass
	flames_effect.emitting = true
	SignalBus.emit_signal("character_selected")
	# pull up character cutin

func _on_button_mouse_entered() -> void:
	#flames_effect.emitting = true
	pass

func _on_button_mouse_exited() -> void:
	#flames_effect.emitting = false
	pass
