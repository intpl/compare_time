## It's... CompareTime!
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
