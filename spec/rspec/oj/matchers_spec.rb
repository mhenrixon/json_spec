# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RSpec::Oj::Matchers do
  let(:environment) do
    klass = Class.new
    klass.send(:include, described_class)
    klass.new
  end

  let(:json)          { %({"json":"spec"}) }
  let(:stubbed)       { matcher_class.new(matcher_arg) }
  let(:matcher_arg)   { json }

  before do
    allow(matcher_class).to receive(:new).and_return(stubbed)
  end

  describe '#be_json_eql' do
    let(:matcher_class) { RSpec::Oj::Matchers::BeJsonEql }
    let(:matcher_arg)   { json }

    it 'instantiates its matcher' do
      environment.be_json_eql(json)
      expect(matcher_class).to have_received(:new).with(json)
    end

    it 'returns its matcher' do
      matcher = environment.be_json_eql(json)
      expect(matcher).to be_a(matcher_class)
    end
  end

  describe '#include_json' do
    let(:matcher_class) { RSpec::Oj::Matchers::IncludeJson }
    let(:matcher_arg)   { json }

    it 'instantiates its matcher' do
      environment.include_json(json)
      expect(matcher_class).to have_received(:new).with(json)
    end

    it 'returns its matcher' do
      matcher = environment.include_json(json)
      expect(matcher).to be_a(matcher_class)
    end
  end

  describe '#have_json_path' do
    let(:matcher_class) { RSpec::Oj::Matchers::HaveJsonPath }
    let(:matcher_arg)   { path }
    let(:path)          { 'json' }

    it 'instantiates its matcher' do
      environment.have_json_path(path)
      expect(matcher_class).to have_received(:new).with(path)
    end

    it 'returns its matcher' do
      matcher = environment.have_json_path(path)
      expect(matcher).to be_a(matcher_class)
    end
  end

  describe '#have_json_type' do
    let(:matcher_class) { RSpec::Oj::Matchers::HaveJsonType }
    let(:matcher_arg)   { type }
    let(:type)          { Hash }

    it 'instantiates its matcher' do
      environment.have_json_type(type)
      expect(matcher_class).to have_received(:new).with(type)
    end

    it 'returns its matcher' do
      matcher = environment.have_json_type(type)
      expect(matcher).to be_a(matcher_class)
    end
  end

  describe '#have_json_size' do
    let(:matcher_class) { RSpec::Oj::Matchers::HaveJsonSize }
    let(:matcher_arg)   { size }
    let(:size)          { 1 }

    it 'instantiates its matcher' do
      environment.have_json_size(size)
      expect(matcher_class).to have_received(:new).with(size)
    end

    it 'returns its matcher' do
      matcher = environment.have_json_size(size)
      expect(matcher).to be_a(matcher_class)
    end
  end
end
