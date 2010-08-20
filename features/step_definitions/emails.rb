
Then /^email was sent with (.*)$/ do |fields|
  email = ActionMailer::Base.deliveries.first
  fields.scan(/(\w+):\s*"([^"]*)"/).each do |field, value|
    email.send(field).to_s.should eql(value)
  end
end
