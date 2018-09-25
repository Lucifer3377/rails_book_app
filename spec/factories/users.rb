#require 'faker'
#I18n.reload!                 #to be used if faker isn't loading

FactoryBot.define do
    factory :random_user,class: User do
        first_name {Faker::Name.first_name}
        last_name {Faker::Name.last_name}
        phone {Faker::Number.number(10)}
        role {ROLES.sample}
        email {Faker::Internet.email}
        password {"uchiha3377"}
        # #encrypted_password: { Devise.bcrypt(User, 'password')}
        # encrypted_password { Devise::Encryptor.digest(User, 'password') }
        # #encrypted_password: <%= User.new.send(:password_digest, '1234567890') %>
        # confirmation_token { SecureRandom.urlsafe_base64.to_s }
        confirmed_at { Time.zone.now - 1.hour }
        confirmation_sent_at { Time.zone.now - 2.hours }
      end
  end