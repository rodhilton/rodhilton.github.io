function autoToC(contentSelector) {
	var ToC = "<div class='toc no-hyphenate'><h1>Contents</h1><ol>"

	var curLevel = 1;

	var headers = ["h1", "h2", "h3", "h4", "h5", "h6"];
	var selector = _.map(headers, function(h) { return contentSelector + " "+h}).join(", ");
	
	var headers = $(selector);

	if(headers.length < 3) return;

	headers.each(function() {

	  var el = $(this);
	  el.attr("id", el.text().toLowerCase().replace(/[^a-z0-9]+/g, "-").replace(/-+/g,"-"))

	  var newLevel = Math.floor(el.context.tagName.slice(-1));
	  
	  if(newLevel - curLevel > 0) { //We need to indent by the diff between curLevel and newLevel
	  	for(var i=0; i<(newLevel - curLevel); i++) {
			ToC += "<ol>"
		}
	  } else if(newLevel - curLevel < 0) { //We need to outdent by the diff between curLevel and newLevel	  
		for(var i=0; i<(-(newLevel - curLevel)); i++) {
			ToC += "</ol>"
		}
	  }

	  curLevel = newLevel;

	  var title = el.text();
	  var link = "#" + el.attr("id");

	  var newLine =
	    "<li>" +
	      "<a href='" + link + "'>" +
	        title +
	      "</a>" +
	    "</li>";

	  ToC += newLine;

	});

	ToC += "</ol></div>"

	$(contentSelector).prepend(ToC);
}

$(function() {
      autoToC(".postentry.enable-toc");
  });
