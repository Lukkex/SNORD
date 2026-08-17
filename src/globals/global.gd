extends Node

@onready var DEFAULT_SKIN = preload("res://assets/snord.png")
@onready var player_skin = DEFAULT_SKIN

var speed_multiplier : float = 10.0
var fwd_input_multiplier : float = 1.0
var back_input_multiplier : float = 1.0
var player : Player
var player_camera : Camera2D
var timer_enabled : bool = true
var character : CharProfile = preload("uid://c1m6f6h85nuno")

var can_pause : bool = true
