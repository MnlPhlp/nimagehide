# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import nimagehidepkg/[imageIO,storeData,helpers]
export imageIO,storeData,helpers

when isMainModule:
  import nimagehidepkg/cli
  interactiveMenu()
