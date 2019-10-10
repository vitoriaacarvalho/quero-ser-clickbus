# hooks.rb
require 'base64'

Before do |scenario|
  Capybara.page.driver.browser.manage.window.resize_to('400','752') if Capybara.default_driver == :firefox_mobile
  Capybara.page.driver.browser.manage.window.maximize unless Capybara.default_driver == :firefox_mobile
end

After do |scenario|
  if scenario.failed?
    encoded_img = @browser.driver.screenshot_as(:base64)
    embed("data:image/png;base64,#{encoded_img}", 'image/png')
  end
	Capybara.current_session.driver.quit
end
