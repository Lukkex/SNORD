extends CharacterBody2D
class_name player

## On READYS
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var camera_2d: Camera2D = $Camera2D

# EXPORTS
@export var sprite_texture : Texture
@export var speed_multiplier := 1
@export var collision_on := true
@export_range(1,5) var channel : int = 3 ## set the starting channel from 0 to 4

# Signals
signal die

func _ready() -> void:
	add_to_group("players")
	_set_y_pos(channel)
	if sprite_texture: sprite_2d.texture = sprite_texture

func _process(_delta: float) -> void:
	velocity.x = get_gravity().y * _delta * speed_multiplier
	print(velocity)
	
	if channel: _set_y_pos(channel)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		if channel != 1: channel -= 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som
	if event.is_action_pressed("down"):
		if channel != 5: channel += 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som

func _set_y_pos(height):
	position.y = height * 8 - 8 * 5 # 8 pixels per channel, might need tweaking
	# NOTE: Can add vertical shake when moving here


func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.name == "Spikes" and collision_on:
		print("die")
		camera_2d.reparent(get_tree().current_scene)
		SignalBus.player_died.emit()
		queue_free()
	if body.name == "Victory":
		print("win")
		SignalBus.player_win.emit()
