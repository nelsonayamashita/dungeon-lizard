extends Control

var can_restart = false

func _ready():
	$Message.hide()


func _on_Timer_timeout():
	$Message.show()
	can_restart = true


func _input(event):
	if event.is_action_pressed("ui_select") and can_restart:
		get_tree().change_scene(Global.start_screen)
