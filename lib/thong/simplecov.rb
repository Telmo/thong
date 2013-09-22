module Thong
  module SimpleCov
    class Formatter
      def format(result)
        pp result
        source_files = []
        result.files.each { |file|
          filename = file.filename.gsub(::SimpleCov.root, '.')

          file_coverage = {}
          file_coverage[:source] = File.open(file.filename, "rb:utf-8").read
          file_coverage[:name] = filename
          file_coverage[:percent] = file.covered_percent.round(2)
          source_files << file_coverage
        }
        global_coverage = {
          :percent => result.covered_percent.round(2),
          :covered_lines => result.covered_lines,
          :missed_lines => result.missed_lines,
          :command_name => result.command_name,
          :run_at => result.created_at,
        }
        color = global_coverage[:percent] < 85 ? "red" : "green"
        puts "[Thong] #{result.command_name} Report generated at  #{result.created_at}".colorize(:green)
        puts "- #{source_files.size} files analized".colorize(:white)
        puts "- Coverage is at #{global_coverage[:percent]}%".colorize(color.to_sym)
        puts "- #{result.covered_lines} lines covered by test.".colorize(:green)
        puts "- #{result.missed_lines} lines not covered by test".colorize(:red)
      end
    end
  end
end
