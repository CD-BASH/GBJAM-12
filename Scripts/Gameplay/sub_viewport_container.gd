extends SubViewportContainer
var time : float
@export var transitionAmmount : float = 2 
@export var speed : float = 0.2 

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	time += delta
	stretch_shrink = round(abs(sin(time * speed) * transitionAmmount))
