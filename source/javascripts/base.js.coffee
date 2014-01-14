$.bigfoot()

$ ->

  # Detect SVG support and use fallbacks
  if !!document.createElementNS and !!document.createElementNS("http://www.w3.org/2000/svg", "svg").createSVGRect
    document.documentElement.className += " svg"
  else
    document.documentElement.className += " no-svg"
    $("img.svg").each ->
      img = $(this)
      png_src = img.attr("src").replace(".svg", ".png")
      img.attr("src", png_src)
