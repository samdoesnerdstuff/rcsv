#! RubyCSV - A Ruby library for handling CSV files and outputting formatted TXT results
#! (c) 2025 samdoesnerdstuff / Sam Watson - BSD-2-Clause
#! See LICENSE file for more info
require 'csv'

module RCSV
  VERSION = "0.2.0"
  AUTHOR  = "samdoesnerdstuff"
  LICENSE = "BSD-2-Clause"

  class << self
    def run(in_file, out_file, filter_col = nil, filter_value = nil, verbose: true, &block)
      unless File.exist?(in_file)
        warn "Input file not found: #{in_file}" if verbose
        return
      end

      begin
        rows = CSV.read(in_file, headers: true, encoding: "bom|utf-8")
      rescue CSV::MalformedCSVError => e
        warn "Error reading CSV file: #{e.message}" if verbose
        return
      end

      headers = rows.headers

      # Filtering: either by column/value or by block
      rows = if block_given?
               rows.select(&block)
             elsif filter_col && filter_value
               rows.select { |r| r[filter_col].to_s.strip.casecmp?(filter_value.to_s.strip) }
             else
               rows
             end

      if rows.empty?
        msg = "No data found."
        File.write(out_file, msg + "\n")
        puts msg if verbose
        return
      end

      col_widths = headers.map do |h|
        [h.length, rows.filter_map { |r| r[h]&.to_s&.length }.max || 0].max
      end

      formatted = []
      formatted << headers.each_with_index.map { |h, i| h.ljust(col_widths[i]) }.join(" | ")
      formatted << col_widths.map { |w| "-" * w }.join("-+-")

      rows.each do |row|
        formatted << headers.each_with_index.map { |h, i| align(row[h].to_s, col_widths[i]) }.join(" | ")
      end

      File.write(out_file, formatted.join("\n") + "\n")
      puts "Processed #{rows.size} rows to #{out_file}" if verbose
    end

    private

    def align(val, width)
      if val =~ /\A-?\d+(\.\d+)?\z/
        val.rjust(width)
      else
        val.ljust(width)
      end
    end
  end
end