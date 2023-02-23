extends Node

# The URL we will connect to
export var websocket_url = "ws://localhost:8000"

# Our WebSocketClient instance
var _client = WebSocketClient.new()

func _ready():
	# Connect base signals to get notified of connection open, close, and errors.
	_client.connect("connection_closed", self, "_closed")
	_client.connect("connection_error", self, "_closed")
	_client.connect("connection_established", self, "_connected")
	_client.connect("server_close_request", self, "ws_close_request")

	# This signal is emitted when not using the Multiplayer API every time
	# a full packet is received.
	# Alternatively, you could check get_peer(1).get_available_packets() in a loop.
	_client.connect("data_received", self, "_on_data")

	# Initiate connection to the given URL.
	var err = _client.connect_to_url(websocket_url)
	if err != OK:
		print("Unable to connect")
		set_process(false)

func _closed(was_clean = false):
	# was_clean will tell you if the disconnection was correctly notified
	# by the remote peer before closing the socket.
	print("Closed, clean: ", was_clean)
	_client.disconnect_from_host(999, "Lost connection.")
	set_process(false)
	
func ws_close_request(code, reason):
	print("closed with code: ", code, " and reason: ", reason)

func _connected(proto = ""):
	# This is called on connection, "proto" will be the selected WebSocket
	# sub-protocol (which is optional)
	print("Connected with protocol: ", proto)
	# You MUST always use get_peer(1).put_packet to send data to server,
	# and not put_packet directly when not using the MultiplayerAPI.
	_client.get_peer(1).put_packet("Test packet".to_utf8())

func _on_data():
	# Print the received packet, you MUST always use get_peer(1).get_packet
	# to receive data from server, and not get_packet directly when not
	# using the MultiplayerAPI.
	var data=_client.get_peer(1).get_packet().get_string_from_utf8()
	var comm=data.split("|")
	if len(comm)>1:
		if comm[0]=='bola':
			print("THIS IS THE BOLA",comm[1])
	print("Got data from server: ", data)

func _process(delta):
	#print(delta)
	# Call this in _process or _physics_process. Data transfer, and signals
	# emission will only happen when calling this function.
	_client.poll()


func _on_Area_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed==true:
		var err = _client.connect_to_url(websocket_url)
		if err != OK:
			print("Unable to connect. Err ", err)
		set_process(false)
		

func _on_Elephant_input_event(camera, event, click_position, click_normal, shape_idx):
	if event is InputEventMouseButton and event.pressed==true:
		_client.get_peer(1).put_packet("vintao no elefante".to_utf8())

