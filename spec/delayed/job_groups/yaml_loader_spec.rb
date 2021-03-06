# frozen_string_literal: true

describe Delayed::JobGroups::YamlLoader do
  describe "#load" do
    context "with a correct yaml object representation" do
      let(:yaml) { '--- !ruby/object:TestJobs::Foo {}' }

      it "deserializes from YAML properly" do
        expect(Delayed::JobGroups::YamlLoader.load(yaml)).to be_a(TestJobs::Foo)
      end
    end

    context "with incorrect yaml object representations" do
      let(:not_yaml1) { 'foo' }
      let(:not_yaml2) { 1 }

      it "deserializes from YAML properly" do
        expect(Delayed::JobGroups::YamlLoader.load(not_yaml1)).to eq('foo')
        expect(Delayed::JobGroups::YamlLoader.load(not_yaml2)).to eq(1)
      end
    end
  end

  describe "#dump" do
    context "with an object" do
      let(:object) { TestJobs::Foo.new }

      it "serializes into YAML properly" do
        expect(Delayed::JobGroups::YamlLoader.dump(object)).to eq("--- !ruby/object:TestJobs::Foo {}\n")
      end
    end

    context "with a nil object" do
      let(:object) { nil }

      it "serializes into YAML properly" do
        expect(Delayed::JobGroups::YamlLoader.dump(object)).to eq(nil)
      end
    end
  end
end
