extends Node2D

@export var levels : Array[PackedScene]
@onready var current_level : int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func next_level() -> bool:
	if current_level + 1 >= levels.size():
		print("Error: No next level!")
		return false
	current_level += 1
	return true

func get_level_scene(level_num : int) -> PackedScene:
	return levels[level_num]

func swap_scene_to_current_level() -> void:
	if levels[current_level]: 
		get_tree().change_scene_to_packed(levels[current_level])

func swap_scene_to_next_level() -> void:
	if next_level():
		if levels[current_level]: 
			get_tree().change_scene_to_packed(levels[current_level])
