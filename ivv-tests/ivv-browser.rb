#!/opt/apps/ruby/ruby/bin/ruby
require 'ivv-browser'
require 'selenium-webdriver'

browser = IVV::Browsers::BrowserFactory.instance()
#browser = browser.get_browser_for("chrome",false)
#browser = browser.get_browser_for("chrome",true)
browser = browser.get_browser_for("firefox",false)
#browser = browser.get_browser_for("firefox",true)
browser.open do |driver|
  Selenium::WebDriver.for :remote, :url => "http://172.30.13.31:4444/wd/hub", :desired_capabilities => :firefox
end
sleep 5
browser.close()
browser.delete_profile()
