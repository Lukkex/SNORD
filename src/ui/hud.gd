extends Control

@onready var timer_label: Label = $MarginContainer/TimerLabel

var minutes : int
var seconds : int
var start_time : float

func _ready() -> void:
	start_time = Time.get_unix_time_from_system() * 1000

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.timer_enabled:
		timer_label.visible = true
		timer_label.text = format_time((Time.get_unix_time_from_system() * 1000) - start_time)
	else:
		timer_label.visible = false
	
# Format time into MM:SS:mmm for timer label :3
func format_time(milliseconds: int) -> String:
	#hours = milliseconds / 3600000
	minutes = (milliseconds % 3600000) / 60000
	seconds = (milliseconds % 60000) / 1000
	milliseconds = milliseconds % 1000
	
	return String("%02d:%02d:%03d" % [minutes, seconds, milliseconds])
