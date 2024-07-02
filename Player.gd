extends Area2D
# player script
@onready var movement_node = $"Movement Node"
@onready var health_node = $"Health Node"
@onready var status_manager = $"Status Manager"
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#TODO remake this into on card played
func _unhandled_input(event):
	if event.is_action_pressed("LeftClick"):
		movement_node.move(movement_node.tileMap.SelectedTile,movement_node.tileMap.SelectedTileGlobal)
		#print("moved")
