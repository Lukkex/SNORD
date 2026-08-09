## TODO: 
## - make resources for all the characters
extends Control
class_name PlayerSelectContainer

@export var character_name : String
@export var bg_color : Color = Color.from_hsv(0.0, 0.0, 1.0, 1.0)
@export var character_sprite : AtlasTexture

@onready var texture_rect: TextureRect = $CharacterCutoff/TextureRect
@onready var char_name: Label = $Name
@onready var portrait_background: ColorRect = $PortraitFrame/MarginContainer/PortraitBackground
@onready var flames_effect: GPUParticles2D = $FlamesEffect

@onready var button: Button = $PortraitFrame/MarginContainer/Button

var character : CharProfile = null

func _ready() -> void:
	flames_effect.emitting = false
	SignalBus.character_selected.connect(cut_flames)


func prep(char_profile : CharProfile) -> void:
	if char_profile == null: 
		print("char profile is null- ", self)
	character = char_profile
	
	texture_rect.texture = character.character_sprite
	flames_effect.texture = character.character_sprite
	char_name.text = character.character_name
	portrait_background.color = character.bg_color

func _on_button_pressed() -> void:
	flames_effect.emitting = true
	SignalBus.emit_signal("character_selected", character)
	flames_effect.emitting = true

func cut_flames(_arg1 = null):
	flames_effect.emitting = false
