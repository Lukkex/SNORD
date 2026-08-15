extends Node2D

@onready var walls: TileMapLayer = $Walls
const TILE_BREAK_AREA = preload("uid://bdf36hjufx0bj")

func break_tile(collision_pos: Vector2):
	var cell_position = walls.local_to_map(collision_pos)
	walls.erase_cell(cell_position)

func _ready() -> void:
	print("testing\n\nTiles!")
	
	"Returns all cells with the given tile id"
	var tiles = walls.get_used_cells_by_id(0)
	print(tiles, "\n\nTile Global Positions!")
	
	"Returns global position of every tile lol"
	print( walls.map_to_local(tiles[0]) , "\n\n coordinate to tile itself..?")
	
	"Returns coordinate of tile in the tileset atlas"
	print( walls.get_cell_atlas_coords( tiles[0] ) )
	
	
	
	for tile in tiles:
		if walls.get_cell_atlas_coords( Vector2i(tile[0],tile[1]) ) == Vector2i(3,0):
			var tile_break_area_instance = TILE_BREAK_AREA.instantiate()
			tile_break_area_instance.position = walls.map_to_local(tile)
			tile_break_area_instance.tile = tile
			tile_break_area_instance.tile_region = walls.get_cell_atlas_coords( Vector2i(tile[0], tile[1]) )
			walls.add_child(tile_break_area_instance)
			tile_break_area_instance.connect("area_entered", on_tile_entered)

func on_tile_entered(body = null):
	print("tile entered!")
