extends Node2D
class_name  Arrow
var direction = 1
var velocity = Vector2.ZERO
@onready var sprite = $Sprites
@onready var animation = $AnimationPlayer
var speed = 100
func _physics_process(delta):
	position.x += 10 * direction * speed * delta
	if direction < 0:
		sprite.scale.x =abs(sprite.scale.x) * -1
	elif direction > 0:
		sprite.scale.x =abs(sprite.scale.x) 




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Enemies"):
		queue_free()
