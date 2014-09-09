namespace :billboard do
  desc "Fill database with sample data"
  task populate: :environment do
    Admin.create!(email: "admin@admin.com",
                 password: 123123123,
                 password_confirmation: 123123123)
    30.times do |n|
      email = "example-#{n+1}@user.com"
      password  = 123123123
      User.create!(email: email,
                   password: password,
                   password_confirmation: password)
    end

    20.times do |n|
      Category.create!(name: Faker::Lorem.word + n.to_s)
    end

    %w(Sale Buy Exchange Service Vacation).each {|name| Type.create!(name: name)}

    states = %w(template moderated rejected published archived)
    100.times do |n|
      title = Faker::Lorem.sentence(3)
      description = Faker::Lorem.paragraph(10)
      price = rand(30.0..30000.0)
      user_id = rand(1..30)
      category_id = rand(1..20)
      type_id = rand(1..5)
      state = states.sample
      Advert.create!(title: title,
                     description: description,
                     price: price,
                     user_id: user_id,
                     category_id: category_id,
                     type_id: type_id,
                     state: state)
    end

    roles = %w(Admin User)
    actions = %w(Create Edit Update Rejected Newest Moderated Archived Published)
    300.times do |n|
      advert_id = rand(1..100)
      editor_id = rand(1..30)
      editor_role = roles.sample
      action = actions.sample
      comment = Faker::Lorem.sentence(4)
      last_state = states.sample
      current_state = states.sample
      Log.create!(advert_id: advert_id,
                  editor_role: editor_role,
                  editor_id: editor_id,
                  action: action,
                  comment: comment,
                  last_state: last_state,
                  current_state: current_state)
    end

    pub_ids = Advert.where(state: "published").order(updated_at: :desc).limit(5).ids
    10.times do |n|
      advert_id = pub_ids.sample
      data = File.new(Rails.root.to_s + "/public/#{rand(1..5)}.jpg")
      Image.create!(advert_id: advert_id, data: data)
    end
  end
end
