import 
  ../nimagehide,
  strformat,
  cli_menu,
  rdstdin,
  terminal


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
    write(stdout,"Available storage: ")
    if space < 1024:
      echo fmt"{space} Bytes"
    elif space < 1048576:
      echo fmt"{space/1024:.2f} KB"
    else:
      echo fmt"{space/1048576:.2f} MB"

proc showSpace() =
  clearScreen()
  try:
    space(@[readLineFromStdin("path: ")])
  except STBIException:
    echo "invalid Path"
  finally:
    waitForEnter()

proc showData() =
  clearScreen()
  try:
    discover(@[readLineFromStdin("path: ")])
  except STBIException:
    echo "invalid Path"
  finally:
    waitForEnter()

proc saveData() =
  clearScreen()
  try:
    discoverAndStore(
      readLineFromStdin("image path: "),
      readLineFromStdin("store path: ")
    )
  except STBIException:
    echo "invalid image path"
  except IOError:
    echo "invalid storage path"
    

proc spaceMenu() =
  subMenus("Check storage space of an Image",@[
    ("Choose image",showSpace)
  ])
  
proc discoverMenu() =
  subMenus("Discover Data",@[
    ("Output data",showData),
    ("Save data to file",saveData)
  ])

proc hideFile() =
  clearScreen()
  try:
    hide(
      readLineFromStdin("source image path: "),
      readLineFromStdin("output image path: "),
      file = readLineFromStdin("path to hide-file: ")
    )
  except STBIException:
    echo "invalid image path"
  except IOError:
    echo "invalid storage path"


proc hideText() =
  clearScreen()
  try:
    hide(
      readLineFromStdin("source image path: "),
      readLineFromStdin("output image path: "),
      secret = readLineFromStdin("text to hide: ")
    )
  except STBIException:
    echo "invalid image path"
  except IOError:
    echo "invalid storage path"

proc hideMenu() =
  subMenus("Hide Data",@[
    ("Hide text input",hideText),
    ("Hide File",hideFile)
  ])

proc interactiveMenu*() = 
  subMenus("What do you want to do",@[
        ("Hide data",hideMenu),
        ("Discover data",discoverMenu),
        ("Check storage space",spaceMenu)
        ])