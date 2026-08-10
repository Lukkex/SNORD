extends Node2D

@export_file var levels : Array[String] = [
	"res://src/levels/level.tscn", 
	"res://src/levels/level_2.tscn"
]
@onready var current_level : int = 0

func next_level() -> bool:
	if current_level + 1 >= levels.size():
		print("Error: No next level!")
		return false
	current_level += 1
	return true

func get_level_scene(level_num : int) -> String:
	return levels[level_num]

func swap_scene_to_current_level() -> void:
	if levels[current_level]: 
		get_tree().change_scene_to_file(levels[current_level])

func swap_scene_to_next_level() -> void:
	if next_level():
		if levels[current_level]:
			get_tree().change_scene_to_file(levels[current_level])
