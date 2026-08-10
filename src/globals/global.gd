extends Node

@onready var DEFAULT_SKIN = preload("res://assets/snord.png")
@onready var player_skin = DEFAULT_SKIN
var speed_multiplier : float = 10.0
var player : Player

var character : CharProfile = preload("uid://c1m6f6h85nuno")
