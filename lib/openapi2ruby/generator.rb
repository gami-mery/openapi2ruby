require 'active_support/core_ext/string/inflections'
require 'erb'
require 'pathname'

module Openapi2ruby
  class Generator
    TEMPLATE_PATH = File.expand_path('../templates/serializer.rb.erb', __FILE__)

    def self.generate(schema, output_path, template_path)
      new(schema).generate(output_path, template_path)
    end

    def initialize(schema)
      @schema = schema
    end

    def generate(output_path, template_path)
      template_path = TEMPLATE_PATH if template_path.nil?
      template = File.read(template_path)
      generated_class = ERB.new(template, nil, '-').result(binding)

      output_file = Pathname.new(output_path).join("#{@schema.name.underscore}_serializer.rb")
      File.open(output_file.to_s, 'w') { |file| file << generated_class }
    end
  end
end