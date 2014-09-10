#/opt/apps/ruby/ruby/bin/ruby


# Required Library
require 'ivv-openid'
require 'ivv-browser'

# Browser and credentials
bf          = IVV::Browsers::BrowserFactory.instance()
browser     = bf.get_browser_for("firefox",false)
browser.open()
credentials = {:username => "AOB.USER", :password => "secret"}

# Create a Geo Stratus Object
openid = IVV::OpenId.new(browser, credentials)
openid.goto_openid()
sleep 5
# Click on the Agree button
openid.click_agree()
sleep 5
# Login via openid
openid.login()
sleep 5
# Check to see if the login was successful, returns boolean
openid.login_successful?
