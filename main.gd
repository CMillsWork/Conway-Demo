extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass



func _on_button_toggled(toggled_on):
	if toggled_on:
		%Clock.start()
		%StartButton.text = "Stop"
		%Clock.one_shot = false
	else:
		%Clock.stop()
		%StartButton.text = "Start"
		%Clock.one_shot = true


func _on_step_button_pressed():
	%Clock.start()
