extends Node2D
class_name Card_Positioner

@onready var signal_bus = get_node("/root/SignalBus")
var hovered = false
var selected = false
@export var vMoveOnSelect = 230
@export var animDuration = 0.2
var posInHand = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_bus.positionCardInHand.connect(position_card_in_hand)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func position_card_in_hand(targetPos: Vector2,targetRot,targetZ,targetCard):
	if targetCard == self && !hovered && !selected:
		posInHand = targetPos
		var tween = create_tween()
		tween.tween_property(self, "position", posInHand,animDuration)
		tween.play()
		self.z_index = targetZ
		#self.rotation = targetRot
		print(self.position.y)

func _on_button_mouse_entered():
	if !hovered:
		hovered = true
		var final_pos = Vector2 (posInHand.x,posInHand.y + vMoveOnSelect)
		var tween = create_tween()
		tween.tween_property(self, "position", final_pos,animDuration)
		tween.play()
		self.rotation = 0
		self.z_index = 1000




func _on_button_mouse_exited():
	
	hovered = false
	#scale = Vector2(0.5,1)
	signal_bus.calculateCardPositions.emit()
