$( document ).ready( function() {
	/*
		Note that this MUST run before the highlightjs code does, 
		otherwise the inner text of the highlighted block will no 
		longer be the unhighlighted version 
	*/

	jQuery("pre code").not(".language-terminal, .language-output").each(function(evt) {
		var highlightBox = $(this);

		var id = highlightBox.attr("id");
		if(!id) {
			id="code-"+Math.floor(Math.random()*1000000);
			highlightBox.attr("id", id);
		}

		var editBox = jQuery("<textarea/>").
			addClass("code-edit").
			css("display", "none").
			attr("wrap", "off").
			attr("id", id+"-edit").
			attr("data-original-val", highlightBox.text()).
			blur(function(evt) {
				$(this).hide();
				highlightBox.show();
			});

		highlightBox.after(editBox);
	}).click(function(evt) {
		var highlightBox = $(this);

		var editBox = jQuery("#"+highlightBox.attr("id")+"-edit")
			
		editBox.width(highlightBox.width()).
			height(highlightBox.height()).
			val(editBox.attr("data-original-val"))

		editBox.show().select();
		highlightBox.hide();
	});
});