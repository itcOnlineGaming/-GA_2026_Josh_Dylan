extends Area2D

signal hit

@export var teleport_cooldown_long := 120.0
@export var teleport_cooldown_short := 40.0

var teleport_cooldown := 0.0
var teleport_timer := 0

@export var speed = 400 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.

func _ready():
	screen_size = get_viewport_rect().size
	hide()

func _input(event):
	if event is InputEventMouseButton:
		print("Mouse Click/Unclick at: ", event.position)

func _process(delta):
	Globals.player_pos = global_position

	if teleport_timer > 0:
		teleport_timer -= delta
	

	var velocity = Vector2.ZERO # The player's movement vector.
	if Input.is_action_pressed(&"move_right"):
		velocity.x += 1
	if Input.is_action_pressed(&"move_left"):
		velocity.x -= 1
	if Input.is_action_pressed(&"move_down"):
		velocity.y += 1
	if Input.is_action_pressed(&"move_up"):
		velocity.y -= 1
	if Input.is_action_just_pressed(&"Teleport") and teleport_timer <= 0:
		position = get_global_mouse_position()
		teleport_timer = teleport_cooldown


	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play()
	else:
		$AnimatedSprite2D.stop()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)

	if velocity.x != 0:
		$AnimatedSprite2D.animation = &"right"
		$AnimatedSprite2D.flip_v = false
		$Trail.rotation = 0
		$AnimatedSprite2D.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite2D.animation = &"up"
		rotation = PI if velocity.y > 0 else 0
		

func set_random_teleport_cooldown():
	if randi() % 2 == 0:
		teleport_cooldown = teleport_cooldown_long
		print("Teleport cooldown chosen: 120s")
	else:
		teleport_cooldown = teleport_cooldown_short
		print("Teleport cooldown chosen: 40s")



func start(pos):
	position = pos
	rotation = 0
	show()
	$CollisionShape2D.disabled = false


func _on_body_entered(_body):
	hide() # Player disappears after being hit.
	hit.emit()
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred(&"disabled", true)
