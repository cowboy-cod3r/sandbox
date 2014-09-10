#/opt/apps/ruby/ruby/bin/ruby

# Required Library
require 'ivv-sac'
require 'ivv-browser'
require 'ivv-openid'

# Browser and credentials
bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox")
browser.open()
credentials = {:username => "uuser", :password => "secret"}

# Create a Geo Stratus Object
sac = IVV::Sac.new(browser, credentials, false)

# Go To GEO Stratus
sac.goto_sac()
sac.openid.click_agree()
sac.openid.login()
