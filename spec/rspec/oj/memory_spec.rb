# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RSpec::Oj::Memory do
  it 'has a memory' do
    expect(RSpec::Oj.memory).to eq({})
  end

  it 'memorizes strings' do
    RSpec::Oj.memorize(:key, 'value')
    expect(RSpec::Oj.memory).to eq({ key: 'value' })
  end

  it 'symbolizes keys' do
    RSpec::Oj.memorize('key', 'value')
    expect(RSpec::Oj.memory).to eq({ key: 'value' })
  end

  it 'regurgitates unremembered strings' do
    expect(RSpec::Oj.remember('foo%{bar}')).to eq('foo%{bar}')
  end

  it 'remembers strings' do
    RSpec::Oj.memorize(:bar, 'baz')
    expect(RSpec::Oj.remember('foo%{bar}')).to eq('foobaz')
  end

  it 'forgets' do
    RSpec::Oj.memorize(:key, 'value')
    RSpec::Oj.forget
    expect(RSpec::Oj.memory).to eq({})
  end
end
