extends Node2D

@onready var signal_bus = get_node("/root/SignalBus")
const cardBase = preload("res://Cards/card.tscn")
#todo add dictionary of cards and import
@export var hand_node:Node2D
@export var card_holder:Node
@export var draw_timer:Timer
@export var card_pos_timer:Timer
var selected_cards = []

@export var hand_width = 250
@export var hand_height = 56

#draw size
@export var drawSize = 5
@export var moveDrawSize = 5

#wax
@export var wax = 0
@export var endTurnWax = 0
@export var waxDrawAdd = 1
#every tick
@export var waxDecayTime = 1
#every tick while turn is ended
@export var waxDecayTurnEndTime = 2


#decks
@export var fullDeck = []
@export var activeDeck = []

#hand
@export var hand = []
#@export var moveHand = []
@export var handSize = 10

# draw piles
@export var drawPile = []
@export var moveDrawPile = []

# discard piles
@export var discardPile = []
@export var moveDiscardPile = []

# exhaust piles
@export var exhaustPile = []
@export var moveExhaustPile = []

# invisible piles
@export var destroyedPile = []
@export var moveDestroyedPile = []
@export var powerPile = []

#curves
@export var horizontalCurve: Curve
@export var verticalCurve: Curve
@export var angleCurve: Curve

func _ready():
	signal_bus.drawCard.connect(draw_cards)
	signal_bus.calculateCardPositions.connect(set_card_positions)
	signal_bus.putCardBackInHand.connect(put_card_back_in_hand)
	signal_bus.selectedCard.connect(on_card_selected)
	card_pos_timer.timeout.connect(set_card_positions)
	#draw_timer
	signal_bus.drawCard.emit(10)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func draw_cards(cardsToDraw: int) -> void:
	signal_bus.disableCards.emit()
	for card in cardsToDraw:
		draw_timer.start()
		await draw_timer.timeout
		var newCard = cardBase.instantiate()
		hand_node.add_child(newCard)
		hand.append(newCard)
		newCard.indexInHand = hand.find(newCard)
		set_card_positions()
	signal_bus.enableCards.emit()
	#set_card_positions()

#TODO make hand array a RESOURCE array instead of NODE2D

func get_card_hand_ratio(card) -> float:
	var hand_ratio = 0.5
	if hand_node.get_child_count() > 1 :
		hand_ratio = float(hand.find(card))/ float(hand_node.get_child_count() - selected_cards.size() - 1)
		#print(hand_ratio)
	return hand_ratio

func set_card_positions():
	print("test")
	for card in hand:
		var hand_ratio = get_card_hand_ratio(card)
		var destination := hand_node.global_position
		destination.y = 0
		destination.x += horizontalCurve.sample(hand_ratio) * hand_width * 0.2 * clamp(hand_node.get_child_count()- selected_cards.size(),1,7)
		#if hand_node.get_child_count()<= 5:
			#destination.x += horizontalCurve.sample(hand_ratio) * hand_width * 0.2 * clamp(hand_node.get_child_count(),1,10)
		#else:
			#destination.x += horizontalCurve.sample(hand_ratio) * hand_width
		var targetZ= horizontalCurve.sample(hand_ratio) * 1
		var targetRot = calculate_card_rotation(card,hand_ratio)
		destination += verticalCurve.sample(hand_ratio) * Vector2.UP* hand_height
		signal_bus.positionCardInHand.emit(destination,targetRot,targetZ,card)
		#print(card.position)

func calculate_card_rotation(card,hand_ratio):
	var targetRot = angleCurve.sample(hand_ratio) * -0.2
	return targetRot

func on_card_selected(card,index):
	selected_cards.append(card)
	
	hand.erase(card)
	set_card_positions()

func put_card_back_in_hand(card,index):
	selected_cards.erase(card)
	hand.insert(index,card)
	for card2 in hand:
		card2.indexInHand = hand.find(card2)
	set_card_positions()



#TODO REDO ALL OF THIS CARD DRAWING AND POSITION ASSIGNING TO INCLUDE GENERATED CARDS
