require 'spec_helper'

RSpec.describe Thingamajig do
  it 'has a version number' do
    expect(Thingamajig::VERSION).not_to be nil
  end

  it 'lists projects' do
    expect(Thingamajig.new.projects.any?).to be_truthy
  end
end
