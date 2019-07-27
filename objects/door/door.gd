extends Area2D

export var new_scene: String
export var requirment: int
var scene

var id

func _ready():
	set_process(false)
	scene = load(new_scene)
	id = get_tree().get_nodes_in_group("Door").size()
	add_to_group("Door")

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if scene == null:
			print("The door is locked!")
		else:
			var stars = get_tree().get_nodes_in_group("Star_Catcher")
			if stars.size() > 0:
				stars = stars[0].stars
			else:
				stars = 0
			if stars >= requirment:
				Audio_Controller.play_sfx("res://objects/door/Exit 1.wav")
				var backtrack: bool
				print(id)
				if id == 0:
					backtrack = true
				else:
					backtrack = false
				print(backtrack)
				get_parent().leave(new_scene, backtrack)
			else:
				print("You need " + str(requirment) + " star(s) to open this door!")

func _on_door_body_entered(body):
	if body.is_in_group("Player"):
		set_process(true)

func _on_door_body_exited(body):
	if body.is_in_group("Player"):
		set_process(false)