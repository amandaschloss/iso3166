# encoding: UTF-8
module ISO3166
  class Parser
    def parse(io)
      data_lines = io.readlines[2..-1]
      raise ParseError if data_lines.nil? || data_lines.empty?

      data_lines.reject { |line| line.chomp.empty? }.map do |line|
        name, code = line.chomp.split(";")
        Country.new(name, code)
      end
    end
  end
end
