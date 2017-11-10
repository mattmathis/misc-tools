#!/usr/bin/python
"""
Extract a subset of a csv:   subsetcsv.py <mask>.csv data.csv
Where mask has 4 records:
  * standard column names (which must be a subset of the names in data.csv)
  * A mask row, where columns with 0 or null entries will be excluded from the output.
  * A min row, which excludes all rows that with entries smaller than any non-null entry
  * A max row, which excludes all rows that with entries larger than any non-null entry
    (Assume numeric) in this case.
"""


import csv

def subset(mask, reader, writer):
  for row in reader:
    writer.writerow(row)


def main(argv):
  maskfile = argv[1]
  inputfile = argv[2]
  with open(maskfile, 'r') as maskinput:
    mask = cvs.reader(maskinput)
    with open(inputfile, 'r') as csvinput:
      reader = csv.DictReader(csvinput)
      with open(outputfile, 'w') as cvsoutput:
        writer = csv.DictWriter(cvsoutput, fieldname=fields)
        subset(mask, reader, writer)


if __name__ == '__main__':
  main(sys.argv)
