require 'rails_helper'

RSpec.describe 'users/show', type: :view do
  describe 'user logged in' do
    context 'current user' do
      before(:each) do
        current_user = assign(:user, FactoryBot.build_stubbed(:user, name: 'Denis'))
        allow(view).to receive(:current_user).and_return(current_user)

        render
      end

      it 'renders user name' do
        expect(rendered).to match 'Denis'
      end

      it 'renders change password' do
        expect(rendered).to match 'Сменить имя и пароль'
      end
    end

    context 'not current user' do
      before(:each) do
        assign(:user, FactoryBot.build_stubbed(:user, name: 'Ilya'))
        render
      end

      it 'doesnt render change password' do
        expect(rendered).not_to match 'Сменить имя и пароль'
      end

      it 'renders game partial' do
        assign(:games, FactoryBot.build_stubbed(:game, id: 1))
        stub_template "users/_game.html.erb" => "<%= game.id %>"
        render

        expect(rendered).to match /1/
      end
    end
  end
end