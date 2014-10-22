var http = require("http");
var url  = require('url');

function start(route, handle) {

  // Method to call when a request is made
  function onRequest(request, response) {

    // Get the path from the url
    var pathname = url.parse(request.url).pathname;
    console.log("Request for " + pathname + " received.");



    // Write the response (Probably should have some errors in here somewhere)
    //response.writeHead(200, {"Content-Type": "text/plain"});

    // Route the path so it can executed accordingly
    route(handle, pathname, response);

    //response.write(content);
    //response.end();
  }

  // Start the server so it can listen for requests
  http.createServer(onRequest).listen(8888);
  console.log("Server has started.");
}

// Module Methods
exports.start = start;