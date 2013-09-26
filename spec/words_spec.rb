require 'simplecov'
SimpleCov.start

require 'json'

require './app/words'

describe 'Words' do
  let(:initial_string) {"hello hello hello my my name is"}
  let(:expected_split) { ["hello", "hello", "hello", "my", "my", "name", "is"] }

  describe "initialization" do
    it "should accept a text string" do
      ->{ Words.new initial_string }.should_not raise_exception
    end

    it "should reject objects, which cannot be split to words" do
      ->{ Words.new 0 }.should raise_exception(ArgumentError)
    end

    it "initializes a stat limit" do
      Words.new(initial_string, 10).limit.should eq 10
    end
  end

  describe "#words" do
    it "should split by whitespaces" do
      Words.new("hello hello    hello my     my     name is").words.should eq expected_split
    end

    it "should consider punctuation marks as dividers" do
      Words.new("hello:hello  * ! hello?my &&^  my     name is").words.should eq expected_split
    end

    it "should accept multiline strings" do
      initial_string = <<-eos
        hello
        hello!
        hello my my
        name is
      eos

      Words.new(initial_string).words.should eq expected_split
    end
  end

  describe "#stat" do
    let(:expected_count) { {"hello" => 3, "my" => 2, "name" => 1, "is" => 1} }

    it "should count the frequency of words" do
      Words.new(initial_string).stat.should eq expected_count
    end

    it "should split the text to words before" do
      obj = Words.new(initial_string)
      obj.should_receive(:words).and_return(Array.new)

      obj.stat
    end

    it "should cache count result and not re-count that twice" do
      obj = Words.new(initial_string)
      obj.should_receive(:words).once.and_return(expected_split)

      obj.stat
      obj.stat
    end
  end

  describe "#to_json" do
    it "should return desired quantity of most freaquent words " do
      expected_count = {"hello" => 3, "my" => 2}.to_json
      Words.new(initial_string, 2).to_json.should eq expected_count
    end
  end
end