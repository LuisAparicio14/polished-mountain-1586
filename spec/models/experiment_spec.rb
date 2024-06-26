require 'rails_helper'

RSpec.describe Experiment, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:objective) }
    it { should validate_presence_of(:num_months) }
  end
  describe 'relationships' do
    it {should have_many :experiment_scientists}
    it { should have_many(:scientists).through(:experiment_scientists) }
  end

  before(:each) do
    @lab = Lab.create!(name: "Tampa Lab")

    @scientist_1 = Scientist.create!(
      name: "Luis",
      specialty: "Numbers",
      university: "Harvard",
      lab_id: @lab.id
    )

    @scientist_2 = Scientist.create!(
      name: "Walter",
      specialty: "Persons",
      university: "Tampa University",
      lab_id: @lab.id
    )

    @experiment1 = Experiment.create!(
      name: "Fire",
      objective: "Test for fire",
      num_months: 7
    )

    @experiment2 = Experiment.create!(
      name: "Polution",
      objective: "Test for polution",
      num_months: 6
    )

    @experiment3 = Experiment.create!(
      name: "Hello",
      objective: "Test for Luis",
      num_months: 8
    )

    @experiment_scientists_1 = ExperimentScientist.create!(experiment_id: @experiment1.id, scientist_id: @scientist_1.id)
    @experiment_scientists_2 = ExperimentScientist.create!(experiment_id: @experiment2.id, scientist_id: @scientist_1.id)
    @experiment_scientists_3 = ExperimentScientist.create!(experiment_id: @experiment1.id, scientist_id: @scientist_2.id)
  end
  describe 'class methods' do
    describe "#long_running_experiments_in_descending_order" do
      it "returns experiments with more than 6 months in descending order by num_months" do
        expect(Experiment.long_running_experiments_in_descending_order).to eq(["Hello", "Fire"])
      end
    end
  end
end