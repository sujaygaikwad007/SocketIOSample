
const express = require('express');
const socket = require('socket.io');
const fs = require('fs');
const app = express();
var PORT = process.env.PORT || 3000;
const server = app.listen(PORT);

app.use(express.static('public'));
console.log('Server is running');
const io = socket(server);

io.on('connection', (socket) => {
    console.log("New socket connection: " + socket.id);

    socket.emit('serverMessage', 'Welcome to the chat!');

    socket.on('chatMessage', (message) => {
        console.log(`Received message from ${socket.id}: ${message}`);
        io.emit('chatMessage', message);
    });

    socket.on('disconnect', () => {
        console.log(`Socket disconnected: ${socket.id}`);
    });
});
