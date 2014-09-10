#/opt/apps/ruby/ruby/bin/ruby

# Required Library
require 'ivv-landing'
require 'ivv-browser'
require 'ivv-openid'

# Browser and credentials
bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox")
browser.open()
credentials = {:username => "AOB.USER", :password => "secret"}

# Create a landing page object
landing = IVV::Landing.new(browser, credentials)

# Go to the landing page
landing.goto_landing()

# Go To INDURE
indure = landing.click_indure()
#indure.openid.click_agree()
#indure.openid.login()

# Go To IRS
#irs = landing.click_irs()
#irs.openid.click_agree()
#irs.openid.login()

# Go To SAC 
#sac = landing.click_sac()
#sac.openid.click_agree()
#sac.openid.login()

# Go To TopicBuilder 
#tb = landing.click_topic_builder()
#tb.openid.click_agree()
#tb.openid.login()

# Go To Geo Stratus 
stratus = landing.click_geo_stratus()
stratus.openid.click_agree()
stratus.openid.login()
