extends Node2D

var song = preload("res://songs/Juhani Junkala Stage 1.ogg")
var new_game = preload("res://levels/intro/Intro.tscn")

var players = []
const TRANSITION_TIME = 3
var timer = 0
var transition = false

func _ready():
	players = get_tree().get_nodes_in_group("Audio")
	players[0].set_stream(song)
	players[0].play()

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		transition = !transition
		
	if transition:
		timer += delta
		players[0].set_volume_db(players[0].get_volume_db() - (timer/3))
	
	if timer > TRANSITION_TIME:
		get_tree().change_scene_to(new_game)
