extends Node

var sfx_player
var sfx_current
var player
var should_play = true
var should_fade = false
var fade_timer = 0
var timer = 0
var next_song: AudioStream
var volume = 0

func _ready():
	sfx_player = AudioStreamPlayer.new()
	add_child(sfx_player)
	player = AudioStreamPlayer.new()
	add_child(player)

func _process(delta):
	if player.get_volume_db() < -100:
		player.stop()
		should_play = false
	if next_song == null:
		should_play = false
	if !player.is_playing():
		if should_play:
			player.set_stream(next_song)
			player.set_volume_db(volume)
			player.play()
	
	if should_fade:
		fade_timer += delta
		player.set_volume_db(player.get_volume_db() - (fade_timer/3))

func request_song(song: AudioStream):
	next_song = song
	if next_song == null:
		should_play = false
	else:
		if (player.get_stream() != next_song) or (!should_play) or should_fade:
			player.stop()
			should_play = true
			set_fade(false)
			player.set_volume_db(0)
			
func request_stop():
	should_play = false
	player.stop()

func set_fade(fade: bool):
	if fade:
		should_fade = true
	else:
		should_fade = false
		

func play_sfx(sfx: String):
	sfx_current = load(sfx)
	if sfx_current != null:
		sfx_player.stop()
		sfx_player.set_stream(sfx_current)
		sfx_player.play()