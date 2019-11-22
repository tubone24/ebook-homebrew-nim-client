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

## Build and Run

```
$ nimble run ebook_homebrew_nim_client
```

## Or Run builder binary 

### for LINUX

```
$ ./bin/ebook_homebrew_nim_client
```

### for Windows

```
$ bin\ebook_homebrew_nim_client.exe
```

## Usage

```
Overview:
  Client App with ebook-homebrew's rest API for Nim

Usage:
  ebook_homebrew_nim_client status
  ebook_homebrew_nim_client list
  ebook_homebrew_nim_client convert <directory> <contentType> [-o|--output=<outputFile>]

Options:
  status                      Check API Status
  list                        Check Result List
  convert                     Upload Images, convert to PDF and download result.pdf
  <directory>                 Specify directory with in images
  <contentType>               Image content Type such as "image/jpeg"
  -o, --output=<outputFile>   Output Filename [default: result.pdf]

```

# Test

```
nimble test
```
