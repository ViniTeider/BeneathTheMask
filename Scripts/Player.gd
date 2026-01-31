extends CharacterBody2D

const JUMP_VELOCITY = -400.0
const JUMP_UPSIDEDOWN = JUMP_VELOCITY*-1
const DEADZONE_X = 0.2 
const DAMAGE_COLDOWN = 1.5

@export var player_id: int = 0
@onready var weapon_holder: Node2D = $WeaponHolder
@onready var sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

var current_mask: Enum.MaskType
var current_weapon: Node = null
var is_invulnerable: bool = false
var was_in_air: bool = false

var speed = 300.0
var can_dash = true

var direction: float = 0 
var last_direction: int = 1

var mask_scenes = {
	Enum.MaskType.Gunner: preload("res://scenes/gun.tscn"),
	Enum.MaskType.Melee: preload("res://scenes/sword.tscn")
}

var sprite_frames = {
	"Player_0": Scenes.PLAYER_0,
	"Player_0_Bomber": Scenes.PLAYER_0_BOMBER,
	"Player_0_Melee": Scenes.PLAYER_0_MELEE,
	"Player_0_Gunner": Scenes.PLAYER_0_GUNNER,
	"Player_1": Scenes.PLAYER_1,
	"Player_1_Bomber": Scenes.PLAYER_1_BOMBER,
	"Player_1_Melee": Scenes.PLAYER_1_MELEE,
	"Player_1_Gunner": Scenes.PLAYER_1_GUNNER,
}

func _ready() -> void:
	change_mask(Enum.MaskType.Bomber)
	sprite_2d.play("idle")
	sprite_2d.sprite_frames = sprite_frames["Player_"+str(player_id)]

func _physics_process(delta: float) -> void:
	if not is_on_floor() and (velocity.y < 2000):
		velocity += get_gravity() * delta
		was_in_air = true

	if Input.is_action_just_pressed("Jump_" + str(player_id)) and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if is_on_floor() and was_in_air:
		Input.start_joy_vibration(player_id, 0.5, 0.1, 0.1)
		was_in_air = false

	var raw_input_x = Input.get_axis("Left_" + str(player_id), "Right_" + str(player_id))
	
	# If the value passes the DEADZONE, round it to 1 or -1
	if abs(raw_input_x) > DEADZONE_X:
		direction = sign(raw_input_x)
	else:
		direction = 0

	if direction != 0:
		velocity.x = direction * speed
		last_direction = int(direction)
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	
	if Input.is_action_just_pressed("Dash_" + str(player_id)):
		if(!can_dash):
			return
		Utils.vibrate_controller(player_id, 0.6, 0.4, 0.15)
		sprite_2d.play("dash")
		$DashTimer.start()
		is_invulnerable = true
		speed = speed * 3
		velocity.x = direction * speed
		
	move_and_slide()

func _process(delta: float) -> void:
	
	if last_direction == 1:
		sprite_2d.flip_h = false
	elif last_direction == -1:
		sprite_2d.flip_h = true

	if (can_dash and !is_invulnerable):
		if velocity.x == 0 and velocity.y == 0:
			sprite_2d.play("idle")

		elif velocity.x != 0 and velocity.y == 0:
			print(sprite_2d.animation)
			sprite_2d.play("walking")
			
		elif velocity.y < 0:
			print(sprite_2d.animation)
			sprite_2d.play("jump")
			
		elif velocity.y > 0:
			sprite_2d.play("falling")
	
	if current_weapon != null:
		var inputVec = Input.get_vector("Left_" + str(player_id), "Right_" + str(player_id), "Up_" + str(player_id), "Down_" + str(player_id))
		
		if inputVec.length() > 0.1:
			weapon_holder.rotation = inputVec.angle()
		
		if current_weapon is Gun:
			current_weapon.scale.y = last_direction


		if Input.is_action_just_pressed("Action_" + str(player_id)):
			if current_weapon.has_method("attack"):
				current_weapon.attack()

func change_mask(new_mask_type: Enum.MaskType):
	if current_weapon != null:
		current_weapon.queue_free()
		current_weapon = null
	
	current_mask = new_mask_type
	
	if Scenes.mask_scenes.has(new_mask_type):
		var new_weapon_scene = Scenes.mask_scenes[new_mask_type]
		current_weapon = new_weapon_scene.instantiate()
		current_weapon.player_id = player_id
		weapon_holder.call_deferred("add_child", current_weapon)
		Utils.vibrate_controller(player_id, 0.4, 0.7, 0.2)
		var mask_sprite_name = "Player_" + str(player_id) + "_" + str(Enum.mask_names[new_mask_type])
		sprite_2d.sprite_frames = sprite_frames[mask_sprite_name]

func take_damage():
	if is_invulnerable:
		return

	Utils.impact_frame(0.5)

	if current_weapon != null:
		is_invulnerable = true
		current_weapon.queue_free()
		current_weapon = null

		var timer = get_tree().create_timer(DAMAGE_COLDOWN)
		timer.timeout.connect(func(): is_invulnerable = false)
		blink_effect()
		sprite_2d.sprite_frames = sprite_frames["Player_"+str(player_id)]
	elif current_weapon == null:
		queue_free()

func blink_effect():
	var tween = create_tween()
	tween.set_loops(int(DAMAGE_COLDOWN * 4))
	tween.tween_property(self, "modulate:a", 0.3, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	tween.finished.connect(func(): modulate.a = 1.0)

func _on_dash_timer_timeout() -> void:
	speed = 300
	is_invulnerable = false
	can_dash = false
	$DashColdownTimer.start()

func _on_dash_coldown_timer_timeout() -> void:
	can_dash = true
