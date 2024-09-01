extends Node2D
var direction = 1

func _physics_process(delta):
	position.x += 10 * direction




func _on_area_2d_area_entered(area):
	if area.get_parent() is Skeleton :
		queue_free()
