extends Node

@export var health_compoennt: Node
@export var sprite: Sprite2D
@export var hit_flash_material: ShaderMaterial

var hit_flash_tween: Tween


func _ready():
	health_compoennt.health_changed.connect(on_health_cahnged)
	sprite.material = hit_flash_material


func on_health_cahnged(health):
	if hit_flash_tween != null && hit_flash_tween.is_valid():
		hit_flash_tween.kill()
	
	hit_flash_tween = create_tween()
	(sprite.material as ShaderMaterial).set_shader_parameter("lerp_percent", 1.0)
	hit_flash_tween.tween_property(sprite.material, "shader_parameter/lerp_percent", 0.0, 0.25)\
	.set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
