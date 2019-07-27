extends Node2D

var destination
var grabbed_stars = []

func _ready():
	Audio_Controller.set_fade(true)

func leave(to: String, backtrack: bool = false):
	destination = load(to)
	if destination != null:
		save_state.level = to
		save_state.back_track = backtrack
		save_state.has_stars[name] = grabbed_stars
		print(save_state.has_stars)
		get_tree().change_scene(to)