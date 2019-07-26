extends Sprite

var stars = 0
var MAX_STARS = 99

var ones: Sprite # Ones digit display (Sprite)
var tens: Sprite # Tens digit display (Sprite)

func _ready():
	ones = get_node("1")
	tens = get_node("10")
	
	# save_state is for save management.
	stars = save_state.stars
	update_gui()

func set_stars(total):
	stars = total
	update_gui()

func add_star() -> bool: # Returns a value so we know if the star was collected or not.
	if stars < MAX_STARS:
		stars += 1
		update_gui()
		return true
	else:
		return false

func update_gui():
	var a = 0
	var b = 0
	var pocket = stars
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