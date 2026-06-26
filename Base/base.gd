extends Node3D


@export var max_health: int = 5
@export var enemy_path: Path3D
@onready var label_3d: Label3D = $Label3D
@onready var defeat_layer: CanvasLayer = $"../DefeatLayer"

var current_health: int:
	set(health_in):
		current_health = max(health_in, 0)
		label_3d.text = str(current_health)	+ "/" + str(max_health)
		var red: Color = Color.RED
		var white: Color = Color.WHITE
		label_3d.modulate = red.lerp(white, float(current_health) / float(max_health))
		
		if current_health < 1:
			get_tree().paused = true
			defeat_layer.visible = true
			#enemy_path.timer.stop()
			#enemy_path.enemy_gone()
			#get_tree().reload_current_scene()
	#get() -> int:
		
		

func _ready() -> void:
	current_health = max_health
	#Engine.time_scale = 5

func take_damage() -> void:
	current_health -= 1
