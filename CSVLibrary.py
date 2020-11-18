import csv
class CSVLibrary(object):
    @classmethod
    def create_csv_file(cls, filename):
        with open(filename, 'w', newline='') as csvfile:
            filewriter = csv.writer(csvfile, delimiter='\t', quoting=csv.QUOTE_NONE)
            filewriter.writerow(['Name', 'Website', 'Address', 'Email', 'Phone'])
            return filename

    @classmethod
    def write_to_csv_file(cls, filename, data):
        with open(filename, 'a', newline='') as csvfile:
            filewriter = csv.writer(csvfile, delimiter='\t', quoting=csv.QUOTE_NONE, escapechar='\\')
            filewriter.writerow(data)