extends Node2D
class_name Coins
@onready var collectedsound: AudioStreamPlayer2D = $Collectedsound
@onready var audio = $Collectedsound
@onready var sound = $Collectedsound
func _ready():
	$AnimationPlayer.play("Idle")
	

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent() is Archer:
		collectedsound.play()
		GameManager.gain_coins(1)
		await audio.finished
		queue_free()
		
