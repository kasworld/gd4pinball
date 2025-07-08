extends Node3D

var tex_array = [
	preload("res://BallTexture/ball1.tres"),	
	preload("res://BallTexture/ball2.tres"),	
	preload("res://BallTexture/ball3.tres"),	
	preload("res://BallTexture/ball4.tres"),	
	preload("res://BallTexture/ball5.tres"),	
	preload("res://BallTexture/ball6.tres"),	
	preload("res://BallTexture/ball7.tres"),	
	preload("res://BallTexture/ball8.tres"),	
	preload("res://BallTexture/ball9.tres"),	
	preload("res://BallTexture/ball10.tres"),	
	preload("res://BallTexture/ball11.tres"),	
	preload("res://BallTexture/ball12.tres"),	
	preload("res://BallTexture/ball13.tres"),	
	preload("res://BallTexture/ball14.tres"),	
	preload("res://BallTexture/ball15.tres"),	
]
var ball_droped :int
var dark_colors :Array
var ball_end_count :Array = []

func _ready() -> void:
	dark_colors = NamedColorList.make_dark_color_list(0.5)
	$Arrow3D.init(Config.BallRadius*6,Color.RED,Config.BallRadius/3,Config.BallRadius)
	$Arrow3D.position = Vector3(Config.WorldSize.x/2 + 0.25, Config.BallRadius*5, Config.BallRadius*1)
	reset_camera_pos()
	set_wall()
	add_pins()

func set_wall() -> void:
	$WallContainer/WallBottom.set_size(Config.BottomSize)
	$WallContainer/WallTop.set_size(Config.BottomSize)
	$WallContainer/WallBottom.position = Config.BottomCenter
	$WallContainer/WallTop.position = Config.TopCenter

	$WallContainer/WallWest.set_size(Config.WestSize)
	$WallContainer/WallEast.set_size(Config.WestSize)
	$WallContainer/WallWest.position = Config.WestCenter
	$WallContainer/WallEast.position = Config.EastCenter

	$WallContainer/WallNorth.set_size(Config.NorthSize)
	$WallContainer/WallSouth.set_size(Config.NorthSize)
	$WallContainer/WallNorth.position = Config.NorthCenter
	$WallContainer/WallSouth.position = Config.SouthCenter
	
func add_pins() -> void:
	for x in Config.WorldSize.x:
		for y in range(3, Config.WorldSize.z-2):
			var b = preload("res://pin.tscn").instantiate(
				).set_radius_height(Config.BallRadius/6, Config.BallRadius*3
				).set_color(dark_colors.pick_random()[0])
			if y % 2 == 0:
				b.position = Vector3(x+0.75, 0.5, y) 
			else :
				b.position = Vector3(x+0.25, 0.5, y) 
			b.set_default_pos(b.position) 
			$PinContainer.add_child(b)
		
	for x in Config.WorldSize.x:
		var lb = Label3D.new()
		lb.text = "0"
		lb.pixel_size = 0.01
		lb.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		lb.no_depth_test = true
		lb.position = Vector3(x+0.5, 0.5, Config.WorldSize.z-1) 
		$BallEndCounterContainer.add_child(lb)
		ball_end_count.append(0)

	for x in Config.WorldSize.x+1:
		var w = preload("res://칸막이.tscn").instantiate(
			).set_size( Vector3(Config.BallRadius/6, Config.BallRadius*3, 2)
			).set_color(dark_colors.pick_random()[0])
		w.position = Vector3(x, 0.5, Config.WorldSize.z-1)
		add_child(w)

func add_ball() -> void:
	var d = 	preload("res://ball.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_material(tex_array.pick_random()
		#).set_color(dark_colors.pick_random()[0]
		).set_radius(Config.BallRadius
	)
	d.position = $Arrow3D.position + Vector3(0,-Config.BallRadius*4,0)
	$DropContainer.add_child(d)
	ball_droped += 1
	d.ball_ended.connect(ball_ended)

func ball_ended(pos :Vector3) -> void:
	var i = int(pos.x) 
	ball_end_count[i] += 1
	$BallEndCounterContainer.get_child(i).text = "%s" % ball_end_count[i]

var camera_move = false
func _process(delta: float) -> void:
	update_label()
	var t = Time.get_unix_time_from_system() /-3.0
	if camera_move:
		$Camera3D.position = Vector3(sin(t)*Config.WorldSize.x/2, sin(t)*Config.WorldSize.y/2, cos(t)*Config.WorldSize.z/2) + Config.WorldSize/2
		$Camera3D.look_at(Config.BottomCenter)

func update_label() -> void:
	$"왼쪽패널/LabelDrops".text = "ball drops %s, alive %s" %[ball_droped, $DropContainer.get_child_count() ]
	$"왼쪽패널/LabelPerformance".text = """%d FPS (%.2f mspf)
%d objects
%dK primitive indices
%d draw calls""" % [
	Engine.get_frames_per_second(),1000.0 / Engine.get_frames_per_second(),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_OBJECTS_IN_FRAME),
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_PRIMITIVES_IN_FRAME) * 0.001,
	RenderingServer.get_rendering_info(RenderingServer.RENDERING_INFO_TOTAL_DRAW_CALLS_IN_FRAME),
	]

func _on_왼쪽이동_pressed() -> void:
	$Arrow3D.position.x -= 0.1
	$Arrow3D.position.x = clampf($Arrow3D.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)

func _on_오른쪽이동_pressed() -> void:
	$Arrow3D.position.x += 0.1
	$Arrow3D.position.x = clampf($Arrow3D.position.x, Config.BallRadius, Config.WorldSize.x-Config.BallRadius)

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
	KEY_ENTER:_on_카메라변경_pressed,
	KEY_LEFT: _on_왼쪽이동_pressed,
	KEY_RIGHT: _on_오른쪽이동_pressed,
	KEY_1: _on_충돌횟수보이기_pressed,
}
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed:
		var fn = key2fn.get(event.keycode)
		if fn != null:
			fn.call()
	elif event is InputEventMouseButton and event.is_pressed():
		pass

func _on_button_esc_pressed() -> void:
	get_tree().quit()

func _on_카메라변경_pressed() -> void:
	camera_move = !camera_move
	if camera_move == false:
		reset_camera_pos()

func reset_camera_pos()->void:
	$Camera3D.position = Vector3(Config.WorldSize.x/2, Config.WorldSize.y, Config.WorldSize.z * 0.8)
	$Camera3D.look_at(Vector3(Config.WorldSize.x/2,0,Config.WorldSize.z*0.6))
	$Camera3D.far = Config.WorldSize.length()

func _on_timer공추가_timeout() -> void:
	add_ball()

var 충돌횟수보이기 := true
func _on_충돌횟수보이기_pressed() -> void:
	충돌횟수보이기 = not 충돌횟수보이기
	for n in $PinContainer.get_children():
		n.show_collision_count(충돌횟수보이기)
