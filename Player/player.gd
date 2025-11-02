extends CharacterBody2D
class_name player

## On READYS
@onready var sprite_2d: Sprite2D = $Sprite2D

# EXPORTS
@export var sprite_texture : Texture
@export var speed_multiplier := 1
@export_range(0,4) var channel : int = 2 ## set the starting channel from 0 to 4

func _ready() -> void:
	add_to_group("players")
	_set_y_pos(channel)
	if sprite_texture: sprite_2d.texture = sprite_texture

func _process(_delta: float) -> void:
	velocity.x = get_gravity().y * _delta * speed_multiplier
	
	if channel:
		_set_y_pos(channel)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if channel != 4: channel += 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som
	if event.is_action_pressed("down"):
		if channel != 0: channel -= 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som

func _set_y_pos(height):
	position.y = height * 8 - 8 * 4 # 8 pixels per channel, might need tweaking
	# NOTE: Can add vertical shake when moving here
