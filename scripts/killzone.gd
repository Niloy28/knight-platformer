extends Area2D

@onready var timer: Timer = $Timer


func _on_body_entered(_body:Node2D):
	get_tree().call_group("player", "play_death_sequence")
	
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1
	get_tree().reload_current_scene()
