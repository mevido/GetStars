extends Node

#var mode
#var level
var stars = 0
# I also need to find a way to keep track of which stars on which levels have been grabbed.
# Probable an array in a dictionary written to by the levels.
var timer = 0
var time_limit = 240 # 4 minutes


func _process(delta):
	timer += delta