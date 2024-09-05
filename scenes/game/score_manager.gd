extends Node

signal score_updated(amount)
signal high_score_updated(amount)

var score : float = 0
var high_score : float
var multiplier : int = 1
var max_multiplier : int = 10

func update_score(amount:float) ->void:
	score += amount * multiplier
	print("score %s" % score)
	print("multi: %s" % multiplier)
	if score > high_score:
		high_score = score
		high_score_updated.emit(high_score)
		
	score_updated.emit(score)
	
func update_multiplier() ->void:
	multiplier += 1

func reset_multiplier() ->void:
	multiplier = 1
