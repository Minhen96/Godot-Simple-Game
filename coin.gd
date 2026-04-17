extends Area2D

# Declares a custom signal — like creating a button others can subscribe to
signal collected

func _ready():
	# Connect the built-in Area2D signal to our function
	# start listening for physics bodies entering the area
	body_entered.connect(_on_body_entered)

func _on_body_entered(body):
	collected.emit()  # Tell whoever is listening that this coin was collected
	queue_free()      # Remove this coin from the scene
