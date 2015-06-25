// test 22

var http = require('http')
var createHandler = require('github-webhook-handler')
var handler = createHandler({ path: '/webhook', secret: 'pixelart' })
var spawn = require('child_process').spawn
var _ = require('underscore'); // for some utility goodness
var fs = require('fs');
var util = require('util');

function writeLogs(log) {
  var flags = 'a';

  var stream = fs.createWriteStream("./logs/webhook.txt", { 'flags': flags, 'encoding': null, 'mode': 0666});
  stream.once('open', function(fd) {
    stream.write('[ ' + new Date() + ' ] ' + log + '\n');
    stream.end();
  });
}

fs.readdir('logs', function(err, files) {
  if(typeof files === 'undefined' || files === null)
    fs.mkdir('logs');

  writeLogs('------------------------------------------------------------');
  writeLogs('start webhook ');

  http.createServer(function (req, res) {
    handler(req, res, function (err) {
      res.statusCode = 404
      res.end('no such location')
    })
  }).listen(7777)

  handler.on('error', function (err) {
    util.debug('Error:', err.message)
  })

  handler.on('push', function (event) {
    writeLogs('Received a push event for ' + event.payload.repository.name + ' to ' + event.payload.ref + '');
    util.debug('Received a push event for %s to %s',
      event.payload.repository.name,
      event.payload.ref)

    var deploySh = spawn('sh', [ 'scripts/deploy.sh' ], {
      cwd: '/home/nicolas/node-webhook',
      env:_.extend(process.env, { PATH: process.env.PATH + ':/usr/local/bin' })
    });
  })

  handler.on('issues', function (event) {
    writeLogs('Received an issue event for %s action=%s: #%d %s');
    util.debug('Received an issue event for ' + event.payload.repository.name + ' action=' + event.payload.action + ': #' + event.payload.issue.number + ' ' + event.payload.issue.title,
      event.payload.repository.name,
      event.payload.action,
      event.payload.issue.number,
      event.payload.issue.title)
  })
});