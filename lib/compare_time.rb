require 'stringio'
require 'benchmark'
require 'colorize'

# CompareTime.new.compare(:whatever_name_you_want) {
#  ...
# }.with(:whatever_name_you_want2) {
#  ...
# }.print_results

class CompareTime
  attr_reader :benchmarks

  def initialize()
    # add how many times
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
    puts results[0].colorize(:green)

    results.drop(1).each do |res|
      puts res
    end
  end

  alias_method :with, :compare

  private def execute_and_save(symbol, block)
    original_stdout = $stdout
    $stdout = StringIO.new
    @benchmarks[symbol] = Benchmark.realtime(&block)
  ensure
    $stdout = original_stdout
  end
end
