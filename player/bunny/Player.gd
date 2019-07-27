extends KinematicBody2D


const WALK_SPEED = 150
const RUN_SPEED = 470 # about 30 mph
const JUMP_SPEED = -320
const GRAVITY = 342.9568 # pixels/s^2 when 32 pixels = 3 feet.
const T_VELOCITY = 388.84 # 40km/h when 32 pixels = 3 feet. (Wouldn't want are main character to hurt themselves would we ;) )
const COYOTE_TIME = .05
var fall_speed = 0
var hang_time = 0

var ladders = []
var offset = Vector2(0,0)

enum {AIR, CLIMB, STAND, CROUCH}
var state = STAND
var jumping = false # An earlier version did not have a jumping flag.
# this made the character stop jumping during the should I be falling check.
enum {LEFT, RIGHT}
var facing = RIGHT
var dir_intent = Vector2(0,0)

var Player # Link to the animation player.
var GFX # Link to the spritesheet.
var SFX # Link to SFX player

func near_ladder(x_pos):
	ladders.append(x_pos)
	ladders.sort()

func left_ladder(x_pos):
	ladders.erase(x_pos)
	if ladders.size() == 0:
		state = AIR

func _ready():
	Player = get_node("AnimationPlayer")
	GFX = get_node("Sprite")
	SFX = get_node("AudioStreamPlayer2D")
	var extents = get_node("CollisionShape2D").shape.extents
	offset = extents / 2

func _physics_process(delta):
	if is_on_ceiling():
		fall_speed = 0
	jumping = false
	# Input Handling
	dir_intent = Vector2(0,0)
	if Input.is_action_pressed("ui_right"):
		dir_intent.x += 1
		facing = RIGHT
	if Input.is_action_pressed("ui_left"):
		dir_intent.x -= 1
		facing = LEFT
	if Input.is_action_pressed("ui_up"):
		dir_intent.y -=1
	if Input.is_action_pressed("ui_down"):
		dir_intent.y +=1
	if Input.is_action_pressed("ui_accept"):
		if state != AIR:
			SFX.play()
			fall_speed = JUMP_SPEED
			jumping = true
			state = AIR
	
	# Should I be falling?
	if state != CLIMB:
		hang_time += delta
		if is_on_floor() and not jumping:
			state = STAND
			hang_time = 0
		else:
			if state != AIR:
				if hang_time >= COYOTE_TIME:
					state = AIR
	
	# Ladder code
	if dir_intent.y < 0:
		if ladders.size() > 0:
			position.x = ladders[0] - offset.x
			state = CLIMB
	
	if state == CLIMB:
		if dir_intent.y < 0:
			Player.play("climb")
		if dir_intent.y > 0:
			Player.play_backwards("climb")
			if is_on_floor():
				state = STAND
		if dir_intent.y == 0:
			Player.stop(false)
	
	if state == AIR:
		if fall_speed < 0:
			Player.play("jump")
		else:
			Player.play("fall")
	
	if state == STAND:
		if dir_intent.y > 0:
			state = CROUCH
		else:
			if dir_intent.x == 0:
				Player.play("idle")
			else:
				Player.play("walk")
	if state == CROUCH:
		Player.play("duck")
		if !(dir_intent.y > 0):
			state = STAND
	
	# My climbing sprites can not be horizontally flipped mid animation.
	# This code stops the flip, but does not prevent the character from changing directions.
	if state != CLIMB:
		if facing == LEFT:
			GFX.flip_h = true
		else:
			GFX.flip_h = false

#func _physics_process(delta):
	var move = Vector2(0,0)
	if state != AIR:
		fall_speed = 0
	if state != CLIMB:
		fall_speed += GRAVITY * delta
		move.y += fall_speed
		if move.y > T_VELOCITY:
			move.y = T_VELOCITY
	
	
	if state == CLIMB:
		move.y = dir_intent.y * WALK_SPEED
	else:
		if state != CROUCH:
			move.x = dir_intent.x * WALK_SPEED
	
	move_and_slide(move, Vector2(0,-1))