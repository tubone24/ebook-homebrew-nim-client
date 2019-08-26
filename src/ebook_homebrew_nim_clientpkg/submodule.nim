# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import ebook_homebrew_nim_clientpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.
import httpclient

const url = "https://ebook-homebrew.herokuapp.com/"

proc getWelcomeMessage*(): string =
  var client = newHttpClient()
  var response = client.get(url & "status")
  echo response.body
