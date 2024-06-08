extends Area2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	position += transform.x * 500 * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()



func _on_area_entered(area):
	if area.name == "enemy_hurtbox":
		queue_free()
