require 'rails_helper'

RSpec.feature 'USER watches profile', type: :feature do

  let(:user_games) do
    [
      FactoryBot.create(
        :game, id: 11, created_at: Time.parse('2019.01.01, 15:00'), current_level: 7,
        prize: 1000, is_failed: true, finished_at: Time.parse('2019.01.01, 15:07')),
      FactoryBot.create(
        :game, id: 177, created_at: Time.parse('2018.12.12, 3:00'), current_level: 12, prize: 32000)
    ]
  end

  let(:current_user) { FactoryBot.create(:user, name: 'Denis') }
  let!(:other_user) { FactoryBot.create(:user, id: 9, name: 'Vova', games: user_games) }

  before(:each) do
    login_as current_user
  end

  scenario 'USER watches other profile' do
    visit '/'

    click_link 'Vova'

    expect(page).to have_current_path '/users/9'

    expect(page).to have_content 'Denis'
    expect(page).to have_content '177'
    expect(page).to have_content '50/50'
    expect(page).to have_content '01 янв., 15:00'
    expect(page).to have_content '12 дек., 03:00'
    expect(page).to have_content '1 000'
    expect(page).to have_content '32 000'
    expect(page).to have_content 'в процессе'
    expect(page).to have_content 'проигрыш'
    expect(page).not_to have_content 'Сменить имя и пароль'
  end

end