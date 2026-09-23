extends Resource
class_name CharProfile

## Name the character (first and last)
@export var character_name : String = ""
## Who are they, why do they do what they do?
@export_multiline() var description: String = ""
## What would they say right now?
@export var flair: String = ""
## Color they spew when dying
@export var die_color : Color = Color.from_hsv(0.0, 0.0, 1.0, 1.0)
## Favorite color
@export var bg_color : Color = Color.from_hsv(0.0, 0.0, 1.0, 1.0)
## Sprite if using 2D
@export var character_sprite : AtlasTexture = null
## 3D Model Scene if using 3D, will prioritize sprite over 3d models.
@export var three_dimensional_rigup : PackedScene = null
## Speed Multiplier
@export var speed_multiplier : float = 1.0
## Character Sound
@export_file var audio_file : String = ""
