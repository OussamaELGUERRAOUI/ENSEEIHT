const express = require('express');
const PDFDocument = require('pdfkit');
const fs = require('fs');

const app = express();
const port = 3000;

// Page HTML
const htmlPage = `
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Formulaire</title>
</head>
<body>
    <form action="/submit" method="post">
        <label for="name">Nom:</label>
        <input type="text" id="name" name="name"><br><br>
        <label for="prenom">Prénom:</label>
        <input type="text" id="prenom" name="prenom"><br><br>
        <input type="submit" value="Soumettre">
    </form>
</body>
</html>
`;

app.get('/', (req, res) => {
    res.send(htmlPage);
});

app.post('/submit', (req, res) => {
    const doc = new PDFDocument();
    doc.pipe(fs.createWriteStream('formulaire.pdf'));
    doc.text(`Nom: ${req.query.name}`, 100, 100);
    doc.text(`Prénom: ${req.query.prenom}`, 100, 150);
    doc.end();
    doc.save();
    res.download('formulaire.pdf');
});

app.listen(port, () => {
    console.log(`Example app listening at http://localhost:${port}`);
});
