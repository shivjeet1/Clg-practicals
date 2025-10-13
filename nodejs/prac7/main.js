const events = require('events');
const eventEmitter = new events.EventEmitter();
eventEmitter.on('greet', () => {
    console.log('Hello there!\nShivam Lawale 3R-73');
});
eventEmitter.emit('greet');
