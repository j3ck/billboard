# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :advert do
    title "Lorem ipsum dolor sit amet."
    description "Lorem ipsum dolor sit amet, consectetur adipisicing elit.
    Molestias eveniet facere a praesentium quis ut harum, temporibus laborum
    similique odit quia reiciendis maxime facilis, perferendis nihil, non numquam!
    Iure eum, voluptatem nulla. Quidem, nihil, repellendus distinctio vel ut repudiandae iure."
    price 100
  end
end
