extends Node2D  # Bisa juga StaticBody2D

@export var speed: float = 200.0  # Kecepatan gerak
@export var move_distance: float = 45.0  # Jarak maksimum
var direction: int = 1
var start_position: Vector2

func _ready():
	start_position = position  # Simpan posisi awal

func _process(delta):
	# Gerakkan platform
	position.x += direction * speed * delta

	# Jika melebihi batas, balik arah
	if abs(position.x - start_position.x) >= move_distance:
		direction *= -1
