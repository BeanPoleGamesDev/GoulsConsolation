extends CharacterBody2D


const move_distance = 1000.0

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("ui_up"):
		velocity.y = -move_distance
	if Input.is_action_just_pressed("ui_down"):
		velocity.y = move_distance
	if Input.is_action_just_pressed("ui_left"):
		velocity.x = -move_distance
	if Input.is_action_just_pressed("ui_right"):
		velocity.x = move_distance

	move_and_slide()
	velocity.y = 0
	velocity.x = 0
