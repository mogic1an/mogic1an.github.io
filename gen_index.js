var lunr = require("./assets/js/lunr.js");
var fs = require('fs');
require("./assets/js/lunr.stemmer.support.js")(lunr)
require("./assets/js/lunr.zh.js")(lunr)

var data = fs.readFileSync("./doc.json", "utf-8");
var documents = JSON.parse(data);

var idx = lunr(function () {
    this.use(lunr.zh)
    this.ref('id')
    this.field('title')
    this.field('body')

    documents.forEach(function (doc) {
        this.add(doc)
    }, this)
})

fs.writeFileSync('./index.json', JSON.stringify(idx))
