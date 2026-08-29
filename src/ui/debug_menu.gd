## TODO: make this automatically add new levels

extends Control

@onready var the_holder: VBoxContainer = $MarginContainer/TheHolder
const BUTTON = preload("uid://dtl4fy58wfpbr")

var level_number : int = 0

func _ready() -> void:
	for level in LevelManager.levels:
		level_number += 1
		
		var open_rack = check_for_open_rack()
		if open_rack != null:
			open_rack.add_child(make_button(level))
		else: 
			instance_level_rack().add_child(make_button(level))

func check_for_open_rack() -> HBoxContainer:
	for rack in the_holder.get_children():
		if rack is HBoxContainer and rack.get_child_count() < 5:
			return rack
	return null

func instance_level_rack() -> HBoxContainer:
	var level_rack = HBoxContainer.new()
	
	# I think this isnt working but leaving it anyway because I cant tell the difference but we should have this set
	level_rack.set("size_flags_horizontal", 4)
	level_rack.set("size_flags_vertical", 4)
	level_rack.set("size_flags_vertical", 2)
	
	the_holder.add_child(level_rack)
	return level_rack

func make_button(level):
	var level_button = BUTTON.instantiate()
	level_button.scene = level
	level_button.text = "Level " + str(level_number)
	return level_button
