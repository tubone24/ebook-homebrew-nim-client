import httpclient, base64, os, lists, json, strutils

const url = "https://ebook-homebrew.herokuapp.com/"

proc getStatus*(): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
  let response = client.get(url & "status")
  return response.body

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

proc extractUploadId*(jsonStr: string): string =
  return parseJson(jsonStr)["upload_id"].getStr()

proc getResultList*(): string =
  let client = newHttpClient()
  client.headers = newHttpHeaders({ "Content-Type": "application/json" })
  let response = client.get(url & "data/upload/list")
  return response.body

proc prettyResultList*(jsonStr: string): void =
  echo "id     upload_id           file_type     upload_at"
  for item in parseJson(jsonStr)["fileList"].items:
    echo $item["id"].getInt() & "      " & item["file_path"].getStr() & "    " & item["file_type"].getStr() & "    " & item["updated_at"].getStr()