extends CharacterBody2D
## Player do jogo de plataforma.

const SPEED: float = 200.0
var JUMP_VELOCITY: float = -400.0

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction: float = Input.get_axis("move_left", "move_right")
	if direction != 0.0:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0.0, SPEED)

	move_and_slide()
func brilhar() -> void:
	$Particulas.restart()
func _update_animation(direction: float, pode_andar: bool) -> void:
	if direction != 0.0:
		animated_sprite.flip_h = direction < 0.0

	if not is_on_floor():
		animated_sprite.play("jump")
	elif direction != 0.0:
		animated_sprite.play("run")
	else:
		animated_sprite.play("idle")
