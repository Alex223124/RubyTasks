require 'capybara/cucumber'
require 'csv'
require 'faker'
require 'faker/internet'

Given(/^"([^"]*)" attempts$/) do |arg1|
  @attempts = arg1.to_i
end

When(/^hacker used them all$/) do
  Capybara.current_driver = :selenium 

  cities = ['Минск', 'Россия', 'Витебск', 'Гомель', 'Гродно', 'Брест', 'Могилев']
  CSV.open("file.csv", "wb") do |csv|
    @attempts.times do
      email = Faker::Internet::safe_email
      password = Faker::Internet::password

      visit('http://www.slivki.by')
      click_on('Войти')

      within('.register') do
        select(cities[rand(7)], :from => 'city')
        fill_in('email', :with => email)
        fill_in('password', :with => password)
        fill_in('confirmPassword', :with => password)
        click_on('ЗАРЕГИСТРИРОВАТЬСЯ')
      end

      csv << [email, password]
    end
  end
end

Then(/^emails and passwords for "([^"]*)" users should be in file\.csv$/) do |arg1|
  count = 0
  CSV.foreach("file.csv") { |row| count += 1 }
  count == arg1
end
