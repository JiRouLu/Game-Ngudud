extends CharacterBody2D

class_name player

@export var speed: float = 175  # Kecepatan jalan
@export var jump_force: float = 325  # Kekuatan lompat
@export var gravity: float = 1080  # Gravitasi

@export var jump_buffer_time: float = 0.2  # Waktu buffer untuk lompat
var jump_buffer_timer: float = 0  # Timer buffer lompat

@onready var sprite = $AnimatedSprite2D  # Ambil node AnimatedSprite2D

var is_dead: bool = false  # Status apakah pemain mati

func _physics_process(delta):
	if is_dead:
		velocity = Vector2.ZERO  # Hentikan pergerakan jika mati
		return

	# Terapkan gravitasi
	if not is_on_floor():
		velocity.y += gravity * delta

	# Cek tombol lompat ditekan
	if Input.is_action_just_pressed("jump"):
		jump_buffer_timer = jump_buffer_time  # Set buffer waktu lompat

	# Jika buffer waktu masih ada dan pemain di lantai, lakukan lompat
	if jump_buffer_timer > 0 and is_on_floor():
		velocity.y = -jump_force
		jump_buffer_timer = 0  # Reset buffer agar tidak lompat terus-menerus

	# Update timer buffer lompat
	if jump_buffer_timer > 0:
		jump_buffer_timer -= delta

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

func die():
	is_dead = true
	sprite.play("die")  # Mainkan animasi mati
