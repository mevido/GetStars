extends Sprite

var my_id # set by save_state.

var stars = 0
var MAX_STARS = 99

var ones
var tens

var timer = 0

func _ready():
	ones = get_node("1")
	tens = get_node("10")
	
	# This is the second half of init_stars()
	# This makes it so the display is updated as soon as it can be.
	update_gui()

func _process(delta):
	timer += delta
	if timer > 1:
		timer -= 1
		if !(add_star(my_id)):
			print("Maxed out!")

func set_stars(total):
	save_state.player_totals[my_id] = total
	update_gui()

func add_star(id): # Returns a value so we know if the star was collected or not.
	
	if save_state.player_totals[my_id] < MAX_STARS:
		save_state.player_totals[my_id] += 1
		update_gui()
		return true
	else:
		return false

func update_gui():
	var a = 0
	var b = 0
	var pocket = save_state.player_totals[my_id]
	while pocket >= 10:
		pocket -= 10
		a += 1
	while pocket >= 1:
		pocket -= 1
		b += 1
	
	if a > 9:
		a = 9
	if b > 9:
		b = 9
	
	tens.set_frame(a)
	ones.set_frame(b)

# Global singleton "save_state" sets the value of stars before the display code works.
# This function catches the data so that it can be used once the sign is ready.
# see _ready() for the rest of the code.
func init_stars(start):
	stars = start