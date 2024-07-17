extends Card
class_name AttackCard
#atack card info = ["Attack",Name,Time,Range,Damage,Special Effect]
@export var damage : int = 1
@export var hits : int= 1
#[status name,duration]
@export var statuses : Array[Array] = [["Status",1]]



func Play(target: Node):
	var HealthNode = target.get_node("%Health Node")
	for I in range(0,hits,1):
		HealthNode.take_damage(damage)
		print(target)
		for each in statuses:
			pass
			#apply statuses here
		for each in specialEffects:
			pass
