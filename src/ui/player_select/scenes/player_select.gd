extends Control

## Add characters to the game!
@export var char_array: Array[CharProfile]
## Intended to be level 1
@export_file("*.tscn") var target_scene : String

@onready var confirmation_button: Button = $ConfirmationButton
@onready var row1: HBoxContainer = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer
@onready var row2: HBoxContainer = $MarginContainer/VBoxContainer/VBoxContainer2/HBoxContainer2

const PLAYER_SELECT_ITEM = preload("uid://cvxvp2n8a3200")

var selected_character : CharProfile

func _ready() -> void:
	for x in char_array:
		if row1.get_child_count() < 5:
			var y : PlayerSelectContainer = PLAYER_SELECT_ITEM.instantiate()
			row1.add_child(y)
			y.call_deferred("prep", x)
		elif row2.get_child_count() < 5:
			var y : PlayerSelectContainer = PLAYER_SELECT_ITEM.instantiate()
			row2.add_child(y)
			y.call_deferred("prep", x)
		else:
			return
	
	confirmation_button.visible = false
	SignalBus.character_selected.connect(ready)

func ready(character):
	selected_character = character
	confirmation_button.visible = true

func _on_confirmation_button_pressed() -> void:
	Global.character = selected_character
	if target_scene: get_tree().change_scene_to_file(target_scene)
	else: print("scene not set")
