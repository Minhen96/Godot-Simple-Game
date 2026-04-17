extends CharacterBody2D

@export var speed = 200

func _physics_process(delta):
	var direction = Vector2.ZERO

	if Input.is_action_pressed("ui_right"):
		direction.x += 1
	if Input.is_action_pressed("ui_left"):
		direction.x -= 1
	if Input.is_action_pressed("ui_down"):
		direction.y += 1
	if Input.is_action_pressed("ui_up"):
		direction.y -= 1

	velocity = direction.normalized() * speed
	move_and_slide()

	# Clamp player position so it never leaves the screen
	var screen = get_viewport_rect().size
	position.x = clamp(position.x, 32, screen.x - 32)
	position.y = clamp(position.y, 32, screen.y - 32)
