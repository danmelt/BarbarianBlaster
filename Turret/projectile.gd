extends Area3D
@onready var barrel: MeshInstance3D = $"../TurretBase/TurretTop/BarrelBase/Barrel"
var direction := Vector3.FORWARD
@export var speed := 30.0

func onready() -> void:
	position = barrel.global_position

func _physics_process(delta: float) -> void:
	position += direction * speed * delta 
	
func _on_timer_timeout() -> void:
	queue_free()


func _on_area_entered(area: Area3D) -> void:
	if area.is_in_group("enemy_area"):
		print(area)
		area.get_parent().current_health -= 25
		queue_free()
