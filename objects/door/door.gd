extends Area2D

export var new_scene: String
export var requirment: int
var scene

func _ready():
	set_process(false)
	scene = load(new_scene)

func _process(delta):
	if Input.is_action_just_pressed("ui_up"):
		if scene == null:
			print("The door is locked!")
		else:
			var stars = get_tree().get_nodes_in_group("Star_Catcher")[0]
			if stars.stars >= requirment:
				get_tree().change_scene_to(scene)
			else:
				print("You need " + str(requirment) + " star(s) to open this door!")

func _on_door_body_entered(body):
	if body.is_in_group("Player"):
		set_process(true)

func _on_door_body_exited(body):
	if body.is_in_group("Player"):
		set_process(false)