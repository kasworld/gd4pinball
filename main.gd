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
	$Arrow3D.init(2,Color.RED,0.1,0.3)
	$Arrow3D.position = Vector3(0.25, -8, -9.5)
	add_bars()
	
func add_bars() -> void:
	reset_camera_pos()
	for x in range(-10,11):
		for y in range(-8,11):
			var b = preload("res://bar.tscn").instantiate().set_color(dark_colors.pick_random()[0])
			if y % 2 == 0:
				b.position = Vector3(x-0.25, -9.5, y-0.25)
			else :
				b.position = Vector3(x+0.25, -9.5, y-0.25)
			b.set_default_pos(b.position) 
			$BarContainer.add_child(b)
		var lb = Label3D.new()
		lb.text = "0"
		lb.pixel_size = 0.01
		lb.billboard = BaseMaterial3D.BILLBOARD_ENABLED
		lb.no_depth_test = true
		lb.position = Vector3(x+0.25, -10, 10)
		$BallEndCounterContainer.add_child(lb)
		ball_end_count.append(0)

func add_ball() -> void:
	var d = 	preload("res://ball.tscn").instantiate(
		).init(Vector3.ZERO, Vector3.ZERO
		).set_material(tex_array.pick_random()
		#).set_color(dark_colors.pick_random()[0]
		).set_radius(0.3
	)
	d.position = $Arrow3D.position + Vector3(0,-1.5,0)
	$DropContainer.add_child(d)
	ball_droped += 1
	d.ball_ended.connect(ball_ended)

func ball_ended(pos :Vector3) -> void:
	var i = int(pos.x+10) 
	ball_end_count[i] += 1
	$BallEndCounterContainer.get_child(i).text = "%s" % ball_end_count[i]

var camera_move = false
func _process(delta: float) -> void:
	update_label()
	var t = Time.get_unix_time_from_system() /-3.0
	if camera_move:
		$Camera3D.position = Vector3(sin(t)*10, sin(t)*8, cos(t)*10)
		$Camera3D.look_at(Vector3(0,-10,0))

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
	$Arrow3D.position.x = clampf($Arrow3D.position.x, -9.5, 9.5)

func _on_오른쪽이동_pressed() -> void:
	$Arrow3D.position.x += 0.1
	$Arrow3D.position.x = clampf($Arrow3D.position.x, -9.5, 9.5)

var key2fn = {
	KEY_ESCAPE:_on_button_esc_pressed,
	KEY_ENTER:_on_카메라변경_pressed,
	KEY_LEFT: _on_왼쪽이동_pressed,
	KEY_RIGHT: _on_오른쪽이동_pressed,
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
	$Camera3D.position = Vector3(0,5,8)
	$Camera3D.look_at(Vector3(0,-10,0))
	$Camera3D.far = 50

func _on_timer공추가_timeout() -> void:
	add_ball()
