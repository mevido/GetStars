extends Node2D

# Swap over to a manual timing system.

var song = load("res://songs/Juhani Junkala Stage Select.ogg")
var new_game = preload("res://levels/test/Level.tscn")

const MAX_LOOP = 1
var loops = 0
var length = 0
var playback_time = 0

var players = []
const TRANSITION_TIME = 3
var timer = 0
var transition = false

func _ready():
	Audio_Controller.request_song(song)
	length = song.get_length()

func _process(delta):
	playback_time += delta
	if playback_time >= length:
		loops += 1
		playback_time -= length
	
	if loops >= MAX_LOOP:
		Audio_Controller.request_stop()
		transition = true
	
	if transition:
		timer += delta
	
	if timer > TRANSITION_TIME:
		get_tree().change_scene_to(new_game)
	