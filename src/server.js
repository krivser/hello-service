const os = require('os');
const express = require('express');
const app = express();

app.get("/health", function(request, response) {
	console.log("Received request from " + os.hostname() + ", ipaddr = " + request.connection.remoteAddress);
	response.status(200).json({ status: 'OK' });
});

app.listen(8080, function() {
	console.log("Server listening on port 8080...");
});