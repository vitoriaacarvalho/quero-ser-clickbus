Given(/^the test configuration data has been initialized$/) do
  $scriptFile = __dir__ # Finds the directory this script is stored in.
  $ted = TestSettingsFenix::RobotTesterFenix.new
  $poHome = PageObjects::Home.new
  $poSearch = PageObjects::SearchResults.new
  $eoVerify = ExtensionObjects::Verify.new
end

When(/^I access the webpage$/) do
  # Aqui você deverá fazer o selenium acessar o site da clickbus
end

And(/^I fill in search form box with my origin place and destination$/) do 
  $poDesktop.fill_search()
end

And(/^I select the dates in the appropriate search form fields in "(.*?)"$/) do |siteName|
  $ted.readEnv
  siteName = siteName + ' ' + $environment
  $poHome::CalendarCommand(siteName)
  $poHome::ValidateDate(siteName)
end

And(/^I select the dates in results page appropriate search form fields in "(.*?)"$/) do |siteName|
  $poSearch::CalendarCommand(siteName)
end

And(/^I select the trip search button in the "(.*?)"$/) do |siteName|
  $ted.readEnv
  siteName = siteName + ' ' + $environment
  $poHome::PerformSearch(siteName)
end

Then(/^I should see results in the "(.*?)" Search Results Page and select one randomly$/) do |siteName|
  wait_for_ajax
  $ted.readEnv
  siteName = siteName + ' ' + $environment
  $eoVerify.addQueryString
  $poSearch::RandomSelect(siteName)
end

When(/^I select randomly seats in the "(.*?)"$/) do |siteName|
  $ted.readEnv
  siteName = siteName + ' ' + $environment
  $poSearch::RandomSelectSeats(siteName)
end

And(/^I click the button to buy the reserved seats in the "(.*?)" to move on$/) do |siteName|
  $ted.readEnv
  siteName = siteName + ' ' + $environment
  $poSearch::ContinueBooking(siteName)
  $poSearch.verifyRoundTrip(siteName)
end

Then(/^I should fill in fields Passenger data and Contact info in the checkout page$/) do 
  $poDesktop.passengerData()
end

And(/^I should choose the "(.*?)" payment options in the "(.*?)" checkout page$/) do |paymentType, siteName|
  $ted.readEnv
  siteName = siteName + ' ' + $environment
  $poCheckout::FillPaymentData(paymentType, siteName)
end

