# This is just an example to get you started. A typical hybrid package
# uses this file as the main entry point of the application.

import parseopt2, ebook_homebrew_nim_clientpkg/submodule

when isMainModule:
  for kind, key, val in getopt() :
    case kind
    of cmdArgument:
      if key == "status":
        echo(getStatus())
      if key == "upload":
        let uploadId = extractUploadId(uploadImgSeq(listImgFiles("tests/assets"), "image/jpeg"))
        discard convertImg(uploadId, "image/jpeg")
        convertPdfDownload(uploadId, "result.pdf")
    of cmdLongOption, cmdShortOption:
      if key == "h" or key == "help":
        echo(getHelp())
      echo "Options > ",key,"=" ,val
    of cmdEnd:
      echo "end"

