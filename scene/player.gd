extends CharacterBody2D

@export var speed: float = 200  # Kecepatan jalan
@export var jump_force: float = 400  # Kekuatan lompat
@export var gravity: float = 980  # Gravitasi

@onready var sprite = $AnimatedSprite2D  # Ambil node AnimatedSprite2D

func _physics_process(delta):
	# Terapkan gravitasi saat tidak di lantai
	if not is_on_floor():
		velocity.y += gravity * delta

	# Lompatan
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = -jump_force

	# Gerakan kiri/kanan
	var direction = Input.get_axis("left", "right")
	velocity.x = direction * speed

	# Flip sprite jika bergerak ke kiri
	if direction != 0:
		sprite.flip_h = direction < 0  # True jika ke kiri

	# Atur animasi berdasarkan kondisi yang benar
	if is_on_floor():
		if direction == 0:
			sprite.play("idle")  # Animasi diam
		else:
			sprite.play("walk")  # Animasi berjalan
	else:
		sprite.play("jump")  # Animasi melompat

	# Terapkan pergerakan
	move_and_slide()
