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

  live = ""
  staged = ""
  silent = false

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
    parser.on "-s", "--silent", "Silent operation" do
      silent = true
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
      else
        # invalid arguments
        STDERR.puts "ERROR: invalid arguments"
        exit 1
      end
    end
  end
  
  begin
    live_container = client.containers.get live
    staged_container = client.containers.get staged
    puts "stop #{live}" unless silent
    live_container.stop
    puts "remove #{live}" unless silent
    live_container.remove
    puts "rename #{staged} -> #{live}" unless silent
    staged_container.rename live
    puts "start #{live}" unless silent
    staged_container.start
  rescue ex
    STDERR.puts "ERROR: #{ex.message}"
    exit 1
  end

end
