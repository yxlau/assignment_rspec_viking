require 'warmup'

describe Warmup do

  let(:w){ Warmup.new }

  describe "#gets_shout" do


    it "returns a string in uppercase" do
      allow(w).to receive(:gets).and_return('hello, world!')
      allow(w).to receive(:puts).and_return(nil)
      expect(w.gets_shout).to eq('HELLO, WORLD!')
    end

  end

  describe '#triple_size(arr)' do

    it 'returns triple array size' do
      my_arr = double(:size => 5)
      expect(w.triple_size(my_arr)).to eq(15)

    end

  end

  describe '#calls_some_methods' do

    let(:s){ "I am unrelated"}

    it 'passed in string receives upcase! method call' do
      expect(s).to receive(:upcase!).and_return('I AM UNRELATED!')
      w.calls_some_methods(s)
    end

    it 'passed in string receives reverse! method call' do
      expect(s).to receive(:reverse!)
      w.calls_some_methods(s)
    end

    it 'returns a different object' do
      expect(w.calls_some_methods(s)).not_to be(s)
    end

  end

end
