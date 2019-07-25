extends Node

var song = []
var players
var i = 0
var timer = 0

#func _ready():
#	song.append(load("res://songs/Juhani Junkala Stage 1.ogg"))
#	song.append(load("res://songs/Juhani Junkala Stage Select.ogg"))
#	song.append(load("res://songs/BGM_Epsilon.ogg"))
#	song.append(load("res://songs/Juhani Junkala Stage 2.ogg"))
#	song.append(load("res://songs/Juhani Junkala Boss Fight.ogg"))
#	song.append(load("res://songs/BGM_Alpha.ogg"))
#	song.append(load("res://songs/BGM_Omega.ogg"))
#	song.append(load("res://songs/BGM_Menu.ogg"))
#	players = get_tree().get_nodes_in_group("Audio")
#	pass # Replace with function body.

#func _process(delta):
#	if !players[0].is_playing():
#		players[0].set_stream(song[i])
#		players[0].play()
#		i += 1
#		if i == song.size():
#			i = 0
#	
#	timer += delta
#	if timer > 5:
#		players[0].stop()
#		timer = 0
