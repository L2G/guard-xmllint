# encoding: utf-8

require 'guard/guard'

module Guard

  # XmlLint plugin for Guard

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
      glob = options[:files]
      UI.info("Linting all XML files matching #{glob}")
      run_on_changes(Dir.glob(glob))
    end

    def run_on_changes(paths)
      UI.info('XmlLint is checking: ' + paths.join(' '))
      errors = 0
      files = 0
      paths.each do |path|
        if File.file?(path)
          files  += 1
          errors += 1 if lint_pick(path)
        end
      end
      UI.info(
        "XmlLint checked #{quant(files, :files)}; #{quant(errors)} had problems"
        )
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
      error = @linter.lint(path)
      if error
        UI.info("XML parser error for #{path}\n" + error)
      end
      !!error
    end

    def quant(num, noun = nil)
      phrase = (num == 0 ? 'no' : num.to_s)
      if noun
        phrase += " #{noun}"
        phrase.gsub!(/s$/, '') if num == 1
      end
      phrase
    end

  end
end
