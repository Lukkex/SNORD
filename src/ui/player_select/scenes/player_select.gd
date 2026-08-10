extends Control

## Add characters to the game!
@export var char_array: Array[CharProfile]
## Intended to be level 1
@export_file("*.tscn") var target_scene : String

@onready var confirmation_button: Button = $ConfirmationButton
@onready var row_1: HBoxContainer = $MarginContainer/CharacterContainer/VBoxContainer2/Row1
@onready var row_2: HBoxContainer = $MarginContainer/CharacterContainer/VBoxContainer2/Row2
@onready var row_3: HBoxContainer = $MarginContainer/CharacterContainer/VBoxContainer2/Row3

const PLAYER_SELECT_ITEM = preload("uid://cvxvp2n8a3200")

var selected_character : CharProfile

func _ready() -> void:
	for x in char_array:
		if row_1.get_child_count() < 5:
			var y : PlayerSelectContainer = PLAYER_SELECT_ITEM.instantiate()
			row_1.add_child(y)
			y.call_deferred("prep", x)
		elif row_2.get_child_count() < 5:
			var y : PlayerSelectContainer = PLAYER_SELECT_ITEM.instantiate()
			row_2.add_child(y)
			y.call_deferred("prep", x)
		elif row_3.get_child_count() < 5:
			var y : PlayerSelectContainer = PLAYER_SELECT_ITEM.instantiate()
			row_3.add_child(y)
			y.call_deferred("prep", x)
		else:
			return
	
	confirmation_button.visible = false
	SignalBus.character_selected.connect(ready)

func ready(character):
	selected_character = character
	Global.character = selected_character
	confirmation_button.visible = true
	AudioManager.set_character_sound()
	AudioManager.play_character_move_sound()

func _on_confirmation_button_pressed() -> void:
	Global.character = selected_character
	SignalBus.game_started.emit()
	if target_scene: get_tree().change_scene_to_file(target_scene)
	else: print("scene not set")
