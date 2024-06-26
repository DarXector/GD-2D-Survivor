extends Area2D
class_name HurtBoxComponent

signal hit

@export var health_cpomoenent: Node

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")


func _ready():
	area_entered.connect(ona_area_entered)


func ona_area_entered(other_area:Area2D):
	if not other_area is HitBoxComponent: return
	if health_cpomoenent == null: return
	
	var hit_box_cpomonent = other_area as HitBoxComponent
	health_cpomoenent.damage(hit_box_cpomonent.damage)

	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	floating_text.global_position = global_position + Vector2.UP * 16

	var format_string = "%0.1f"
	if round(hit_box_cpomonent.damage) == hit_box_cpomonent.damage:
		format_string = "%0.0f"
	floating_text.start(format_string % hit_box_cpomonent.damage)

	hit.emit()
