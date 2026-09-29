extends Node2D

@export_file var levels : Array[String] = [
	"res://src/levels/level.tscn", 
	"res://src/levels/level_2.tscn",
	"res://src/levels/level_3.tscn",
	"res://src/levels/level_4.tscn",
]
@onready var current_level : int = 1

var level_times : Dictionary = {
	1:"null", 
	2:"null",
	3:"null",
	4:"null",
} 

func next_level() -> bool:
	if current_level + 1 >= levels.size():
		print("Error: No next level!")
		return false
	current_level += 1
	return true

func is_on_last_level() -> bool:
	if current_level == levels.size() -1:
		return true
	return false

func get_level_scene(level_num : int) -> String:
	return levels[level_num]

func swap_scene_to_current_level() -> void:
	if levels[current_level]: 
		get_tree().change_scene_to_file(levels[current_level])

func swap_scene_to_next_level() -> void:
	if next_level():
		if levels[current_level]:
			get_tree().change_scene_to_file(levels[current_level])

func update_level_time(time : String) -> void:
	level_times[current_level] = time
	SignalBus.level_time_updated.emit()

func get_current_level_time() -> String:
	return level_times[current_level]
