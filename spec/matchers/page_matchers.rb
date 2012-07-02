RSpec::Matchers.define :have_errors do
  match do |page|
    page.status_code.to_s !~ /^2/
  end

  failure_message_for_should_not do |page|
    "Page error: status #{page.status_code}"
  end
end
