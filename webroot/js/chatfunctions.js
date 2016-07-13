
	function init() {
		output = document.getElementById("output");
		input = document.getElementById("input");
        requestJoin();
		
	}
    function requestJoin() {
    		connectWebsocket(ws_params.channel);
  
    }
               
	function connectWebsocket(channel, clientid) {
		websocket = new WebSocket(wsUri);
		websocket.onopen = function(evt) { onOpen(evt) };
		websocket.onclose = function(evt) { onClose(evt) };
		websocket.onmessage = function(evt) { onMessage(evt) };
		websocket.onerror = function(evt) { onError(evt) };
	}

	function onOpen(evt) {
		if(ws_params.client_id == undefined){
			writeToScreen("Connecting: "+evt.data);
			valuetosend = {"cmd": "register", "msg": "joining channel "+ws_params.channel, "channelid":ws_params.channel};
        
		} else {
			writeToScreen("CONNECTED: "+evt.data);
			valuetosend = {"cmd": "register", "msg": "registered "+ws_params.client_id, "clientid": ws_params.client_id, "channelid": ws_params.channel_id};
        
		}
		websocket.send(JSON.stringify(valuetosend));
        
        writeToScreen('<span style="color: red;">Registering:<\/span> ');
	}

	function onClose(evt) {
		writeToScreen("DISCONNECTED");
	}

	function onMessage(evt) {
		json_data = JSON.parse(evt.data);
		msg = json_data["msg"];
		request = json_data["request"];
		
		writeToScreen('<span style="color: blue;">RESPONSE: ' + msg+' for Request: '+ request +'<\/span>');
	}

	function onError(evt) {
		writeToScreen('<span style="color: red;">ERROR:<\/span> ' + evt.data);
	}

	function doSend() {
		writeToScreen('<span style="color: red;">SENDING:<\/span> ' + input.value);
        valuetosend = {"cmd": "send", "msg": input.value, "clientid": ws_params.client_id, "channelid": ws_params.channel_id};
        websocket.send(JSON.stringify(valuetosend));
	}

    function doEcho() {
        writeToScreen('<span style="color: red;">Echo:<\/span> ' + input.value);
        valuetosend = {"cmd": "echo", "msg": input.value, "clientid": ws_params.client_id, "channelid": ws_params.channel_id};
        websocket.send(JSON.stringify(valuetosend));
    }
	function writeToScreen(message) {
		output.innerHTML += '<br>' +message
	}