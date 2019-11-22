import unittest
import base64, os, json, algorithm

import ebook_homebrew_nim_clientpkg/submodule
test "listImgFile":
  let actual = listImgFile("tests/assets")
  # you can get like those seq on windows @["tests\\assets\\saved_file1570019388166.jpg", "tests\\assets\\saved_file1570022912069.jpg"]
  # you can get like those seq on linux @["tests/assets/saved_file1570019388166.jpg", "tests/assets/saved_file1570022912069.jpg"]
  check "tests\\assets\\saved_file1570019388166.jpg" in actual or "tests/assets/saved_file1570019388166.jpg" in actual
  check "tests\\assets\\saved_file1570022912069.jpg" in actual or "tests/assets/saved_file1570022912069.jpg" in actual

test "convertBase64":
  let f : File = open("tests/assets/saved_file1570022912069.jpg" , FileMode.fmRead)
  defer :
    close(f)
  let base64 = encode(f.readAll())
  check convertBase64("tests/assets/saved_file1570022912069.jpg") == base64

test "listImgFiles":
  let actual = listImgFiles("tests/assets")
  let f1 : File = open("tests/assets/saved_file1570022912069.jpg" , FileMode.fmRead)
  let f2 : File = open("tests/assets/saved_file1570019388166.jpg" , FileMode.fmRead)
  defer:
    close(f1)
    close(f2)
  let base64one = encode(f1.readAll())
  let base64two = encode(f2.readAll())
  check base64one in actual
  check base64two in actual

test "extractUploadId":
  check extractUploadId("{\"upload_id\": \"test\", \"aaa\": \"bbb\"}") == "test"

test "getStatus":
  let status = parseJson(getStatus())["status"].getStr()
  check status == "ok"

test "getResultList":
  let jsonStr = parseJson(getResultList())
  check jsonStr.hasKey("fileList")
