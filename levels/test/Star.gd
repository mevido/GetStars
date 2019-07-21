extends Sprite

var max_frames
const FRAME_LENGTH = .125
var timer = 0

func _ready():
	max_frames = (vframes * hframes) - 1
	set_frame(int(rand_range(0, max_frames)))
	pass # Replace with function body.

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
		print("Found one!")
