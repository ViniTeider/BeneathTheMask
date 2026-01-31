extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DEADZONE_X = 0.2 

@onready var aimArrow: Node2D = $AimArrow
@export var player_id: int = 0

var direction: float = 0 
var last_direction: int = 1

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump_" + str(player_id)) and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var raw_input_x = Input.get_axis("Left_" + str(player_id), "Right_" + str(player_id))
	
	# If the value passes the DEADZONE, round it to 1 or -1
	if abs(raw_input_x) > DEADZONE_X:
		direction = sign(raw_input_x)
	else:
		direction = 0

	if direction != 0:
		velocity.x = direction * SPEED
		last_direction = int(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func _process(delta: float) -> void:
	var inputVec = Input.get_vector("Left_" + str(player_id), "Right_" + str(player_id), "Up_" + str(player_id), "Down_" + str(player_id))
	
	if inputVec.length() > 0.1:
		aimArrow.rotation = inputVec.angle()
