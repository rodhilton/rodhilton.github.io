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

    var navBarTop = navBar.position().top
    var navBarHeight = navBar.height();

    var thinHeader = $("#thinheaderwrapper");
    var thinHeaderHeight = thinHeader.height();

    function fixNav() {
      var sidebarTop;

      if(win.scrollTop() > navBarTop - thinHeaderHeight) {
        navBar.
          addClass("sticky").
          css("top", thinHeaderHeight + "px");
          
        body.css("margin-top", navBarHeight);
        sideBarTop = thinHeaderHeight + navBarHeight + 1;

        thinHeader.
          css("visibility", "visible").slideDown();

        smallLogo.
          css("top", Math.floor((navBarHeight - 16)/2) +"px").
          css("left", Math.floor($("#navlist").position().left + $("#navlist").width() - 16 - 5)+"px");


      } else {
        navBar.removeClass("sticky");
        body.css("margin-top", 0);

        thinHeader.
          css("visibility", "hidden");

        var navBarBottomPos = navBar.position().top + navBar.height();      
        sideBarTop = navBarBottomPos - $(window).scrollTop() + 1;
      }

      var position = sidebars.css("position");
      if(position == "fixed") {
        sidebars.
          css({ 
            top: sideBarTop+"px",
            left: (content.position().left+content.width()+20)+"px"
          });
      }
    }

    jQuery(document).scroll(function(evt) {
      fixNav();
    })

    jQuery(window).resize(function(evt) {
      fixNav();
    });

    fixNav();
  });

}).call(this);
