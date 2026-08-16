extends Area2D

var tile : Vector2i
var tile_region : Vector2i
var layer : TileMapLayer

func _on_area_entered(_area: Area2D) -> void:
	SignalBus.iamatileandyoushouldkillmethanks.emit(tile, layer)
