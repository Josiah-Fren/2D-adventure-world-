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
	coins += coins_gained # this coin allows it to be counted from 0 to 50
	emit_signal("gained_coins")# this give signals to when a coin is collected
	prints(coins)
	if coins >= 50:# if there is 50 coins collected then it will trigger the ending
		get_tree().change_scene_to_file("res://Scripts/Core/win_sreen.tscn")
#this code allows it so that it will change to the ending screen
