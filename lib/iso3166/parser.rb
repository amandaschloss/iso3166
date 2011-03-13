# encoding: UTF-8
require "iconv"

module ISO3166
  class Parser
    def parse(io)
      file_lines = io.readlines.map { |line| Iconv.conv("UTF-8", "ISO-8859-1", line) }
      data_lines = file_lines[2..-1]
      raise ParseError if data_lines.nil? || data_lines.empty?

      data_lines.reject { |line| line.chomp.empty? }.map do |line|
        name, code = line.chomp.split(";")
        {:alpha2 => code, :short_name => name}
      end
    end
  end
end
