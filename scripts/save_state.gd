extends Node

#level>star>player

var players = []
var P_huds = []

var player_totals = []

# Called when the node enters the scene tree for the first time.
func _ready():
	players = get_tree().get_nodes_in_group("Player")
	P_huds = get_tree().get_nodes_in_group("HUD")
	var i = 0
	while i < players.size():
		players[i].my_id = i
		P_huds[i].my_id = i
		player_totals.append(11)
		P_huds[i].init_stars(player_totals[i])
		
		i += 1

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
