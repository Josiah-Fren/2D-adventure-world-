extends CanvasLayer

func _ready():
	GameManager.gained_coins.connect(update_coin_display) 
	#this connects Game manager with the Ui manager so that it can update
	#the Coin counter 
	#When it collects a coin it turns from 0 to 1

func update_coin_display():
	$CoinDisplay.text = str(GameManager.coins) # this emits the signal from 
	#Game manager in order to display it and update thetext for the canvas
	# Counter
	
	
