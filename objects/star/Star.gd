extends Sprite

var max_frames
const FRAME_LENGTH = .125
var timer = 0
var id
var col_shape

# Used for keeping track of what stars are grabed.
var level: Node

func _ready():
	level = get_parent()
	# "Who am I?" code.
	var stars = get_tree().get_nodes_in_group("Star")
	id = stars.size()
	add_to_group("Star")
	
	# Animation prep.
	max_frames = (vframes * hframes) - 1
	set_frame(int(rand_range(0, max_frames)))
	
	# Reading the on off switch
	col_shape = get_node("Area2D/CollisionShape2D")

func _process(delta):
	timer += delta
	if timer >= FRAME_LENGTH:
		timer -= FRAME_LENGTH
		if frame == max_frames:
			set_frame(0)
		else:
			set_frame(frame + 1)

# Add code for star collection.

func _on_Area2D_body_entered(body):
	if body.is_in_group("Player"):
		if !col_shape.disabled:
			var holder = get_tree().get_nodes_in_group("Star_Catcher")[0]
			if holder.add_star():
				set_self_modulate(Color(1, 1, 1, .25))
				col_shape.set_deferred("disabled", true)
				if level != null:
					level.grabbed_stars.append(id)

# So the level can turn stars on and off.
func enabled(switch: bool):
	col_shape.set_deferred("disable", !switch)