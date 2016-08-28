require 'stringio'
require 'benchmark'
require 'colorize'

class CompareTime
  attr_reader :benchmarks

  def initialize(repetitions = 1, silence_output: true)
    @silence_output = silence_output
    @repetitions = repetitions
    @benchmarks = {}
  end

  def compare(symbol, &block)
    if @silence_output
      silence_stdout { execute_and_save(symbol, block) }
    else
      execute_and_save(symbol, block)
    end and self
  end

  def sort_results
    @benchmarks.sort_by(&:last)
  end

  def print_results
    serialized_results = sort_results.map { |res| serialize_result(res) }
    puts serialized_results[0].colorize(:green)

    serialized_results.drop(1).each do |res|
      puts res
    end
  end

  alias_method :with, :compare

  private

  def serialize_result(arr)
    "#{arr[0]}: #{'%.10f' % arr[1]}"
  end

  def execute_and_save(symbol, block)
    if @repetitions == 1
      @benchmarks[symbol] = single_repetition(block)
    else
      @benchmarks[symbol] = multiple_repetitions(block)
    end
  end

  def single_repetition(block)
    Benchmark.realtime(&block)
  end

  def multiple_repetitions(block)
    arr = []
    @repetitions.times do
      arr << single_repetition(block)
    end
    arr.inject(0.0) { |sum, el| sum + el } / arr.size
  end

  def silence_stdout(&block)
    original_stdout = $stdout
    $stdout = StringIO.new
    block.call
  ensure
    $stdout = original_stdout
  end
end

