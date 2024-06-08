extends CharacterBody2D

@export var enemy_scene: PackedScene = preload("res://scene/enemy.tscn")
@export var enemy_script: Script = load("res://script/enemy.gd")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var SPLIT = false
var SPLIT_COUNT = 1

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()


func _on_area_2d_area_entered(_area):
	if SPLIT_COUNT > 0:
		for n in 2:
			var enemy = enemy_scene.instantiate() as CharacterBody2D
			enemy.scale.x = 0.5
			enemy.scale.y = 0.5
			enemy.position.x = position.x + n * 100
			enemy.position.y = position.y
			enemy.set_script(enemy_script)
			enemy.SPLIT_COUNT = 0
			get_parent().add_child(enemy)
	queue_free()
