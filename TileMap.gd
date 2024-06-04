extends TileMap

var grid_size = 12
var dic = {}

# 0 = empty
# 1 = populated
var cells = []

# 0 = die
# 1 = stay
# 2 = populate
var operations = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for x in grid_size:
		cells.append([])
		operations.append([])
		for y in grid_size:
			dic[str(Vector2(x,y))] = {
				"Type" : "Grass"
			}
			set_cell(0, Vector2(x,y), 0, Vector2i(0,0), 0)
			cells[x].append(0)
			operations[x].append(1)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var tile = local_to_map(get_global_mouse_position())
	
	# check cells' conditions
	for x in grid_size:
		for y in grid_size:
			erase_cell(1,Vector2(x,y))
	
	if dic.has(str(tile)):
		set_cell(1, tile, 1, Vector2i(0,0), 0)
		#print_debug('x=',tile.x, ' y=', tile.y, ' data=', cells[tile.x][tile.y])


func _unhandled_input(event):
	if Input.is_action_pressed('mouse_left'):
		var mouse_position = local_to_map(get_global_mouse_position())
		set_cell(2, mouse_position, 3, Vector2i(0,0), 0)
		cells[mouse_position.x][mouse_position.y] = 1
	if Input.is_action_pressed('mouse_right'):
		var mouse_position = local_to_map(get_global_mouse_position())
		erase_cell(2, mouse_position)
		cells[mouse_position.x][mouse_position.y] = 0
		
func check_neighbors(x,y):
	var total_neighbors = 0
	# left
	if x > 0 && cells[x-1][y] == 1:
		#print_debug('neighbor found left: ',x-1,',', y,': ', cells[x-1][y])
		total_neighbors += 1
	# right
	if x < grid_size-1 && cells[x+1][y] == 1:
		#print_debug('neighbor found right')
		total_neighbors += 1
	# up
	if y > 0 && cells[x][y-1] == 1:
		#print_debug('neighbor found up')
		total_neighbors += 1
	# down
	if y < grid_size-1 && cells[x][y+1] == 1:
		#print_debug('neighbor found down')
		total_neighbors += 1
	# left and up
	if x > 0 && y > 0 && cells[x-1][y-1] == 1:
		#print_debug('neighbor found left and up')
		total_neighbors += 1
	# left and down
	if x > 0 && y < grid_size-1 && cells[x-1][y+1] == 1:
		#print_debug('neighbor found left and down')
		total_neighbors += 1
	# right and up
	if x < grid_size-1 && y > 0 && cells[x+1][y-1] == 1:
		#print_debug('neighbor found right and up')
		total_neighbors += 1
	# right and down
	if x < grid_size-1 && y < grid_size-1 && cells[x+1][y+1] == 1:
		#print_debug('neighbor found right and down for ', x,',',y)
		total_neighbors += 1
	
	if total_neighbors < 2: # incorrect population
		operations[x][y] = 0
	elif total_neighbors == 2: # no change
		operations[x][y] = 1
	elif total_neighbors == 3: # happy middle
		operations[x][y] = 2
	elif total_neighbors > 3: # incorrect population
		operations[x][y] = 0


func _on_timer_timeout():	
	for x in grid_size:
		for y in grid_size:
			check_neighbors(x,y)
	
	for x in grid_size:
		for y in grid_size:
			if operations[x][y] == 0:
				cells[x][y] = 0
				erase_cell(2, Vector2(x,y))
			elif operations[x][y] == 1:
				pass
			elif operations[x][y] == 2:
				cells[x][y] = 1
				set_cell(2, Vector2(x,y), 3, Vector2i(0,0), 0)
				
			operations[x][y] = 0 
