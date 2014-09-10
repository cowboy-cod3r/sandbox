#/opt/apps/ruby/ruby/bin/ruby

# Required Library
require 'ivv-reporting'
require 'ivv-browser'
require 'ivv-openid'

# Browser and credentials
bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox",false)
browser.open()
credentials = {:username => "AOB.USER", :password => "secret"}

# Go To Reporting
reporting = IVV::Reporting::ReportingApp.new(browser, credentials)
reporting.goto_reporting()
reporting.openid.click_agree()
reporting.openid.login()


# Import a Report
form = reporting.click_create_new_report("OPE - Area Study Social Report")
browser.driver.switch_to.window(browser.driver.window_handles.last())
form.import_report("/home/sean.humbarger/workspace/projects/GESINF/cucumber/topic-builder/src/main/features/data/reports/ope-assr.yml")

# Submit Report
form.submit("PUBLISHER")

# Publish Report
# Go back to the first browser window
browser.driver.switch_to.window(browser.driver.window_handles.first())
reporting.nav.expand_workflow()
reporting.nav.workflow.click_inbox()
reporting.nav.workflow.click_report(form.rpt_id)
browser.driver.switch_to.window(browser.driver.window_handles.last())
form.click_edit()
form.save()
form.publish()
=begin

browser.driver.switch_to.window(browser.driver.window_handles.first())
search = reporting.linkbar.click_search

# There is a time lag between the record getting
# saved and it being available it solr, so it is 
# possible for the record to not immediately be
# available, so we query a few times before erroring
found = false
5.times do |i| 
  search.execute_search(form.rpt_id)
  if search.record_exists?(form.rpt_id)
    found = true
    break
  end 
end
puts found
browser.close()

bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox",false)
browser.open()
credentials = {:username => "SOCPACJ3.USER", :password => "secret"}

# Launch Topic Builder
tb = reporting.linkbar.click_topic_builder()

# Perform a search in topic builder
tb.click_search()
#tb.search.enter_search_criteria(form.rpt_id)
tb.search.enter_search_criteria("pyongyang")
tb.search.click_simple_search() 
=end
