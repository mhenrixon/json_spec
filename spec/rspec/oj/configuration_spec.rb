# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RSpec::Oj::Configuration do
  it 'excludes id and timestamps by default' do
    expect(RSpec::Oj.excluded_keys).to eq %w[id created_at updated_at]
  end

  it 'excludes custom keys' do
    RSpec::Oj.exclude_keys('token')
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'excludes custom keys via setter' do
    RSpec::Oj.excluded_keys = ['token']
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'excludes custom keys via block' do
    RSpec::Oj.configure { |c| c.exclude_keys('token') }
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'excludes custom keys via block setter' do
    RSpec::Oj.configure { |c| c.excluded_keys = ['token'] }
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'excludes custom keys via instance-evaluated block' do
    RSpec::Oj.configure { exclude_keys('token') }
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'ensures its excluded keys are strings' do
    RSpec::Oj.exclude_keys(:token)
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'ensures its excluded keys are unique' do
    RSpec::Oj.exclude_keys('token', :token)
    expect(RSpec::Oj.excluded_keys).to eq ['token']
  end

  it 'resets its excluded keys' do
    original = RSpec::Oj.excluded_keys

    RSpec::Oj.exclude_keys('token')
    expect(RSpec::Oj.excluded_keys).not_to eq original

    RSpec::Oj.reset
    expect(RSpec::Oj.excluded_keys).to eq original
  end

  it 'resets its directory' do
    expect(RSpec::Oj.directory).to be_nil

    RSpec::Oj.directory = '/'
    expect(RSpec::Oj.directory).not_to be_nil

    RSpec::Oj.reset
    expect(RSpec::Oj.directory).to be_nil
  end
end
