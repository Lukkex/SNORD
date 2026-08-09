extends Resource
class_name CharProfile

## Name the character (first and last)
@export var character_name : String = ""
## Who are they, why do they do what they do?
@export_multiline() var description: String = ""
## What would they say right now?
@export var flair: String = ""
## Favorite color
@export var bg_color : Color = Color.from_hsv(0.0, 0.0, 1.0, 1.0)
## Sprite
@export var character_sprite : AtlasTexture = null
## Speed Multiplier
@export var speed_multiplier : float = 1.0
