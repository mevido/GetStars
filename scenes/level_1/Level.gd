extends Node2D

var song = load("res://songs/BGM_Alpha.ogg")

var grabbed_stars = []
var destination

func _ready():
	Audio_Controller.request_song(song)
	
	# Makes sure you backtrack through the right door. Needs a Position2d named "Alt_Spawn" to work.
	if save_state.back_track:
		var player = get_tree().get_nodes_in_group("Player")[0]
		var loc = get_node("Alt_Spawn").position
		var player_info = player.get_node("CollisionShape2D").shape.extents
		loc.y -= player_info.y
		player.position = loc
	
	# Turns off the stars you already have when you come back to a room.
	if save_state.has_stars.has(name):
		grabbed_stars = save_state.has_stars[name]
		var stars = get_tree().get_nodes_in_group("Star")
		for each in grabbed_stars:
			print("star: " + str(each))
			stars[each].enabled(false)
	
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func leave(to: String, backtrack: bool = false):
	destination = load(to)
	if destination != null:
		save_state.level = to
		save_state.back_track = backtrack
		
		var pocket = get_tree().get_nodes_in_group("Star_Catcher")
		if pocket.size() > 0:
			save_state.stars = pocket[0].stars
		save_state.has_stars[name] = grabbed_stars
		print(save_state.has_stars[name])
		get_tree().change_scene_to(destination)
	pass