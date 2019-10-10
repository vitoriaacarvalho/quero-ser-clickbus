require 'pry'
require 'pry-byebug'
require 'appium_capybara'
require 'capybara'
require 'capybara/cucumber'
require 'rspec'
require 'date'
require 'selenium-webdriver'
require 'capybara-screenshot/cucumber'
require 'json'
require 'jenkins_api_client'
require "net/http"
require "uri"
require 'json'
require 'faraday'
require 'simple_oauth'
require 'google/apis/gmail_v1'
require 'googleauth'
require 'googleauth/stores/file_token_store'
require 'fileutils'
require 'csv'

desired_caps_ios = {
  automationName: 'XCUITest',
  deviceName: "David Tavares's iPhone",
  platformName: 'iOS',
  platformVersion: '10.0',
  app: 'safari'
}

desired_caps_android = {
  deviceName: 'device',
  platformName: 'Android',
  platformVersion: '7.0',
  browserName: 'chrome'
}

if ENV['iphone']
  Capybara.default_driver = :iphone
elsif ENV['appium']
  Capybara.default_driver = :appium
elsif ENV['safari']
  Capybara.default_driver = :safari
elsif ENV['firefox']
  Capybara.default_driver = :firefox
elsif ENV['firefox_mobile']
  Capybara.default_driver = :firefox_mobile
elsif ENV['internet_explorer']
  Capybara.default_driver = :internet_explorer
elsif ENV['edge']
  Capybara.default_driver = :selenium_edge
elsif ENV['SELENIUM_REMOTE']
  Capybara.default_driver = :remote_driver
elsif ENV['chrome_headless']
  Capybara.default_driver = :selenium_chrome_headless
elsif ENV['chrome']
  Capybara.default_driver = :selenium_chrome
elsif ENV['chromium']
  Capybara.default_driver = :chromium
elsif ENV['chromium_mobile']
  Capybara.default_driver = :chromium_mobile
elsif ENV['chromium_headless']
  Capybara.default_driver = :chromium_headless
elsif ENV['chromium_mobile_headless']
  Capybara.default_driver = :chromium_mobile_headless
end

class Capybara::Session
  def execute_script(script, *args)
    @touched = true
    driver.execute_script(script, *args)
  end

  def evaluate_script(script, *args)
    @touched = true
    driver.evaluate_script(script, *args)
  end
end

class Capybara::Selenium::Driver
  def execute_script(script, *args)
    browser.execute_script(script, *args)
  end

  def evaluate_script(script, *args)
    browser.execute_script("return #{script}", *args)
  end
end

Capybara.default_max_wait_time = 50

Capybara.ignore_hidden_elements = true

Capybara::Screenshot.register_driver(Capybara::default_driver) do |driver, path|
  driver.browser.save_screenshot(path)
end  

Capybara.register_driver :selenium_edge do |app|
  # ::Selenium::WebDriver.logger.level = "debug"
  Capybara::Selenium::Driver.new(app, browser: :edge)
end

Capybara.register_driver :remote_driver do |app|
  url = 'http://localhost:4444/wd/hub' # hub address
  capabilities = Selenium::WebDriver::Remote::Capabilities.chrome(
    chromeOptions: { args: %w[headless disable-gpu] }
  )
  Capybara::Selenium::Driver.new(app,
                                 browser: :remote, url: url,
                                 desired_capabilities: capabilities)
end

Capybara.register_driver :selenium_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w["ignore-certificate-errors disable-popup-blocking no-sandbox disable-gpu"]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :chromium do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w["ignore-certificate-errors disable-popup-blocking no-sandbox disable-gpu"],
    binary: "/Applications/Chromium.app/Contents/MacOS/Chromium"
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :chromium_mobile do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
    "chromeOptions" => { "mobileEmulation" => { "deviceName" => "Nexus 5" },
      args: %w["ignore-certificate-errors disable-popup-blocking no-sandbox disable-gpu"],
      binary: "/Applications/Chromium.app/Contents/MacOS/Chromium"
    }
  ))
end

Capybara.register_driver :chromium_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w["ignore-certificate-errors headless disable-popup-blocking no-sandbox disable-gpu window-size=1366,768"]
  )
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :chromium_mobile_headless do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome, desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
    "chromeOptions" => { "mobileEmulation" => { "deviceName" => "Nexus 5" },
      args: %w["ignore-certificate-errors headless disable-popup-blocking no-sandbox disable-gpu lang=pt-BR"],
      binary: "/Applications/Chromium.app/Contents/MacOS/Chromium"
    }
  ))
end

Capybara.register_driver :selenium_chrome_headless do |app|
  options = Selenium::WebDriver::Chrome::Options.new(
    args: %w["ignore-certificate-errors disable-popup-blocking headless no-sandbox disable-gpu window-size=1366,768"]
  )
  #options.add_emulation(device_name: 'iPhone 8')
  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options, :driver_path => '/chromedriver/chromedriver')
end

Capybara.register_driver :internet_explorer do |app|
  options = Selenium::WebDriver::IE::Options.new(
    args: %w["--no-sandbox --window-size=1920x1080]
  )
  Capybara::Selenium::Driver.new(app, browser: :internet_explorer, options: options)
end

Capybara.register_driver :firefox do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.native_events = true
  profile['geo.prompt.testing'] = true
  profile['geo.prompt.testing.allow'] = true
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end

Capybara.register_driver :firefox_mobile do |app|
  profile = Selenium::WebDriver::Firefox::Profile.new
  profile.native_events = true
  profile['geo.prompt.testing'] = true
  profile['geo.prompt.testing.allow'] = true
  profile['general.useragent.override'] = 'iphone'
  Capybara::Selenium::Driver.new(app, browser: :firefox, profile: profile)
end

# INFO: Change :iphone to :appium on both 101 and 115 lines that start each driver to run tests on chrome with device agent
Capybara.register_driver :iphone do |app|
  Capybara::Selenium::Driver.new(app,
                                 browser: :chrome,
                                 :driver_path => '/chromedriver/chromedriver',
                                 desired_capabilities: Selenium::WebDriver::Remote::Capabilities.chrome(
                                   'chromeOptions' => {
                                     'args' => %w[ignore-certificate-errors disable-popup-blocking headless disable-gpu no-sandbox lang=pt-BR],
                                     'mobileEmulation' => {
                                       'deviceMetrics' => { 'width' => 414, 'height' => 736, 'pixelRatio' => 1 },
                                       'userAgent' => 'Mozilla/5.0 (Linux; Android 4.2.1; en-us; Nexus 5 Build/JOP40D) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/73.0.3683.75 Mobile Safari/535.19'
                                     }
                                   }
                                 ))
end

Capybara.register_driver :appium do |app|
  appium_lib_options = {
    server_url: 'http://0.0.0.0:4723/wd/hub'
  }
  all_options = {
    appium_lib: appium_lib_options,
    caps: desired_caps_android
  }

  Appium::Capybara::Driver.new app, all_options
end

Capybara.register_driver :safari do |app|
  options = {
    js_errors: true,
    timeout: 360,
    debug: false,
    inspector: false
  }
  Capybara::Selenium::Driver.new(app, browser: :safari)
end

Capybara.javascript_driver = :selenium
