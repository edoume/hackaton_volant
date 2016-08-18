FactoryGirl.define do
  factory :spot do
    user

    factory :fixed_spot do
      nom "Sainte Feyre"
      adresse "7 place du 8 mai"
    end

    factory :invalid_spot do
      user
      nom nil
      adresse nil
    end
  end
end