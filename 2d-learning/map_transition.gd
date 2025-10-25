extends Area2D

@export_file var next_world: String

func _physics_process(delta: float) -> void:
	var bodies = get_overlapping_bodies()
	if len(bodies) > 0:
		get_tree().change_scene_to_file(next_world)
