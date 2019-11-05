import 
  ../nimagehide,
  strformat,
  cli_menu


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
  ## echos out the available storage space for the `images`
  for image in images:
    let img = loadImage(image)
    let space = img.space()
    if space < 1024:
      echo fmt"{space} bytes"
    elif space < 1048576:
      echo fmt"{space/1024:.2f} kb"
    else:
      echo fmt"{space/1048576:.2f} mb"

proc spaceMenu() =
  discard
proc discoverMenu() =
  discard
proc hideMenu() =
  discard

proc interactiveMenu*() = 
  subMenus("What do you want to do",@[
        ("Hide data",hideMenu),
        ("Discover data",discoverMenu),
        ("Check storage space",spaceMenu)
        ])