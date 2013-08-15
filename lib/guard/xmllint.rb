# encoding: utf-8

require 'guard/guard'

module Guard

  class XmlLint < Guard

    require 'guard/xmllint/linter'
    require 'guard/xmllint/version'

    # Create an instance of the XmlLint guard
    #
    # This implements a Guard plugin to watch for changes in XML files, then
    # check to make sure they are well-formed and valid (in the XML senses of
    # those terms).
    #
    # Naturally you shouldn't have to call this directly; instead, just add a
    # "guard 'xmllint'" block to your Guardfile.
    #
    # @param [Array] watchers Accepts watchers defined in the Guardfile with the
    #   "watch" directive
    # @param [Hash] options Accepts options defined in the Guardfile with "guard
    #   'xmllint'
    # @option options [String] :files Path to XML files to check; accepts file
    #   globs
    # @api public

    def initialize(watchers = [], options = {})
      super
      @options = {
        files: '**/*.xml'
      }.update(options)
      @linter = Linter.new
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
      UI.debug("Picking at #{path}")
      error = @linter.lint(path)
      if error
        UI.info("XML parser raised error for #{path}:")
        error.lines.each { |line| UI.info(":: #{line}") }
      end
      !error
    end
  end
end
