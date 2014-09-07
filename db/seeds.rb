Admin.create!(email: 'admin@admin.com', password: 123_123_123, password_confirmation: 123_123_123)
User.create!(email: 'user@user.com', password: 123_123_123, password_confirmation: 123_123_123)

%w(Sale Buy Exchange Service Vacation).each { |name| Type.create!(name: name) }
%w(Sport Programming Building Auto Games Video Music).each { |name| Category.create!(name: name) }
