# encoding: utf-8

require 'spec_helper'

describe Guard::XmlLint::Linter do
   example { subject.should be_an_instance_of(Guard::XmlLint::Linter) }
   example { subject.should respond_to(:lint).with(1).argument }
end
