var prerender = require('prerender');

console.log("server starting with:");
console.log("S3_BUCKET_NAME: " + process.env.S3_BUCKET_NAME);
console.log("AWS_ACCESS_KEY_ID: " + process.env.AWS_ACCESS_KEY_ID);
console.log("AWS_SECRET_ACCESS_KEY: " + process.env.AWS_SECRET_ACCESS_KEY);
console.log("AWS_REGION: " + process.env.AWS_REGION);
console.log("PRERENDER_NUM_ITERATIONS: " + process.env.PRERENDER_NUM_ITERATIONS);
console.log("PRERENDER_NUM_WORKERS: " + process.env.PRERENDER_NUM_WORKERS);

var server = prerender({
  workers: process.env.PRERENDER_NUM_WORKERS,
  iterations: process.env.PRERENDER_NUM_ITERATIONS
});

server.use(prerender.sendPrerenderHeader());
// server.use(prerender.basicAuth());
// server.use(prerender.whitelist());
server.use(prerender.blacklist());
server.use(prerender.logger());
server.use(prerender.removeScriptTags());
server.use(prerender.httpHeaders());
// server.use(prerender.inMemoryHtmlCache());
server.use(prerender.s3HtmlCache());

server.start();
console.log('Prerender server started on port 3000');
