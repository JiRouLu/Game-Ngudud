extends CharacterBody2D

func _physics_process(delta: float) -> void:
	velocity = Input.get_vector("left", "right", "up", "down")*1200
	move_and_slide()
