extends Node2D

@onready var walls: TileMapLayer = $Walls
@onready var spikes: TileMapLayer = $Spikes
const TILE_BREAK_AREA = preload("uid://bdf36hjufx0bj")
const MAP_TILE_DESTRUCTION_BASE_MATERIAL = preload("uid://c832bg8y8wxlm")

@export var tile_desctruction_exceptions : Array[TileMapLayer]

func _ready() -> void:
	for map_layer in get_children():
		if map_layer is TileMapLayer and not map_layer in tile_desctruction_exceptions:
			var tile_array : Array[Vector2i] = map_layer.get_used_cells()
			
			for tile in tile_array:
				var tile_break_area_instance = TILE_BREAK_AREA.instantiate()
				tile_break_area_instance.position = map_layer.map_to_local(tile)
				tile_break_area_instance.tile = tile
				tile_break_area_instance.tile_region = map_layer.get_cell_atlas_coords( Vector2i(tile[0], tile[1]) )
				tile_break_area_instance.layer = map_layer
				map_layer.add_child(tile_break_area_instance)
				
				var break_particles = GPUParticles2D.new()
				break_particles.emitting = false
				break_particles.lifetime = 3.0
				break_particles.explosiveness = 1.0
				break_particles.amount = 6
				break_particles.one_shot = true
				tile_break_area_instance.add_child(break_particles)
				tile_break_area_instance.particles = break_particles
				
				tile_break_area_instance.process_material_instance = MAP_TILE_DESTRUCTION_BASE_MATERIAL
	
	SignalBus.iamatileandyoushouldkillmethanks.connect(tile_detected)

func tile_detected(tile_import, layer_import):
	layer_import.erase_cell(tile_import)
	
