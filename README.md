# It's... CompareTime!
Compare execution times between Ruby blocks. Add a block to a class state using `compare` or `with` and compare them all later using `print_results` (in CLI) or `sort_results` if you want to use the results for something.

    gem install compare_time

Let's compare something pretty obvious:

    require 'compare_time'
    require 'openssl'

    please = CompareTime.new( # both params are optional
      5,                      # number of repetitions. default: 1
      silence_output: false   # whether to silence the output, doesn't matter here. default: true
      )

    please.compare("4096 bit") do
      OpenSSL::PKey::RSA.new 4096
    end.with("2048") do
      OpenSSL::PKey::RSA.new 2048
    end.with("1024 bit") do
      OpenSSL::PKey::RSA.new 1024
    end.print_results

    # will print:
    # 1024 bit: 0.0156294590
    # 2048 bit: 0.2788835170
    # 4096 bit: 0.3576796250

Bang, bang, pow, pow! Tadaaam!

## How does it work?
First of all, install and include the gem to your project. Either incliude it in your Gemfile and run `bundle` or just run:

    gem install compare_time
Then, require the gem in your project file:

    require 'compare_time'
To compare anything you want, you need to initialize a class. You can pass number of executions and whenever you want output to be silenced. You don't have to pass anything though to execute it only once with hidden noise.

    comparator = CompareTime.new
You can start by executing any block you want using either `compare` or `with` methods (`with` is an alias). It returns `self` so you can chain them if you want and/or use it later. Pass a desired name and a block to a `compare` method.

    comparator.compare('calculating 2**128') { 2**128 }

From there, you can compare anything with it as long as you need to.

    comparator.compare('calculating 2**256') { 2**256 }

Above two methods can be chained like this:

    comparator.compare('calculating 2**128') { 2**128 }
    .with('calculating 2**256') { 2**256 }
    .with('calculating 2**512') { 2**512 }

Then, when you are finished you just call `print_results` to display it to the console (when debugging) or `sort_results` when you need to pass it further.

    comparator.print_results

So, summing everything up:

    require 'compare_time'
    comparator = CompareTime.new

    comparator.compare('calculating 2**128') { 2**128 }
    .with('calculating 2**256') { 2**256 }
    .with('calculating 2**512') { 2**512 }

    comparator.compare('calculating 2**1024') { 2**1024 }
    .with('calculating 2**2048') { 2**2048 }

    comparator.print_results # => everything will be sorted by execution time and printed to STDOUT
