require 'spec_helper'

describe Guard::XmlLint do

  it 'knows its own name' do
    subject.to_s.should eq 'XmlLint'
  end
end
