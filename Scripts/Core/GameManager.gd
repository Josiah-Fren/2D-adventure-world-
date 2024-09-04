extends Node

signal gained_coins()

var current_checkpoint : Checkpoint

var coins : int

var player 	: Archer

func respawn_player():
	player.health = player.max_health
	if current_checkpoint != null:
		player.position = current_checkpoint.global_position

func gain_coins(coins_gained:int):
	coins += coins_gained
	emit_signal("gained_coins")
	prints(coins)
