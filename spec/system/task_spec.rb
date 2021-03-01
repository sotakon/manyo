require 'rails_helper'

RSpec.describe 'タスク管理機能', type: :system do
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[name]',with: 'task'
        fill_in 'task[details]',with: 'details'
        find_by_id('task_limit_1i').select '2021'
        find_by_id('task_limit_2i').select '3月'
        find_by_id('task_limit_3i').select '1'
        find_by_id('task_stutas').select '未着手'
        click_button 'commit'
        expect(page).to have_content 'task'
        expect(page).to have_content 'details'
      end
    end
  end

  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, name: 'task')
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
  end

  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        @task = FactoryBot.create(:task, name: 'task')
        visit task_path(@task)
        expect(page).to have_content 'task'
      end
    end
  end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        FactoryBot.create(:task, name: 'task')
        FactoryBot.create(:second_task, name: 'task2')
        visit tasks_path
        task_list = all('.task_list')
        expect(task_list[0]).to have_content 'task'
        expect(task_list[1]).to have_content 'task2'
      end
    end
  end

  context '終了期限でソートするリンクを押した場合' do
    it '終了期限の早いタスクが一番上に表示される' do
      fast_task = FactoryBot.create(:task, name: 'important_name', details: 'important_details', limit: Time.zone.today - 1)
      visit tasks_path
      find('.sort_limit').click
      task_list_asc = all('.task_list')
      expect(task_list_asc[0]).to have_content 'important_name'
    end
  end

  describe '検索機能' do
    before do
      # 必要に応じて、テストデータの内容を変更して構わない
      FactoryBot.create(:task, name: "task")
    end
    context 'タイトルであいまい検索をした場合' do
      it "検索キーワードを含むタスクで絞り込まれる" do
        visit tasks_path
        fill_in "search_text", with:"task"
        click_button 'search_btn'
        expect(page).to have_content 'task'
      end
    end
    context 'ステータス検索をした場合' do
      it "ステータスに完全一致するタスクが絞り込まれる" do
        visit tasks_path
        find("#stutas").find("option[value='未着手']").select_option
        click_button 'search_btn'
        expect(page).to have_content '未着手'
      end
    end
    context 'タイトルのあいまい検索とステータス検索をした場合' do
      it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
        visit tasks_path
        fill_in "search_text", with:"task"
        find("#stutas").find("option[value='未着手']").select_option
        click_button 'search_btn'
        expect('.task_list').to have_content 'task'
        expect(page).to have_content '未着手'
      end
    end
  end
