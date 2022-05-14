extends TileMap

# Enumerations for cell states to enhance code readability
# Black (tile 0) = OFF, White (tile 1) = ON
enum {ON, OFF}

# Size of OLED in pixels
onready var bounds = Vector2(128, 32)

# Clicked cell position
onready var cell_pos

# Clicked cell status (ON or OFF)
onready var cell_status

# Set every pixel to OFF on startup
func _ready():
	clearDisplay()
	
	drawSine(10)

# Respond to mouse click
func _input(event):
	# Mouse in viewport coordinates.
	if event is InputEventMouseButton:
		if event.pressed:
			# Get TileMap's cell position and status at clicked position 
			cell_pos = world_to_map(event.position)
			cell_status = get_cell(cell_pos.x, cell_pos.y)
			
			# Check clicked cell is within bounds of the OLED display
			if (cell_pos.x in range(bounds.x)) and (cell_pos.y in range(bounds.y)):
				# Toggle the status of the clicked cell
				set_cell(cell_pos.x, cell_pos.y, !cell_status)

# Draw a sine wave of 5Hz within the bounds of the display
func drawSine(freq : float):
	var y : float
	for i in range(bounds.x):
		y = (14 * sin(i * freq * 2 * PI / bounds.x))
		set_cell(i, 16 - y, ON)

func drawFreqResponse():
	for x in range(bounds.x):
		for y in rand_range(2, 30):
			set_cell(x, bounds.y - 2 - y, ON)

# Set all pixels to black
func clearDisplay():
	for i in bounds.x:
		for j in bounds.y:
			set_cell(i, j, OFF)

func _on_ClearButton_pressed():
	clearDisplay()

func _on_DrawSineButton_pressed():
	clearDisplay()
	drawSine(4)


func _on_DrawFreqResponseButton_pressed():
	clearDisplay()
	drawFreqResponse()
