extends Node2D

var available = [true, true, true]

func restart():
	available = [true, true, true]

func _on_s_1_body_exited(_body):
	if not $s_1.get_overlapping_bodies():
		available[0] = true


func _on_s_2_body_exited(_body):
	if not $s_2.get_overlapping_bodies():
		available[1] = true


func _on_s_3_body_exited(_body):
	if not $s_3.get_overlapping_bodies():
		available[2] = true


func _on_s_1_body_entered(_body):
	available[0] = false


func _on_s_2_body_entered(_body):
	available[1] = false


func _on_s_3_body_entered(_body):
	available[2] = false
