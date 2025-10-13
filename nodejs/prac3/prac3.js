const fs = require('fs');
const os = require('os');
fs.writeFileSync('sample.txt', 'This file is created using fs module.');
console.log('System Info:', os.platform(), os.release());
console.log('Shivam Lawale 3R-73');

