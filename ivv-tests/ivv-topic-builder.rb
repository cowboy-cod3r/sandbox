#/opt/apps/ruby/ruby/bin/ruby

# Required Library
require 'ivv-topic-builder'
require 'ivv-browser'
require 'ivv-openid'
require 'selenium-webdriver'

# Browser and credentials
bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox",false)
browser.open do
  Selenium::WebDriver.for :remote, :url => "http://172.30.13.31:4444/wd/hub", :desired_capabilities => :firefox
end
credentials = {:username => "AOB.USER", :password => "secret"}

# Create a Topic Builder Object
tb = IVV::TopicBuilder::TopicBuilderApp.new(browser, credentials)

# Go To Topic Builder
tb.goto_topic_builder()
tb.openid.click_agree()
tb.openid.login()

# Create a new topic
tb.click_search()
tb.search.click_create_topic()
tb.search.details.enter_topic_name("North Korea")
tb.search.details.check_shared()
tb.search.details.save()

# Perform a simple search
tb.click_search()
tb.search.enter_search_criteria("Pyongyang")
tb.search.click_simple_search()
tb.search.click_syns_on()
sleep 3
tb.search.click_syns_on()
sleep 3
tb.search.click_syns_off()
sleep 3

# Delete a topic
#tb.click_topics()
#tb.topics.click_manage_topics()
#tb.topics.manager.click_my()
#tb.topics.manager.click_delete("My", "North Korea")
#tb.topics.manager.click_close()

# Click file upload tab
#tb.click_file_upload()
