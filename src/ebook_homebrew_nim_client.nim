# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import parseopt2
import ebook_homebrew_nim_clientpkg/submodule

when isMainModule:
  for kind, key, val in getopt() :
    case kind
    of cmdArgument:
      if key == "status":
        echo(getWelcomeMessage())
    of cmdLongOption, cmdShortOption:
      echo "Options > ",key,"=" ,val
    of cmdEnd:
      echo "end"

