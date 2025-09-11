# RubyCSV

![Static Badge](https://img.shields.io/badge/Built_with-Ruby-red?logo=ruby&color=%23CC342D)
![Commits since latest release](https://img.shields.io/github/commits-since/samdoesnerdstuff/rcsv/latest)

A small CLI tool for parsing CSV content and outputting it to plain formatted text. This project only requires the [latest verison of Ruby](https://www.ruby-lang.org/en/) ( > 3.2.9) and that's it. No external gems or libraries are needed to run this tool locally. 

## Usage

There are only three switches for rcsv. The flags for input / output files and one for basic filtering.

**Shorthand Version:**
```
rcsv -if data.csv -of output.txt -ff ImportantThing
```

**Longhand Version:**
```
rcsv --input purchases.csv --output formatted.txt --filter-for CardNum