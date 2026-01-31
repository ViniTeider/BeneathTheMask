extends CharacterBody2D

const SPEED = 300.0
const JUMP_VELOCITY = -400.0
const DEADZONE_X = 0.2 
const DAMAGE_COLDOWN = 1.5

@export var player_id: int = 0
@onready var weapon_holder: Node2D = $WeaponHolder

var current_mask: Enum.MaskType
var current_weapon: Node = null
var is_invulnerable: bool = false

var mask_scenes = {
	Enum.MaskType.Gunner: preload("res://scenes/gun.tscn"),
	Enum.MaskType.Melee: preload("res://scenes/sword.tscn")
}


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
	if current_weapon == null: return
	
	var inputVec = Input.get_vector("Left_" + str(player_id), "Right_" + str(player_id), "Up_" + str(player_id), "Down_" + str(player_id))
	
	if inputVec.length() > 0.1:
		weapon_holder.rotation = inputVec.angle()
	
	#BUG: c
	# Com o codigo: Arma fica de ponta cabeça quando para de andar, espada nao funciona por algum motivo
	# Sem o codigo: Arma fica de ponta cabeça se o usuario vai pra esquerda
	# boa sorte tuza :)
	#if inputVec.x < 0:
		#current_weapon.scale.y = -1
	#else:
		#current_weapon.scale.y = 1

	if Input.is_action_just_pressed("Action_" + str(player_id)):
		if current_weapon.has_method("attack"):
			current_weapon.attack()

func change_mask(new_mask_type: Enum.MaskType):
	if current_weapon != null:
		current_weapon.queue_free()
		current_weapon = null
	
	current_mask = new_mask_type
	
	if mask_scenes.has(new_mask_type):
		var new_weapon_scene = mask_scenes[new_mask_type]
		current_weapon = new_weapon_scene.instantiate()
		
		weapon_holder.add_child(current_weapon)

func take_damage():
	if is_invulnerable:
		return
		
	if current_weapon != null:
		is_invulnerable = true
		current_weapon.queue_free()
		current_weapon = null
		
		var timer = get_tree().create_timer(DAMAGE_COLDOWN)
		timer.timeout.connect(func(): is_invulnerable = false)
		blink_effect()
	elif current_weapon == null:
		queue_free()

func blink_effect():
	var tween = create_tween()
	tween.set_loops(int(DAMAGE_COLDOWN * 4))
	tween.tween_property(self, "modulate:a", 0.3, 0.1)
	tween.tween_property(self, "modulate:a", 1.0, 0.1)
	tween.finished.connect(func(): modulate.a = 1.0)
