const http = require('http');
http.createServer(function (req, res) {
    res.writeHead(200, {'Content-Type': 'text/plain'});
    res.end('Welcome to Node.js Web Server!\nShivam Lawale 3R-73');
}).listen(3000);

 
