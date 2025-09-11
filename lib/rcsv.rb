#! RubyCSV - A Ruby library for handling CSV files and outputting formatted TXT results
#! (c) 2025 samdoesnerdstuff / Sam Watson - BSD-2-Clause
#! See LICENSE file for more info
require 'csv'

module RCSV
    VERSION = "0.0.1"

    def self.run(in_file, out_file, filter_col = nil)
        rows = CSV.read(in_file, headers: true)

        if filter_col
            rows = rows.select { |row| row[filter_col] && !row[filter_col].strip.empty? }
        end

        headers = rows.headers

        col_widths = headers.map do |h|
            max_data_len = rows.map { |r| r[h].to_s.length }.max || 0
            [h.length, max_data_len].max
        end

        formatted_lines = []
end