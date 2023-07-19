extends Node3D

@export var player : PackedScene
var net_peer = ENetMultiplayerPeer.new()
var messange 
var id

func _ready():
	#creo el servidor y le añado el puerto
	net_peer.create_server(9999)
	#le asigno el par de coneccion a la variable enet_peer " enet par"
	multiplayer.multiplayer_peer = net_peer
	
	multiplayer.peer_disconnected.connect(remove_player)
	#llamo a la funcion enviar variable
	#net_peer.peer_connected.connect()
	id = net_peer.get_unique_id()
	
	$StaticBody2D.hide()
	
	

	


func _input(_event):
	if Input.is_key_pressed(KEY_W):
		print("press ", id, "  " ,messange)
		$Label.text = " \n" + str(messange)
		_send_msg.rpc(messange)
		print(messange)
		
	if Input.is_key_pressed(KEY_S):
		_send_msg.rpc_id(int(messange),"se cerrara el servidor")
	
		
	if Input.is_key_pressed(KEY_ESCAPE):
		get_tree().quit()
		
	
#@rpc("any_peer") # Add "call_local" to spawn a player from the server
#func add_player(id):
#	var player_instance = player.instantiate()
#	player_instance.name = str(id)
#	%SpawnPosition.add_child(player_instance)
	
@rpc("any_peer")
func remove_player(id):
	pass
#	if %SpawnPosition.get_node(str(id)):
#		%SpawnPosition.get_node(str(id)).queue_free()
	
func _on_input_confirmed(text: String):
	print("Valor ingresado:", text)
	%LineEdit.text = $LineEdit.text_changed(messange)


func _on_line_edit_text_submitted(new_text):
	messange = $LineEdit.text


func _on_button_pressed():
	messange = " "
	$LineEdit.clear()



func _on_button_2_pressed():
	$LineEdit.hide()
	$Button.hide()
	$StaticBody2D.show()
	
@rpc("any_peer")
func _send_msg(value):
	print(value)

@rpc("call_remote")
func show_info(_info):
	print(_info)
	
