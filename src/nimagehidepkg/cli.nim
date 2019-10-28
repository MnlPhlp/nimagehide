import ../nimagehide

proc interactiveMenu*() = 
  echo "Menu"

proc hide*(image: string,secret = "hello World",output: string) =
  discard

proc discover*(images: seq[string]) =
  for image in images:
    let img = loadImage(image)
    echo img.discoverData().toString()