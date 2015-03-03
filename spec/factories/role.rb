FactoryGirl.define do
  factory :role do
    factory :administrator do
      name 'Admin'
    end
    factory :editor do
      name 'Editor'
    end
  end
end
