## TODO: export char sprite or something, to update the character portrait, as well as the description text. Also needs a second textbox for the name, also updated

extends CanvasLayer

## To call
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var camera_2d: Camera2D = $Camera2D
@onready var timer: Timer = $Timer

## To modify
@onready var flair: RichTextLabel = $Flair
@onready var description: RichTextLabel = $Lore/Descriptoin
@onready var sprite_2d: Sprite2D = $left/character/Sprite2D
@onready var character_nameplate: Label = $left/character/Name

@onready var gpu_particles_2d: GPUParticles2D = $left/GPUParticles2D
@onready var gpu_particles_2d_3: GPUParticles2D = $right/GPUParticles2D3

@onready var bg2: Control = $left/bg
@onready var bg: Control = $right/bg


func _ready() -> void:
	SignalBus.character_selected.connect(cut_in)

func cut_in(character : CharProfile = null):
	if character != null: 
		sprite_2d.texture = character.character_sprite
		character_nameplate.text = character.character_name
		description.text = character.description
		flair.text = character.flair
		flair.set("theme_override_colors/default_color", character.bg_color)
		recolor_bg(character.bg_color)
	
	animation_player.stop()
	#recolor_bg()
	animation_player.play("cut_in")

## TODO: add sound effect lmao
func camera_shake(duration: float = 0.2, intensity : float = 5.0) -> void:
	var old_offset = camera_2d.offset
	
	var tween = create_tween()
	tween.set_trans(Tween.TRANS_SINE)
	tween.set_ease(Tween.EASE_IN_OUT)
	
	for i in range(int(duration * 60)):
		var random_x = randf_range(-intensity, intensity)
		var random_y = randf_range(-intensity, intensity)
		tween.tween_callback(func(): camera_2d.offset = Vector2(random_x, random_y))
		tween.tween_interval(0.016)  # ~1 frame at 60 FPS
	
	tween.tween_callback(func(): camera_2d.offset = old_offset)

func shake_particles(duration: float = 1):
	gpu_particles_2d.emitting = true
	gpu_particles_2d_3.emitting = true
	
	timer.wait_time = duration
	timer.stop()
	timer.start()
	await timer.timeout
	
	gpu_particles_2d.emitting = false
	gpu_particles_2d_3.emitting = false

func play_character_sound():
	AudioManager.set_character_sound()
	AudioManager.play_character_move_sound()

func recolor_bg(color : Color):
	for x in bg2.get_children():
		if x is ColorRect:
			x.color = color
	for x in bg.get_children():
		if x is ColorRect:
			x.color = color
