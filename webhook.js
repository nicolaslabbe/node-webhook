var http = require('http')
var createHandler = require('github-webhook-handler')
var handler = createHandler({ path: '/webhook', secret: 'pixelart' })
var spawn = require('child_process').spawn
var _ = require('underscore'); // for some utility goodness

http.createServer(function (req, res) {
  handler(req, res, function (err) {
    res.statusCode = 404
    res.end('no such location')
  })
}).listen(7777)

handler.on('error', function (err) {
  console.error('Error:', err.message)
})

handler.on('push', function (event) {
  console.log('Received a push event for %s to %s',
    event.payload.repository.name,
    event.payload.ref)

  var deploySh = spawn('sh', [ 'deploy.sh' ], {
    cwd: process.env.HOME + '/myProject',
    env:_.extend(process.env, { PATH: process.env.PATH + ':/usr/local/bin' })
  });
})

handler.on('issues', function (event) {
  console.log('Received an issue event for %s action=%s: #%d %s',
    event.payload.repository.name,
    event.payload.action,
    event.payload.issue.number,
    event.payload.issue.title)
})
