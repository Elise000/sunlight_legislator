require 'rspec'
require_relative '../db/config'


describe "create table with correct schema" do
  before(:all) do
    raise RuntimeError, "be sure to run 'rake db:migrate' before running these specs" unless ActiveRecord::Migrator.current_version > 0
  end

  it "should have a Senators table" do
    expect(ActiveRecord::Base.connection.table_exists?(:senators)).to eq(true)
  end

  it "should have the right columns and types" do
    expected = {
      :integer => ["id"],
      :string => ["title","firstname","middlename","lastname","name_suffix","nickname","party","state","district","in_office","gender","phone","fax","website","webform","congress_office","bioguide_id","votesmart_id","fec_id","govtrack_id","crp_id","twitter_id","congresspedia_url","youtube_url","facebook_id","official_rss","senate_class"],
      :date => ["birthdate"],
      :datetime => ["created_at", "updated_at"]
    }

    ActiveRecord::Base.connection.columns(:senators).each do |col|
      expect(expected[col.type].include?(col.name)).to eq(true)
    end
  end
end
