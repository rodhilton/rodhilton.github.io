(function() {
  $(function() {
    if (navigator.platform === "iPad") {
      return;
    }
    jQuery(".post img").not(".cycle img").lazyload({
      effect: "fadeIn",
      placeholder: "/assets/grey.gif"
    });
  });

  $(function() {
    Hyphenator.config({
      minwordlength: 8,
      classname: "postentry",
      donthyphenateclassname: "no-hyphenate",
      remoteloading: false,
      defaultlanguage: "en-us"
    });

    Hyphenator.addExceptions("", "JAVA_HOME, config");
    Hyphenator.run();

    hljs.initHighlightingOnLoad();

    jQuery(".social-icon").hover((function() {
      $(this).removeClass("dimmed");
    }), function() {
      $(this).addClass("dimmed");
    });

    var navBar = $("#navbar");
    var body = $("body");
    var win = $(window);
    var smallLogo = $("#small-logo");
    var sidebars = $("#sidebars");      
    var content = $("#content");

    var navBarHeight = navBar.height();

    function fixNav() {
      var navBarTop = navBar.position().top;
      var sideBarTop = navBarTop + navBarHeight + 1

      var position = sidebars.css("position");
      if(position == "absolute") {
          sidebars.
            css({ 
              top: (sideBarTop)+"px",
              left: (content.position().left+content.width()+20)+"px",
              visibility: "visible"
            });
      } else if (position == "relative") {
        sidebars.
            css({ 
              top: "",
              left: "0px",
              visibility: "visible"
            });
      }
    }

    // jQuery(document).scroll(function(evt) {
    //   fixNav();
    // })

    jQuery(window).resize(function(evt) {
      fixNav();
    });

    fixNav();
  });

}).call(this);
