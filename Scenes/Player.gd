extends KinematicBody2D

const GRAVITY = 2400.0
const WALK_SPEED = 800

var velocity = Vector2()
var target_spring = null
var attached = false

func _physics_process(delta):
	velocity.y += delta * GRAVITY

	if target_spring != null and attached:
		var spring_force = target_spring.spring_constant * (target_spring.global_position - global_position)

		var internal_force = Vector2(0.0, 0.0)
		var mag = 2000
		if Input.is_action_pressed("ui_left"):
			internal_force.x = -mag
		elif Input.is_action_pressed("ui_right"):
			internal_force.x = mag
		if Input.is_action_pressed("ui_up"):
			internal_force.y = - mag
		elif Input.is_action_pressed("ui_down"):
			internal_force.y = mag
			
		velocity += delta * (spring_force + internal_force) - velocity * 0.01

	elif is_on_floor():
		if Input.is_action_pressed("ui_left"):
			velocity.x = -WALK_SPEED
		elif Input.is_action_pressed("ui_right"):
			velocity.x =  WALK_SPEED
		else:
			velocity.x = 0
	else:
		var spring_force = Vector2(0.0, 0.0)

		var internal_force = Vector2(0.0, 0.0)
		var mag = 2000
		if Input.is_action_pressed("ui_left"):
			internal_force.x = -mag
		elif Input.is_action_pressed("ui_right"):
			internal_force.x = mag
			
		velocity += delta * (spring_force + internal_force) - velocity * 0.01
			
	velocity = move_and_slide(velocity, Vector2(0, -1))

func _on_SpringRange_area_entered(area):
	if area.is_in_group("Spring"):
		if target_spring == null:
			target_spring = area

func _on_SpringRange_area_exited(area):
	if area == target_spring and !attached:
		target_spring = null
