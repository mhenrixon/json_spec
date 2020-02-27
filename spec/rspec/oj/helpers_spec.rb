# frozen_string_literal: true

require 'spec_helper'

RSpec.describe RSpec::Oj::Helpers do
  include described_class

  describe '#parse_json' do
    it 'parses JSON documents' do
      expect(parse_json(%({"json":["spec"]}))).to eq({ 'json' => ['spec'] })
    end

    it 'parses JSON values' do
      expect(parse_json(%("rspec-oj"))).to eq 'rspec-oj'
    end

    # it 'raises a parser error for invalid JSON' do
    #   expect { parse_json('rspec-oj') }.to raise_error(MultiJson::DecodeError)
    # end

    it 'parses at a path if given' do
      json = %({"json":["spec"]})
      expect(parse_json(json, 'json')).to eq ['spec']
      expect(parse_json(json, 'json/0')).to eq 'spec'
    end

    it 'raises an error for a missing path' do
      json = %({"json":["spec"]})
      %w[spec json/1].each do |path|
        expect { parse_json(json, path) }.to raise_error(RSpec::Oj::MissingPath)
      end
    end

    it 'parses at a numeric string path' do
      json = %({"1":"two"})
      expect(parse_json(json, '1')).to eq 'two'
    end
  end

  describe '#normalize_json' do
    it 'normalizes a JSON document' do
      normalized = <<~JSON
        {"json":["spec"]}
      JSON
      expect(normalize_json(%({"json":["spec"]}))).to eq normalized.chomp
    end

    it 'normalizes at a path' do
      expect(normalize_json(%({"json":["spec"]}), 'json/0')).to eq %("spec")
    end

    it 'accepts a JSON value' do
      expect(normalize_json(%("rspec-oj"))).to eq %("rspec-oj")
    end

    it 'normalizes JSON values' do
      expect(normalize_json(%(1e+1))).to eq %(10.0)
    end
  end

  describe '#generate_normalized_json' do
    it 'generates a normalized JSON document' do
      normalized = <<~JSON
        {"json":["spec"]}
      JSON
      expect(generate_normalized_json({ 'json' => ['spec'] })).to eq normalized.chomp
    end

    it 'generates a normalized JSON value' do
      expect(generate_normalized_json(nil)).to eq %(null)
    end
  end

  describe '#load_json_file' do
    it 'raises an error when no directory is set' do
      expect { load_json('one.json') }.to raise_error(RSpec::Oj::MissingDirectory)
    end

    it 'returns JSON when the file exists' do
      RSpec::Oj.directory = files_path
      expect(load_json('one.json')).to eq %({"value":"from_file"})
    end

    it 'ignores extra slashes' do
      RSpec::Oj.directory = "/#{files_path}/"
      expect(load_json('one.json')).to eq %({"value":"from_file"})
    end

    it "raises an error when the file doesn't exist" do
      RSpec::Oj.directory = files_path
      expect { load_json('bogus.json') }.to raise_error(RSpec::Oj::MissingFile)
    end

    it "raises an error when the directory doesn't exist" do
      RSpec::Oj.directory = "#{files_path}_bogus"
      expect { load_json('one.json') }.to raise_error(RSpec::Oj::MissingFile)
    end

    it 'finds nested files' do
      RSpec::Oj.directory = files_path
      expect(load_json('project/one.json')).to eq %({"nested":"inside_folder"})
      expect(load_json('project/version/one.json')).to eq %({"nested":"deeply"})
    end
  end
end
