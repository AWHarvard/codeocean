require 'rails_helper'

describe Submission do
  before(:all) do
    @submission = FactoryGirl.create(:submission)
  end

  it 'validates the presence of a cause' do
    expect(described_class.create.errors[:cause]).to be_present
  end

  it 'validates the presence of an exercise' do
    expect(described_class.create.errors[:exercise_id]).to be_present
  end

  it 'validates the presence of a user' do
    expect(described_class.create.errors[:user_id]).to be_present
    expect(described_class.create.errors[:user_type]).to be_present
  end

  [:download, :render, :run, :test].each do |action|
    describe "##{action}_url" do
      let(:url) { @submission.send(:"#{action}_url") }

      it "starts like the #{action} path" do
        filename = File.basename(__FILE__)
        expect(url).to start_with(Rails.application.routes.url_helpers.send(:"#{action}_submission_path", @submission, filename).sub(filename, ''))
      end

      it 'ends with a placeholder' do
        expect(url).to end_with(Submission::FILENAME_URL_PLACEHOLDER)
      end
    end
  end

  [:score, :stop].each do |action|
    describe "##{action}_url" do
      let(:url) { @submission.send(:"#{action}_url") }

      it "corresponds to the #{action} path" do
        expect(url).to eq(Rails.application.routes.url_helpers.send(:"#{action}_submission_path", @submission))
      end
    end
  end

  describe '#to_s' do
    it "equals the class' model name" do
      expect(@submission.to_s).to eq(described_class.model_name.human)
    end
  end
end
