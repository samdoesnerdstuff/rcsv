#! RubyCSV - A Ruby library for handling CSV files and outputting formatted TXT results
#! (c) 2025 samdoesnerdstuff / [removed] - BSD-2-Clause
#! See LICENSE file for more info
require 'csv'

module RCSV
  VERSION = "0.1.4"

  def self.run(in_file, out_file, filter_col = nil)
    begin
      rows = CSV.read(in_file, headers: true, return_headers: false, encoding: "bom|utf-8")
    rescue CSV::MalformedCSVError => e
      puts "Error reading CSV file: #{e.message}"
      return
    end

    # Store headers before filtering. The headers should always be from the original file.
    # (Thanks, Gemini!)
    headers = rows.headers

    if filter_col
      rows = rows.select { |row| row[filter_col] && !row[filter_col].strip.empty? }
    end

    if rows.empty?
      puts "No rows to process after filtering."
      File.open(out_file, "w") { |f| f.puts "No data found." }
      return
    end

    # Determine col width based on the max len of headers and data
    col_widths = headers.map do |h|
      max_data_len = rows.map { |r| r[h].to_s.length }.max || 0
      [h.length, max_data_len].max
    end

    formatted_lines = []

    # Format header row and separator line
    formatted_lines << headers.each_with_index.map { |h, i| h.ljust(col_widths[i]) }.join(" | ")
    formatted_lines << col_widths.map { |w| "-" * w }.join("-+-")

    # Data rows (*very* important)
    rows.each do |row|
      formatted_lines << headers.each_with_index.map { |h, i|
        val = row[h].to_s
        # Right-align if a number
        if val =~ /\A-?\d+(\.\d+)?\z/
          val.rjust(col_widths[i])
        else
          val.ljust(col_widths[i])
        end
      }.join(" | ")
    end

    # Write formatted output to the file
    File.open(out_file, "w") do |f|
      f.puts formatted_lines
    end

    puts "Processed #{rows.size} rows -> #{out_file}"
  end
end