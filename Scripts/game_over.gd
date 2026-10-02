extends Control

func _ready() -> void:
	# Ensure the menu is hidden when the game starts
	hide()


func toggle_pause() -> void:
	# Toggle the paused state of the entire game engine
	get_tree().paused = false
	get_tree().reload_current_scene()
	visible = false
	# Show the menu if paused, hide it if resumed


func _on_button_pressed() -> void:
	toggle_pause()
