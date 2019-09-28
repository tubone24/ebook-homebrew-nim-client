# This is just an example to get you started. Users of your hybrid library will
# import this file by writing ``import ebook_homebrew_nim_clientpkg/submodule``. Feel free to rename or
# remove this file altogether. You may create additional modules alongside
# this file as required.
import httpclient

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
