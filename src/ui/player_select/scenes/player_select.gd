extends Control

@onready var confirmation_button: Button = $ConfirmationButton

func _ready() -> void:
	confirmation_button.visible = false
	SignalBus.character_selected.connect(display)

func display():
	confirmation_button.visible = true
