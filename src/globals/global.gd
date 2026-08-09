extends Node

@onready var DEFAULT_SKIN = preload("res://assets/snord.png")
@onready var player_skin = DEFAULT_SKIN

var speed_multipler : float = 10.0
var player : Player

var character : CharProfile
