let { WebSocketServer } = require('ws')

const { SerialPort } = require('serialport')
const { ReadlineParser } = require('@serialport/parser-readline')
const serial_port = new SerialPort({ path: '/dev/ttyUSB1', baudRate: 115200 })

const express = require('express')
const app = express()
const port = 3000

app.use('/', express.static(__dirname + '/static'))

app.listen(port, function() { console.log('listening') })

const wss = new WebSocketServer({ port: 8000 })

let input = ''

wss.on('connection', (ws) => {
  console.log('Client connected');

  setInterval(() => {
	  const parser = serial_port.pipe(new ReadlineParser({ delimiter: '\n' }))
	  parser.on('data', (line) => {
		  ws.send(line)
	  })
  }, 1000);

  ws.on('message', (message) => {
    console.log(`Received message => ${message}`);
  });

  ws.on('close', () => {
    console.log('Client disconnected');
  });
});

