# encoding: utf-8

require 'guard/guard'
require 'guard/xmllint/version'

module Guard
  class XmlLint < Guard

    # Returns this guard's name, in accordance with Guard's plugin API
    #
    # @api public
    # @return [String]
    # @example
    #   g.to_s  # => 'XmlLint'

    def to_s
      'XmlLint'
    end
  end
end
