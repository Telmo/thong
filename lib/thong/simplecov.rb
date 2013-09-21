module Thong
  module SimpleCov
    class Formatter
      def format(result)
        pp result
        puts "Coverage is at #{result.covered_percent.round(2)}%."
      end
    end
  end
end
