require 'json'
module Thong
  module SimpleCov
    class Formatter
      def format(result)
        result.files.each { |f|
        puts "#{f.filename} -  #{f.covered_percent.round(2)}%"
        }
        puts "Coverage is at #{result.covered_percent.round(2)}%. 
        #{result.covered_lines} lines covered by test.
        #{result.missed_lines} lines not covered by test"
      end
    end
  end
end
