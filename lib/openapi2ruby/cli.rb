require 'thor'

module Openapi2ruby
  class Cli < Thor
    desc 'parse', 'load openapi.yaml'
    def parse(path)
      puts 'Loading...'
      raise "File not found. #{path}" unless File.exist?(path)

      openapi = Openapi2ruby::Parser.parse(path)
      p openapi.schemas
    end

    option :template, type: :string
    option :out, required: true, type: :string
    desc 'generate', 'load openapi.yaml and generate serializer'
    def generate(path)
      puts 'Loading...'
      raise "File not found. #{path}" unless File.exist?(path)

      openapi = Openapi2ruby::Parser.parse(path)
      openapi.schemas.each do |schema|
        Openapi2ruby::Generator.generate(schema, options[:out], options[:template])
      end
    end
  end
end
