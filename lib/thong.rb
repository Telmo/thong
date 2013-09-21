require 'colorize'
require "thong/version"
require 'simplecov'

module Thong
  extend self

  attr_accessor :adapter

  def wear!(simplecov_setting=nil, &block)
    setup!
    start! simplecov_settings, &block
  end

  def setup
   ::SimpleCov.formatter = Thong::SimpleCov::Formatter
   puts "[Thong] Setting up the SimpleCov formatter.".colorize(:green)
  end


  def start!(simplecov_setting = 'test_frameworks', &block)
    ::SimpleCov.add_filter 'vendor'

    if simplecov_setting
      puts "[Thong] Using SimpleCov's '#{simplecov_setting}' settings.".colorize(:green)
      if block_given?
        ::SimpleCov.start(simplecov_setting) { instance_eval &block }
      else
        ::SimpleCov.start(simplecov_setting)
      end
    elsif block_given?
      puts "[Thong] Using SimpleCov settings defined in block".colorize(:green)
      ::SimpleCov.start { instance_eval &block }
    else
      puts "[Thong] Using SimpleCov with default settings".colorize(:green)
      ::SimpleCov.start
    end
  end

end
