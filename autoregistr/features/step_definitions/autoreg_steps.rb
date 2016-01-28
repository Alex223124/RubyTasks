require_relative 'registration.rb'

Given(/^"([^"]*)" attempts$/) do |arg1|
  @attempts = arg1.to_i
end

When(/^hacker used them all$/) do
  @reg = Registration.new('http://www.slivki.by')
  @reg.autoreg(@attempts) 
end

Then(/^emails and passwords saved in "([^"]*)"$/)  do |arg1|
  @reg.save_to_file(arg1)
end
