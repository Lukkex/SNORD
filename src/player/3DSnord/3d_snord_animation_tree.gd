extends AnimationTree


func _ready() -> void:
	active = true
	SignalBus.player_jump.connect(play_jump_animation)

func play_jump_animation() -> void:
	set("parameters/conditions/jump", true)
	await get_tree().process_frame
	set("parameters/conditions/jump", false)
	set("parameters/conditions/walk", true)
