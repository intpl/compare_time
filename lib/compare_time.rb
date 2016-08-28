require 'stringio'
require 'benchmark'
require 'colorize'

class CompareTime
  attr_reader :benchmarks

  def initialize(repetitions = 1)
    @repetitions = repetitions
    @benchmarks = {}
  end

  def compare(symbol, &block)
    execute_and_save(symbol, block)
    self
  end

  def results
    @benchmarks.sort_by(&:last).map do |arr|
      "#{arr[0]}: #{'%.10f' % arr[1]}"
    end
  end

  def print_results
    calculated_results = results
    puts calculated_results[0].colorize(:green)

    calculated_results.drop(1).each do |res|
      puts res
    end
  end

  alias_method :with, :compare

  private def execute_and_save(symbol, block)
    original_stdout = $stdout
    $stdout = StringIO.new
    arr = []
    @repetitions.times do
      arr << Benchmark.realtime(&block)
    end
    @benchmarks[symbol] = arr.inject(0.0) { |sum, el| sum + el } / arr.size
  ensure
    $stdout = original_stdout
  end
end

