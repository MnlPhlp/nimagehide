import 
  ../nimagehide,
  strformat

proc interactiveMenu*() = 
  echo "Menu"

proc hide*(image: string,output: string,secret = "",file = "") =
  if secret == "" and file != "":
    try:
      hideAndStoreFile(image,output,file)
    except OverflowError:
      echo "Error:"
      echo "  " & getCurrentExceptionMsg()
  elif file == "" and secret != "":
    try:
      hideAndStore(image,output,secret)
    except OverflowError:
      echo "Error:"
      echo "  " & getCurrentExceptionMsg()
  else: # no file or secret or both specified
    echo "specify either a secret string (-s) or a file (-f)"

proc discover*(images: seq[string]) =
  for image in images:
    let img = loadImage(image)
    echo img.discoverData().toString()

proc space*(images: seq[string]) =
  for image in images:
    let img = loadImage(image)
    let space = img.space()
    if space < 1024:
      echo fmt"{space} bytes"
    elif space < 1048576:
      echo fmt"{space/1024:.2f} kb"
    else:
      echo fmt"{space/1048576:.2f} mb"