FactoryGirl.define do
  factory :developer do
    username 'king_kong'
    email 'king@kong.io'
    password 'factory123'
    created_at Time.now.iso8601
    updated_at Time.now.iso8601
  end

  factory :application do
    name 'Jungle Book'
    key 'jungle_book'
    description 'Basically a book about the jungle'
    created_at Time.now.iso8601
    updated_at Time.now.iso8601
  end
end