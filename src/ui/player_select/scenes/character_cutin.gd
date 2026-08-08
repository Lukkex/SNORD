## TODO: export char sprite or something, to update the character portrait, as well as the description text. Also needs a second textbox for the name, also updated

extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer



@onready var rich_text_label: RichTextLabel = $RichTextLabel
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	SignalBus.character_selected.connect(cut_in)
	

func cut_in():
	animation_player.stop()
	animation_player.play("cut_IN")
