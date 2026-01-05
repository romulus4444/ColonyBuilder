extends Area2D

@export var speed = 50
var direction = "down"
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
		direction = "right"
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
		direction = "left"
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		direction = "down"
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
		direction = "up"
	
	if velocity.length() == 0:
		if direction == "down":
			$AnimatedSprite2D.animation = "idle_front"
			$AnimatedSprite2D.flip_h = false
		elif direction == "up":
			$AnimatedSprite2D.animation = "idle_back"
			$AnimatedSprite2D.flip_h = false
		elif direction == "right":
			$AnimatedSprite2D.animation = "idle_right"
			$AnimatedSprite2D.flip_h = false
		elif direction == "left":
			$AnimatedSprite2D.animation = "idle_right"
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.animation = "idle_front"
			$AnimatedSprite2D.flip_h = false
	elif velocity.length() > 0:
		if Input.is_action_pressed("run"):
			velocity = velocity.normalized() * speed * 3
			if direction == "down":
				$AnimatedSprite2D.animation = "run_front"
				$AnimatedSprite2D.flip_h = false
			elif direction == "up":
				$AnimatedSprite2D.animation = "run_back"
				$AnimatedSprite2D.flip_h = false
			elif direction == "right":
				$AnimatedSprite2D.animation = "run_right"
				$AnimatedSprite2D.flip_h = false
			elif direction == "left":
				$AnimatedSprite2D.animation = "run_right"
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.animation = "run_front"
				$AnimatedSprite2D.flip_h = false
		else:
			velocity = velocity.normalized() * speed
			if direction == "down":
				$AnimatedSprite2D.animation = "walk_front"
				$AnimatedSprite2D.flip_h = false
			elif direction == "up":
				$AnimatedSprite2D.animation = "walk_back"
				$AnimatedSprite2D.flip_h = false
			elif direction == "right":
				$AnimatedSprite2D.animation = "walk_right"
				$AnimatedSprite2D.flip_h = false
			elif direction == "left":
				$AnimatedSprite2D.animation = "walk_right"
				$AnimatedSprite2D.flip_h = true
			else:
				$AnimatedSprite2D.animation = "walk_front"
				$AnimatedSprite2D.flip_h = false
	
	$AnimatedSprite2D.play()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
