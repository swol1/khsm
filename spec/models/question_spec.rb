require 'rails_helper'

RSpec.describe Question, type: :model do
  context 'validation check' do
    it { should validate_presence_of :text }
    it { should validate_presence_of :level }

    it { should validate_inclusion_of(:level).in_range(0..14) }


    it { should allow_value(14).for(:level) }
    it { should_not allow_value(15).for(:level) }

    subject { Question.new(text: 'В каком году была куликовская битва?', level: 1, answer1: '1920', answer2: '1930', answer3: '1380', answer4: '1812') }
    it { should validate_uniqueness_of :text }
  end
end
