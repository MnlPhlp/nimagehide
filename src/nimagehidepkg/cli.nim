import ../nimagehide

proc interactiveMenu*() = 
  echo "Menu"

proc hide*(image: string,output: string,secret = "",file = "") =
  if secret == "" and file != "":
    hideAndStoreFile(image,output,file)
  elif file == "" and secret != "":
    hideAndStore(image,output,secret)
  else: # no file or secret or both specified
    echo "specify either a secret string (-s) or a file (-f)"

proc discover*(images: seq[string]) =
  for image in images:
    let img = loadImage(image)
    echo img.discoverData().toString()