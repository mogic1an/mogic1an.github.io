
var documents = [{
    "id": 0,
    "url": "/404.html",
    "title": "404",
    "body": "404 Page does not exist!Please use the search bar at the top or visit our homepage! "
    }, {
    "id": 1,
    "url": "/about",
    "title": "Mediumish Template for Jekyll",
    "body": "This website is built with Jekyll and Mediumish template for Jekyll. It's for demonstration purposes, no real content can be found. Mediumish template for Jekyll is compatible with Github pages, in fact even this demo is created with Github Pages and hosted with Github.  Documentation: Please, read the docs here. Questions or bug reports?: Head over to our Github repository! Buy me a coffeeThank you for your support! Your donation helps me to maintain and improve Mediumish . Buy me a coffee Documentation"
    }, {
    "id": 2,
    "url": "/blog",
    "title": "Blogs",
    "body": ""
    }, {
    "id": 3,
    "url": "/bottler",
    "title": "Bottlers",
    "body": ""
    }, {
    "id": 4,
    "url": "/categories",
    "title": "Categories",
    "body": ""
    }, {
    "id": 5,
    "url": "/distillery",
    "title": "Distilleries",
    "body": ""
    }, {
    "id": 6,
    "url": "/",
    "title": "Home",
    "body": ""
    }, {
    "id": 7,
    "url": "/note",
    "title": "notes",
    "body": ""
    }, {
    "id": 8,
    "url": "/distillery/caol_ila/",
    "title": "Caol Ila",
    "body": ""
    }, {
    "id": 9,
    "url": "/distillery/clynelish/",
    "title": "Clynelish",
    "body": ""
    }, {
    "id": 10,
    "url": "/distillery/laphroaig/",
    "title": "Laphroaig",
    "body": ""
    }, {
    "id": 11,
    "url": "/bottler/AMOY/",
    "title": "AMOY",
    "body": ""
    }, {
    "id": 12,
    "url": "/bottler/GM/",
    "title": "GM",
    "body": ""
    }, {
    "id": 13,
    "url": "/robots.txt",
    "title": "",
    "body": "      Sitemap: {{ “sitemap. xml”   absolute_url }}   "
    }, {
    "id": 14,
    "url": "/blog/whisky/",
    "title": "Laphroaig",
    "body": "2024/03/14 - Nose: bacon, bean paste, some charcoal, some maritime flavor, a bit medicinal flavor, some citrus Taste: Medicinal, beans, seaweed, some lemon, a bit of malty sweetness, yellow fruity notes Finish: Some bean paste, charcoal, some seaweed, brown sugar "
    }, {
    "id": 15,
    "url": "/blog/lala/",
    "title": "testflight",
    "body": "2024/03/14 - Nose: bacon, bean paste, some charcoal, some maritime flavor, a bit medicinal flavor, some citrus Taste: Medicinal, beans, seaweed, some lemon, a bit of malty sweetness, yellow fruity notes Finish: Some bean paste, charcoal, some seaweed, brown sugar "
    }, {
    "id": 16,
    "url": "/blog/brandy/",
    "title": "Caol Ila",
    "body": "2024/03/14 - Nose: bacon, bean paste, some charcoal, some maritime flavor, a bit medicinal flavor, some citrus Taste: Medicinal, beans, seaweed, some lemon, a bit of malty sweetness, yellow fruity notes Finish: Some bean paste, charcoal, some seaweed, brown sugar "
    }, {
    "id": 17,
    "url": "/blog/agave/",
    "title": "Caol Ila 2",
    "body": "2024/03/14 - Nose: bacon, bean paste, some charcoal, some maritime flavor, a bit medicinal flavor, some citrus Taste: Medicinal, beans, seaweed, some lemon, a bit of malty sweetness, yellow fruity notes Finish: Some bean paste, charcoal, some seaweed, brown sugar "
    }];

var idx = lunr(function () {
    this.ref('id')
    this.field('title')
    this.field('body')

    documents.forEach(function (doc) {
        this.add(doc)
    }, this)
});
function lunr_search(term) {
    document.getElementById('lunrsearchresults').innerHTML = '<ul></ul>';
    if(term) {
        document.getElementById('lunrsearchresults').innerHTML = "<p>Search results for '" + term + "'</p>" + document.getElementById('lunrsearchresults').innerHTML;
        //put results on the screen.
        var results = idx.search(term);
        if(results.length>0){
            //console.log(idx.search(term));
            //if results
            for (var i = 0; i < results.length; i++) {
                // more statements
                var ref = results[i]['ref'];
                var url = documents[ref]['url'];
                var title = documents[ref]['title'];
                var body = documents[ref]['body'].substring(0,160)+'...';
                document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML + "<li class='lunrsearchresult'><a href='" + url + "'><span class='title'>" + title + "</span><br /><span class='body'>"+ body +"</span><br /><span class='url'>"+ url +"</span></a></li>";
            }
        } else {
            document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = "<li class='lunrsearchresult'>No results found...</li>";
        }
    }
    return false;
}

function lunr_search(term) {
    $('#lunrsearchresults').show( 400 );
    $( "body" ).addClass( "modal-open" );
    
    document.getElementById('lunrsearchresults').innerHTML = '<div id="resultsmodal" class="modal fade show d-block"  tabindex="-1" role="dialog" aria-labelledby="resultsmodal"> <div class="modal-dialog shadow-lg" role="document"> <div class="modal-content"> <div class="modal-header" id="modtit"> <button type="button" class="close" id="btnx" data-dismiss="modal" aria-label="Close"> &times; </button> </div> <div class="modal-body"> <ul class="mb-0"> </ul>    </div> <div class="modal-footer"><button id="btnx" type="button" class="btn btn-danger btn-sm" data-dismiss="modal">Close</button></div></div> </div></div>';
    if(term) {
        document.getElementById('modtit').innerHTML = "<h5 class='modal-title'>Search results for '" + term + "'</h5>" + document.getElementById('modtit').innerHTML;
        //put results on the screen.
        var results = idx.search(term);
        if(results.length>0){
            //console.log(idx.search(term));
            //if results
            for (var i = 0; i < results.length; i++) {
                // more statements
                var ref = results[i]['ref'];
                var url = documents[ref]['url'];
                var title = documents[ref]['title'];
                var body = documents[ref]['body'].substring(0,160)+'...';
                document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML + "<li class='lunrsearchresult'><a href='" + url + "'><span class='title'>" + title + "</span><br /><small><span class='body'>"+ body +"</span><br /><span class='url'>"+ url +"</span></small></a></li>";
            }
        } else {
            document.querySelectorAll('#lunrsearchresults ul')[0].innerHTML = "<li class='lunrsearchresult'>Sorry, no results found. Close & try a different search!</li>";
        }
    }
    return false;
}
    
$(function() {
    $("#lunrsearchresults").on('click', '#btnx', function () {
        $('#lunrsearchresults').hide( 5 );
        $( "body" ).removeClass( "modal-open" );
    });
});