extends RigidBody2D
var speed = 50

var playerPos = Globals.player_pos

func _ready():
	var mob_types = Array($AnimatedSprite2D.sprite_frames.get_animation_names())
	
	
func _physics_process(delta: float) -> void:
	playerPos = Globals.player_pos
	var direction: Vector2 = playerPos - position
	
	if direction.length() == 0:
		linear_velocity = Vector2.ZERO
		return

	direction = direction.normalized()
	
	rotation = direction.angle()
	
	linear_velocity = direction * speed

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
	
