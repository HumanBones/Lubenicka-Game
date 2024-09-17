extends ProgressBar

@export var timer : Timer
@onready var label: Label = $Label

var is_visible : bool = false



func _ready() -> void:
	ScoreManager.multiplier_updated.connect(on_multi_updated)
	ScoreManager.multiplier_reset.connect(on_reset)
	is_visible = false
	max_value = timer.wait_time

func _process(delta: float) -> void:
	if is_visible:
		value = (timer.time_left /max_value) * 100
		print(value)
		

func on_multi_updated(amount) ->void:
	if !is_visible:
		show()
		is_visible = true
	label.text = "COMBO X %s" % amount
	
func on_reset() ->void:
	is_visible = false
	label.text = "COMBO X"
	hide()
