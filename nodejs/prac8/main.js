const http = require('http');
const formidable = require('formidable');
const fs = require('fs');
const path = require('path');

http.createServer((req, res) => {
    if (req.url == '/fileupload' && req.method.toLowerCase() === 'post') {
        const form = new formidable.IncomingForm();

        form.parse(req, (err, fields, files) => {
            if (err) {
                console.error('Error parsing the form: ', err);
                res.writeHead(500, {'Content-Type': 'text/plain'});
                res.write('An error occurred during file upload.');
                return res.end();
            }

            if (!files.filetoupload || files.filetoupload.length === 0) {
                res.writeHead(400, {'Content-Type': 'text/plain'});
                res.write('No file was uploaded.');
                return res.end();
            }

            const uploadedFile = files.filetoupload[0];
            const oldpath = uploadedFile.filepath;
            const newpath = path.join(__dirname, uploadedFile.originalFilename);

            const readStream = fs.createReadStream(oldpath);
            const writeStream = fs.createWriteStream(newpath);

            readStream.on('error', (err) => {
                console.error('Error reading the temp file:', err);
                res.writeHead(500, {'Content-Type': 'text/plain'});
                res.write('An error occurred while saving the file.');
                res.end();
            });

            writeStream.on('error', (err) => {
                console.error('Error writing the new file:', err);
                res.writeHead(500, {'Content-Type': 'text/plain'});
                res.write('An error occurred while saving the file.');
                res.end();
            });

            writeStream.on('finish', () => {
                fs.unlink(oldpath, (err) => {
                    if (err) {
                        console.error('Error deleting temp file:', err);
                    }
                });
                res.writeHead(200, {'Content-Type': 'text/html'});
                res.write('File uploaded and moved successfully!<br>Shivam Lawale 3R-73');
                res.end();
            });

            readStream.pipe(writeStream);
        });
    } else {
        res.writeHead(200, {'Content-Type': 'text/html'});
        res.write('<form action="fileupload" method="post" enctype="multipart/form-data">');
        res.write('<h2>Select a file to upload:</h2>');
        res.write('<input type="file" name="filetoupload"><br><br>');
        res.write('<input type="submit" value="Upload File">');
        res.write('</form>');
        return res.end();
    }
}).listen(3000, () => {
    console.log('Server is listening on http://localhost:3000');
});
