extends Node2D

var timer = 0
var delay = 2
var start_color = Color(.3,.3,.3)

func _ready():
	VisualServer.set_default_clear_color(start_color)
	Audio_Controller.set_fade(true)
	
func _process(delta):
	timer += delta
	if timer > delay:
		var color = start_color * (1 / (1 + (timer - delay)))
		
		VisualServer.set_default_clear_color(color)

