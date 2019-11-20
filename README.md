# ebook-homebrew-nim-client

[![Actions Status](https://github.com/tubone24/ebook-homebrew-nim-client/workflows/Build%20and%20test%20Nim/badge.svg)](https://github.com/tubone24/ebook-homebrew-nim-client/actions)

> Make pdf file which you use e-books by take in some image files such as jpeg, png and gif.

# Setup

Use Nim and Nimble, so you should install nim (>=0.20.2)

```
$ nimble install -d
$ nimble build
```

## Release Build

If you would like to optimize build.

```
$ nimble build -d:release
```

# Run

for LINUX
```
$ ./bin/ebook_homebrew_nim_client
```

for Windows
```
$ bin\ebook_homebrew_nim_client.exe
```

# Test

```
nimble test
```
