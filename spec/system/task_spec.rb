require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do

  before do
    @user = FactoryBot.create(:user)
  end

  def login
    visit new_session_path
    fill_in 'session[email]', with: 'test@gmail.com'
    fill_in 'session[password]', with: '123456'
    click_on 'Log in'
  end

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        login
        visit new_task_path
        fill_in 'task[name]',with: '手動で作成したタスク'
        fill_in 'task[details]',with: 'details'
        find_by_id('task_limit_1i').select '2021'
        find_by_id('task_limit_2i').select '3月'
        find_by_id('task_limit_3i').select '1'
        find_by_id('task_stutas').select '未着手'
        click_button 'commit'
        expect(page).to have_content  '手動で作成したタスク'
        expect(page).to have_content 'details'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        login
        FactoryBot.create(:task, user: @user)
        visit tasks_path
        expect(page).to have_content 'test_details'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        login
        @task = FactoryBot.create(:task, user: @user)
        visit task_path(@task)
        expect(page).to have_content 'test_name'
      end
    end
  end

  context 'タスクが作成日時の降順に並んでいる場合' do
    it '新しいタスクが一番上に表示される' do
      login
      FactoryBot.create(:task, user: @user)
      FactoryBot.create(:second_task, user: @user)
      visit tasks_path
      task_list = all('.task_list')
      expect(task_list[0]).to have_content 'test_name'
      expect(task_list[1]).to have_content 'test_name2'
    end
  end

  context '終了期限でソートするリンクを押した場合' do
    it '終了期限の早いタスクが一番上に表示される' do
      login
      FactoryBot.create(:task, name: 'important_name', details: 'important_details', limit: Time.zone.today - 1, user: @user)
      visit tasks_path
      find('.sort_limit').click
      task_list_asc = all('.task_list')
      expect(task_list_asc[0]).to have_content 'important_name'
    end
  end

  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: '検索機能用タスク', stutas: '未着手', user: @user)
      FactoryBot.create(:task, name: '検索機能用タスク2', stutas: '着手中', user: @user)
      FactoryBot.create(:task, name: '検索機能用タスク3', stutas: '完了', user: @user)
      login
    end

    context 'タイトルであいまい検索をした場合' do
      it '検索キーワードを含むタスクで絞り込まれる' do
        visit tasks_path
        fill_in 'search_text', with: '検索機能用タスク'
        click_button 'search_btn'
        expect(page).to have_content '検索機能用タスク'
      end
    end

    context 'ステータス検索をした場合' do
      it 'ステータスに完全一致するタスクが絞り込まれる' do
        visit tasks_path
        find("#stutas").find("option[value='着手中']").select_option
        click_button 'search_btn'
        expect(page).to have_content '着手中'
      end
    end

    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "search_text", with: '検索機能用タスク3'
        find("#stutas").find("option[value='完了']").select_option
        click_button 'search_btn'
        expect(page).to have_content '検索機能用タスク3'
        expect(page).to have_content '完了'
      end
    end
  end

    describe 'ラベル機能' do
      before do
        @label = FactoryBot.create(:label)
        @second_label = FactoryBot.create(:second_label)
        @second_user = FactoryBot.create(:second_user)
          visit new_session_path
          fill_in 'session[email]', with: 'testtest@gmail.com'
          fill_in 'session[password]', with: '123456'
          click_on 'Log in'
      end

      context 'タスクを新規作成する場合' do
        it "タスクに複数のラベルをつけられる" do
          visit new_task_path
          fill_in 'task[name]',with: 'task'
          fill_in 'task[details]',with: 'details'
          find_by_id('task_limit_1i').select '2021'
          find_by_id('task_limit_2i').select '3月'
          find_by_id('task_limit_3i').select '1'
          find_by_id('task_stutas').select '未着手'
          check 'テストラベル'
          check 'テストラベル2'
          click_button 'commit'
          expect(page).to have_content 'テストラベル'
          expect(page).to have_content 'テストラベル2'
        end
      end

      context 'タスクを編集する場合' do
        it "タスクに複数のラベルをつけられる" do
          @task = FactoryBot.create(:task, user: @second_user)
          visit edit_task_path(@task)
          check 'テストラベル'
          check 'テストラベル2'
          click_button 'commit'
          expect(page).to have_content 'テストラベル'
          expect(page).to have_content 'テストラベル2'
        end
      end

      context 'タスクの詳細画面で' do
        it "そのタスクに紐づいているラベル一覧を出力できる" do
          @task = FactoryBot.create(:task, user: @second_user)
          visit edit_task_path(@task)
          check 'テストラベル'
          check 'テストラベル2'
          click_button 'commit'
          visit task_path(@task)
          expect(page).to have_content 'テストラベル'
          expect(page).to have_content 'テストラベル2'
        end
      end

      context 'ラベル検索をした場合' do
        it 'つけたラベルで検索ができる' do
          visit new_task_path
          fill_in 'task[name]',with: 'task'
          fill_in 'task[details]',with: 'details'
          find_by_id('task_limit_1i').select '2021'
          find_by_id('task_limit_2i').select '3月'
          find_by_id('task_limit_3i').select '1'
          find_by_id('task_stutas').select '未着手'
          check 'テストラベル'
          check 'テストラベル2'
          click_button 'commit'
          visit tasks_path
          select 'テストラベル', from: 'label_id'
          click_button 'search_btn'
          expect(page).to have_content 'テストラベル'
        end
      end
    end
  end
