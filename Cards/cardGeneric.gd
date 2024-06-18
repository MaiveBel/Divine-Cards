extends Node2D
class_name Card_Positioner

@onready var signal_bus = get_node("/root/SignalBus")

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_bus.drawCard.connect(position_card_in_hand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func position_card_in_hand(targetPos: Vector2,targetRot,targetZ,targetCard):
	if targetCard == self:
		self.position = targetPos
		self.rotation = targetRot
		self.z_index = targetZ
		
