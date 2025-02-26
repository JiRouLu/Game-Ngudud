extends Node2D

@export var speed: float = 200.0
@export var direction: Vector2 = Vector2(0, 0)  # Bergerak ke kanan

func _process(delta):
	position += direction * speed * delta


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().reload_current_scene()


func _on_reload_2_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().reload_current_scene()


func _on_reload_3_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().reload_current_scene()


func _on_win_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().change_scene_to_file("win.tcsn")


func _on_trap_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().reload_current_scene()


func _on_trap_2_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().reload_current_scene()


func _on_trap_3_body_entered(body: Node2D) -> void:
	if body is player:
		get_tree().reload_current_scene()
