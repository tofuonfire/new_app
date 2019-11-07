require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ApplicationHelper. For example:
#
# describe ApplicationHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe ApplicationHelper, type: :helper do
  describe 'website_name' do
    it 'サイト名を返すこと' do
      expect(website_name).to eq 'Mewblr'
    end
  end

  describe 'full_title' do
    it 'ページタイトルが無いならサイト名だけを返すこと' do
      expect(full_title).to eq website_name
    end

    it 'ページタイトルがあるならサイト名を合わせた完全なタイトルを返すこと ' do
      expect(full_title('Contact')).to eq "Contact | #{website_name}"
    end
  end

  describe 'date_format' do
    it '投稿やコメントがされてから現在までのおおよその時間/日数を返すこと' do
      post = FactoryBot.create(:post, created_at: 2.hours.ago)
      expect(date_format(post.created_at)).to eq '2時間前'

      comment = FactoryBot.create(:comment, post: post, created_at: 10.minutes.ago)
      expect(date_format(comment.created_at)).to eq '10分前'
    end
  end
end
