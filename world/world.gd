extends Node2D

@onready var collision_polygon = $Environment/CollisionPolygon2D
@onready var polygon = $Environment/Polygon2D

func _ready():
	collision_polygon.polygon = polygon.polygon
