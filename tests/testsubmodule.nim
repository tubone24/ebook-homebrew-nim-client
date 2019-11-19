import unittest
import base64, os, json

import ebook_homebrew_nim_clientpkg/submodule
test "listImgFile":
  check listImgFile("tests/assets") == @["tests\\assets\\saved_file1570019388166.jpg", "tests\\assets\\saved_file1570022912069.jpg"]

test "convertBase64":
  let f : File = open("tests/assets/saved_file1570022912069.jpg" , FileMode.fmRead)
  defer :
    close(f)
  let base64 = encode(f.readAll())
  check convertBase64("tests/assets/saved_file1570022912069.jpg") == base64

test "extractUploadId":
  check extractUploadId("{\"upload_id\": \"test\", \"aaa\": \"bbb\"}") == "test"

test "getStatus":
  let status = parseJson(getStatus())["status"].getStr()
  check status == "ok"