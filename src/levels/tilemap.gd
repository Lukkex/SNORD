extends Node2D

@onready var walls: TileMapLayer = $Walls
@onready var spikes: TileMapLayer = $Spikes
const TILE_BREAK_AREA = preload("uid://bdf36hjufx0bj")

func _ready() -> void:
	for map_layer in get_children():
		if map_layer is TileMapLayer and map_layer.name != "Background":
			var tile_array : Array[Vector2i] = map_layer.get_used_cells()
			
			for tile in tile_array:
				var tile_break_area_instance = TILE_BREAK_AREA.instantiate()
				tile_break_area_instance.position = map_layer.map_to_local(tile)
				tile_break_area_instance.tile = tile
				tile_break_area_instance.tile_region = map_layer.get_cell_atlas_coords( Vector2i(tile[0], tile[1]) )
				tile_break_area_instance.layer = map_layer
				map_layer.add_child(tile_break_area_instance)
				SignalBus.iamatileandyoushouldkillmethanks.connect(tile_detected)

func tile_detected(tile_import, layer_import):
	layer_import.erase_cell(tile_import)
