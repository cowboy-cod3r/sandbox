// This file is used to bootstrap our application

// Modules
var server = require('./server');
var router = require('./router');
var requestHandlers = require('./requestHandlers');

// Map Endpoints to Handlers
var handle        = {};
handle["/"]       = requestHandlers.start;
handle["/start"]  = requestHandlers.start;
handle["/update"] = requestHandlers.update;

// Start the server
server.start(router.route, handle);