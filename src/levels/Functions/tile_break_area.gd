extends Area2D

var tile : Vector2i
var tile_region : Vector2i
var layer : TileMapLayer
var particles : GPUParticles2D
var process_material_instance : ParticleProcessMaterial

func _on_area_entered(area: Area2D) -> void:
	if area.name != "TilemapCollider":
		return
	
	var burst_direction = (global_position - area.global_position).normalized()
	process_material_instance.direction = Vector3(burst_direction.x, burst_direction.y, 0.0)
	
	particles.process_material = process_material_instance
	particles.emitting = true
	SignalBus.iamatileandyoushouldkillmethanks.emit(tile, layer)
