extends CharacterBody2D
class_name Player

## On READYS
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var character_name: Label = $Name
@onready var camera_2d: Camera2D = $Camera2D

# EXPORTS
@export var default_sprite : Texture
@export var speed_multiplier : float
@export var collision_on := true
@export_range(1,5) var channel : int = 3 ## set the starting channel from 0 to 4

var character : CharProfile

signal die

func _ready() -> void:
	add_to_group("players")
	_set_y_pos(channel)
	
	character = Global.character
	if character != null:
		update_characrer()
	
	Global.player = self
	speed_multiplier = Global.speed_multiplier

func update_characrer():
	sprite_2d.texture = character.character_sprite
	character_name.text = character.character_name.get_slice(" ", 0)

func _physics_process(delta: float) -> void:
	speed_multiplier = Global.speed_multiplier
	velocity.x = get_gravity().y * delta * speed_multiplier
	print(velocity)
	
	if channel: _set_y_pos(channel)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		AudioManager.snord1.play()
		if channel != 1: channel -= 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som
	if event.is_action_pressed("down"):
		AudioManager.snord1.play()
		if channel != 5: channel += 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som

func _set_y_pos(height):
	position.y = height * 8 - 8 * 5 # 8 pixels per channel, might need tweaking
	# NOTE: Can add vertical shake when moving here


func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.name == "Spikes" and collision_on:
		print("die")
		AudioManager.snord1.play()
		camera_2d.reparent(get_tree().current_scene)
		SignalBus.player_died.emit()
		queue_free()
	if body.name == "Victory":
		print("win")
		AudioManager.snord1.play()
		SignalBus.player_win.emit()
