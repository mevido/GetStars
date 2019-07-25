extends Node2D

# Swap over to a manual timing system.

var song = load("res://songs/Juhani Junkala Stage Select.ogg")
var new_game = preload("res://levels/test/Level.tscn")

const MAX_LOOP = 1
var loops = 0

var players = []
const TRANSITION_TIME = 3
var timer = 0
var transition = false

func _ready():
	players = get_tree().get_nodes_in_group("Audio")
	players[0].set_stream(load("res://songs/Juhani Junkala Stage Select.ogg"))
	players[0]
	players[0].play()

func _process(delta):
	if transition:
		timer += delta
		players[0].set_volume_db(players[0].get_volume_db() - (timer/3))
	
	if timer > TRANSITION_TIME:
		get_tree().change_scene_to(new_game)

func _on_AudioStreamPlayer_finished():
	loops += 1
	if loops < MAX_LOOP:
		players[0].play()
	else:
		players[0].stop()
		transition = true