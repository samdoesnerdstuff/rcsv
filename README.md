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
```

## Performance

Tests were done on [preset data](https://www.datablist.com/learn/csv/download-sample-csv-files) of varying sizes, from 100 entries to 10000 entries. Files over 10000 entries may take significantly longer to execute, and in that case I advise using a superior parser, as rcsv is meant for small ( < 10000 records ) CSV files.

<!-- PowerShell command: $results = @(); for ($i = 0; $i -lt 100; $i++) { $results += Measure-Command { ruby exe/rcsv -if customers-10000.csv -of out.txt -ff "Customer Id" } }; Write-Host $results -->

| Entries | Avg. Time (ms) | Platform |
| ------- | -------------- | -------- |
| 100 | UNTESTED | UNTESTED |
| 1000 | 711.4 | Windows 11 |
| 10000 | 683.4 | Windows 11 |
| 100000 | UNTESTED | UNTESTED