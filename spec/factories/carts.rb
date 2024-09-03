FactoryBot.define do
  factory :cart do
    session_id { SecureRandom.hex(16) }
  end
end
