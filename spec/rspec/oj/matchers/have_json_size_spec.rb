# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RSpec::Oj::Matchers::HaveJsonSize do
  it 'counts array entries' do
    expect(%([1,2,3])).to have_json_size(3)
  end

  it 'counts null array entries' do
    expect(%([1,null,3])).to have_json_size(3)
  end

  it 'counts hash key/value pairs' do
    expect(%({"one":1,"two":2,"three":3})).to have_json_size(3)
  end

  it 'counts null hash values' do
    expect(%({"one":1,"two":null,"three":3})).to have_json_size(3)
  end

  it 'matches at a path' do
    expect(%({"one":[1,2,3]})).to have_json_size(3).at_path('one')
  end

  it 'provides a failure message' do
    matcher = have_json_size(3)
    matcher.matches?(%([1,2]))
    expect(matcher.failure_message).to eq 'Expected JSON value size to be 3, got 2'
  end

  it 'provides a failure message for negation' do
    matcher = have_json_size(3)
    matcher.matches?(%([1,2,3]))
    expect(matcher.failure_message_when_negated).to eq 'Expected JSON value size to not be 3, got 3'
  end

  it 'provides a description message' do
    matcher = have_json_size(1)
    matcher.matches?(%({"id":1,"json":["spec"]}))
    expect(matcher.description).to eq %(have JSON size "1")
  end

  it 'provides a description message with path' do
    matcher = have_json_size(1).at_path('json')
    matcher.matches?(%({"id":1,"json":["spec"]}))
    expect(matcher.description).to eq %(have JSON size "1" at path "json")
  end

  it 'provides an error when parsing nil' do
    matcher = have_json_size(0).at_path('json')
    expect { matcher.matches?(%({"id":1,"json":null})) }.to raise_error(RSpec::Oj::EnumerableExpected,
                                                                        'Enumerable expected, got nil')
  end

  it 'provides an error when parsing non-enumerables' do
    matcher = have_json_size(0).at_path('json')
    expect { matcher.matches?(%({"id":1,"json":12345})) }.to raise_error(RSpec::Oj::EnumerableExpected,
                                                                         'Enumerable expected, got 12345')
  end
end
