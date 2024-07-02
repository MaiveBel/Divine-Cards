extends Node2D
class_name Card_Positioner

@onready var signal_bus = get_node("/root/SignalBus")
var followMouse = false 
var cardHovered = false
var cardSelected = false
@export var vMoveOnSelect = 230
@export var animDuration = 0.2
@export var unhoverable = false
var posInHand = Vector2(0,0)
var indexInHand = 0
var currentSelectedCards = []

# Called when the node enters the scene tree for the first time.
func _ready():
	signal_bus.positionCardInHand.connect(position_card_in_hand)
	signal_bus.disableCards.connect(disable)
	signal_bus.enableCards.connect(enable)
	signal_bus.selectedCard.connect(on_card_selected)
	signal_bus.putCardBackInHand.connect(on_card_deselected)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if followMouse:
		self.global_position = get_global_mouse_position()

func position_card_in_hand(targetPos: Vector2,targetRot,targetZ,targetCard):
	if targetCard == self && !cardHovered && !cardSelected:
		disable(null)
		posInHand = targetPos
		var tween = create_tween()
		
		tween.tween_property(self, "position", posInHand,animDuration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.play()
		self.z_index = targetZ
		#self.rotation = targetRot
		await tween.finished
		enable()


func _on_button_mouse_entered():
	if !cardSelected:
		hovered()

func hovered():
	if !cardHovered:
		cardHovered = true
		var final_pos = Vector2 (posInHand.x,posInHand.y - vMoveOnSelect)
		self.rotation = 0
		
		var tween = create_tween()
		tween.tween_property(self, "position", final_pos,animDuration).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN)
		tween.play()
		self.z_index = 1000
		signal_bus.calculateCardPositions.emit()
		signal_bus.disableCards.emit(self)

func _on_button_mouse_exited():
	unhovered()
	

func unhovered():
	cardHovered = false
	#scale = Vector2(0.5,1)
	signal_bus.calculateCardPositions.emit()
	signal_bus.enableCards.emit()
	
	

func disable(excludedCard):
	if excludedCard != self:
		unhoverable = true
		$Button.hide()

func enable():
	unhoverable = false
	$Button.show()


func _on_button_gui_input(event):
	if (event is InputEventMouseButton) and (event.button_index == 1):
		if event.button_mask == 1:
			if cardHovered && currentSelectedCards.size() < 1:
				signal_bus.selectedCard.emit(self,indexInHand)
				cardHovered = false
				followMouse = true
				cardSelected = true
				
		elif event.button_mask == 0:
			followMouse = false
			cardSelected = false
			cardHovered = false
			signal_bus.putCardBackInHand.emit(self,indexInHand)
			

func on_card_selected(card,index):
	currentSelectedCards.append(card)

func on_card_deselected(card,index):
	currentSelectedCards.erase(card)
