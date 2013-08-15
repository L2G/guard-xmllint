# encoding: utf-8

require 'guard/guard'
require 'guard/xmllint/version'

module Guard
  class XmlLint < Guard

    def initialize(watchers = [], options = {})
      super
      @options = {
        files: '**/*.xml'
      }.update(options)
    end

    def run_all
      UI.debug("XML-linting all files matching #{options[:files]}")
      run_on_changes(Dir.glob(options[:files]))
    end

    def run_on_changes(paths)
      paths.each do |path|
        UI.debug("XML-linting #{path}")
        lint_pick(path) if File.file?(path)
      end
    end

    # Returns this guard's name, in accordance with Guard's plugin API
    #
    # @api public
    # @return [String]
    # @example
    #   g.to_s  # => 'XmlLint'

    def to_s
      'XmlLint'
    end

    private

    def lint_pick(path)
      UI.debug("Picking at #{path} (well, I would be!)")
    end
  end
end
