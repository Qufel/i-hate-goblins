extends Control

@export var buildSpot : Node2D 

func changedBuildSlot(slot : Node2D):
	print("Building at %s" % slot.name)
	buildSpot = slot

func _input(event: InputEvent):
	if event is InputEventMouseButton and event.is_pressed() and event.button_index == 1:
		var evLocal = make_input_local(event)
		if !Rect2(Vector2(0 ,0), size).has_point(evLocal.position):
			queue_free()
