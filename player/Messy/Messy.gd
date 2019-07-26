extends Area2D

var timer: float = 0
const TIME_LIMIT: float = 1.2
var it_is_done: bool = false

func _ready():
	pass # Replace with function body.

func _process(delta):
	if !it_is_done:
		timer += delta
		if timer >= TIME_LIMIT:
			get_node("AnimationPlayer").play("Light")
			it_is_done = true
	

func _burn():
	get_node("AnimationPlayer").play("Burn")