module Thong
  module SimpleCov
    class Formatter
      def format(result)
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
          :covered_files => source_files.size,
        }
        display_results(global_coverage)

        if ::Thong::API::CONFIG.fetch(:thong_url) { nil }
          API.post_json "jobs", {:source_files => source_files, :test_framework => result.command_name.downcase, :run_at => result.created_at}
        end

        true

      rescue Exception => e
        display_error e
      end

      def display_results(coverage)

        if coverage[:percent] > 90
          color = "green"
        elsif coverage[:percent] > 80
          color = "yellow"
        else
          color = "red"
        end

        puts "[Thong] #{coverage[:command_name]} Report generated at  #{coverage[:run_at]}".colorize(:green)
        puts "- #{coverage[:covered_files]} files analyzed".colorize(:white)
        puts "- #{coverage[:covered_lines]} lines covered by tests.".colorize(:green)
        puts "- #{coverage[:missed_lines]} lines not covered by tests".colorize(:red)
        puts "- Coverage is at #{coverage[:percent]}%".colorize(color.to_sym)
      end

      def display_error(e)
        puts "Thong encountered an exception:".colorize(:red)
        puts e.class.to_s.colorize(:red)
        puts e.message.colorize(:red)
        if e.respond_to?(:response) && e.response
          puts e.response.to_s.colorize(:red)
        end
        false
      end

    end
  end
end
