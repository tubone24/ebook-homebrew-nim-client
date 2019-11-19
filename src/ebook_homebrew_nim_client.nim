const doc = """
Overview:
  Client App with ebook-homebrew's rest API for Nim

Usage:
  ebook_homebrew_nim_client status
  ebook_homebrew_nim_client convert <directory> <contentType> [--output=<outputFile>]

Options:
  status                Check API Status
  convert               Upload Images, convert to PDF and download result.pdf
  <directory>           Specify directory with in images
  <contentType>         Image content Type such as "image/jpeg"
  --output=<outputFile> Output Filename [default: result.pdf]
"""

import docopt
import ebook_homebrew_nim_clientpkg/submodule

proc main() =
  let args = docopt(doc, version = "0.1.0")
  if args["status"]:
    echo getStatus()
  if args["convert"]:
    let uploadId = extractUploadId(uploadImgSeq(listImgFiles($args["<directory>"]), $args["<contentType>"]))
    discard convertImg(uploadId, $args["<contentType>"])
    if args["--output"]:
      convertPdfDownload(uploadId, $args["--output"])
    else:
      convertPdfDownload(uploadId, "result.pdf")

when isMainModule:
  main()
