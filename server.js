var prerender = require('prerender');

console.log("server starting");
console.log("PRERENDER_NUM_ITERATIONS: " + process.env.PRERENDER_NUM_ITERATIONS);
console.log("PRERENDER_NUM_WORKERS: " + process.env.PRERENDER_NUM_WORKERS);

var server = prerender({
  workers: process.env.PRERENDER_NUM_WORKERS,
  iterations: process.env.PRERENDER_NUM_ITERATIONS
});

if (typeof process.env.BASIC_AUTH !== 'undefined' && process.env.BASIC_AUTH) {
  console.log("basicAuth configured");
  server.use(prerender.basicAuth());
}

if (typeof process.env.MEMORY_CACHE !== 'undefined' && process.env.MEMORY_CACHE) {
  console.log("inMemoryHtmlCache configured");
  server.use(prerender.inMemoryHtmlCache());
}

if (typeof process.env.S3_CACHE !== 'undefined' && process.env.S3_CACHE) {
  console.log("s3HtmlCache configured");
  server.use(prerender.s3HtmlCache());
}

server.use(prerender.sendPrerenderHeader());
server.use(prerender.whitelist());
server.use(prerender.blacklist());
server.use(prerender.logger());
server.use(prerender.removeScriptTags());
server.use(prerender.httpHeaders());

server.start();
console.log('Prerender server started on port 3000');
