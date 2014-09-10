#/opt/apps/ruby/ruby/bin/ruby

# Required Library
require 'ivv-geo-stratus'
require 'ivv-browser'
require 'ivv-openid'

# Browser and credentials
bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox")
browser.open()
#credentials = {:username => "AOB.USER", :password => "secret"}
credentials = {:username => "uuser", :password => "secret"}

# Create a Geo Stratus Object
geo = IVV::GeoStratus.new(browser, credentials, false)

# Go To GEO Stratus
geo.goto_stratus()
geo.openid.click_agree()
geo.openid.login()

geo.linkbar.click_topic_builder()
