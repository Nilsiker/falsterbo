extends CharacterBody3D

@export var SPEED = 5.0
@export var JUMP_FORCE = 5.0
@export var ROTATION_SPEED = 10.0

@onready var nav = $NavigationAgent3D
@onready var camera = $ThirdPersonCamera/SpringArm3D/Camera3D
@onready var mesh = $CollisionShape3D/pointer

var move_direction = Vector3()
var y_movement = 0.0
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	apply_gravity(delta)
	move(delta)
	face_move_direction(delta)
	

func apply_jump_force(force:float) -> void:
		y_movement = force

func set_move_direction(direction: Vector2) -> void:
	var vertical_part = camera.global_transform.basis.z * direction.x
	vertical_part.y = 0
	var horizontal_part = camera.global_transform.basis.x * direction.y
	
	var new_direction = (-vertical_part + horizontal_part).normalized()
	move_direction = new_direction * SPEED

func apply_gravity(delta) -> void:
	if not is_on_floor():
		y_movement -= gravity * delta
	elif y_movement < 0 && is_on_floor():
		y_movement = 0

func move(delta:float) -> void:
	velocity = move_direction
	velocity.y = y_movement
	move_and_slide()

func face_move_direction(delta:float) -> void:
	if !move_direction.is_zero_approx():
		mesh.rotation.y = lerp_angle(
			mesh.rotation.y, 
			atan2(-move_direction.x, -move_direction.z), 
			delta*ROTATION_SPEED
		)

# Signals
func _on_input_move_direction_changed(direction):
	set_move_direction(direction)

func _on_input_jump_requested():
	if is_on_floor():
		apply_jump_force(JUMP_FORCE)

