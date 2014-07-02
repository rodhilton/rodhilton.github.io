---
---

$ ->
  return  if navigator.platform is "iPad"
  jQuery(".post img").not(".cycle img").lazyload
    effect: "fadeIn"
    placeholder: "/assets/grey.gif"

  return

$ ->
  Hyphenator.config
    minwordlength: 8
    classname: "postentry"
    donthyphenateclassname: "no-hyphenate"
    remoteloading: false
    defaultlanguage: "en-us"

  Hyphenator.addExceptions "", "JAVA_HOME, config"
  Hyphenator.run()

  hljs.initHighlightingOnLoad()
  
  jQuery(".social-icon").hover (->
    $(this).removeClass "dimmed"
    return
  ), ->
    $(this).addClass "dimmed"
    return

  return
