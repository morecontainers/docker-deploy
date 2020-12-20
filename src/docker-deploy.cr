# TODO: Write documentation for `Docker::Deploy`
module Docker::Deploy
  VERSION = "0.1.0"
  require "option_parser"

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
  end
end
