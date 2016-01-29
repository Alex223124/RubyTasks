require 'capybara'
require 'capybara/dsl'
require 'csv'
require 'faker'
require 'faker/internet'

Capybara.current_driver = :selenium 

Pair = Struct.new(:email, :password)

class Registration
  include Capybara::DSL

  def initialize(site)
    @site = site
    @array = []
  end

  def autoreg(attempts)
    attempts.times do
      cities = ['Минск', 'Россия', 'Витебск', 'Гомель', 'Гродно', 'Брест', 'Могилев']

      email = Faker::Internet::safe_email
      password = Faker::Internet::password

      visit(@site)
      click_on('Войти')

      within('.register') do
        select(cities[rand(7)], :from => 'city')
        fill_in('email', :with => email)
        fill_in('password', :with => password)
        fill_in('confirmPassword', :with => password)
        click_on('ЗАРЕГИСТРИРОВАТЬСЯ')
      end

      @array << Pair.new(email, password)
    end
  end

  def save_to_file(file)
    CSV.open(file, "wb") do |csv|
      @array.each { |el| csv << [el.email, el.password] }
    end
  end
end
