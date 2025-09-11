#! RubyCSV - A Ruby library for handling CSV files and outputting formatted TXT results
#! (c) 2025 samdoesnerdstuff / Sam Watson - BSD-2-Clause
#! See LICENSE file for more info
require 'csv'

module RCSV
    VERSION = "0.1.3"

    def self.run(in_file, out_file, filter_col = nil)
        rows = CSV.read(in_file, headers: true, return_headers: false, encoding: "bom|utf-8")
        rows = CSV::Table.new(rows.map { |r| CSV::Row.new(rows.headers, r) }) unless rows.is_a?(CSV::Table)

        if filter_col
            rows = rows.select { |row| row[filter_col] && !row[filter_col].strip.empty? }
        end

        # !! This causes errors, review asap
        headers = rows.headers

        col_widths = headers.map do |h|
            max_data_len = rows.map { |r| r[h].to_s.length }.max || 0
            [h.length, max_data_len].max
        end

        formatted_lines = []

        formatted_lines << headers.each_with_index.map { |h, i| h.ljust(col_widths[i]) }.join(" | ")
        formatted_lines << col_widths.map { |w| "-" * w }.join("-+-")

        # Data rows (important)
        rows.each do |row|
          formatted_lines << headers.each_with_index.map { |h, i|
            val = row[h].to_s
            # Right-align if numerical
            if val =~ /\A-?\d+(\.\d+)?\z/
              val.rjust(col_widths[i])
            else
              val.ljust(col_widths[i])
            end
          }.join(" | ")
        end

        File.open(out_file, "w") do |f|
            f.puts formatted_lines
        end

        puts "Processed #{rows.size} rows --> #{out_file}"
    end
end