import ../nimagehide

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