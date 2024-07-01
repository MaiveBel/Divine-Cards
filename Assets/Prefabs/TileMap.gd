extends TileMap

var Dic = {}
@export var multiHighlight = false


enum layers{
	Ground1 = 0,
	Ground2 = 1,
	Decor = 2,
	Walls = 3,
	Objects = 4,
	Selection = 5,
}


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !multiHighlight:
		clear_layer(layers.Selection)
	highlight_tile(get_moused_over_tile())

func get_moused_over_tile():
	var tile = local_to_map(get_global_mouse_position())
	return tile

func highlight_tile(tile):
	set_cell(layers.Selection,tile,1,Vector2i.ZERO)

