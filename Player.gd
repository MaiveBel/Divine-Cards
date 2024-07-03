extends Area2D
# player script
@onready var signal_bus = get_node("/root/SignalBus")
@onready var movement_node = $"Movement Node"
@onready var health_node = $"Health Node"
@onready var status_manager = $"Status Manager"
@onready var animation_player = $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready():
	#signal_bus.entityDic[self] = 
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#TODO remake this into on card played
func _unhandled_input(event):
	if Input.is_action_pressed("LeftClick"):
		if !movement_node.tileMap.multiHighlight:
			movement_node.move_to(movement_node.tileMap.SelectedTiles[0],movement_node.tileMap.SelectedTilesGlobal[0])
		else:
			movement_node.tileMap.highlight_tile(movement_node.tileMap.get_moused_over_tile())
		
	if event.is_action_pressed("RightClick"):
		movement_node.tileMap.multiHighlight = !movement_node.tileMap.multiHighlight
		
	if event.is_action_pressed("Deck"):
		movement_node.tileMap.highlight_tile(movement_node.tileMap.get_moused_over_tile())
