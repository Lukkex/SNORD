extends Control

@export var character_sprite : Resource
@export var character_name : String

@onready var texture_rect: TextureRect = $VBoxContainer/TextureRect
@onready var char_name: Label = $VBoxContainer/Name

func _ready() -> void:
	texture_rect.texture = character_sprite
	char_name.text = character_name
