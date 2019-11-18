# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import ebook_homebrew_nim_clientpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.
import httpclient, base64, os, lists, json, strutils

const url = "https://ebook-homebrew.herokuapp.com/"

proc getStatus*(): string =
  let client = newHttpClient()
  let response = client.get(url & "status")
  return response.body

proc getHelp*(): string =
  const result = """Usage:
  ebook_homebrew_nim_client.exe [-h|--help] [-v|--version]
  ebook_homebrew_nim_client.exe status
  ebook_homebrew_nim_client.exe upload <directory> <extension> [--host <host>] [--port <port>]
  """
  return result

proc convertBase64*(filePath: string): string =
  block:
    let f : File = open(filePath , FileMode.fmRead)
    defer :
      close(f)
      echo "closed"
    return encode(f.readAll())

proc listImgFile*(filePath: string): seq[string] =
  var path = newSeq[string]()
  for f in walkDir(filePath):
    path.add(f.path)
  return path

proc listImgFiles*(filePath: string): seq[string] =
  var base64seq = newSeq[string]()
  for f in listImgFile(filePath):
    base64seq.add(convertBase64(f))
  return base64seq

proc uploadImgSeq*(imgSeq: seq[string], contentType: string): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
  let body = %* {"contentType": contentType, "images": imgSeq}
  echo body
  let response = client.request(url & "data/upload", httpMethod = HttpPost, body = $body)
  echo response.status
  return response.body

proc convertImg*(uploadId: string, contentType: string): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
  let body = %* {"contentType": contentType, "uploadId": uploadId}
  let response = client.request(url & "convert/pdf", httpMethod = HttpPost, body = $body)
  echo response.status
  return response.body

proc convertPdfDownload*(uploadId: string, filename: string): void =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
  let body = %* {"uploadId": uploadId}
  let response = client.request(url & "convert/pdf/download", httpMethod = HttpPost, body = $body)
  echo response.status
  block:
    let f : File = open(filename, FileMode.fmWrite)
    f.write(response.body)
    defer :
      close(f)
      echo "closed"