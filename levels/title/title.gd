extends Node2D

var song = preload("res://songs/Juhani Junkala Stage 1.ogg")
var new_game = preload("res://levels/intro/Intro.tscn")

var players = []
const TRANSITION_TIME = 3
var timer = 0
var transition = false

func _ready():
	Audio_Controller.request_song(song)

func _process(delta):
	if Input.is_action_just_pressed("ui_accept"):
		transition = !transition
		
	if transition:
		timer += delta
		Audio_Controller.set_fade(true)
	
	if timer > TRANSITION_TIME:
		get_tree().change_scene_to(new_game)
