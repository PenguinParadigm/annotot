FactoryBot.define do
  factory :annotation, class: Annotot::Annotation do
    uuid { SecureRandom.hex }
    canvas { 'http://www.example.com/hola' }
    data { '' }
  end
end
