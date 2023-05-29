FactoryBot.define do
  factory :label do
    label_name { "Default1" }
  end
  factory :second_label, class: Label do
    label_name { "Default2" }
  end
  factory :third_label, class: Label do
    label_name { "Default3" }
  end
end
