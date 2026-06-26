extends Path3D

@export var enemy_scene: PackedScene
@export var difficulty_manager: Node
@export var victory_layer: CanvasLayer
@export var defeat_layer: CanvasLayer

@onready var timer: Timer = $Timer
@onready var bank = get_tree().get_first_node_in_group("bank")
@onready var base: Node3D = $"../Base"


func spawn_enemy() -> void:
	var new_enemy = enemy_scene.instantiate()
	new_enemy.max_health = difficulty_manager.get_enemy_health()
	add_child(new_enemy)
	timer.wait_time = difficulty_manager.get_spawn_time()
	new_enemy.tree_exited.connect(enemy_gone)

func _on_difficulty_manager_stop_spawning_enemies() -> void:
	timer.stop()

func enemy_gone() -> void:
	if timer.is_stopped():
		for child in get_children():
			if child is PathFollow3D:
				return
		if base.current_health > 0:				
			victory_layer.victory()
		else:
			defeat_layer.defeat()
