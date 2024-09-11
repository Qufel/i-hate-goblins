extends Area2D

const BUILD_BUTTON = preload("res://Scenes/build_button.tscn")
@onready var map_control = $"../../UI/MapControl"
const BUILD_MENU = preload("res://Scenes/build_menu.tscn")

var button : Control
var build : Control

func _on_mouse_entered():
	print("Mouse entered over slot: %s" % name)
	button = BUILD_BUTTON.instantiate()
	button.position = get_global_transform_with_canvas().get_origin() + button.position
	button.button_down.connect(showBuildMenu)
	map_control.add_child(button)

func _on_mouse_exited():
	map_control.remove_child(button)
	button.queue_free()

func showBuildMenu():
	build = BUILD_MENU.instantiate()
	build.position = get_global_transform_with_canvas().get_origin() + build.position
	map_control.add_child(build)
