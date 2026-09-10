extends Node2D
class_name destructible_tilemap

const TILE_BREAK_AREA = preload("uid://bdf36hjufx0bj")
const MAP_TILE_DESTRUCTION_BASE_MATERIAL = preload("uid://c832bg8y8wxlm")

@export var destruction_enabled : bool = true
@export var tile_desctruction_exceptions : Array[TileMapLayer]

@onready var obstacles_layer: TileMapLayer = $Obstacles

var animated_tiles: Dictionary = {}

## Instantiates break particles on EVERYTHING in the tilemap layers
func _ready() -> void:
	for map_layer: TileMapLayer in get_children():
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
				
				# Check if the tile has an animation, and register it
				var tile_data : TileData = map_layer.get_cell_tile_data(tile)
				## CRITICAL: TileData does not contain much info, I need to gte info from TileSetAtlasSource through some BS shit. deets in ai.
				#var tile_atlas = map_layer.get
				if tile_data:
					var tile_frames_count = tile_data.get("animation_separation")
					if tile_frames_count:
						print(tile_frames_count)
						if tile_data and tile_frames_count > 0:
							register_animated_tile(map_layer, tile, tile_data)
							add_visibility_detector(tile_break_area_instance, tile)
	
	SignalBus.iamatileandyoushouldkillmethanks.connect(tile_detected)

func add_visibility_detector(tile_break_area:Node2D, coords: Vector2i) -> void:
	var notifier = VisibleOnScreenNotifier2D.new()
	notifier.scale = Vector2(0.5, 0.5) # Adjust size to match tile size
	tile_break_area.add_child(notifier)
	
	notifier.screen_entered.connect(func() -> void: 
		if coords in animated_tiles and not animated_tiles[coords]["is_running"]:
			animate_tile(coords)
		)

func register_animated_tile(tilemap_layer: TileMapLayer, coords: Vector2i, tile_data: TileData) -> void:
	var frames: Array[Vector2i] = []
	var frame_duration = tile_data.animation_frame_duration(0)
	
	# Extract all frames from the TileSet animation
	for i in range(tile_data.animation_frames_count):
		frames.append(tile_data.get_animation_frame_texture_atlas_uv(i))
	
	animated_tiles[coords] = {
		"tilemap_layer": tilemap_layer,
		"source_id": tilemap_layer.get_cell_source_id(coords),
		"frames": frames,
		"frame_duration": frame_duration,
		"is_running": false
	}
	print("Registered animated tile at ", coords, " with ", frames.size(), " frames")


func tile_detected(tile_import, layer_import):
	layer_import.erase_cell(tile_import)
	AudioManager.play_tile_break_sound(tile_import)

func rig_obstacles():
	var tile_array : Array[Vector2i] = obstacles_layer.get_used_cells()
	
	for tile in tile_array:
		pass

func animate_tile(coords: Vector2i) -> void:
	var tile_data = animated_tiles[coords]
	tile_data["is_running"] = true
	
	while tile_data["is_running"]:
		for frame in tile_data["frames"]:
			await get_tree().create_timer(tile_data["frame_duration"]).timeout
			tile_data["tilemap_layer"].set_cell(coords, tile_data["source_id"], frame)
		
