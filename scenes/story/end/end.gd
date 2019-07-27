extends Node2D

#var ending1
#var ending2

func _ready():
	Audio_Controller.set_fade(true)
#	if save_state.timer < save_state.time_limit:
#		add_child(ending1)
#	else:
#		add_child(ending2)