extends Node

@onready var score_label = $ScoreLabel


var score := 0
var format_string := "You've collected {coin} coins"


func add_point():
	score += 1
	score_label.text = format_string.format({"coin": score})
