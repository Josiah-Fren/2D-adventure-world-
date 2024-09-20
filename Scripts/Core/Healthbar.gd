extends Control

@onready var fill_max = $ColorRect.size.x 
var fill_amount : float
# this makes it so that if the health is max then it will fill up the bar with 
#the chosen colour
func update_healthbar(health, max_health):
	fill_amount = (float(health) / max_health) * fill_max
	$ColorRect.size.x = fill_amount
#This code is used to update the Health UI for the skeleton
#if it takes damage the float amount will decrease meaning it will
#Decrease the colour on the healthu bar
