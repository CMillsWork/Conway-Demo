# Base class for the other cell types, likely
extends Node2D

enum type {
	DIRT,
	LICHEN,
	ANNUAL,
	PERRENIAL,
	FAST_TREE,
	SLOW_TREE
}

# nutrients
var water : int = 0
var nitrates : int = 0
var phosphates : int = 0
var potassium : int = 0
var sunlight : int = 4

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
