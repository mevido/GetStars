extends Node2D

# Swap over to a manual timing system.

var song = load("res://songs/Juhani Junkala Stage Select.ogg")
var new_game = preload("res://scenes/level_1/level_1.tscn")

const MAX_LOOP = 1
var loops = 0
var length = 0
var playback_time = 0

var players = []
const TRANSITION_TIME = 3
var timer = 0
var transition = false

var pages
var current_page
var page_time = 0
const page_delay = 10

func _ready():
	Audio_Controller.request_song(song)
	length = song.get_length()
	pages = get_children()
	current_page = pages.size() - 1

func _process(delta):
	page_time += delta
	if page_time > page_delay:
		page_time -= page_delay
		if current_page != 0:
			pages[current_page].hide()
			current_page -= 1
	
	playback_time += delta
	if playback_time >= length:
		loops += 1
		playback_time -= length
	
	if loops >= MAX_LOOP:
		#Audio_Controller.request_stop()
		Audio_Controller.set_fade(true)
		transition = true
	
	if transition:
		timer += delta
	
	if timer > TRANSITION_TIME:
		get_tree().change_scene_to(new_game)
	