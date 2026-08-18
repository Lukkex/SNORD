extends CharacterBody2D

## cooldown for bite animation (including damage frames) in seconds
@export var bite_cooldown : float = 1.0
## speed adder for antag, 0.0 should match player speed
@export_range(-5.0,5.0) var antag_speed_adder : float = 1.0
@export var moving : bool = true

## How fast antag moves, should automatically change depending on player spd
var relative_player_speed : float
## enable or disable biting (loop it)
var bite_bool : bool = false
var bite_lock : bool

@onready var bite_timer: Timer = $BiteTimer
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var hitbox: Area2D = $Hitbox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	bite_timer.wait_time = bite_cooldown
	animated_sprite_2d.frame = 0

func _physics_process(delta: float) -> void:
	relative_player_speed = Global.speed_multiplier
	
	if Global.player != null and moving:
		position.y = Global.player.global_position.y
		velocity.x = (get_gravity().y * delta * relative_player_speed) + (get_gravity().y * delta * (antag_speed_adder/relative_player_speed) )
		velocity.x *= sign(Global.player.position.x - position.x)
	
	if bite_bool:
		bite()
	
	move_and_slide()

## Called solely by animation player
func KYLE():
	AudioManager.play_antagonist_sound()

## TODO: Run this once when the antag gets introduced
func bare_teeth():
	animation_player.play("open_mouth")

## TODO: Run this on loop when the antag gets close to the player
func bite():
	if bite_lock == false:
		animation_player.stop()
		animation_player.play("bite")
		bite_lock = true
		bite_timer.start()

func _on_hitbox_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		body.die()

func _on_detection_box_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		bare_teeth()

func _on_chomp_radius_body_entered(body: Node2D) -> void:
	if body.is_in_group("players"):
		hitbox.monitoring = true
		bite_bool = true

func _on_chomp_radius_body_exited(body: Node2D) -> void:
	if body.is_in_group("players"):
		bite_bool = false

func _on_bite_timer_timeout() -> void:
	bite_lock = false
	
@onready var tilemap_collider: Area2D = $TilemapCollider


## Trying to make antag destroy cells but tilemaps are fucking me
func _on_tilemap_collider_body_entered(body: Node2D) -> void:
	if body.get_parent().has_method("break_tile"): 
		var tilemaplayer : TileMapLayer = body
		#var cell_pos = body.local_to_map(collision_pos)
		#tilemap.erase_cell(1 ,tile_pos)
		
		#body.get_parent().break_tile(body.position)
