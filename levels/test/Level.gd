extends Node2D

var song = load("res://songs/BGM_Epsilon.ogg")

func _ready():
	Audio_Controller.request_song(song)

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
