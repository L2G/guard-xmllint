# encoding: utf-8

require 'xmlsimple'

module Guard
  class XmlLint
    class Linter

      def initialize
        @parser = XmlSimple.new
      end

      def lint(path)
        @parser.xml_in(path)
        nil
      rescue REXML::ParseException => exc
        exc.message.gsub(/.*^\.\.\.$\s/m, '')
      end

    end
  end
end
