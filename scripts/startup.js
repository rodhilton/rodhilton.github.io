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
    var navBarTop = navBar.position().top
    var navBarHeight = navBar.height();

    var thinHeader = $("#thin-headerwrapper");
    var thinHeaderHeight = thinHeader.height();

    function fixNav() {
      var sidebarTop;

      console.log(thinHeaderHeight);  

      if($(window).scrollTop() > navBarTop - thinHeaderHeight) {
        $("#navbar").
          addClass("sticky").
          css("top", thinHeaderHeight + "px");
          
        $("body").css("margin-top", navBarHeight);
        sideBarTop = thinHeaderHeight + navBarHeight + 1;

        $("#thin-headerwrapper").
          css("visibility", "visible").slideDown();

        $("#small-logo").
          css("top", Math.floor((navBarHeight - 16)/2) +"px").
          css("left", Math.floor($("#navlist").position().left + $("#navlist").width() - 16 - 5)+"px");


      } else {
        $("#navbar").removeClass("sticky");
        $("body").css("margin-top", 0);

        $("#thin-headerwrapper").
          css("visibility", "hidden");

        var navBarBottomPos = navBar.position().top + navBar.height();      
        sideBarTop = navBarBottomPos - $(window).scrollTop() + 1;
      }

      var sidebars = $("#sidebars");      
      var position = sidebars.css("position");
      if(position == "fixed") {
        sidebars.css({ top: sideBarTop+"px" });
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
