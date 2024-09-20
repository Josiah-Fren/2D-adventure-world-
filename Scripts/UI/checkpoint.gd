extends Node2D
class_name Checkpoint
@export var spawnpoint = false
@onready var activated_cp: AudioStreamPlayer = $ActivatedCP


var activated = false

func _ready():
	if spawnpoint:
		activate()


func activate():
	GameManager.current_checkpoint = self
	activated = true
	$AnimationPlayer.play("Activated")




func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Archer && !activated:
		activated_cp.play()
		activate()
