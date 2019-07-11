extends Area2D

var x_pos = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	x_pos = position.x + (get_node("CollisionShape2D").shape.extents.x / 2)
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	body.near_ladder(x_pos)


func _on_Area2D_body_exited(body):
	body.left_ladder(x_pos)
