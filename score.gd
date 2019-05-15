extends Label

func coin_collected(coins):
	self.text = "Score: " + str(coins*10)
	self.show()
	pass
	