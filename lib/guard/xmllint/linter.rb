# encoding: utf-8

require 'libxml'

module Guard
  class XmlLint
    class Linter

      def lint(path)
        @parser = LibXML::XML::Reader.file(path)
        begin
          loop { break unless @parser.read }
        rescue LibXML::XML::Error => error
          return error.message.lines[0]
        end
        nil
      end

    end
  end
end
