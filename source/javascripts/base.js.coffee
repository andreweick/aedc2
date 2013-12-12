$ ->
  supportsSVG = () -> !!document.createElementNS and !!document.createElementNS("http://www.w3.org/2000/svg", "svg").createSVGRect
  fallbackSVG = () ->
    if supportsSVG()
      document.documentElement.className += " svg"
    else
      document.documentElement.className += " no-svg"
      imgs = document.getElementsByTagName("img")
      dotSVG = /.*\.svg$/
      i = 0

      while i isnt imgs.length
        imgs[i].src = imgs[i].src.slice(0, -3) + "png"  if imgs[i].src.match(dotSVG)
        ++i
