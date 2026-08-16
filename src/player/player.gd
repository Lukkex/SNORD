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
@export_range(1,3) var actv_forward_multiplier : float = 1.7 ## When you press D or right arrow, multiplies speed by this amount
@export_range(0,1) var actv_backward_multiplier : float = 0.6 ## When you press A or left arrow, multiplies speed by this amount

var character : CharProfile
#var input_multiplier : float = 1.0
#var backward_multiuplier : float = 1.0

func _ready() -> void:
	add_to_group("players")
	_set_y_pos(channel)
	
	character = Global.character
	if character != null:
		update_characrer()
	
	Global.player = self
	Global.player_camera = camera_2d
	speed_multiplier = Global.speed_multiplier
	
	if Input.is_anything_pressed():
		for action in ["left", "right"]:
			if Input.is_action_pressed("right"):
				Global.fwd_input_multiplier = actv_forward_multiplier
			else: 
				Global.fwd_input_multiplier = 1.0
			if Input.is_action_pressed("left"):
				Global.back_input_multiplier = actv_backward_multiplier
			else:
				Global.back_input_multiplier = 1.0

func update_characrer():
	sprite_2d.texture = character.character_sprite
	character_name.text = character.character_name.get_slice(" ", 0)

func _physics_process(delta: float) -> void:
	speed_multiplier = Global.speed_multiplier
	velocity.x = get_gravity().y * delta * speed_multiplier * Global.fwd_input_multiplier * Global.back_input_multiplier
	#print(velocity)
	
	if channel: _set_y_pos(channel)
	
	move_and_slide()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("up"):
		AudioManager.play_character_move_sound()
		if channel != 1: channel -= 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som
	if event.is_action_pressed("down"):
		AudioManager.play_character_move_sound()
		if channel != 5: channel += 1
		else: pass # NOTE: can add error sound effect or som here and flash sprite red or som
	
	if event.is_action_pressed("right"):
		Global.fwd_input_multiplier = actv_forward_multiplier
	if event.is_action_pressed("left"):
		Global.back_input_multiplier = actv_backward_multiplier
	
	if event.is_action_released("right"):
		Global.fwd_input_multiplier = 1.0
	if event.is_action_released("left"): 
		Global.back_input_multiplier = 1.0

func _set_y_pos(height):
	position.y = height * 8 - 8 * 5 # 8 pixels per channel, might need tweaking
	# NOTE: Can add vertical shake when moving here

func _on_collision_area_body_entered(body: Node2D) -> void:
	if body.name == "Spikes" and collision_on:
		die()
	if body.name == "Victory":
		print("win")
		AudioManager.play_character_move_sound()
		SignalBus.player_win.emit()

func die():
	AudioManager.play_character_move_sound()
	
	camera_2d.reparent(get_tree().current_scene)
	var player_particles = GPUParticles2D.new()
	player_particles.explosiveness = 1.0
	player_particles.one_shot = true
	#player_particles.
	
	Global.can_pause = false
	SignalBus.player_died.emit(self)
	queue_free()
