Feature: Clickbus Critical Flow on Phoenix
  Run through the critical flow of the Clickbus - Phoenix powered websites.

@ClickBus
Scenario: BR Critical Flow of the Clickbus Website
  Given the test configuration data has been initialized
  When I access the webpage
    And I fill in search form box with my origin place and destination
    And I select the dates in the appropriate search form fields in "Clickbus"
    And I select the trip search button in the "Clickbus"
  Then I should see results in the "Clickbus" Search Results Page and select one randomly
 
