require 'rails_helper'
RSpec.describe 'ユーザー登録機能', type: :system do
  describe 'ユーザー新規登録' do
    context 'ユーザーが新規登録された場合' do
      it 'ユーザーが登録される' do
        visit new_user_path
        fill_in '名前', with: 'テスト'
        fill_in 'メールアドレス', with: 'test@gmail.com'
        fill_in 'パスワード', with: '123456'
        fill_in '確認用パスワード', with: '123456'
        click_on 'Create my account'
        expect(page).to have_content 'テスト'
        expect(page).to have_content 'test@gmail.com'
      end
    end
    context 'ログインせずにタスク一覧に移動した場合' do
      it 'ログイン画面に移動する' do
        visit tasks_path
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe 'セッション機能' do
    before do
      @user = FactoryBot.create(:user)
      visit new_session_path
      fill_in 'session[email]', with: 'test@gmail.com'
      fill_in 'session[password]', with: '123456'
      click_on 'Log in'
    end
    context 'ユーザーがログインした場合' do
      it 'ログイン状態になる' do
        expect(page).to have_content 'テスト'
      end
    end
    context 'ユーザーがログインしている場合' do
      it 'マイページに飛べる' do
        find('#Profile').click
        expect(page).to have_content 'テスト'
      end
    end
    context 'ログイン中に他人のマイページに飛んだ場合' do
      it 'タスク一覧に遷移する' do
        @second_user = FactoryBot.create(:second_user)
        visit user_path(@second_user.id)
        expect(page).to have_content 'タスク一覧'
      end
    end
    context 'ログアウトした場合' do
      it 'ログアウト状態になる' do
        click_on 'Logout'
        expect(page).to have_content 'Log in'
      end
    end
  end
  describe '管理画面' do
    context '管理ユーザーがログインしている場合' do
      it '管理画面にアクセスできる' do
        @user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        find('#kanri').click
        expect(page).to have_content '管理画面'
      end
    end
  end
    context '一般ユーザーがログインしている場合' do
      it '管理画面にアクセスできない' do
        @second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'testtest@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        visit admin_users_path
        expect(page).not_to have_content '管理画面'
      end
    end
    context '管理ユーザーがログインしている場合' do
      it '他ユーザーの詳細画面にアクセスできる' do
        @user = FactoryBot.create(:user)
        @second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        visit admin_user_path(@second_user.id)
      end
    end
    context '管理ユーザーがログインしている場合' do
      it 'ユーザーの新規登録ができる' do
        @user = FactoryBot.create(:user)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        visit admin_users_path
        click_on '新規登録'
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test2@gmail.com'
        fill_in 'user[password]', with: '123456'
        fill_in 'user[password_confirmation]', with: '123456'
        select '一般', from: 'user[admin]'
        click_on 'commit'
        expect(page).to have_content 'テスト'
      end
    end
    context '管理ユーザーがログインしている場合' do
      it '一般ユーザーを編集できる' do
        @user = FactoryBot.create(:user)
        @second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        visit edit_admin_user_path(@second_user.id)
        fill_in 'user[name]', with: 'テスト'
        fill_in 'user[email]', with: 'test2@gmail.com'
        select '一般', from: 'user[admin]'
        click_on 'commit'
        expect(page).to have_content 'テスト'
      end
    end
    context '管理ユーザーがログインしている場合' do
      it 'ユーザーを削除できる' do
        @user = FactoryBot.create(:user)
        @second_user = FactoryBot.create(:second_user)
        visit new_session_path
        fill_in 'session[email]', with: 'test@gmail.com'
        fill_in 'session[password]', with: '123456'
        click_on 'Log in'
        visit admin_user_path(@second_user.id)
        click_on '削除'
        expect(page).not_to have_content 'テストユーザー2'
      end
    end
  end
