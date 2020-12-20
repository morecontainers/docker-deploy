# TODO: Write documentation for `Docker::Deploy`
require "option_parser"
require "docker"

module Docker::Deploy
  VERSION = "0.1.0"

  begin
    client = Docker.client
  rescue ex
    STDERR.puts "Could not connect to Docker"
    STDERR.puts ex.message
    exit(1)
  end

  # TODO: Put your code here
  OptionParser.parse do |parser|
    parser.banner = "Docker Deploy"

    parser.on "-v", "--version", "Show version" do
      puts "alpha"
      exit
    end
    parser.on "-h", "--help", "Show help" do
      puts parser
      exit
    end
    parser.missing_option do |option_flag|
      STDERR.puts "ERROR: #{option_flag} is missing something."
      STDERR.puts ""
      STDERR.puts parser
      exit(1)
    end
    parser.invalid_option do |option_flag|
      STDERR.puts "ERROR: #{option_flag} is not a valid option."
      STDERR.puts parser
      exit(1)
    end
    parser.unknown_args do |unknown_args|
      if unknown_args.size == 2
        live = unknown_args[0]
        staged = unknown_args[1]
        puts "live=#{live} staged=#{staged}"
      else
        # invalid arguments
        STDERR.puts "ERROR: invalid arguments"
        exit 1
      end
    end
  end
end
