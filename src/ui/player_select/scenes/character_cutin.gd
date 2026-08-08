extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	SignalBus.character_selected.connect(cut_in)

func cut_in():
	animation_player.play("cut_IN")
