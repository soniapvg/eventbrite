User.destroy_all
Event.destroy_all
Attendance.destroy_all

ActiveRecord::Base.connection.reset_pk_sequence!('users')
ActiveRecord::Base.connection.reset_pk_sequence!('events')
ActiveRecord::Base.connection.reset_pk_sequence!('attendances')

5.times do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  email = Faker::Internet.email(name: first_name + last_name)
  User.create(
    first_name: first_name,
    last_name: last_name,
    description: Faker::Lorem.paragraph,
    email: email
  )
end
puts "#{User.count} users were created."

10.times do
  Event.create(
    start_date: Faker::Time.forward(days: rand(1..15), period: :all),
    duration: rand(3..24) * 5,
    title: Faker::Lorem.sentence(word_count: 1, random_words_to_add: 2).chop,
    description: Faker::Lorem.paragraph(sentence_count: 2, random_sentences_to_add: 2),
    price: rand(5..200),
    location: Faker::Address.city,
    administrator: User.all.sample
  )
end
puts "#{Event.count} events were created."

20.times do
  Attendance.create(
    user: User.all.sample,
    event: Event.all.sample,
    stripe_customer_id: Faker::Alphanumeric.alpha(number: 10)
  )
end
puts "#{Attendance.count} attendances were created."
