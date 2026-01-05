extends Area2D

@export var speed = 50
var direction = "down"
var screen_size


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	$Nameplate.text = $Stats.character_name


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
			$Skin.animation = "idle_front"
			$Skin.flip_h = false
		elif direction == "up":
			$Skin.animation = "idle_back"
			$Skin.flip_h = false
		elif direction == "right":
			$Skin.animation = "idle_right"
			$Skin.flip_h = false
		elif direction == "left":
			$Skin.animation = "idle_right"
			$Skin.flip_h = true
		else:
			$Skin.animation = "idle_front"
			$Skin.flip_h = false
	elif velocity.length() > 0:
		if Input.is_action_pressed("run"):
			velocity = velocity.normalized() * speed * 3
			if direction == "down":
				$Skin.animation = "run_front"
				$Skin.flip_h = false
			elif direction == "up":
				$Skin.animation = "run_back"
				$Skin.flip_h = false
			elif direction == "right":
				$Skin.animation = "run_right"
				$Skin.flip_h = false
			elif direction == "left":
				$Skin.animation = "run_right"
				$Skin.flip_h = true
			else:
				$Skin.animation = "run_front"
				$Skin.flip_h = false
		else:
			velocity = velocity.normalized() * speed
			if direction == "down":
				$Skin.animation = "walk_front"
				$Skin.flip_h = false
			elif direction == "up":
				$Skin.animation = "walk_back"
				$Skin.flip_h = false
			elif direction == "right":
				$Skin.animation = "walk_right"
				$Skin.flip_h = false
			elif direction == "left":
				$Skin.animation = "walk_right"
				$Skin.flip_h = true
			else:
				$Skin.animation = "walk_front"
				$Skin.flip_h = false
	
	$Skin.play()
	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
